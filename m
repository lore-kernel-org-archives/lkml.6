Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4E52145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="mSLvMFys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4E52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJRLu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:50:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34824 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeJRLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:50:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id e187-v6so4250275wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=woTHCCBcWF0KQDDnOXNhQc/hQcydq3e5I66sN6R154E=;
        b=mSLvMFysJatryPu37ifhkt+K5dXgrstFO2U2ox4m9vuGawz98AvKuwvzunpn923IMv
         IqXaIrAIshevoQvN5NlKpIadK8svSYD9UE7PehVSpGmcjueq9jtcLB3NfdzfNhyPse0K
         ukmIkBGq5SMU/LjDfHSmiSYk0P+kCJO/nHdhCkC5Vmmi5NVFr8X7E+rLGS4zmj1BHUv/
         BqsltREJBHrZ4RhTK2l5xDKI2td4Qw87mu6/vP+qAXUsq6yjUceVJZcsd0k+KQLCySzi
         zkchZez01dfuVpDFLldfDbDMOYhLhX3YSKsNy3tzQm5KaoyyOCj6xMgnrFd61W48cNYL
         yo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=woTHCCBcWF0KQDDnOXNhQc/hQcydq3e5I66sN6R154E=;
        b=VS7U08IQbzCdu+Lb+0MKaUCDlQ4QZta9uzb/rhKkiCTPyu8rDg5FcO29Z43tZJ/9wU
         KBoTQftKDe/NAqmOMrd/bk0zrp4x7njr+K2A5eWuzMT/VBTHcD2M4iJXi4X/KjNsFu+o
         eVlDWZU7bZMRbSdb89ENZy8SS5ddDvqt+Rxd1qBO5DooiVfmt+0HJ57yfPlUrftLST56
         nZwOTxkIG6K6n2DXP/X8UOMU11Ky0M8yqU8vYU7efBwRJSDeszYpvQqnwhyvUWI+Pvuk
         JJ50l2HoRzNTFEO5Tist0U7LgrD/AqxNUohXgGN2KsXdwKa3xU9VKqm/tGwwuXbpDuU/
         9PbA==
X-Gm-Message-State: ABuFfoinyjFNYKKIR1j+UQ7tkeAbjuDT5fB671AuahXInX+8WevZv+Xy
        FCaa61LQnpPkNCo1omvMAZIc81U1SqoF47RDioBlxw==
X-Google-Smtp-Source: ACcGV620xmHE4InY+TcouIfxJP4H+Myc1SWkzp0mbQyJnp83klHZ8O20xiLfD827Im4Edicq+dQ5R6CeTcZpjD6eaGs=
X-Received: by 2002:a1c:4054:: with SMTP id n81-v6mr5529301wma.82.1539834693792;
 Wed, 17 Oct 2018 20:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181018005420.82993-1-namit@vmware.com> <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net> <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
In-Reply-To: <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 17 Oct 2018 20:51:22 -0700
Message-ID: <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 8:12 PM Nadav Amit <namit@vmware.com> wrote:
>
> at 6:22 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>
> >
> >> On Oct 17, 2018, at 5:54 PM, Nadav Amit <namit@vmware.com> wrote:
> >>
> >> It is sometimes beneficial to prevent preemption for very few
> >> instructions, or prevent preemption for some instructions that precede
> >> a branch (this latter case will be introduced in the next patches).
> >>
> >> To provide such functionality on x86-64, we use an empty REX-prefix
> >> (opcode 0x40) as an indication that preemption is disabled for the
> >> following instruction.
> >
> > Nifty!
> >
> > That being said, I think you have a few bugs. First, you can=E2=80=99t =
just ignore
> > a rescheduling interrupt, as you introduce unbounded latency when this
> > happens =E2=80=94 you=E2=80=99re effectively emulating preempt_enable_n=
o_resched(), which
> > is not a drop-in replacement for preempt_enable(). To fix this, you may
> > need to jump to a slow-path trampoline that calls schedule() at the end=
 or
> > consider rewinding one instruction instead. Or use TF, which is only a
> > little bit terrifying=E2=80=A6
>
> Yes, I didn=E2=80=99t pay enough attention here. For my use-case, I think=
 that the
> easiest solution would be to make synchronize_sched() ignore preemptions
> that happen while the prefix is detected. It would slightly change the
> meaning of the prefix.
>
> > You also aren=E2=80=99t accounting for the case where you get an except=
ion that
> > is, in turn, preempted.
>
> Hmm.. Can you give me an example for such an exception in my use-case? I
> cannot think of an exception that might be preempted (assuming #BP, #MC
> cannot be preempted).
>

Look for cond_local_irq_enable().

--Andy
