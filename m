Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF31C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C571120652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oe3BjouC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C571120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeJWGCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:02:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33420 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbeJWGCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:02:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id q50so41661514otd.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ib2UcmGTPXQPxuj5+v3hHcVygVb/GMm0sygsdffu/s8=;
        b=oe3BjouCTUrtHZ2FtL9O5reLIX7f2Ql6XW2DxGbjFIDS3Osf6YdW9wgBwD3mbUBrFs
         ym6JbKCNbCIpEiTKW9LrCydsaXJ/e39yqUfGH2+tip9Sf6rZLEt7U2sEadzzYAfgbgZg
         idXbElkJXozNxql3FZu/9Tp6Q1pVyWOk2qH52XV28+EBI8LkvSJod78X3Qo4RyuOdlLF
         GMbcghnfEuWH5UiJBCRmLHLCYyrzK7IungHe9GWmwP/gw+iTYNJmJK3ZPeazMzy3tsH9
         GrFLMOLOT46ATuBMTTXW9CTeJ6KL+N7zsdmcnIaN7zoZRUbGgtm843UPgnQOcCfv2kIV
         wrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ib2UcmGTPXQPxuj5+v3hHcVygVb/GMm0sygsdffu/s8=;
        b=r3aWjxwMSshm2cxYcPInqpAtRH6GszJGwCK5embDgY7UXCi7bfR1aTZHVAkUc1AHYx
         r4QT1X8vV3BsakyxIwj6WiZblsA2LHX1oBXAlFEfzjuLKYtOQcK0oHuATnhRk9ycoJQe
         GiKP5dOd8YaAm6mcS3ZyFMU9RCXB3KEsScjw10DO2hWgqSiZTzqQTpBP/nMYa+l1M/JW
         FQ/E+bemQ1y/FNPNoJSougaKO4dszaGpSXTpbr9GPVqQ/+AlzfVO+5SyVT03S6CFmo55
         hhkDRXpJdJ5YzfiPQvUZOP1mgj+Z6XDW5uSBEH41dqfo8iXu/Yt2/iNnmsfhNeagvtOB
         GHsA==
X-Gm-Message-State: ABuFfoi44kRSLpM3VKyCnyTmZyCkKLH7ejF4rzBQHH2l9rroTHA9DoXG
        yIeT27EdlIhUCHT8EblRCOPWnkjRUbmkZBBg9l1Lfg==
X-Google-Smtp-Source: ACcGV6375H0TEOSM5IuM1rsnD5FsWHpbFE57v/mH73/UkWUjArQA76ld1qIqBPBR6LDXzz0zIdISZgkV88yIxsCDwoQ=
X-Received: by 2002:a9d:da2:: with SMTP id 31mr27721571ots.246.1540244556427;
 Mon, 22 Oct 2018 14:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2ac9:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 14:42:35
 -0700 (PDT)
In-Reply-To: <1540074145-31285-7-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de> <1540074145-31285-7-git-send-email-karahmed@amazon.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 22 Oct 2018 14:42:35 -0700
Message-ID: <CALMp9eRh2syfY9KjaH9h=AA1dwRnKb+S-NXEB3Hn+tjQoSrBXg@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] KVM/nVMX: Use kvm_vcpu_map when mapping the L1
 MSR bitmap
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 3:22 PM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
> Use kvm_vcpu_map when mapping the L1 MSR bitmap since using
> kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
> a "struct page".
>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v1 -> v2:
> - Do not change the lifecycle of the mapping (pbonzini)
> ---
>  arch/x86/kvm/vmx.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index d857401..5b15ca2 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -847,6 +847,9 @@ struct nested_vmx {
>         struct page *apic_access_page;
>         struct page *virtual_apic_page;
>         struct page *pi_desc_page;
> +
> +       struct kvm_host_map msr_bitmap_map;
> +
>         struct pi_desc *pi_desc;
>         bool pi_pending;
>         u16 posted_intr_nv;
> @@ -11546,9 +11549,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>                                                  struct vmcs12 *vmcs12)
>  {
>         int msr;
> -       struct page *page;
>         unsigned long *msr_bitmap_l1;
>         unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
> +       struct kvm_host_map *map = &to_vmx(vcpu)->nested.msr_bitmap_map;
> +
>         /*
>          * pred_cmd & spec_ctrl are trying to verify two things:
>          *
> @@ -11574,11 +11578,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>             !pred_cmd && !spec_ctrl)
>                 return false;
>
> -       page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
> -       if (is_error_page(page))
> +       if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), map))

Isn't this the sort of high frequency operation that should not use the new API?

>                 return false;
>
> -       msr_bitmap_l1 = (unsigned long *)kmap(page);
> +       msr_bitmap_l1 = (unsigned long *)map->hva;
>         if (nested_cpu_has_apic_reg_virt(vmcs12)) {
>                 /*
>                  * L0 need not intercept reads for MSRs between 0x800 and 0x8ff, it
> @@ -11626,8 +11629,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>                                         MSR_IA32_PRED_CMD,
>                                         MSR_TYPE_W);
>
> -       kunmap(page);
> -       kvm_release_page_clean(page);
> +       kvm_vcpu_unmap(&to_vmx(vcpu)->nested.msr_bitmap_map);
>
>         return true;
>  }
> --
> 2.7.4
>
