Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B30C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B09726335
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtRYMeHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B09726335
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeF0K1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:27:20 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46759 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeF0K1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:27:18 -0400
Received: by mail-ot0-f196.google.com with SMTP id v24-v6so1607471otk.13;
        Wed, 27 Jun 2018 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62RYM+ZcHX9H3T2yH1Wop7i6AAEkAvVxwkADLNV79UE=;
        b=JtRYMeHSzbPUyJTWyJXuaecGkn4NXjGUEQKQtP1YPFSfo4AwV8v6jcHru5ulosmgh/
         IUe6ttaeSdHuWew79aOp5PawkLQOaUOgkOld8+M5ASeQyLqSe7oH9eQ14f/JCM0jBGbY
         XIEXbJISRvWr0STcaX7I8IjkQ/nLlfjN8UUwWAsOXk2NGt8gHIbUBLKYt7jV2ftUfWn7
         0bbGP7A7Q5pDS9U1EcpSgsIm5vHIT36+VnA3xnnIiQTCG/zBcj/TfFmBqjknIgSI/RX2
         oVkUgvyGeChBiQSub15GwWqPKlCqlj04OzgYMb0f0dSPGwAjN40e84xsr6/yRXNQs0tr
         yBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62RYM+ZcHX9H3T2yH1Wop7i6AAEkAvVxwkADLNV79UE=;
        b=bBC1Eung96fu+tZ4xq8buKDkxyLMB/nD49KZxNwXXh2BoTTzfoGyQbuLSuY+6NcD2p
         BcQVvcXRUP5OdWRPtWqOSktsDrCoEdxBKjrlic1YQCovb2+241b2brbYFopTpYRe9rCB
         GXUTiDZBAGDaLdi6ZpYIb3StYcPD639xVwRm8BT3HZ9pWkvrEJyilKEhum3SUdxMFNxW
         PhiRQhbt25FHLpDjn3KQ3tTFdmDK9X5CR39Nkr/X71mSI8kEcRsE0JcTyhylNoH4pZbG
         kPAYWm9uwDIamlOqLelEEaNuRWxkaVfM7nyd9Pu+DJHgOKZuKHtGEp3VTmqxd/e+T1kK
         nRhA==
X-Gm-Message-State: APt69E03J9EQETdB+9dc/DlmadjWNCq2uMg/DH+GvOdszBYgcvq6k92B
        oTEorq+LrImfoRxQldxB1N/G+XeSC3aH1FK0SjE=
X-Google-Smtp-Source: AAOMgpfkGqRYoV9pdl+ZaezCBRSMSCeL1IrHGzxS+7lP+6YgyNqcSouaeNwCFhmLtXIaZXH/tBbGZmBAcUmdLm/GSuw=
X-Received: by 2002:a9d:184:: with SMTP id e4-v6mr3076556ote.249.1530095237856;
 Wed, 27 Jun 2018 03:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180622170625.30688-1-vkuznets@redhat.com> <CANRm+CwNfOkosECeSGaXXDaqTDvh1u228ztU8C5Xe95FGgNsFQ@mail.gmail.com>
 <877emkh98h.fsf@vitty.brq.redhat.com>
In-Reply-To: <877emkh98h.fsf@vitty.brq.redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 27 Jun 2018 18:27:08 +0800
Message-ID: <CANRm+CxwQyzW0ud2p=7ZubW0cTAen-4+Xw_T_gkjj4pz9fpofA@mail.gmail.com>
Subject: Re: [PATCH 0/4] x86/hyper-v: optimize PV IPIs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        devel@linuxdriverproject.org, LKML <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tianyu.Lan@microsoft.com,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 at 17:25, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Wanpeng Li <kernellwp@gmail.com> writes:
>
> > Hi Vitaly, (fix my reply mess this time)
> > On Sat, 23 Jun 2018 at 01:09, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> When reviewing my "x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_
> >> {LIST,SPACE} hypercalls when possible" patch Michael suggested to apply the
> >> same idea to PV IPIs. Here we go!
> >>
> >> Despite what Hyper-V TLFS says about HVCALL_SEND_IPI hypercall, it can
> >> actually be 'fast' (passing parameters through registers). Use that too.
> >>
> >> This series can collide with my "KVM: x86: hyperv: PV IPI support for
> >> Windows guests" series as I rename ipi_arg_non_ex/ipi_arg_ex structures
> >> there. Depending on which one gets in first we may need to do tiny
> >> adjustments.
> >
> > As hyperv PV TLB flush has already been merged, is there any other
> > obvious multicast IPIs scenarios? qemu supports interrupt remapping
> > since two years ago, I think windows guest can switch to cluster mode
> > after entering x2APIC, so sending IPI per cluster.
>
>I got confused, which of my patch series are you actually looking at?
>:-)

Yeah, actually originally I want to reply the thread which you sent
out to kvm ml "KVM: x86: hyperv: PV IPI support for Windows guests"
and miss to reply this one since the subject is similar.

> When we manifest ourselves as Hyper-V Windows 'forgets' about x2apic
> mode: Hyper-V has a concept of 'Synthetic interrupt controller' - an
> xapic extension which we also support in KVM. I don't really know any
> obvious scenarios for mass IPIs in Windows besides TLB flush but I'm
> worried they may exist. Without PV IPIs any such attempt will likely
> lead to a crash.
>
> In general, I do care more about completeness and correctness of our
> Hyper-V emulation at this point: Windows is only being tested on 'real'
> Hyper-Vs so when we emulate a subset of enlightenments we're on our own
> when something is not working. It is also very helpfult for
> Linux-on-Hyper-V depelopment as we can see how Windows-on-Hyper-v
> behaves :-)
>
> > In addition, you
> > can also post the benchmark result for this PV IPI optimization,
> > although it also fixes the bug which you mentioned above.
>
> I'd love to get to know how to trigger mass IPIs in Windows so a
> benchmark can be performed...

I also not sure about windows. I use
https://lkml.org/lkml/2017/12/19/141 as a linux kernel module to
evaluate broadcast IPI performance in the linux guest laster year. :)

>
> > I can post one variant for Linux guest PV IPI if it also makes
> > sense. :)
>
> With x2apic support I'm actually not sure. Maybe configurations with
> a very large number of vCPUs and IPIs going to > 256 vCPUs can benefit
> from a 'single hypercall' solution.

Each cluster of x2apic cluster mode can just support 16 unique logical
IDs, so I think linux guest can also get benefit as long as VM has >
16 vCPUs. I will cook patches to evaluate it. :)

Regards,
Wanpeng Li
