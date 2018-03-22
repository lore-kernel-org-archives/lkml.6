Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AG47ELtStSftvmRMvl/RxECUX9Wz+9jkd6Y45B6GLEXAag6Zhv1N1fK4t8VQlDvaQGafMUVqFDv6
ARC-Seal: i=1; a=rsa-sha256; t=1521731928; cv=none;
        d=google.com; s=arc-20160816;
        b=rQJ8/Ty1m+ZQcTMiqGB4kpOCatG1BG7zOLerapzpWSU4PrwB2mdm0jq9h49yjhA91m
         W8leHsKM2KdQ3EMKiG5hGUxqdS2lDRto1txMDEhFplpH4o0le3mdDS54+ud0UyJeWeZ7
         ZiGA9u5lrwlvLA3TrXzrH3tDXCASMTCatC/ctovpQ7bqjk7IHXsAMAsHTGyPhX1P9rq6
         t7xL40tnBQERh9jwev6o65VBpq/o2ZloN0WlqhgWvQlM4wfljT72eMlTAHfKozLurY4Y
         b9Vv3ftz12KE7sj2CThPPKpBVqNfjaE97uxTikIhzqhqryCQNcbyMTHo+qaAyewFUyTA
         pR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=pNTPOcJgNRy2JJxhC4bYjl+dbiOFXwbmHxZMCv4mAsU=;
        b=FB7TztvWyglWb7F7WpjP55EKRZ1vSKOmVrFbfddznIfplbYthRa49WcdgRNwR6SF5H
         dzI98+/KpdMdMiEhvZzo01easbs3ua7YllFSZF357u4eMkg/P4qflByNTmUFJzEhRqsz
         DJkQkPRWuO58FOjDNBmsXlBADwIR8Q+OlrkZavUqEBMUgFYUIfs+UdHQUBvwsd87jnx8
         Gr+aIbJa97fVL4klT2qFrP9RWdMgFP2o8cteJGdM71kE4iyAi+Z2kC2sZkvdrB3mNJeH
         gha212XeVXTAMHO06YSHcwf94mpgtDJCKAWVPhBhfIr+2x8zMbPHpCcqGE5QgvBMFIkB
         HPfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Thu, 22 Mar 2018 11:18:45 -0400 (EDT)
Message-Id: <20180322.111845.2287793858307871828.davem@davemloft.net>
To: christian.brauner@ubuntu.com
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, serge@hallyn.com,
 avagin@virtuozzo.com, ktkhai@virtuozzo.com
Subject: Re: [PATCH net-next 1/2 v4] net: add uevent socket member
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180319121731.14449-1-christian.brauner@ubuntu.com>
References: <20180319121731.14449-1-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595368388087752146?=
X-GMAIL-MSGID: =?utf-8?q?1595651578505889987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 19 Mar 2018 13:17:30 +0100

> This commit adds struct uevent_sock to struct net. Since struct uevent_sock
> records the position of the uevent socket in the uevent socket list we can
> trivially remove it from the uevent socket list during cleanup. This speeds
> up the old removal codepath.
> Note, list_del() will hit __list_del_entry_valid() in its call chain which
> will validate that the element is a member of the list. If it isn't it will
> take care that the list is not modified.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied.
