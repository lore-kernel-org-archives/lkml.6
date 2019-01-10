Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CD9C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38F8214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTGY9Vaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfAJJGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:06:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39794 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfAJJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:06:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so5016956pfc.6;
        Thu, 10 Jan 2019 01:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oq80hyIRxc7kD/9H1MyYY3fFLvm60ShEsiOlrZc3KYA=;
        b=hTGY9VawGhKjAEPgrRt1SPQT4EG5iuZqoIW1KBax7pl8YNTXG4Vfd9yFbNqVTP6CKq
         Lq9gCQr172eU4c6qB+2ZJoksKKEV0IrNS25SJMIWPuxgIbu6deseS3OSzEsbAJy2YeM+
         nA4gDJwymhlOM0pD950PKH7w1M22eiN5i/ObZwBQeq8LJFMBXiVzhVcTAUMlKc5aXzrp
         9vkvrrM9VLbJcerBTbmQuUZK6eUWVSVly6mIouFlvpkaK7mBPZywI4SN2+PEgTyQNXlk
         0civggBqSPQuln3CUOhsBUZ7jfJwDRjbFCyzKA0fficEthHyKNDX96C2SNbZYYLG6FHc
         VpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oq80hyIRxc7kD/9H1MyYY3fFLvm60ShEsiOlrZc3KYA=;
        b=QWfUPOzrHS4YFNUcHs9YKYE8lKF7bEP5yflxcK1vgPxSEp/UFiAFOFv2RcstRpuf+5
         VvYTluPE5hcDOtj3eSKYY0BWgKoyFHgkt9uTgcg+IkqdtjOztpmX8SsAaEZdtuGc4U2z
         PYYopwL8uMlogI/RNO+mG1WlpA0NehABFLOZohrxL3MnvEjJDGo85Y6KdNQcTlxK54A0
         yN5Ta0hJu4BfPZx8o7EkS6L/7w9c6/06IYSNtPxwu5Um3iI+Dhw21vYR+4/BYeTWSS4W
         uoeQ9S2QIth9VPO6xnwhunEM0cRuvgd+kF6/be/un0LBI9rfyotTo6jBqtbRajDjOqra
         BhYw==
X-Gm-Message-State: AJcUukc5EgEmZhE3IrQYpeK/Ci0nGO092Xe3C37awzz/197fYTpf5gsx
        cDohGUi2fmpOoxUUd8TPfhgDZsL4YDAYxnsm8Pg=
X-Google-Smtp-Source: ALg8bN4BE6q8xxDDtq+YuLH5+cixz7d0oBOOvQbl+bRUmSLVR5oY8KTP6B615fpl1R0lgmzzlO6hmmnE0EIbQpvPK5o=
X-Received: by 2002:a63:da14:: with SMTP id c20mr8224322pgh.233.1547111196652;
 Thu, 10 Jan 2019 01:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-10-Tianyu.Lan@microsoft.com> <7eb0cde4-9436-9719-dd13-caf4ab5083a2@redhat.com>
In-Reply-To: <7eb0cde4-9436-9719-dd13-caf4ab5083a2@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Thu, 10 Jan 2019 17:06:25 +0800
Message-ID: <CAOLK0pz6K90+QOMV2Vmhd3vC2t5+15vmUo0E=2rwax7cGDfxjw@mail.gmail.com>
Subject: Re: [PATCH 9/11] KVM/MMU: Flush tlb in the kvm_mmu_write_protect_pt_masked()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
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

On Tue, Jan 8, 2019 at 12:26 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/01/19 09:54, lantianyu1986@gmail.com wrote:
> >               rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
> >                                         PT_PAGE_TABLE_LEVEL, slot);
> > -             __rmap_write_protect(kvm, rmap_head, false);
> > +             flush |= __rmap_write_protect(kvm, rmap_head, false);
> >
> >               /* clear the first set bit */
> >               mask &= mask - 1;
> >       }
> > +
> > +     if (flush && kvm_available_flush_tlb_with_range()) {
> > +             kvm_flush_remote_tlbs_with_address(kvm,
> > +                             slot->base_gfn + gfn_offset,
> > +                             hweight_long(mask));
>
> Mask is zero here, so this probably won't work.
>
> In addition, I suspect calling the hypercall once for every 64 pages is
> not very efficient.  Passing a flush list into
> kvm_mmu_write_protect_pt_masked, and flushing in
> kvm_arch_mmu_enable_log_dirty_pt_masked, isn't efficient either because
> kvm_arch_mmu_enable_log_dirty_pt_masked is also called once per word.
>
Yes, this is not efficient.

> I don't have any good ideas, except for moving the whole
> kvm_clear_dirty_log_protect loop into architecture-specific code (which
> is not the direction we want---architectures should share more code, not
> less).

kvm_vm_ioctl_clear_dirty_log/get_dirty_log()  is to get/clear dirty log with
memslot as unit. We may just flush tlbs of the affected memslot instead of
entire page table's when range flush is available.

>
> Paolo
>
> > +             flush = false;
> > +     }
> > +
>


--
Best regards
Tianyu Lan
