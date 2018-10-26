Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACC0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0926720873
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+2wYCz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0926720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeJ0BgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:36:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38176 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeJ0BgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:36:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id r22-v6so1995663qtm.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HMQd188qzuqG4+dxkGPmwub/uJl29RnH1fd1M5T9Lg8=;
        b=J+2wYCz7ia8XaSkr7i/VjYKK8Jnp5LuHzzxUs+kwY/qrnNa06I3fPapLYEXzrltPTb
         kaKfYX6AqRn78Dbt/RqzMZvriBOaecJpJi70vxzDedUsU8F3hWrCxwFhzlTLOycVDvqk
         0fiH6E6tQEzm2iW290GL8N4GkETBgMr1ZPf+hszlP9dG8AK9KjNOtvRgltwpCAKpXivs
         +wYux3BEGE/gNYqxEywGM93jakCG4zAfNOa32Gmtot+boktnFO2qsnlgd/pEMKrwAx97
         EDoj78tlwvOuYACJOZpPyj3pacaXo0G+kdXk4gkVImnza68kh5JKYo7SsTmw+GLyDcwh
         NVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HMQd188qzuqG4+dxkGPmwub/uJl29RnH1fd1M5T9Lg8=;
        b=Lk11vYTQYSDGoFRhTbzkiONWY6egt6IhQ4zQkGnoR40bXFuzEIrCJzl1/twXCxVmc7
         ZSj45GGomShGUrKKu7kRLbrISR7BeB5ySXUGdNO9GEBj45gmYo3isoPV3Z4mJyA4CXwH
         CW5p4ea+C9ZnNlkGsDHHv2cU8e6h6RzGR5PAVP1dvUb+K4rInGPDj32nN3samegKkzor
         9kN9bjITVFTnhXOqrPXsGGFNXnSUdQCTuupddDGVWAWU5MysdfBHN8tzP1Wme2/TkFrJ
         GYVkMddq4aDHNhFiS1LFRfvRC3isGroef3tkiUq4Cp1HVnFwss+9Xhah0BNXJDK8Jlrc
         e/+A==
X-Gm-Message-State: AGRZ1gJTmpZQ/tLsW5+YlBJ43A8cKXB1ogppQoy20aq30VdNzx4LTvad
        xIO0Y3XnDHKbPX4e5ryeYgM=
X-Google-Smtp-Source: AJdET5eAq5eSqd0JMSzuDBD4UED1dCVUAMKWmHRrR78CL4BDMwAgdC4HbkZeSrNzeHtG8FhGKsxgRw==
X-Received: by 2002:ac8:7693:: with SMTP id g19-v6mr3908626qtr.388.1540573098773;
        Fri, 26 Oct 2018 09:58:18 -0700 (PDT)
Received: from llong.remote.csb (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q38-v6sm8910329qtc.9.2018.10.26.09.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 09:58:18 -0700 (PDT)
Subject: Re: [Patch v3 03/13] x86/speculation: Add static key for Enhanced
 IBRS
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
 <d62b81e9390c4e404ede02139f7a29327dfe1921.1539798901.git.tim.c.chen@linux.intel.com>
From:   Waiman Long <longman9394@gmail.com>
Message-ID: <b5b6f492-8bf0-7fcc-eb4f-3016b4d46c08@gmail.com>
Date:   Fri, 26 Oct 2018 12:58:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <d62b81e9390c4e404ede02139f7a29327dfe1921.1539798901.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 01:59 PM, Tim Chen wrote:
> Add static key to indicate whether we are using Enhanced IBRS to mitigate
> Spectre v2.  This will be used in later patches to disengage STIBP code
> for Spectre v2 mitigation as STIBP is not needed when Enhanced IBRS is
> in use.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/include/asm/nospec-branch.h | 3 +++
>  arch/x86/kernel/cpu/bugs.c           | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index fd2a8c1..d57e84e 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -3,6 +3,7 @@
>  #ifndef _ASM_X86_NOSPEC_BRANCH_H_
>  #define _ASM_X86_NOSPEC_BRANCH_H_
>  
> +#include <linux/static_key.h>
>  #include <asm/alternative.h>
>  #include <asm/alternative-asm.h>
>  #include <asm/cpufeatures.h>
> @@ -228,6 +229,8 @@ enum ssb_mitigation {
>  extern char __indirect_thunk_start[];
>  extern char __indirect_thunk_end[];
>  
> +DECLARE_STATIC_KEY_FALSE(spectre_v2_enhanced_ibrs);
> +
>  /*
>   * On VMEXIT we must ensure that no RSB predictions learned in the guest
>   * can be followed in the host, by overwriting the RSB completely. Both
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index b2f6b8b..2fc7b4e 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -142,6 +142,9 @@ static const char *spectre_v2_strings[] = {
>  	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
>  };
>  
> +DEFINE_STATIC_KEY_FALSE(spectre_v2_enhanced_ibrs);
> +EXPORT_SYMBOL(spectre_v2_enhanced_ibrs);
> +
>  #undef pr_fmt
>  #define pr_fmt(fmt)     "Spectre V2 : " fmt
>  
> @@ -386,6 +389,7 @@ static void __init spectre_v2_select_mitigation(void)
>  			/* Force it so VMEXIT will restore correctly */
>  			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
>  			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +			static_branch_enable(&spectre_v2_enhanced_ibrs);
>  			goto specv2_set_mode;
>  		}
>  		if (IS_ENABLED(CONFIG_RETPOLINE))

Why you need a static key for enhanced IBRS? It is supposed to be set at
boot time and never get changed after that. It will be easier to use a
feature bit for that instead. We usually use static key when the value
can be changed at run time.

Cheers,
Longman

