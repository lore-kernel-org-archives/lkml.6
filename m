Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A35FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B1D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDjNCFmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfAGFOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 00:14:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37029 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbfAGFOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 00:14:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so20207545pgb.4;
        Sun, 06 Jan 2019 21:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkcm1HTbMQBDwve8/v16eQj6g2NpqtytScttFvde1sI=;
        b=TDjNCFmoJrm+GqQkTwUJs2zJ9JR4ndHopbHKyvuC3qFVRSV8H9d+pteoP53xeDgVJ/
         BVDSUiAmcgwcS4PiJmoJTK8R8C/E/d+OefgCTl88z0jEXs9ltiHJJqGN5Du15ClEX9vp
         qniTw3SKWriemK3Rddiv8yfbFJI8SvUZBezNiE08BtP6ikrGN+gzn0Ui3YF59Q7xIA2H
         eif0b60ulE18GWwu9mUPlliP4IRdxhzpqSjvPkHg62BzYeXG+7K5z+VoW9fHB4QMgy6U
         /a4qTeYgWZpk6WRCyKEmzlOTVqpf0ZlfS4KjQpV0SiOrUDaDWzrI0lXMzk6o5sZ7p6uI
         s/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkcm1HTbMQBDwve8/v16eQj6g2NpqtytScttFvde1sI=;
        b=EHSb04ZpFtlBxaeezXzR6PXEsVPJ6WjPMCZkp5O8pF9RC1AU8fg91LZm5AOhdpyHBg
         hEa+UKTOTSy86MFNLJvVhHBCDE1Ls7PkshUl+xjIELT4nnI0OmN5QzISNxcAbwZwjbal
         p+KBHTYihT310wrPlJ782LSUufNlqRWfY7KjBZpK2lKGh2nCF8890LYi40fLJObcu+HM
         4g1+wEoWE2H2BsosSnit8Gyp1dUOh3nS7hRqOc7zaEr0FdfA2BpFWN+aIwzAnES3/9vX
         3M/CqVAbHt7hRkVa3id2rl9pGYn7ZAfdRA+UpHQ4QxNtMXYndDbPUf7eH7Fbq8QmV9Ii
         yHAw==
X-Gm-Message-State: AJcUukea+fzldw4bcNUtOjh8K5zfhDrWfPs/SfXDSZjfDQ0rOM5N/agz
        bZAaPlqpXLBW0hGcqF2pgBQIM8tuWtL6CrfF9Ys=
X-Google-Smtp-Source: ALg8bN6ETe1B9Q5up9Hz9+4Q4Khc8bwT2716MN0eJrPgrbPk5aEqN1u7xxt9RAxMs1TCeO7x9mqiJ4rAUgtKjunlSgk=
X-Received: by 2002:a63:da14:: with SMTP id c20mr9334574pgh.233.1546838050378;
 Sun, 06 Jan 2019 21:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-7-Tianyu.Lan@microsoft.com> <20190104163035.GC11288@linux.intel.com>
In-Reply-To: <20190104163035.GC11288@linux.intel.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 7 Jan 2019 13:13:59 +0800
Message-ID: <CAOLK0pyMbKuxA0KnsRz_92jr5j15YXb2yUP0GH-xE06BqO_zTA@mail.gmail.com>
Subject: Re: [PATCH 6/11] KVM/MMU: Flush tlb with range list in sync_page()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm <kvm@vger.kernel.org>,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 12:30 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Jan 04, 2019 at 04:54:00PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > This patch is to flush tlb via flush list function.
>
> More explanation of why this is beneficial would be nice.  Without the
> context of the overall series it's not immediately obvious what
> kvm_flush_remote_tlbs_with_list() does without a bit of digging.
>
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  arch/x86/kvm/paging_tmpl.h | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
> > index 833e8855bbc9..866ccdea762e 100644
> > --- a/arch/x86/kvm/paging_tmpl.h
> > +++ b/arch/x86/kvm/paging_tmpl.h
> > @@ -973,6 +973,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> >       bool host_writable;
> >       gpa_t first_pte_gpa;
> >       int set_spte_ret = 0;
> > +     LIST_HEAD(flush_list);
> >
> >       /* direct kvm_mmu_page can not be unsync. */
> >       BUG_ON(sp->role.direct);
> > @@ -980,6 +981,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> >       first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
> >
> >       for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
> > +             int tmp_spte_ret = 0;
> >               unsigned pte_access;
> >               pt_element_t gpte;
> >               gpa_t pte_gpa;
> > @@ -1029,14 +1031,24 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
> >
> >               host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
> >
> > -             set_spte_ret |= set_spte(vcpu, &sp->spt[i],
> > +             tmp_spte_ret = set_spte(vcpu, &sp->spt[i],
> >                                        pte_access, PT_PAGE_TABLE_LEVEL,
> >                                        gfn, spte_to_pfn(sp->spt[i]),
> >                                        true, false, host_writable);
> > +
> > +             if (kvm_available_flush_tlb_with_range()
> > +                 && (tmp_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)) {
> > +                     struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
> > +                                     & PT64_BASE_ADDR_MASK);
> > +                     list_add(&leaf_sp->flush_link, &flush_list);
> > +             }
> > +
> > +             set_spte_ret |= tmp_spte_ret;
> > +
> >       }
> >
> >       if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
> > -             kvm_flush_remote_tlbs(vcpu->kvm);
> > +             kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
>
> This is a bit confusing and potentially fragile.  It's not obvious that
> kvm_flush_remote_tlbs_with_list() is guaranteed to call
> kvm_flush_remote_tlbs() when kvm_available_flush_tlb_with_range() is
> false, and you're relying on the kvm_flush_remote_tlbs_with_list() call
> chain to never optimize away the empty list case.  Rechecking
> kvm_available_flush_tlb_with_range() isn't expensive.

That makes sense. Will update. Thanks.

>
> >
> >       return nr_present;
> >  }
> > --
> > 2.14.4
> >



-- 
Best regards
Tianyu Lan
