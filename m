Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F61BC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825E520674
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bee3765Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825E520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeJWFxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:53:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44827 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeJWFxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:53:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so33488245oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cds5zw2071i/hH6b+s9eTBNdfqHThkCE6lw/l4JIBD4=;
        b=Bee3765ZxHVcjtm4g2h2JjASJHhIyIgT4+3k3EhsejAQQ65Gz2Gn66JupVgyOY9oQv
         RPgVdVxOYFbUYVE+1U1BINiuI7NFNS11a/v4TY7yzpX+xrnbbe2escMyP58Qu4gFcJLt
         9foU9jYZA5vM/IceTA9nCfgJvBIgymW0yz0vWhE+v+owzL/w1DxpFT+3xvdAlb6KegXB
         alSpoPO3lMw26A9Fb13J+ZxfCFFfmM247aBwEwvVhxJOSMrIhS17D8C6IqY3HsjaD97T
         hnqr4U5iHyCxdrpKMX5foNBIHDh4zw4XffTp53wxUyBKYPGYoNC0QTdWOGZ8Z9fUAynb
         Hvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cds5zw2071i/hH6b+s9eTBNdfqHThkCE6lw/l4JIBD4=;
        b=X1td/MKv/PflydPkfGOa5yL1LorEw1sDVGzEpdp2KabHXuGjcoZlg4lBr0M9Xj7BxP
         qcwPjQpQErbRat8hm61P8xHdWKzX1iRSzc1v37L2rasujN6clBI8n1SihwutqWzbsk6q
         svxR0JTmoYPxbzmYxL7UHGvZI1adm128ijVlISV9qjhfQpBETP22781QPWDml67kKcMk
         pJrBfNVrxaQXhd88zAINkztobtt5GHR56NQycT8i/5P96xlL89P46F/4D5k/SjgxSdKm
         VULGlM1KHT/looUMTEuVzQB7l+2ltW+0RVWwIQhISVv7aybDZ2PzKVEqMxZ2FueLSlfG
         u2yQ==
X-Gm-Message-State: ABuFfoh2nBBFyl5npIfwzwBcpuPkM3McxppuP2owLvTbafQ3H3ndEJz6
        6JQMCcVQJALONYP0tPDcUTUQswNSNCr+o8q5XW20Mw==
X-Google-Smtp-Source: ACcGV61FQEHmUgmcwy2PfNplMy9OYC8bxO5fmmbiPId5TBm0teeTxIiT7B8JyUgzVORKu1gXITKvktPjmGbr/KOc2v8=
X-Received: by 2002:aca:60c5:: with SMTP id u188-v6mr25900811oib.4.1540243973336;
 Mon, 22 Oct 2018 14:32:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2ac9:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 14:32:52
 -0700 (PDT)
In-Reply-To: <1540074145-31285-3-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de> <1540074145-31285-3-git-send-email-karahmed@amazon.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 22 Oct 2018 14:32:52 -0700
Message-ID: <CALMp9eQfMOjwS2R-9d_9m8z2+XKdvg2FaL65q83DR-RhxLkf3g@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] X86/nVMX: handle_vmptrld: Copy the VMCS12
 directly from guest memory
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
> Copy the VMCS12 directly from guest memory instead of the map->copy->unmap
> sequence. This also avoids using kvm_vcpu_gpa_to_page() and kmap() which
> assumes that there is a "struct page" for guest memory.
>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v1 -> v2:
> - Massage commit message a bit.
> ---
>  arch/x86/kvm/vmx.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 358759a..bc45347 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -8879,33 +8879,28 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>         }
>
>         if (vmx->nested.current_vmptr != vmptr) {
> -               struct vmcs12 *new_vmcs12;
> -               struct page *page;
> -               page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
> -               if (is_error_page(page)) {
> +               struct vmcs12 *new_vmcs12 = (struct vmcs12 *)__get_free_page(GFP_KERNEL);
> +
> +               if (!new_vmcs12 ||
> +                   kvm_read_guest(vcpu->kvm, vmptr, new_vmcs12,
> +                                  sizeof(*new_vmcs12))) {
> +                       free_page((unsigned long)new_vmcs12);
>                         nested_vmx_failInvalid(vcpu);

I believe that this failure, like the one below, should be:

nested_vmx_failValid(vcpu, VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);

First, if there is a valid current VMCS, then nested_vmx_failInvalid
is incorrect. Second, if there is no backing memory, then by PCI bus
error semantics, we should read all 1's, which isn't the correct VMCS
revision ID.

>                         return kvm_skip_emulated_instruction(vcpu);
>                 }
> -               new_vmcs12 = kmap(page);
> +
>                 if (new_vmcs12->hdr.revision_id != VMCS12_REVISION ||
>                     (new_vmcs12->hdr.shadow_vmcs &&
>                      !nested_cpu_has_vmx_shadow_vmcs(vcpu))) {
> -                       kunmap(page);
> -                       kvm_release_page_clean(page);
> +                       free_page((unsigned long)new_vmcs12);
>                         nested_vmx_failValid(vcpu,
>                                 VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
>                         return kvm_skip_emulated_instruction(vcpu);
>                 }
>
>                 nested_release_vmcs12(vmx);
> -               /*
> -                * Load VMCS12 from guest memory since it is not already
> -                * cached.
> -                */
>                 memcpy(vmx->nested.cached_vmcs12, new_vmcs12, VMCS12_SIZE);
> -               kunmap(page);
> -               kvm_release_page_clean(page);
> -
> +               free_page((unsigned long)new_vmcs12);
>                 set_current_vmptr(vmx, vmptr);
>         }
>
> --
> 2.7.4
>
