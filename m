Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1CBC10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58909207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4zcylc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbfBOPFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:05:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36346 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBOPFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:05:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so4965010pfa.3;
        Fri, 15 Feb 2019 07:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdlq/dEtI363+RqrBnNPZ7uHe1H/unQpX6+JLG3TUso=;
        b=l4zcylc3JZXCQ5dgtx8+3QDOppft9OqAq2m82EUh2nCHYAFX7hShjjFF8JFVHzGJMU
         hDiNoQiA83mgT5zit13fJerL3eNlO8QK0+YJdgH1hgxjc4nMTuTYtTxbkMP44HSfzyC1
         o9oEY99aJsWTakOSwV2WB8m5VTbJRd5qH22G3VA9WavtTAjRArJ/9Bm3YlEG7iolxA9I
         SCYMG3G+yQ9hchXv9kQOT+DKP1hON8ZP35cDUJXFTVYYragi/KhQ1rkV60PemXeFaYjA
         cmLNbLuwyNbKX2Xgppa4lWNGt3Ckvd2kHMHjWbo3JmLRMOiJC4w3YlEJhYzJnj+58FjL
         v1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdlq/dEtI363+RqrBnNPZ7uHe1H/unQpX6+JLG3TUso=;
        b=SYY3z8wuSJntHa3pEchAWUUpmMp0W2ATBRl3O0nu1mAxzwRfwe2Z4TYaPQXcSUbnW9
         2rvK4bnvEALIYzUfzv08eBROXAuG4ZIY0iVhvL3e5RC7aVkehEo6RKzLHuzwPWMiJihK
         2p5N0dLN/zY8dmo8HTg1a1H8nI78tGGS+3zrsLxn/FcPeKmX9uH9EGmCyUtw3oaR7V4W
         HxsA//AlqElmQGRcaWR3zVvxtj4JWsl0Iv7aizUKd4Beyg+xBTjQdI3ogLpGieNzrl2b
         p+zrYUR1mkgSwOOezP4XTW8OdwREldXkPgWgPZXNAFBUk35CgudpbygDxrFEx884N1+g
         4M5A==
X-Gm-Message-State: AHQUAuYaqcQiwpkgRr0T5uObAjfWWTrstQ3KbLR2oXfyp5tQrD6VzDzu
        kFKkNKIxHZxwL1W0gs2wFtIZqvH6Yp3WMxQwfnQ=
X-Google-Smtp-Source: AHgI3IZGOB0YXIwlivSAxLHT4URYYb3+UhrAB9EIaQZQ4W7zt8lv9iT8EbVfih6aM7/Q0WiZpsDnUp+4G9hZ8+OTfjo=
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr5915867pgc.25.1550243132454;
 Fri, 15 Feb 2019 07:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
 <20190202013825.51261-4-Tianyu.Lan@microsoft.com> <572a6ce3-23f6-7b16-a070-4d4a81ee4335@redhat.com>
In-Reply-To: <572a6ce3-23f6-7b16-a070-4d4a81ee4335@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Fri, 15 Feb 2019 23:05:21 +0800
Message-ID: <CAOLK0pzXnvk=FsfjH07jUyRJGpeiNG7-9vR9Vo0mLJtdPnt_7Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/10] KVM/MMU: Add last_level in the struct mmu_spte_page
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
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:32 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/02/19 02:38, lantianyu1986@gmail.com wrote:
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index ce770b446238..70cafd3f95ab 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -2918,6 +2918,9 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
> >
> >       if (level > PT_PAGE_TABLE_LEVEL)
> >               spte |= PT_PAGE_SIZE_MASK;
> > +
> > +     sp->last_level = is_last_spte(spte, level);
>
> Wait, I wasn't thinking straight.  If a struct kvm_mmu_page exists, it
> is never the last level.  Page table entries for the last level do not
> have a struct kvm_mmu_page.
>
> Therefore you don't need the flag after all.  I suspect your
> calculations in patch 2 are off by one, and you actually need
>
>         hlist_for_each_entry(sp, range->flush_list, flush_link) {
>                 int pages = KVM_PAGES_PER_HPAGE(sp->role.level + 1);
>                 ...
>         }
>
> For example, if sp->role.level is 1 then the struct kvm_mmu_page is for
> a page containing PTEs and covers an area of 2 MiB.

Yes, you are right. Thanks to point out and will fix. The last_level
flag is to avoid adding middle page node(e.g, PGD, PMD)
into flush list. The address range will be duplicated if adding both
leaf, node and middle node into flush list.

>
> Thanks,
>
> Paolo
>
> >       if (tdp_enabled)
> >               spte |= kvm_x86_ops->get_mt_mask(vcpu, gfn,
> >                       kvm_is_mmio_pfn(pfn));
>


-- 
Best regards
Tianyu Lan
