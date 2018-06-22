Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B43C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0818249D0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="By8PBnjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0818249D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933953AbeFVXZt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933310AbeFVXZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:25:48 -0400
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com [209.85.128.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB045249DB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 23:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529709948;
        bh=qlPTUDOYWtl0Eu5pp4L6EmY2Nynpd7ojpIAwS3H/3vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=By8PBnjRZvY1fXTwLFI1YsZYugABpa50J0WUkd+OKiE39ndWIiCQOCOOTl4fnm1V/
         BXsCYzsfqXcSat6uJvuNVU1UyuWg8nCn3/HgxPx6pcP7DTd0kwZAFaijBiIJILYVoZ
         +QeVozoooMhztnw9Qqmgp25Ga5JK61DZBiuE+Y+A=
Received: by mail-wr0-f172.google.com with SMTP id h10-v6so8101030wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:25:47 -0700 (PDT)
X-Gm-Message-State: APt69E1Q/RjPE5S8qNv/gWj/3be6yCCvOjM4Xr5Lwufad7wnjNs0ZqDZ
        Cf2CsCRmO8hinPSxvIrfm0qub4F8fyfQNNcL9BhPhg==
X-Google-Smtp-Source: AAOMgpfEtDk0sTlBvooR93PrbTIjG+sPLwb3E1qkoiGX2qqkM83FxT/DwvBwWnYCXHIPDaEWJX072Swza7Jeb8HBPPw=
X-Received: by 2002:adf:fe4c:: with SMTP id m12-v6mr2931096wrs.171.1529709946392;
 Fri, 22 Jun 2018 16:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180604172711.18962-1-michael-git@rodin.online> <alpine.DEB.2.21.1806222333070.1589@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806222333070.1589@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 16:25:34 -0700
X-Gmail-Original-Message-ID: <CALCETrVDuqie6WS--gyb9ohEKXmreA+iN5P-raJbnfS7Tp8nkQ@mail.gmail.com>
Message-ID: <CALCETrVDuqie6WS--gyb9ohEKXmreA+iN5P-raJbnfS7Tp8nkQ@mail.gmail.com>
Subject: Re: [PATCH] arch/x86/entry/vsyscall/vsyscall_gtod.c: remove
 __read_mostly from vclocks_used
To:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     michael-git@rodin.online, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 3:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Michael,
>
> On Mon, 4 Jun 2018, Michael Rodin wrote:
>
> > The variable "vclocks_used" doesn't appear to be "read mostly".
> > Measurements of the access frequency with perf stat [1] and
> > perf report show, that approximately half of the accesses to
> > this variable are write accesses and happen in update_vsyscall()
> > in the file arch/x86/entry/vsyscall/vsyscall_gtod.c.
> > The measurements were done with the kernel 4.13.0-43-generic used by
> > ubuntu as well as with the stable kernel 4.16.7 with a custom config.
> > I've used "perf bench sched" and iperf3 as workloads.
> >
> > This was discovered during my master thesis in the CADOS project [2].
>
> Nice find, but ...
>
> The point is that the content of that variable changes once in a blue moon,
> so the intent of marking it read_mostly is almost correct.

I would propose a rather different fix.  Add a an
arch_change_clocksource() function.  Do:

static inline void arch_change_clocksource(struct clocksource
*new_clocksource) { ... }
#define arch_change_clocksource arch_change_clocksource

and

#ifndef arch_change_clocksource
static inline void arch_change_clocksource(struct clocksource
*new_clocksource) {}
#endif

in the generic header.  In change_clocksource(), add a call to
arch_change_clocksource() right after tk_setup_internals().  In x86's
arch_change_clocksource, update vclocks_used.

Now it's genuinely read_mostly, and we don't need to touch that
cacheline at all in the normal clock tick code.  Everyone wins.
(vclocks_used is actually rather rarely read.  It's only used to
prevent user code from accessing a never-used clocksource through the
vvar area, which is a hardening measure.  It's only referenced from
the vvar fault handler code.)

--Andy
