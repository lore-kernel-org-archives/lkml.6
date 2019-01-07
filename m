Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACDAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D702087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrUOFLva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfAGQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:04:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46825 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfAGQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:04:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so925184wrt.13;
        Mon, 07 Jan 2019 08:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7gZK4N7t6W55GDlhqZairkkf+H38yqT12vjLL2Yth+c=;
        b=KrUOFLvaB5ld7/aUVAqSD0BcPIoM0JKAXhHmmUTRRg8sQ0hPLahW0NwxTlNDxRNNxI
         Oyx3aXuaaNYDR1qAMzlDzJ+TRJMolo4qIBuMNgh5wi6LFwwl6mwGcZlL/ponYXkMvWi2
         XP83J/59bD5oCRkJ09ic8I3VeiI6SwC0i0vlYdn6TGOjFTJAeeyIrYwFqKWV4u2YB+tq
         AY/Fmeq/LUigkUP6e/jHEc9alCI2t/nzGJHCMzgAlSeoQvIvEEFTpAH0LvY1fVeUN1/b
         BA9iaBqnzyLWK14Rq9fAPm4fxXWulNR4TCuhXakCmn3cy4cit/sX2hiGyZZnl3XIY1u4
         allg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7gZK4N7t6W55GDlhqZairkkf+H38yqT12vjLL2Yth+c=;
        b=i0OE/auP/9U88xcEJNWfA/nD8Pcz6gun19MronhZMGY8UQ2IblP3IOv64EZKWyKvgi
         yBjtYV8V7wk9T1wpnte/P1bAF13NSWuoDz1oWsrDy/YSqW8wfe57LEL2f8o/pZEO03rq
         KUkI4SC1tkNCaO2ANhsAZJhBQ2rkXCxsjCvy0bU5FFL4Fn1Q/rVQQz/qqSUxB5pMp7jj
         PIQSCIpSkSt/klp432pXy4/tmkVhRKRe6ruTWzxAEWTvF2yYq3WSr0gky70xgLEdkin5
         hXHTz8wdL2K5TxbpLbqhnyyXP4Zcp7v8DRSagY+7UUcFsFrgMaf/nZFiiTEAyJQJr3bn
         ZZEg==
X-Gm-Message-State: AJcUukfMyOZ24k4+3sfBo98GwNFUFmyUu0qYNdJDqYfzSd4QNpzXdDmS
        68RA6FwP8DnpwHl2pzXpfNU=
X-Google-Smtp-Source: ALg8bN5m920E3Duk8PfW3WlJLocjfdb8JxmV2E5kk9lLNr7MNToUgloHRySQyCBeZJg6LLNwq7kJ0A==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr55006885wrv.188.1546877038805;
        Mon, 07 Jan 2019 08:03:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3473:41cf:8b30:f2e1? ([2001:b07:6468:f312:3473:41cf:8b30:f2e1])
        by smtp.googlemail.com with ESMTPSA id e16sm59509441wrn.72.2019.01.07.08.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:03:58 -0800 (PST)
Subject: Re: [PATCH v1 8/8] kvm:cpuid Report CET SHSTK and IBT support in
 CPUID.(EAX=0x7,ECX=0).
To:     Yang Weijiang <weijiang.yang@intel.com>, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     Zhang Yi Z <yi.z.zhang@linux.intel.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
 <20181226081532.30698-9-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <72bb7ac5-1137-2a4a-de5e-5a3db53a0b13@redhat.com>
Date:   Mon, 7 Jan 2019 17:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181226081532.30698-9-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/12/18 09:15, Yang Weijiang wrote:
> Guest OS can query CET SHSTK and IBT support by CPUID.(EAX=0x7,ECX=0),
> in return, ECX[bit 7] corresponds to SHSTK feature, and EDX[bit 20]
> corresponds to IBT feature.
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 55c282f71f93..d7b60b3c4326 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -67,6 +67,8 @@ u64 kvm_supported_xcr0(void)
>  
>  #define F(x) bit(X86_FEATURE_##x)
>  
> +#define CET_IBT_BIT bit(20)
> +
>  /* For scattered features from cpufeatures.h; we currently expose none */
>  #define KF(x) bit(KVM_CPUID_BIT_##x)
>  
> @@ -407,12 +409,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
>  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
>  		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
> -		F(CLDEMOTE);
> +		F(CLDEMOTE) | F(SHSTK);
>  
>  	/* cpuid 7.0.edx*/
>  	const u32 kvm_cpuid_7_0_edx_x86_features =
>  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
> -		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
> +		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | CET_IBT_BIT;
>  
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();
> 

This might change soon, but at least for now KVM's XSAVES/XRSTORS usage
depends on Linux's.  Therefore, this should only be enabled if Linux has
set bits 11 and 12 in MSR_IA32_XSS.

Paolo
