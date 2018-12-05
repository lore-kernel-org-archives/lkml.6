Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F407AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EEA20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPt0qcNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EEA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeLEXKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:10:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38168 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeLEXKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:10:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so20332823otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKWGlg2UOSjs1lv56V75iwQ/7WJY8e6vN8MAabWosoA=;
        b=ZPt0qcNZIB62WVzH0gyDiayM4HyGaDIXyiLFZNA5IM5WnzCEjx1+jeC3w4A6tBvKE6
         8EeUYnb/IPqJnGLvX7pTeC3WeAynqdc/CkbDEbwJHeMXUJaWXFD7jWVdRrCZWrOwOiuN
         GeV4lbbmwuGFoXgSA5VNrTHiNQSS+TUhVfcISg42VIXk+XSk38pmu11Qzn6hPIaXsJEb
         G/yMsbg/5w6IqdIbmxFeW89RFmAKOPu1PbSTTHtY9VcaOM/ggIvTNwAD0YvV5nPZv6mr
         10ZsgcxA2Id2wljj0eIXRRNOs/5pvHAQjdVhm7hAeLMoV8n9dIE9afBiWZjMHFIpXUwD
         TAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKWGlg2UOSjs1lv56V75iwQ/7WJY8e6vN8MAabWosoA=;
        b=feDcdJ9WokzZBx7HUL2W8kpzOm7lL/Y3FL5etKkoNvJP/xxWkxDJyv3ztRjlaOvI1R
         TdzK89of3+2fS8SIjEInKaUyMlFFG6+0Lus3Blwioi2NXH9vYep+UJ+cV7vSkCTr67zy
         2FHBtwYQrEzJEobnkMQdOyCc/SQup9c3oke4MkkuiWBynveX4YdPIkZrxdchN1Q8vDWJ
         WDlXXih7WAPxhpQqeV0ZrjE635aV+HLhYrymdLLQ086q9N4aANt7n5zk+0YBczFS8yr7
         DRC9v6uJXhtLxBnZyL5PKyNt3b8W3nlY9YcKb4rPG/5F/vPbeJ4H7C0FDoOSyTtyDCkv
         pZNQ==
X-Gm-Message-State: AA+aEWaIKaY+KMCAAsMj0kISLsxTf8NBAGvvlm8+6n3ITXyzJK72fZC+
        wzrQaJ9IYMCou3uGqbxvdyJzsFkFIbiCBSeCekE4sQ==
X-Google-Smtp-Source: AFSGD/X2llRnM9ET7rdCH4YdW88RrUlXNDacnBSDaGl9RM0ixx72CLvGhuNf4bL9/ZezHkNF6q65bVXQ2Jvw0BC+0+U=
X-Received: by 2002:a9d:bee:: with SMTP id 101mr17358342oth.120.1544051413740;
 Wed, 05 Dec 2018 15:10:13 -0800 (PST)
MIME-Version: 1.0
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de> <1543829467-18025-3-git-send-email-karahmed@amazon.de>
In-Reply-To: <1543829467-18025-3-git-send-email-karahmed@amazon.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 5 Dec 2018 15:10:02 -0800
Message-ID: <CALMp9eSX99cd3-XCCJOySVPXwxt=fx0zOczzq0ictDFNU1rqNw@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] X86/nVMX: handle_vmptrld: Copy the VMCS12
 directly from guest memory
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 1:31 AM KarimAllah Ahmed <karahmed@amazon.de> wrote:
>
> Copy the VMCS12 directly from guest memory instead of the map->copy->unmap
> sequence. This also avoids using kvm_vcpu_gpa_to_page() and kmap() which
> assumes that there is a "struct page" for guest memory.
>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v3 -> v4:
> - Return VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID on failure (jmattson@)
> v1 -> v2:
> - Massage commit message a bit.
> ---
>  arch/x86/kvm/vmx.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index b84f230..75817cb 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -9301,20 +9301,22 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>                 return 1;
>
>         if (vmx->nested.current_vmptr != vmptr) {
> -               struct vmcs12 *new_vmcs12;
> -               struct page *page;
> -               page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
> -               if (is_error_page(page))
> -                       return nested_vmx_failInvalid(vcpu);
> +               struct vmcs12 *new_vmcs12 = (struct vmcs12 *)__get_free_page(GFP_KERNEL);
> +
> +               if (!new_vmcs12 ||
> +                   kvm_read_guest(vcpu->kvm, vmptr, new_vmcs12,
> +                                  sizeof(*new_vmcs12))) {

Isn't this a lot slower than kmap() when there is a struct page?

> +                       free_page((unsigned long)new_vmcs12);
> +                       return nested_vmx_failValid(vcpu,
> +                                                   VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);

I agree with David that this isn't the right thing to do for -ENOMEM.
