Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134B62133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxC5os3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbeLQOJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:09:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44103 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbeLQOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:09:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so6424838pfh.11;
        Mon, 17 Dec 2018 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9INxQF6ba+WhvjvlUupOU5hyjZrvqQnqOZkjDUpVdjg=;
        b=WxC5os3McpR/wAfBbZki8xMmR7AXRcmmrgeE9RoTghG7ekbV9+oSfWN2fRiXq65rC6
         ij3iI5TvroLzzHZHCocAwjc9wQ4pB7ZzEqU0D7c0hL3SunUP52Lav00fxbQb7m5WOzHW
         kFzaMdqMEfsmVoNlpgURmx0vFwFoP/bLqKLTSFPm5nBLAJMPUkkC0pAODIHXz9F3wLjk
         rG5Ak20nX4Hhjn0hWgjBMTkgNdpiMQuchZ/J4UfSt4lyVD5soPtb2InRD4ma3ujocvr/
         CCID5EQbzsm5gTNfPcD/DTBQ4kENor0eLK6PeOwkUJnH2Q6XXeL9LXFPCW2SmefX9l33
         Ty9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9INxQF6ba+WhvjvlUupOU5hyjZrvqQnqOZkjDUpVdjg=;
        b=Rz8V0qIw0iGRjLBrUzwOROL+LniDIIfB9WOKwfRrf8mXM0v5W3ryPhSzZEFv7AOBem
         bXNiQrLwSD6ZpYrtUCk0uFhCNyoShhKzGKo9e2O4hrFdlHP7m/cAYNE9akMgNh3zhdvJ
         +y8tz4BZAj6o5gJdoCghi7yJA7b+PAQmx0ISdPe1d3qTen8Yr2fECWx8cbHJMQnOOklA
         FPIEJ9x6AFGYOIJ44vhIEsiUzohnLOuxOIGXm9swtXii66Xh+5wCIj7Z01HkmN5C9XOU
         aP9fy4jLOhE8rl3S8pSOTqYieiMblUtJ2AgNRzamoSmYcNGfHxNKH99Ch8kub+4PaQpM
         nUdA==
X-Gm-Message-State: AA+aEWaiIsLIbfECLJbviR+jYcIFqick49FEg8X4uv5DFFLibnujGsaU
        HzhsAGNC5zCqkeLImjmyTiAXWdWjotIpOz907k0=
X-Google-Smtp-Source: AFSGD/X0zLV7+9XbcX5OYMMX6JoAI2Z75kXzme+SHNhbFYfDNnLICVfwZSzhssFPSxlmIOVCdLJysMlBpUvUATK7ynQ=
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr12558929pgc.25.1545055740549;
 Mon, 17 Dec 2018 06:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20181206073437.1995-1-Tianyu.Lan@microsoft.com> <eb059d1b-78c9-035d-d601-e397df292212@redhat.com>
In-Reply-To: <eb059d1b-78c9-035d-d601-e397df292212@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 17 Dec 2018 22:08:49 +0800
Message-ID: <CAOLK0pyv8a2ou3THn9h71BQT2ZXfaRQdzNjZAmMxzs8TYFnw=w@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] KVM/VMX: Check ept_pointer before flushing ept tlb
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm <kvm@vger.kernel.org>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 7:00 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 06/12/18 08:34, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > This patch is to initialize ept_pointer to INVALID_PAGE and check it
> > before flushing ept tlb. If ept_pointer is invalid, bypass the flush
> > request.
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
>
> Can you explain better *why* this patch is needed?
Yes, hypercall still maybe called when ept_pointers aren't
initialized. Such case happens
during guest boot up when BP works at first and APs aren't activated.

>  Also, should vmx->ept_pointer be cleared at reset time, rather than vCPU creation?
>

Yes, that make sense. Thanks for suggestion.

> Thanks,
>
> Paolo
>
> > ---
> >  arch/x86/kvm/vmx.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index c379d0bfdcba..6577ec8cbb0f 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -1582,11 +1582,18 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
> >       /*
> >        * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
> >        * base of EPT PML4 table, strip off EPT configuration information.
> > +      * If ept_pointer is invalid pointer, bypass the flush request.
> >        */
> >       if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
> > -             kvm_for_each_vcpu(i, vcpu, kvm)
> > +             kvm_for_each_vcpu(i, vcpu, kvm) {
> > +                     u64 ept_pointer = to_vmx(vcpu)->ept_pointer;
> > +
> > +                     if (!VALID_PAGE(ept_pointer))
> > +                             continue;
> > +
> >                       ret |= hyperv_flush_guest_mapping(
> > -                             to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer & PAGE_MASK);
> > +                             ept_pointer & PAGE_MASK);
> > +             }
> >       } else {
> >               ret = hyperv_flush_guest_mapping(
> >                               to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
> > @@ -11614,6 +11621,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
> >       vmx->pi_desc.nv = POSTED_INTR_VECTOR;
> >       vmx->pi_desc.sn = 1;
> >
> > +     vmx->ept_pointer = INVALID_PAGE;
> > +
> >       return &vmx->vcpu;
> >
> >  free_vmcs:
> >
>


-- 
Best regards
Tianyu Lan
