Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E70C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8BC20660
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egwE/USG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfAGDnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:43:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44904 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfAGDnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:43:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so20095684pgr.11;
        Sun, 06 Jan 2019 19:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4Vbstej3VAneOE8NJl/qUzPSkF2WggfusBmTAKBwUM=;
        b=egwE/USGm5sivqG2SMXhrkv2m9V3/DD1HlR622ysYAGPHkmSnEOCF9tvQDNpiqh6Gx
         HU6F2ntNdxircs+47ceJ1Pe+caNmHQz6v/uVT3McBCAQYTVbdVGpRNhOJUUEif+qHbZP
         PD32ddRLFcQC/cWzY3muIB/H31OeXlqr5lKf3ZYs3VONuS7C6zH2q8sPWsjPmiKJTeR8
         x0yd0qFAycy/h/94Po1zBBCCPUVJot9aeT9NAYpBlxeFGjT2ErVPAj4TLJrscdzycK+W
         DDiteSM+l/9IaXJWPr/odNNDHQnRg5V2vHEV5BV5wLfrPwOuFpO9Nrdz3FIM4mSX/HC8
         HqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4Vbstej3VAneOE8NJl/qUzPSkF2WggfusBmTAKBwUM=;
        b=uQdzE4jmX321y4fPRk7zvsHeXt4qUn0z8bT73de9NowfDnfA8V8L80cYDIXGXytyMv
         enScERgEFZK86JWjBx95BlysD4QfohY8q0TZU6vQu4C4TzqW5zZ9iEyXArC+EPaN5cJ3
         s5sLgMxqJEu4pcsjWBlPiacADm6m4CaSZTg8mJicx+C9rzhWoHWI6NGQ2QE4ozud5NzE
         dR6D4e4PhgNLNFM1IzW6Mrpt5MJanEFShvpCFivIZh439WaefjGIO07kNVJDT9gS3JTg
         DjfGHmLVMQM7u/kBk2M2/2RfqllOp70i/ECw7Rr2cXKDBP86+UviuWAd+4+acgIiyMvF
         WV9A==
X-Gm-Message-State: AJcUukfwR/a0ynNoYxrQ3B4u5978Sf4hlt2ftAzliGqwWtmPQ5VLDvfT
        KMZSzW4Q88vrj9sJI5NdMyf8T6DntZjyug2Z9Gw=
X-Google-Smtp-Source: ALg8bN4k587ha4oJ6zDfdpMVPqjrdrOo683otyk5Siz2e8ACUXH76j8cA6JQaoq2n84HuebQTd2HvPahHXDcL0Iqw/Y=
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr29286395pgc.25.1546832590303;
 Sun, 06 Jan 2019 19:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-12-Tianyu.Lan@microsoft.com> <20190104161235.GB11288@linux.intel.com>
In-Reply-To: <20190104161235.GB11288@linux.intel.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 7 Jan 2019 11:42:59 +0800
Message-ID: <CAOLK0pzPe3agXCFrvHt9Qa_kRVfdtYeKorbRL2waOo29f5wcyw@mail.gmail.com>
Subject: Re: [PATCH 11/11] KVM/MMU: Flush tlb in the kvm_age_rmapp()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm <kvm@vger.kernel.org>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com, linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean:
             Thanks for your review.

On Sat, Jan 5, 2019 at 12:12 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Jan 04, 2019 at 04:54:05PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > This patch is to flush tlb in the kvm_age_rmapp() when tlb range flush
> > is available and flush request is true.
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  arch/x86/kvm/mmu.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index a5728f51bf7d..bc402a72956a 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -1958,10 +1958,17 @@ static int kvm_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
> >       u64 *sptep;
> >       struct rmap_iterator uninitialized_var(iter);
> >       int young = 0;
> > +     bool flush = (bool)data;
> >
> >       for_each_rmap_spte(rmap_head, &iter, sptep)
> >               young |= mmu_spte_age(sptep);
> >
> > +     if (young && flush) {
> > +             kvm_flush_remote_tlbs_with_address(kvm, gfn,
> > +                             KVM_PAGES_PER_HPAGE(level));
> > +             young = 0;
> > +     }
> > +
>
> young shouldn't be cleared, the tracing will be wrong and the caller
> might actually care about the return value.

Yes, this is wrong and will update.

> I'm assuming you're
> clearing young to avoid the flush in kvm_mmu_notifier_clear_flush_young(),
> but keeping that flush is silly since it will never be invoked.  Just
> squash this patch with patch 10/11 so that you can remove the unnecessary
> flush in kvm_mmu_notifier_clear_flush_young() and preserve young.
>

The platform may provide tlb flush with address range as granularity. My changes
are to use range flush when it's available. kvm_mmu_notifier_clear_flush_young()
is common function for all platforms and most platforms still need the
flush in the
kvm_mmu_notifier_clear_flush_young(). I think it's better to separate
flush request and
"young" from return value of kvm_age_hva(). New flush parameter I
added in the patch 10
can be changed to a pointer and kvm_age_hva() can use it to return
flush request.

-- 
Best regards
Tianyu Lan
