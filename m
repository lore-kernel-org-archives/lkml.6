Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB72ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3916120834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbxfQLTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3916120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJ0B7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:59:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33351 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJ0B7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:59:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id i15-v6so2103231qtr.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZZ6CCkSzeSnBxqo/F4fShURMlDtCrRBhfbrlwTW07KQ=;
        b=VbxfQLTeODfXqGuOxhAD1BM6ghL0dVJrnqsy9+s9DSnNRniGReUkqYx5p/L95+BSx4
         I6m4E4/XnLSayTpqKWAduIWclMoEKENBAcfMIfHYCanB5oFAuSmEsGE5jT9QUnQO1255
         4ZZ5GJz0oJohRSqZU66iewDjBc3/v/a+Q6hhGQoR0sH9EZKe/2c1aFSY9RD3PxaFARqr
         OPJW0pCDLI4xtTrfJLuLRzMupsalbkPczpzTzelOL3u3iXlXU+avolWtODWOFnD5M4s8
         GwiA7NlSe68Pp2riveZXiEYmhi3Zv779D4FWv0BJm//mR2PeYNSR6eC6QEiBvBM39YO4
         ZWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZZ6CCkSzeSnBxqo/F4fShURMlDtCrRBhfbrlwTW07KQ=;
        b=DcfhHyg+I0+cEXLwVjxEzmt6bYvv89RjWTwHdJkud5OQQyEAYE1b1x5BZaFRdNe9tQ
         cylEJyt9iYKZDnd78bpMfpugSZlu7WPvSKWeSSl4GVg2qIQPIupenWX4JDwebpsRg5s8
         Uw9e10vkmAX4IudHdkygejci/q5ImoIWTV0N+JQeuOmXRbJCGNBBGJPFwRldFaaZoikH
         AEEn2B/0DiPE9KPODlxnfKbWpj/LVXMCmpGQSGXJxSXfMYM6hNFSewPsYBYI/92KaEIK
         TzqoO4xfNshf/beH+cSffSoiibg+NSLBYfxdjqZCGzRgxhBJdFonW7nDhWUF439JUKTg
         1Tww==
X-Gm-Message-State: AGRZ1gIsbGIIBcV4pmn1kLfDaMtfInmCeHPNaakbqdEW3fD2XJrlX4eL
        s5OgL7CagKhrpShNgRvvKmE=
X-Google-Smtp-Source: AJdET5fvZ64K+nUFxGCPZV6PsYdjhGtlaGULB4rg3YPojp1eD6G9iVv7npAaXid6eKVjJjW9YH6Bpg==
X-Received: by 2002:a0c:d4a7:: with SMTP id u36mr3971164qvh.38.1540574498877;
        Fri, 26 Oct 2018 10:21:38 -0700 (PDT)
Received: from llong.remote.csb (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 24-v6sm10013523qts.19.2018.10.26.10.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 10:21:38 -0700 (PDT)
Subject: Re: [Patch v3 09/13] x86/speculation: Reorganize SPEC_CTRL MSR update
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
 <23d8ffaac99be49aa163eb16dd131399141fc432.1539798901.git.tim.c.chen@linux.intel.com>
From:   Waiman Long <longman9394@gmail.com>
Message-ID: <63856b8d-0b53-7103-db7e-315330e2ee48@gmail.com>
Date:   Fri, 26 Oct 2018 13:21:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <23d8ffaac99be49aa163eb16dd131399141fc432.1539798901.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 01:59 PM, Tim Chen wrote:
> Reorganize the spculation control MSR update code. Currently it is limited
> to only dynamic update of the Speculative Store Bypass Disable bit.
> This patch consolidates the logic to check for AMD CPUs that may or may
> not use this MSR to control SSBD. This prepares us to add logic to update
> other bits in the SPEC_CTRL MSR cleanly.
>
> Originally-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/kernel/process.c | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 8aa4960..789f1bada 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -397,25 +397,45 @@ static __always_inline void amd_set_ssb_virt_state(unsigned long tifn)
>  
>  static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
>  {
> -	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
> +	u64 msr = x86_spec_ctrl_base;
> +
> +	/*
> +	 * If X86_FEATURE_SSBD is not set, the SSBD
> +	 * bit is not to be touched.
> +	 */
> +	if (static_cpu_has(X86_FEATURE_SSBD))
> +		msr |= ssbd_tif_to_spec_ctrl(tifn);
>  
>  	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
>  }
>  
> -static __always_inline void __speculation_ctrl_update(unsigned long tifn)
> +static __always_inline void __speculation_ctrl_update(unsigned long tifp,
> +						      unsigned long tifn)

I think it will be more intuitive to pass in (tifp ^ tifn) as bitmask of
changed TIF bits than tifp alone as you are only interested in the
changed bits anyway. Please also document the input parameters as it is
hard to know what they are by reading the function alone.

Cheers,
Longman
>  {
> -	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
> -		amd_set_ssb_virt_state(tifn);
> -	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> -		amd_set_core_ssb_state(tifn);
> -	else
> +	bool updmsr = false;
> +
> +	/* Check for AMD cpu to see if it uses SPEC_CTRL MSR for SSBD */
> +	if ((tifp ^ tifn) & _TIF_SSBD) {
> +		if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
> +			amd_set_ssb_virt_state(tifn);
> +		else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> +			amd_set_core_ssb_state(tifn);
> +		else if (static_cpu_has(X86_FEATURE_SSBD))
> +			updmsr  = true;
> +	}
> +
> +	if (updmsr)
>  		spec_ctrl_update_msr(tifn);
>  }
>  
>  void speculation_ctrl_update(unsigned long tif)
>  {
> +	/*
> +	 * On this path we're forcing the update, so use ~tif as the
> +	 * previous flags.
> +	 */
>  	preempt_disable();
> -	__speculation_ctrl_update(tif);
> +	__speculation_ctrl_update(~tif, tif);
>  	preempt_enable();
>  }
>  
> @@ -451,8 +471,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
>  	if ((tifp ^ tifn) & _TIF_NOCPUID)
>  		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
>  
> -	if ((tifp ^ tifn) & _TIF_SSBD)
> -		__speculation_ctrl_update(tifn);
> +	__speculation_ctrl_update(tifp, tifn);
>  }
>  
>  /*


