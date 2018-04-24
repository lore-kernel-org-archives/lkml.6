Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AIpwx4/crxlIhvRrBcKkRI5PaU+B4VXCa/dcsHlRTPH7rjGnel0zxZT/FsMwEfyWeGazrj0N1SVZ
ARC-Seal: i=1; a=rsa-sha256; t=1524598770; cv=none;
        d=google.com; s=arc-20160816;
        b=wYGySySOAnM1mg4PBbpcYRFG0SHqdEP5Z85Uu01KnE7YvJx7K32OVe5TT2oh1LQ3Xh
         C83UkjoCJJZyptGJWiUKLbfzaC7+/+V2lBDojyLazDtODNLPS92VASCGMb/KR+JBK24M
         LXLCGkqv+TE8jXb5re7uF/fe5HLuySvDtUmnU+8UMoAzaNAf/cWXnfnmDobgBLTq50qO
         +n4di2nY0wIZLca9PCtL6cvKwemUQcRmgChyqGZuCvoFrsctfBsNZRckhDlJzG3TNm2L
         WbXs1EAby3XFmX5Mh5cDeO6fHyZ+7MMASk5u/3l6axjPJgTRmqCmDwvBKoe0MqmxfPPA
         l3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=lzSARTkMpICu5wsFtcd/uUR+MfNlKvYMf60OU2r0wHQ=;
        b=C/0k045Wk0QZL8Q67mrSZ+HvZgEuKfPfyIcIqI3qS+NxfCLImKnrmqXDj7BUcFCWQa
         C7pcKWXVBqsX06Sh43i0Jke3TttM+EdkDiOf19DVUltRcv6zmMbtvACoPtuHYGsgq+eB
         Q7UbqG5PoWyhm2KnMCB0cEUlmOrW2Doa+YTsDrN+HNABYCYurONP+0+QM/Hyk+J0S6+i
         SoaC79kOBD1NxIXyyt+DrYYg7tPO8EY3Fc0GEjhVqokpQ60IfqHqb8JT9L2My2WEV3ff
         VA95Zr93BQ2uXDjyyOoOXvorVVdzQlhT7GOi/EOS/Yiwy1x4BL0+ruZlrFKaB/NUAoxK
         kUuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Tue, 24 Apr 2018 15:39:25 -0400 (EDT)
Message-Id: <20180424.153925.2063217911734444324.davem@davemloft.net>
To: christian.brauner@ubuntu.com
Cc: ebiederm@xmission.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, avagin@virtuozzo.com, ktkhai@virtuozzo.com,
 serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 2/2 v1] netns: isolate seqnums to use
 per-netns locks
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180423102443.16627-3-christian.brauner@ubuntu.com>
References: <20180423102443.16627-1-christian.brauner@ubuntu.com>
	<20180423102443.16627-3-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598532193391122395?=
X-GMAIL-MSGID: =?utf-8?q?1598657680194501406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 23 Apr 2018 12:24:43 +0200

> +	#ifdef CONFIG_NET
> +		seqnum = get_ns_uevent_seqnum_by_vpid();
> +	#else
> +		seqnum = uevent_seqnum;
> +	#endif

Please don't indend the code like this.

By indenting the CPP directives, which should be at column zero, the
actual code became double indented.

Thank you.
