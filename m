Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44882C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1013320879
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giW3aRTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfABXlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:41:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45410 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfABXlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:41:10 -0500
Received: by mail-io1-f67.google.com with SMTP id c2so3629590iom.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 15:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYO1L8CJLgm3SnZ/7k7RpO0bY8+uT6HmEvnDlAJzdH4=;
        b=giW3aRTrDpOM8dZZavL4iU/X+nc2YltHD09kBs5t6ah0h89vcXiaTz8BnHzuIVAYvU
         lY4iOVEwjow4I6/H69TgBxRgsNcJMQV/nFcmM3N1Iy31WKqQVK2nPTniVxfi9aA69GAi
         LRdkSDZshy/vmqnh+ZQbCyvauh5Dps64mh1zOcEQT1RsE+9CCbIZp/nQsp1d7fHqZ+3s
         g8Zr4+UMcS6kTU90fxnhBo9Hxc6zMnM/5ZbMI71PX/15mq+bU0/hywockfiS0hDDzPgE
         c6wMXEL4DYl5lEf/Vsyo0K+XY9Dcfj17J7m6EtnYuQTT8VsZfLMp7eRWX4a/+Y9Hf6uf
         /JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYO1L8CJLgm3SnZ/7k7RpO0bY8+uT6HmEvnDlAJzdH4=;
        b=iY37hJdndcKK62k67Q1O2cQcIky5mojV/D+qsON7IKeuhQdtK3hBfLYNlROD8paqRS
         UOOi/NrKK19HjyltRKLq8ghrH7f9ldtLOsRurtb1J9NfY/bhw2+DxvOO8DiHnzD55OTp
         +y+lCotwTRj1fLVgztzKtsqHzb80OAhx76r1DDcALAvuKWPNFtyngzFmxI8B0rjcEi4J
         rjhFubKivqDB+Hs2WuSB8RdHaiNeuOEN/EE1E+BqClU4xSOEpiJwcMf2n0UHqFl6ZtYD
         dd7oOmu0Tk7PxfX/P8tJ5iqRsFiFsUz+dH40jzncq4WlqmO1e4S7jrJNeDBmcLJ9H1Ey
         +vWg==
X-Gm-Message-State: AJcUukcEQ32JBt0B/wF49BWrTV8UhcF/WP2qgdBXiCPEwtQ5DU0nM9gY
        tjlnQGAAgQzpkPGMUxBlg1yZg+79rdwbkqLeMKUuxg==
X-Google-Smtp-Source: ALg8bN7k3FpghbsbqcgHoww1IV6rpOmUHt3VbdOXKnEk/aIpAULveWfOQBqvGWQjriY6L8U8w5eBUqqqHJUJDz67mXQ=
X-Received: by 2002:a6b:db17:: with SMTP id t23mr20604537ioc.262.1546472469208;
 Wed, 02 Jan 2019 15:41:09 -0800 (PST)
MIME-Version: 1.0
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1545816338-1171-6-git-send-email-wei.w.wang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Jan 2019 15:40:58 -0800
Message-ID: <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 2:01 AM Wei Wang <wei.w.wang@intel.com> wrote:
>
> Bits [0, 5] of MSR_IA32_PERF_CAPABILITIES tell about the format of
> the addresses stored in the LBR stack. Expose those bits to the guest
> when the guest lbr feature is enabled.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/include/asm/perf_event.h | 2 ++
>  arch/x86/kvm/cpuid.c              | 2 +-
>  arch/x86/kvm/vmx.c                | 9 +++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 2f82795..eee09b7 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -87,6 +87,8 @@
>  #define ARCH_PERFMON_BRANCH_MISSES_RETIRED             6
>  #define ARCH_PERFMON_EVENTS_COUNT                      7
>
> +#define X86_PERF_CAP_MASK_LBR_FMT                      0x3f
> +
>  /*
>   * Intel "Architectural Performance Monitoring" CPUID
>   * detection/enumeration details:
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 7bcfa61..3b8a57b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -365,7 +365,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>                 F(XMM3) | F(PCLMULQDQ) | 0 /* DTES64, MONITOR */ |
>                 0 /* DS-CPL, VMX, SMX, EST */ |
>                 0 /* TM2 */ | F(SSSE3) | 0 /* CNXT-ID */ | 0 /* Reserved */ |
> -               F(FMA) | F(CX16) | 0 /* xTPR Update, PDCM */ |
> +               F(FMA) | F(CX16) | 0 /* xTPR Update*/ | F(PDCM) |
>                 F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
>                 F(XMM4_2) | F(X2APIC) | F(MOVBE) | F(POPCNT) |
>                 0 /* Reserved*/ | F(AES) | F(XSAVE) | 0 /* OSXSAVE */ | F(AVX) |
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 8d5d984..ee02967 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -4161,6 +4161,13 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                         return 1;
>                 msr_info->data = vcpu->arch.ia32_xss;
>                 break;
> +       case MSR_IA32_PERF_CAPABILITIES:
> +               if (!boot_cpu_has(X86_FEATURE_PDCM))
> +                       return 1;
> +               msr_info->data = native_read_msr(MSR_IA32_PERF_CAPABILITIES);

Since this isn't guarded by vcpu->kvm->arch.lbr_in_guest, it breaks
backwards compatibility, doesn't it?

> +               if (vcpu->kvm->arch.lbr_in_guest)
> +                       msr_info->data &= X86_PERF_CAP_MASK_LBR_FMT;
> +               break;
>         case MSR_TSC_AUX:
>                 if (!msr_info->host_initiated &&
>                     !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> @@ -4343,6 +4350,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                 else
>                         clear_atomic_switch_msr(vmx, MSR_IA32_XSS);
>                 break;
> +       case MSR_IA32_PERF_CAPABILITIES:
> +               return 1; /* RO MSR */
>         case MSR_TSC_AUX:
>                 if (!msr_info->host_initiated &&
>                     !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> --
> 2.7.4
>
