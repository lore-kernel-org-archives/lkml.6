Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D052063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIfqP7mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfBZTbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:31:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40592 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:31:24 -0500
Received: by mail-it1-f196.google.com with SMTP id l139so3890029ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/27UOZuBPxdLcxWVH/Nj+1hb2KlIJLPyFaHeHdsEkI=;
        b=IIfqP7mQD1roA4R4rH++YkgKkiqjsHvjD+qTt8VUHfqdTFhvk7JmlYgmOm8o2kCXy2
         jBHyx2muVXHyLUVYykALf8P3EXxPu1269djylgDqh34XQmdhr8QGiD7cOXUazKV8jW3T
         rZYnEGt1DjcL2fU5ISIaidztEMneXcH8rJWtb+ffnLBlUVzx6gb4jialNnoloDzkj3VU
         4dIumfHn6RiAp2+eAnhJtnVbOkdez0SFqvxxzZaxBF84VychpT9aquuWf+43uEuBFMUU
         Yyiv1ZaeHpkqJLgFS0Ev1qTTJPL/91kHEmPmY3o5NYXL4ga2S8/LNEMeqCHJCV4qMrpE
         Mlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/27UOZuBPxdLcxWVH/Nj+1hb2KlIJLPyFaHeHdsEkI=;
        b=ZMPXrmIEjKz/3EmCoQBf2PxZKO/t/w8zQ+md8rhsQx/q0mDJ44VDO5gnIznNANT7JA
         alo2s/bvAmAlkNnN4Nu9OZrknA11L3kk0uqRzDbS9dKLeo3VEVxQ/1XW4fBflu+osJfN
         w0deqvorpLnR4W+nx0O0Wcv/jCHO2Cl7QbfDqwaZmCPQ6qRUArVHWGPwNIL96nmn8ymD
         bBVpZa626McY1QHS1jja4RH68XZLTMbPTllq3HQzFdmHPw2ZBQGpyo63nIzsE8j1sUzE
         3/KIFqWofFMsYdEvNfckEzGIj/FN59JYuZudryBrmdktenkmsrZpS8GDmBnc8cVjEIFm
         I5rw==
X-Gm-Message-State: AHQUAuYnkW3My+Pn60dSCao5gSARwxOuTOiW5l03gBV8yRYwQXskAeB1
        6FHRRPAZKcK31Y3KaNFMcs3KBawPVd5WNEPKT06SsQ==
X-Google-Smtp-Source: AHgI3IaiOj1ETy4Th4Ei5DFVOwcUsTJ37aV8O4KQB8ykdghLto8MnYIr5d4zhF2+ItKcxm5DZRltWvg/E9foaqo4/Ew=
X-Received: by 2002:a02:41d9:: with SMTP id n86mr7076654jad.4.1551209483232;
 Tue, 26 Feb 2019 11:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20190225132716.6982-1-weijiang.yang@intel.com> <20190225132716.6982-2-weijiang.yang@intel.com>
In-Reply-To: <20190225132716.6982-2-weijiang.yang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 26 Feb 2019 11:31:11 -0800
Message-ID: <CALMp9eSnkrk+chKkyGcToqdnvScQ0hJ0eWZ89Y_dccOrEuYHTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] KVM:VMX: Define CET VMCS fields and bits
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:32 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
>
> CET - Control-flow Enforcement Technology, it's used to
> protect against return/jump oriented programming (ROP)
> attacks. It provides the following capabilities to defend
> against ROP/JOP style control-flow subversion attacks:
> - Shadow Stack (SHSTK):
>                  A second stack for the program that is
>                  used exclusively for control transfer
>                  operations.
> - Indirect Branch Tracking (IBT):
>                  Free branch protection to defend against
>                  Jump/Call Oriented Programming.
>
> On processors that support CET, VMX saves/restores
> the states of IA32_S_CET, SSP and IA32_INTR_SSP_TABL_ADDR MSR
> to the VMCS area for Guest/Host unconditionally.
>
> If VM_EXIT_LOAD_HOST_CET_STATE = 1, the host CET MSRs are
> restored from VMCS host-state area at VM exit as follows:
>
> - HOST_IA32_S_CET: Host supervisor mode IA32_S_CET MSR is loaded
>                    from this field.
>
> - HOST_SSP :       Host SSP is loaded from this field.
>
> - HOST_INTR_SSP_TABL_ADDR : Host IA32_INTR_SSP_TABL_ADDR
>                              MSR is loaded from this field.
>
> If VM_ENTRY_LOAD_GUEST_CET_STATE = 1, the guest CET MSRs are loaded
> from VMCS guest-state area at VM entry as follows:
>
> - GUEST_IA32_S_CET : Guest supervisor mode IA32_S_CET MSR is loaded
>                      from this field.
>
> - GUEST_SSP :        Guest SSP is loaded from this field.
>
> - GUEST_INTR_SSP_TABL_ADDR : Guest IA32_INTR_SSP_TABL_ADDR
>                              MSR is loaded from this field.
>
> Additionally, to context switch guest and host CET states, the VMM
> uses xsaves/xrstors instructions to save/restore the guest CET states
> at VM exit/entry. The CET xsave area is within thread_struct.fpu area.
> If OS execution flow changes during task switch/interrupt/exception etc.,
> the OS also relies on xsaves/xrstors to switch CET states accordingly.
>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/vmx.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index ade0f153947d..395c1f7e5938 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -98,6 +98,7 @@
>  #define VM_EXIT_LOAD_IA32_EFER                  0x00200000
>  #define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
>  #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
> +#define VM_EXIT_LOAD_HOST_CET_STATE             0x10000000
>
>  #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR      0x00036dff
>
> @@ -109,6 +110,7 @@
>  #define VM_ENTRY_LOAD_IA32_PAT                 0x00004000
>  #define VM_ENTRY_LOAD_IA32_EFER                 0x00008000
>  #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
> +#define VM_ENTRY_LOAD_GUEST_CET_STATE           0x00100000
>
>  #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR     0x000011ff
>
> @@ -325,6 +327,9 @@ enum vmcs_field {
>         GUEST_PENDING_DBG_EXCEPTIONS    = 0x00006822,
>         GUEST_SYSENTER_ESP              = 0x00006824,
>         GUEST_SYSENTER_EIP              = 0x00006826,
> +       GUEST_IA32_S_CET                = 0x00006828,
> +       GUEST_SSP                       = 0x0000682a,
> +       GUEST_INTR_SSP_TABL_ADDR        = 0x0000682c,

Nit: TABL is an unusual abbreviation. Perhaps TBL here and below? And
why did you drop the 'IA32' here, but not in GUEST_IA32_S_CET above?
(It is true that there seems to be no rhyme or reason to the mnemonics
chosen here. For example, EFER keeps its IA32, but SYSENTER_EIP
doesn't. Sigh.)

>         HOST_CR0                        = 0x00006c00,
>         HOST_CR3                        = 0x00006c02,
>         HOST_CR4                        = 0x00006c04,
> @@ -337,6 +342,9 @@ enum vmcs_field {
>         HOST_IA32_SYSENTER_EIP          = 0x00006c12,
>         HOST_RSP                        = 0x00006c14,
>         HOST_RIP                        = 0x00006c16,
> +       HOST_IA32_S_CET                 = 0x00006c18,
> +       HOST_SSP                        = 0x00006c1a,
> +       HOST_INTR_SSP_TABL_ADDR         = 0x00006c1c
>  };
>
>  /*
> --
> 2.17.1

Reviewed-by: Jim Mattson <jmattson@google.com>
