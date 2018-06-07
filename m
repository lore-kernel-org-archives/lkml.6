Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hONyODA7GVv5IQAAmS7hNA
	; Thu, 07 Jun 2018 14:03:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C9146607DC; Thu,  7 Jun 2018 14:03:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pow9opu7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4FE0B602FC;
	Thu,  7 Jun 2018 14:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FE0B602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932733AbeFGODZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:03:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38000 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbeFGODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:23 -0400
Received: by mail-pf0-f196.google.com with SMTP id b74-v6so4975210pfl.5;
        Thu, 07 Jun 2018 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rb32PzJxgfECDSPhRR0aOtSLawZ3p8s2QVzA6l8WqNk=;
        b=Pow9opu7ceiiCW9TQAf8RGUKsxhD5O+p5xjuI0MH3Uq/6VQcnBhI0uGRhP9GZBPALD
         jf6VgMopnpHp3qFpPzxgNs7FTQUpd/IgDUQZb2QYyUsAzgEkmwHZyV01iyQgkCts/Y6f
         Heuo1o+skK79Fxafuf16gG0gqeTaeK2ilCceLJSue/MrixBsrrzrIpKlR8KZY7WhcRe9
         c1BOJQlWStRZaqMe/P4GCZ/xSCxfv97crWyzsHKiwuDzgS4CWSV5Jd+z8h20mT6h7qLi
         2pH5jJLqDNrv/JbQog/+E+6QgMarwWvnn50uFpuBMwMskMJszx+U+K4Sju8uc9WfWpjx
         9Cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rb32PzJxgfECDSPhRR0aOtSLawZ3p8s2QVzA6l8WqNk=;
        b=hHyIArSDSEZPmMThmygGjy+vmwXBwJ1C0OT4xcurRfODiSafG+Yo9KlKnQbkaBtIau
         xkhfMkVsYSggAOsesFYpJ5FRrC+09fsgCIe27+LWYVwXSNxCxd88pKB59R7AN4qSJ4cL
         fEePsFXmSXmdyNY3TwWkzhV0ylv/TcJpMbqqADvIeckOtB/UciSr4s4gtMxlgOFAztlq
         OmUQ7J+8bZC4QickHc0VM3cCvLZscAd7hkfI965n2zCtZNmIiwovYP99+QtOrtX1jCd/
         Au0tsTPpDbEC/HQDdhiKwgJELtOf4463015if4JpGV33K5c9CpE81Fa/A+6LssfgRHRm
         G2RQ==
X-Gm-Message-State: APt69E1YTTu05L84TnZHI/zoVn/tJQOCALBmNWoRogqXZXQxXBqt/4Pw
        XMZHCZPTiej7roLd0ohQWsM=
X-Google-Smtp-Source: ADUXVKJbQQX7KNiXqyyQ58zASRfsZqfOjotVe8TJ4DbT9LDxK0w4z2Rg7ck3bSfEY6vBXeIZgTRO2Q==
X-Received: by 2002:a65:6319:: with SMTP id g25-v6mr1724485pgv.437.1528380202533;
        Thu, 07 Jun 2018 07:03:22 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id t23-v6sm36594650pfa.86.2018.06.07.07.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 07:03:21 -0700 (PDT)
Date: Thu, 7 Jun 2018 23:03:19 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: possible deadlock in console_unlock
Message-ID: <20180607140319.GB398@tigerII.localdomain>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
 <6cc6d5c1-fc01-efab-86b8-eb072607680c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc6d5c1-fc01-efab-86b8-eb072607680c@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/07/18 20:40), Tetsuo Handa wrote:
> >> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> >> index c996b6859c5e..71958ef6a831 100644
> >> --- a/drivers/tty/tty_buffer.c
> >> +++ b/drivers/tty/tty_buffer.c
> >> @@ -167,7 +167,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
> >>  	   have queued and recycle that ? */
> >>  	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
> >>  		return NULL;
> >> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> >> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
> >> +			GFP_ATOMIC | __GFP_NOWARN);
> >>  	if (p == NULL)
> >>  		return NULL;
> >>
> >> ---
> > 
> > This looks like the most simple solution for this particular problem.
> > I am just afraid that there are many other locations like this.
> > 
> I haven't tried the reproducer with that change. But isn't __GFP_NOWARN
> ignored by fail_dump() (and thus printk() from fault injection still occurs)?

Thanks for the info. Need to check it [I didn't know that GFP_NOWARN
meant GFP_WARN_ME_SOMETIMES]. If this is the case then we have just one
option left - printk_safe contexts for TTY/UART locks.

	-ss
