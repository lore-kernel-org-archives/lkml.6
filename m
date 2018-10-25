Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999972082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3+1hs8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999972082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJYSD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:03:56 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:33250 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeJYSD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:03:56 -0400
Received: by mail-pf1-f172.google.com with SMTP id a15-v6so67355pfn.0;
        Thu, 25 Oct 2018 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9cMT8LZuNmBWNb1QTopavEQmwdR+ZioPmPC6LJqNN9c=;
        b=t3+1hs8Qv59PoeFSo/DAgL4eahzEx4mZzw4TzhaH/+G1NUS4b23/jJbby8xUHcMSKi
         LlWpvrFGgRESE3EZQRmqhIaCRCi3GLNdRa3k978+U9hLHx2ug/AUzYpoErK0omWoKrNd
         27xqmTDF0AkYcVd86lRsL4UyizfE+Ihez0pzS7etyqERf2FmidFn+cmLN9BcjQfDihLf
         O4AKcwFY5zLqNiGTfVK7eiQFBhDcirx1tfj6xc2ckZVBBgW5Rg+1aYqtmDRb5d97nKr3
         kl14LEXLmVmt9UrNIJipb0qXfsKdEIzJyXJM7wHzV1/qdVhyBFKFcsip9OW2EFKbXfsi
         tDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9cMT8LZuNmBWNb1QTopavEQmwdR+ZioPmPC6LJqNN9c=;
        b=is1hs7xrq4RujpOSwhtOOOUq5ggcwkDq5uGp1TdBKZTEcHWhRjvm2SkCP+k7TayXD/
         Rc2RfeSteO+loDVOpfekz9vJaOQAZuEDimSlk49ZlsY8EM8Phcyy0+UGAVbI3gGFA4QI
         ZcB51CC4VtTjrFvw/JhzGbf3kjI9zhjJ+9639XcuO58Sxx6U+xhJO4oRRF838R2AftjP
         Qqt4U+d7pATBjoz+iHwS6VmYJBTj+6gXzuAquWcMl5HkhwJ9J8Z25EY2NfglVb2Enh85
         U/w/VWpqAlAk4/N9OTxdl2QNknrBgtVWaqgZ7Ugfd1+XIgU4BNEv9qBeqrY75qege1PQ
         jAww==
X-Gm-Message-State: AGRZ1gKXtRrFIfxn5hMZdu++QVrsyGcgE7JdXA6j6Ihj2Nv3AIaVXCR8
        dOLnZlKLG+Zn7AsLSoPVZUo=
X-Google-Smtp-Source: AJdET5eBopEMaCIiI5Ddd3UqqNSAJ+fweIuRormA27S6FW46IEw9jHKf4h7/EFvJwm6AUBgfu/tOEA==
X-Received: by 2002:a62:454d:: with SMTP id s74-v6mr829716pfa.136.1540459920471;
        Thu, 25 Oct 2018 02:32:00 -0700 (PDT)
Received: from localhost ([175.223.22.26])
        by smtp.gmail.com with ESMTPSA id a1-v6sm11657537pfj.38.2018.10.25.02.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:31:59 -0700 (PDT)
Date:   Thu, 25 Oct 2018 18:31:55 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Message-ID: <20181025093155.GE20702@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
 <20181023115433.GA10251@jagdpanzerIV>
 <20181023120441.GB10251@jagdpanzerIV>
 <20181023121057.GC10251@jagdpanzerIV>
 <20181025090603.7gkevv5l3zg7dj5e@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025090603.7gkevv5l3zg7dj5e@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/25/18 11:06), Petr Mladek wrote:
> 
> IMHO, the custom s390 implementation can get removed.
> The generic code should do the same job these days.
> 

Yep.

> > And console_unblank() is not guaranteed to print anything (unlike
> > console_flush_on_panic(), but oops is not panic() yet, so we can't
> > replace it with flush_on_panic()) - console_sem can be locked, so
> > console_unblank() would do nothing.
> 
> I see. I missed that console_unblank() returns early when
> down_trylock_console_sem() fails.
> 
> I still would like to refactor the code somehow to avoid
> the bust_spinlocks(0)/bust_spinlocks(1) ping-pong.
> 
> It might make sense to call console_unblank() from
> console_flush_on_panic().
> 
> I wonder if it would make sense to call unblank_screen() in
> console_unblank()...

These are interesting thoughts.

I can add one more thing to the list.
bust_spinlock() is probably not doing enough. It says that it

	"clears any spinlocks which would prevent oops, die(), BUG()
	 and panic() information from reaching the user."

But this is, technically, not true. Because bust_spinlock() does not remove
console_sem out of sight. And we do have several spinlocks behind it. E.g.
semaphore's ->lock. Both down() and down_trylock() do
raw_spin_lock_irqsave(&sem->lock, flags), so if we got NMI panic while one
of the CPUs was under raw_spin_lock_irqsave(&sem->lock, flags) trying to
lock the console_sem then we are done. And IIRC we had exactly this type
of a bug report from LG 1 or 2 years ago - deadlock on sem->lock.

	-ss
