Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95553C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA7E20831
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g68mAYU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA7E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439476AbeKWNRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:17:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34735 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:17:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so2419300pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 18:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jGxhvUPVEw8Q9zn/vw1X4TK4CjBUF04EQkEuyKSCjRw=;
        b=g68mAYU54SvmWn+8/Cg2yQ2FnlLVF62K9rlvN0+dSchs59G1JsGo+Rn1lK1OA/xSBo
         2vvzcK4F1oj3S8UWbFO6osxz6Yuq7hePZTRlfeehxbDPkWbCROCGhAQOFRrLUUmDfI7j
         T85N0mK14BwmRdimsarLDnX2Qpb2FtwCy+DK/km1XXZBYe2l8TMPSr9Zv/AojL2+18I2
         w83qpWoklx5Suk+2jG1c/KXIHk+06EBTZVafD4cqXMDBS4QDLvxGNCqFRDtwwmBqeKUB
         9rDgZoMNjyf7zk5ApNe7tN3crrbdoVNTg/AicvatILSFodqoRHkao8Vd33e1w2jH2ZOh
         Q0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jGxhvUPVEw8Q9zn/vw1X4TK4CjBUF04EQkEuyKSCjRw=;
        b=WwoIhA7HE6IFaw6VgkvCzKvtLfxyS0a3f2O9/S5sA7mwithv4ls+SHMPRXylFpr7dx
         w5liRFnPV4zrgVDL3skolqAGtZpoiXABYg7E2tyAq7hb1oexEQNcsPVpXrRPdPDRvo5a
         uL59mMPQPTIelgQL8V7seV2w8XtiBag+4EiLxlhWiHNptxYqcjXhEEemA0NKi5ArT0YQ
         5IG1koZM+wP8IclHeXvNgaPBdM/K4RTfeWc4hHF/JzG2scxaI+5RYgtrP4bBvQG+2yNa
         grqxVMSZ5GjplJ/57yaJRc0wGAInTxf/E3JDfN+NATtKvan57vYMNHessZHiBge7AcQm
         3AXg==
X-Gm-Message-State: AGRZ1gLsLcvWREMJ6NsrH7CgZt+NOJEQNEm3ZGw4IuTrVHtB8425Sjmq
        AL6loqz6aQWVQj1rvIbYpJM=
X-Google-Smtp-Source: AJdET5cay499p9ta7XVfpRnGtYFDNz7s5FO7XwH2hgFrVKc5481CEAeckMHB2hpYcMeA3MTDc0A0PQ==
X-Received: by 2002:a63:d904:: with SMTP id r4mr12370472pgg.207.1542940519679;
        Thu, 22 Nov 2018 18:35:19 -0800 (PST)
Received: from localhost ([175.223.19.111])
        by smtp.gmail.com with ESMTPSA id k137sm55099047pfd.56.2018.11.22.18.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 18:35:17 -0800 (PST)
Date:   Fri, 23 Nov 2018 11:35:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Message-ID: <20181123023514.GC1582@jagdpanzerIV>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
 <c8c29a58-f356-d379-2bf4-cea09b03dc3e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8c29a58-f356-d379-2bf4-cea09b03dc3e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/22/18 14:57), Waiman Long wrote:
> > [..]
> >> As a side note, one of the test systems that I used generated a
> >> debugobjects splat in the bootup process and the system hanged
> >> afterward. Applying this patch alone fix the hanging problem and the
> >> system booted up successfully. So it is not really a good idea to call
> >> printk() while holding a raw spinlock.
> > Right, I like this patch.
> > And I think that we, maybe, can go even further.
> >
> > Some serial consoles call mod_timer(). So what we could have with the
> > debug objects enabled was
> >
> > 	mod_timer()
> > 	 lock_timer_base()
> > 	  debug_activate()
> > 	   printk()
> > 	    call_console_drivers()
> > 	     foo_console()
> > 	      mod_timer()
> > 	       lock_timer_base()       << deadlock
> >
> > That's one possible scenario. The other one can involve console's
> > IRQ handler, uart port spinlock, mod_timer, debug objects, printk,
> > and an eventual deadlock on the uart port spinlock. This one can
> > be mitigated with printk_safe. But mod_timer() deadlock will require
> > a different fix.
> >
> > So maybe we need to switch debug objects print-outs to _always_
> > printk_deferred(). Debug objects can be used in code which cannot
> > do direct printk() - timekeeping is just one example.
> 
> Actually, I don't think that was the cause of the hang.

Oh, I didn't suggest that this was the case. Just talked about more
problems with printk in debug objects. Serial consoles call mod_time,
mod_timer calls debug objects, debug objects call printk and end up
in serial console again. Serial consoles are not re-entrant at this
point.

> The debugobjects splat was caused by debug_object_is_on_stack(), below
> was the output:
>
> [    6.890048] ODEBUG: object (____ptrval____) is NOT on stack
> (____ptrval____), but annotated.
> [    6.891000] WARNING: CPU: 28 PID: 1 at lib/debugobjects.c:369
> __debug_object_init.cold.11+0x51/0x2d6
[..]
>    11.270654] systemd[1]: systemd 239 running in system mode. (+PAM
> +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
> +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN
> +PCRE2 default-hierarchy=legacy)
> [   11.311307] systemd[1]: Detected architecture x86-64.
> [   11.316420] systemd[1]: Running in initial RAM disk.
> 
> Welcome to
> 
> The system is not responsive at this point.
> 
> I am not totally sure what caused this.

Hmm, me neither.

	-ss
