Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx4/KXx4jM5RCyZ0w7W33BFB8qF/baHfd5RSOw2fG/dSqj01AzeV/oI03pDwcWgU1P8ELSVNt
ARC-Seal: i=1; a=rsa-sha256; t=1524083889; cv=none;
        d=google.com; s=arc-20160816;
        b=M0uUz9bZUQi0fjabjAbsYOJmK8LdFpc7gxvCKSRrcl17QhnSCnLoVP6nGUlr2l4OKH
         t3/QwsWWIn/sYQNPQd4c1FYQEDGOPeZULgPb5V3s2+suJ0h8RzG/HclHHL6ur1XZ2U38
         VBFXwKgOupRkAEYj2IQxICakFdtBRcaOKEcvX/HONkCofbLZO8DlcYwvHtqATcL9w4ZY
         O/IM5kJq0uVz07Xy6Gdib7HA9SgLN8GWZfEdbgqG+2Yb1pDQZNGSvQBz/hMwKrG5D0x4
         ztfdEtfVaaeMCILLiEQDTUaCgzjpkURcl790k0YK8tkezlYXVNW3WF0MaJQ/A1zGyVKB
         TlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=9cqJ+E4gqZL1yjHfwwbWNqqvDd5lcTYYTpJZbOGdLKQ=;
        b=AWtfbPzrnvk7jUFlu/Ve29pdcyxwm3lLJ4qBpUVb78XdMsFsarS5p6CI1GlcS0hrjT
         k6bLakUC2Rmp5jhAu8rpOlnBG8uY+dzSaKK/YJgFcGjsjnK9/lEVWz6UCXvbDvsvcUIo
         DouG6WUEjbj15jnLpjGjRmxJT9wZ8hZ/DYTh9uWuCFhu5aQUonIRu0U5hgAIztbjQ/Sg
         gsPE+K2SxvAOPISLNhzlHaqPWvfQ5UhXD6xfgKj5pifamQvn/fxPsPbfvBgXvvBz/4Sk
         68EKCKrAwUJbKAbpsq4QZJ2jsScQdu3MQg4j4MRndrTFF+sKoVxsKjgrRg/ORVZfO+M0
         UAOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 18 Apr 2018 22:38:09 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH driver-core 2/2] test_firmware: fix setting old custom fw
 path back on exit, second try
Message-ID: <20180418203808.GQ30543@wotan.suse.de>
References: <20180404203712.zecit6po44qsde4c@xylophone.i.decadent.org.uk>
 <20180404203848.3txsangsvaxtxsu4@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404203848.3txsangsvaxtxsu4@xylophone.i.decadent.org.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849475289780977?=
X-GMAIL-MSGID: =?utf-8?q?1598117788958441908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 10:38:49PM +0200, Ben Hutchings wrote:
> Commit 65c79230576 tried to clear the custom firmware path on exit by
> writing a single space to the firmware_class.path parameter.  This
> doesn't work because nothing strips this space from the value stored
> and fw_get_filesystem_firmware() only ignores zero-length paths.
> 
> Instead, write a null byte.
> 
> Fixes: 0a8adf58475 ("test: add firmware_class loader test")
> Fixes: 65c79230576 ("test_firmware: fix setting old custom fw path back on exit")
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

Greg, let me know if you want to take these two in now, or if you want me to
queue them up on my own and then send you what I get in the queue later.

  Luis
