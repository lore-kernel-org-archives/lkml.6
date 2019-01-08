Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B79C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9E02087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfAHQL3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:11:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41475 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfAHQL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:11:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so4740530edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 08:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6wAlyXG/C6KGbFsGNO7v4HiGDeFNvmBp0wQlbh7CFu0=;
        b=avjNwxnH4/C4GiEO8NlPU86OQcUhr6MSNQWqyLX3AFHD10e+9xyGxkUPS1PuTx/mQY
         RX0Ulls7bKCFTqUeOXiFefCigGwiyWh1qVfgReAz5YwcZ4sKhzYlrmgEV7MdN9w0rjwJ
         yeRp+LJqMy/dWesmucTnpMB9BnJT6e145JXxkjxyvm7LuuoM8lafYTlF35BltBFkPtq2
         AJXg/MYx/uJaRteXYLWnsE0+HDwuXqGHv8oLIDULaCbWjM9O6lgT9tnY0j6NA9AG5K5h
         IjXyHjc/Yf4kD2shVB3fdq5u5ax9D4wjb+/hZCsauwbE+9AKPOBYprfdVC/Ve4LGIRSN
         btVw==
X-Gm-Message-State: AJcUukdqtcxfmikscL2hgfGu3YehNNofsRcLukN2Ykh4ukJpCNxQX7Mf
        AeGCPXTaHiGUoJqmZNj+l9zE4g==
X-Google-Smtp-Source: ALg8bN5zKjLOmWNAZbiwErF+HRh9PACVne3jATItZ/B6aET+vL6bK9oLS8+wG7hY2fxf6Gt/2/7z4A==
X-Received: by 2002:a50:999b:: with SMTP id m27mr2722389edb.10.1546963886827;
        Tue, 08 Jan 2019 08:11:26 -0800 (PST)
Received: from [192.168.77.22] (val06-1-88-182-161-34.fbx.proxad.net. [88.182.161.34])
        by smtp.gmail.com with ESMTPSA id f35sm162653edd.80.2019.01.08.08.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:11:26 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [Qemu-devel][PATCH 3/4] Add hepler functions for CPUID xsave area
 size calculation.
From:   Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <7a6de6a8c37161fc207f7003fc0e762045fb4028.1545806972.git.weijiang.yang@intel.com>
Date:   Tue, 8 Jan 2019 17:11:22 +0100
Cc:     qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <840FA547-E55B-4B91-AE92-43A6F1AF4461@redhat.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
 <cover.1545806972.git.weijiang.yang@intel.com>
 <7a6de6a8c37161fc207f7003fc0e762045fb4028.1545806972.git.weijiang.yang@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in subject line (helper)

> On 26 Dec 2018, at 09:25, Yang Weijiang <weijiang.yang@intel.com> wrote:
> 
> These functions are called when return CPUID xsave area
> size information.
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
> target/i386/cpu.c | 26 +++++++++++++++++++++++++-
> 1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3630c688d6..cf4f2798dc 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1281,12 +1281,34 @@ static inline bool accel_uses_host_cpuid(void)
>     return kvm_enabled() || hvf_enabled();
> }
> 
> +static uint32_t xsave_area_size_compat(uint64_t mask)

Just curious, why “compat”?

> +{
> +    int i;
> +    uint64_t ret = 0;
> +    uint32_t offset;
> +
> +    for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
> +        const ExtSaveArea *esa = &x86_ext_save_areas[i];
> +        offset = i > 1 ? ret : esa->offset;

What about a named constant instead of ‘1’?

(note that a loop around line 4657 starts at 2, so I guess it’s OK to use 1 here, or at least >= 2 ;-)


> +        if ((mask >> i) & 1) {
> +            ret = MAX(ret, offset + esa->size);
> +        }
> +    }
> +    return ret;
> +}
> +
> static inline uint64_t x86_cpu_xsave_components(X86CPU *cpu)
> {
>     return ((uint64_t)cpu->env.features[FEAT_XSAVE_COMP_HI]) << 32 |
>            cpu->env.features[FEAT_XSAVE_COMP_LO];
> }
> 
> +static inline uint64_t x86_cpu_xsave_sv_components(X86CPU *cpu)
> +{
> +    return ((uint64_t)cpu->env.features[FEAT_XSAVE_SV_HI]) << 32 |
> +           cpu->env.features[FEAT_XSAVE_SV_LO];
> +}
> +
> const char *get_register_name_32(unsigned int reg)
> {
>     if (reg >= CPU_NB_REGS32) {
> @@ -4913,8 +4935,10 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>         }
>     }
> 
> -    env->features[FEAT_XSAVE_COMP_LO] = mask;
> +    env->features[FEAT_XSAVE_COMP_LO] = mask & CPUID_XSTATE_USER_MASK;
>     env->features[FEAT_XSAVE_COMP_HI] = mask >> 32;
> +    env->features[FEAT_XSAVE_SV_LO] = mask & CPUID_XSTATE_KERNEL_MASK;
> +    env->features[FEAT_XSAVE_SV_HI] = mask >> 32;
> }
> 
> /***** Steps involved on loading and filtering CPUID data
> -- 
> 2.17.1
> 

