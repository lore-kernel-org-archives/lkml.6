Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C611CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EED320846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw3CUwfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EED320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeGWEa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:30:26 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39203 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeGWEaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:30:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so30784639oib.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 20:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhWUm2eQO6SABFd0ZireSHPv8/Gwgjiq4jH1RO3tI3k=;
        b=Vw3CUwfipUrURKs0WftvA0Gc0C68HyYQBAmlmGiJ/J1R/OHmnLMCO9yJPQmSFplR72
         HiQGLQ8iC0l4dkmzFu6ApHwCE1/f4AL1d6W5MsrGKU//u7wvwtvnTjdKF7Qht+uPFAXQ
         2mKjIaLvrJ4zdOwJ3735QwCKLIjzVlWr8X3YUvWzDrf/xaXVgIcEeT1cTXsP5pvtHKKz
         6kPN5uqCY3S/toYkrGu/VOG9Qz5yxzDv2b7xSFyRSMYoghStBwdJTCYha08UslbKdJ9p
         jEZsgLoR9cVztYq/lBtxe8Pjrti5qJZab7+Mv+mXIewoNMd9kePkqZYkY/mEMPWzFEMh
         bh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhWUm2eQO6SABFd0ZireSHPv8/Gwgjiq4jH1RO3tI3k=;
        b=VVbirsJNSTaIFkb2+2KXk1tkCnkJEEK3/ozo6h1DrwatVOI3qoAy6fkNkgSRMMeHlC
         fMHJPvRYRAeVlQ2VHj9LG6Oe5pD9egwA4ULFqLVQLcsWOBMyCZGQm6giguyyfEanocFP
         w3KOJ8DVCUeaSIHa/W28hMe6UmZYBbd+kajNDxxbfeCid1cLHE2P1y1feDm6BCF8G8sw
         R/cUegWp0wbiH5PngFUlz/d6nBKHNu9frgxPWhmpAsMmQdSM06Gdu9Fy7Bo0kXpNxyGK
         dkzIeTpCaZbD8WSwo/Q4rmkK+l47rUDrxAbSDMHGoAhqmJ/qHAmgwOwCFeJDzaTUYaUY
         /bFg==
X-Gm-Message-State: AOUpUlFYJagsVfiy4l6ln0k5gCT9fkMKs84rjbfoWa6shimlJnTmAAfe
        hagK+KWEasWjNYUa9RoXhizAxfdBSn2qIewHnFc=
X-Google-Smtp-Source: AAOMgpeyTj1moB9I/E9Unvtt8UBxvf+rE5d1GPVtJGbG9RNzzBzy3ZwEyOBpzz5JhuH9TzAm8m67Z5wvSJnHkvKzBW8=
X-Received: by 2002:aca:2808:: with SMTP id 8-v6mr1105638oix.7.1532316681772;
 Sun, 22 Jul 2018 20:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <1532036397-19449-1-git-send-email-longman@redhat.com>
 <20180719215456.5ho3udhfoqlkh75a@linux-r8p5> <00e98205-606a-a121-36c2-dedaeae1d0bb@redhat.com>
In-Reply-To: <00e98205-606a-a121-36c2-dedaeae1d0bb@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 23 Jul 2018 11:31:13 +0800
Message-ID: <CANRm+CyHfvBKVKNk+pKF+s6+1seZ8c+NyjHuepT2Mf+4Cdd-2w@mail.gmail.com>
Subject: Re: [PATCH v2] xen/spinlock: Don't use pvqspinlock if only 1 vCPU
To:     Waiman Long <longman@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 06:03, Waiman Long <longman@redhat.com> wrote:
>
> On 07/19/2018 05:54 PM, Davidlohr Bueso wrote:
> > On Thu, 19 Jul 2018, Waiman Long wrote:
> >
> >> On a VM with only 1 vCPU, the locking fast paths will always be
> >> successful. In this case, there is no need to use the the PV qspinlock
> >> code which has higher overhead on the unlock side than the native
> >> qspinlock code.
> >>
> >> The xen_pvspin veriable is also turned off in this 1 vCPU case to
> >> eliminate unneeded pvqspinlock initialization in xen_init_lock_cpu()
> >> which is run after xen_init_spinlocks().
> >
> > Wouldn't kvm also want this?
> >
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index a37bda38d205..95aceb692010 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -457,7 +457,8 @@ static void __init sev_map_percpu_data(void)
> > static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
> > {
> >     native_smp_prepare_cpus(max_cpus);
> > -    if (kvm_para_has_hint(KVM_HINTS_REALTIME))
> > +    if (num_possible_cpus() == 1 ||
> > +        kvm_para_has_hint(KVM_HINTS_REALTIME))
> >         static_branch_disable(&virt_spin_lock_key);
> > }
>
> That doesn't really matter as the slowpath will never get executed in
> the 1 vCPU case.

So this is not needed in kvm tree?
https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=queue&id=3a792199004ec335346cc607d62600a399a7ee02

Regards,
Wanpeng Li
