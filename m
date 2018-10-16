Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF03920881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtHQafuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF03920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJPWcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:32:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33237 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:32:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id l14-v6so12603637edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8axZzdNvrzI+u2U7+oDvY9j58Np1YM3RjpcEuRDVIkc=;
        b=DtHQafuoPc7DjasCmVzobJEekwr2igNZxE/S9NeZl6sJaVW3AQklnLiGKdZ9aZ92zb
         2BZLPlzKoAx+AxBM8KN9WArM0uwnfRYMnLyWCdJA9ZaT83jwJkEshtKCRw5huwkUvQuz
         e+nCvLZSsoRRkwvXwW4Asox8kFJbv8jYNq2h+gckswA5wk+pEacXwgxF0bU31ckTN5dn
         TxNmjJKMJlcmQC0gQj2Itn3KbynqDmEImixhZ2UmVkwTpO25H0kBLqG6Ly/i8tsFe/SC
         ZXJ2W/ATWrj4L6hQmqwnUx8ZWMJLhm6c/FJ3KK/OhMHAGbXbCo9+l2N6uJkPsz/ojnMQ
         GUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8axZzdNvrzI+u2U7+oDvY9j58Np1YM3RjpcEuRDVIkc=;
        b=mo9Mqk4xVPD7e6KYMAkOozQ44uWpY20yqTaUaSUJVXTSvkXTNvE3KYl0Jx+IRBkCBh
         Z0Qc98Wlxj6uqY8pKHO53H+TB/lH03Luo8tfCRzWKOjmMxeXcwR9D1GQARexBqqKhSr8
         UNOV1bvDEAG64htkqEsrKZG1Ql19g4dEDOnCu1Qaooa4lIlgwWSwjMAdlnRGvxKdDLna
         ISbM39AEHAQ/W3Xe8MsGYwql0Ld3ltpt7D7Xz///VY+ptDXfSgZbl7VLWkoA6XDMz+4L
         Jrjo4X0S8zuoBbF9dzl4j9F0p/26neA1nIA9zHMCXBLdkaiHR9CelE96BrV73QPhk1zP
         L9XA==
X-Gm-Message-State: ABuFfoiGDpS68gwP+VwJXgd4+eGJywpOhuG2IFvBdfFQnEGAdqrG5Xa1
        XVVqmorCvT4EA9sSDXsDkp0=
X-Google-Smtp-Source: ACcGV62G/mS0znNf8CngBl4BCW3qf1M3FK/+g33m2Y45QLsQLd0/b6Jg0ys0uQ9vsY1Za1+51jYw+g==
X-Received: by 2002:a50:abc2:: with SMTP id u60-v6mr31020767edc.185.1539700892076;
        Tue, 16 Oct 2018 07:41:32 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD0F03569FD0D231D8C2067.dip0.t-ipconnect.de. [2003:ef:2bd0:f035:69fd:d23:1d8c:2067])
        by smtp.gmail.com with ESMTPSA id h21-v6sm7119155eda.23.2018.10.16.07.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 07:41:31 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:41:28 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com,
        juri.lelli@redhat.com
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181016144045.GF9130@localhost.localdomain>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
 <20181016140322.GB3121@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016140322.GB3121@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/18 16:03, Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 03:24:06PM +0200, Thomas Gleixner wrote:
> > It does reproduce here but with a kworker stall. Looking at the reproducer:
> > 
> >   *(uint32_t*)0x20000000 = 0;
> >   *(uint32_t*)0x20000004 = 6;
> >   *(uint64_t*)0x20000008 = 0;
> >   *(uint32_t*)0x20000010 = 0;
> >   *(uint32_t*)0x20000014 = 0;
> >   *(uint64_t*)0x20000018 = 0x9917;
> >   *(uint64_t*)0x20000020 = 0xffff;
> >   *(uint64_t*)0x20000028 = 0;
> >   syscall(__NR_sched_setattr, 0, 0x20000000, 0);
> > 
> > which means:
> > 
> >   struct sched_attr {
> >   	 .size		= 0,
> > 	 .policy	= 6,
> > 	 .flags		= 0,
> > 	 .nice		= 0,
> > 	 .priority	= 0,
> > 	 .deadline	= 0x9917,
> > 	 .runtime	= 0xffff,
> > 	 .period	= 0,
> >   }
> > 
> > policy 6 is SCHED_DEADLINE
> > 
> > That makes the thread hog the CPU and prevents all kind of stuff to run.
> > 
> > Peter, is that expected behaviour?
> 
> Sorta, just like FIFO-99 while(1);. Except we should be rejecting the
> above configuration, because of the rule:
> 
>   runtime <= deadline <= period
> 
> Juri, where were we supposed to check that?

Not if period == 0.

https://elixir.bootlin.com/linux/latest/source/kernel/sched/deadline.c#L2632
https://elixir.bootlin.com/linux/latest/source/kernel/sched/deadline.c#L2515

Now, maybe we should be checking also against the default 95% cap?

Best,

- Juri
