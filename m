Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeBIX5m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:57:42 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41517 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbeBIX50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:57:26 -0500
X-Google-Smtp-Source: AH8x225f5G1FABwIatQ7CkspTvjZpZGshaqmLUVVEsUvF31LTyJbw6HOc42xZpVUNTmS3tP2XK9xh7fpRm/d1eEggBU=
MIME-Version: 1.0
In-Reply-To: <8d50836c-4eee-15ef-da20-212559105594@amazon.com>
References: <1518130410-6583-1-git-send-email-karahmed@amazon.de>
 <1518130410-6583-3-git-send-email-karahmed@amazon.de> <CALMp9eThOMGTru3hnuupJ_m4jPA7Hf=5=8ZJ4ygmC50vsDmngw@mail.gmail.com>
 <8d50836c-4eee-15ef-da20-212559105594@amazon.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 9 Feb 2018 15:57:24 -0800
Message-ID: <CALMp9eSTWpRnXbxHA83UrMpwBsUMPJqNKe84DiGFPrwUgrYBVQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] X86/nVMX: Update the MSR_BITMAP field with the L02
 MSR BITMAP
To: KarimAllah Ahmed <karahmed@amazon.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 3:41 PM, KarimAllah Ahmed <karahmed@amazon.com> wrote:

> I assume you are referring to this:
>
> https://patchwork.kernel.org/patch/10194819/
>
> .. which is now:
>
> commit 904e14fb7cb9 ("KVM: VMX: make MSR bitmaps per-VCPU")
>
> right?
>
> If this is the case, then I do not see where the MSR_BITMAP is being
> updated here. In fact, would not this be the commit that actually broke
> it?

I'm referring to
<1517938181-15317-6-git-send-email-dwmw@amazon.co.uk>, which has:

@@ -10043,6 +9954,9 @@ static void prepare_vmcs02(struct kvm_vcpu
*vcpu, struct vmcs12 *vmcs12)
        if (kvm_has_tsc_control)
                decache_tsc_multiplier(vmx);

+       if (cpu_has_vmx_msr_bitmap())
+               vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
+
        if (enable_vpid) {
                /*
                 * There is no direct mapping between vpid02 and vpid12, the
