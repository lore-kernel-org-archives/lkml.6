Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E834ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD45C20848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGsETFzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD45C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeJ0Bin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:38:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36708 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeJ0Bim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:38:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34-v6so2014059qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T5Z4gkXIbPfnWJmltvX718zmpIaavY1fjtWfX1bzD28=;
        b=NGsETFzd6xVQ/+PqmkGvelVQvmwX8RebSHkOoerLMTsjo0W9cvHFBrUDfo79rfmJ3j
         xpqropXwcVeUqxKqYrDoat8CqfG7/UK2kpvV+yOWHn1TEBKdYPqYgT/G5YqaT6MK9grN
         ED0swNuVvv29WS5vSKDMI8H36TJ4xiw3IYshjAWoDos4Afgqcv5qJTqraD0aWYIUy3ZE
         ydRBim+1FHUSM+wwqsHY8qG5OXhmsFmHZGDnGl80Xhb5TSX0jwlsGCCyFpgcOb8uBBpm
         g9PlX1eTm0oW9SFuTMmNavJPMBW81OnJPHcEe3ysGrsY+20sZvq8bkSZ1GHDPhuplJs3
         7lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T5Z4gkXIbPfnWJmltvX718zmpIaavY1fjtWfX1bzD28=;
        b=iE/9sZQvKp/WxyGHFyQnNv+NVIEbtNWybKJ0Dq1hpxRdzKJDrWuXPZ+Ik5ldyeFohr
         rapgx4q00Ob2pQvyocc9O6CaBQfalMf8nZ6YHCes7v+mhLKX5xsPJJ9bQvspoSLsT2mN
         WGHJhOqv1Zdt0Ks6ACIWZ98lC5VY7B70Gqb3aVSZYtXRu7fPfdvOoOEFqq6K67m4cKpd
         p2SdM89ihCjf1z740n2G6y36GunOo/dwrV7wFRlDQztLtblQF7q60RKjXb6Uzeh1D/xO
         BhdFW5QGYZKsMWVAyekDjeRNXzCUrR1rZRj1+wqsk/zf4vDnK73eYNggiqtGm0jd+8Dl
         8VsQ==
X-Gm-Message-State: AGRZ1gL93ZKUmNN1U0ItfdVV9dLDPvt05CpEb3Ye/lezHCpYY4kVPvhX
        sgn90aJ+m7WtZTOP6KphRLs=
X-Google-Smtp-Source: AJdET5f7elRrn5utp5CzoMj7ur2X5I1kwrG4Webc0qWs7ekXy25PqL7OsIAvvnFPWBo7EcSuVDM5dg==
X-Received: by 2002:a0c:d107:: with SMTP id a7mr4046933qvh.104.1540573255075;
        Fri, 26 Oct 2018 10:00:55 -0700 (PDT)
Received: from llong.remote.csb (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k185-v6sm6266398qkd.27.2018.10.26.10.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 10:00:54 -0700 (PDT)
Subject: Re: [Patch v3 04/13] x86/speculation: Disable STIBP when enhanced
 IBRS is in use
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
 <a96456805e51e234d1bae30837366243e24a4b83.1539798901.git.tim.c.chen@linux.intel.com>
From:   Waiman Long <longman9394@gmail.com>
Message-ID: <43c23fc3-ebaa-fe7c-f7b7-54a5166b6b49@gmail.com>
Date:   Fri, 26 Oct 2018 13:00:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <a96456805e51e234d1bae30837366243e24a4b83.1539798901.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 01:59 PM, Tim Chen wrote:
> With enhanced IBRS in use, the application running on sibling CPU will not
> be able to launch Spectre v2 attack to the application on current CPU.
> There is no need to use STIBP for this case.  Disable the STIBP code
> when enhanced IBRS is used.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 2fc7b4e..6ed82ea 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -327,6 +327,14 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
>  
>  static bool stibp_needed(void)
>  {
> +	/*
> +	 * Determine if we want to leave STIBP always on.
> +	 * Using enhanced IBRS makes using STIBP unnecessary.
> +	 */
> +
> +	if (static_branch_unlikely(&spectre_v2_enhanced_ibrs))
> +		return false;
> +
>  	if (spectre_v2_enabled == SPECTRE_V2_NONE)
>  		return false;
>  
> @@ -881,7 +889,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
>  				   ", IBPB" : "",
>  			boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ?
>  				   ", IBRS_FW" : "",
> -			(x86_spec_ctrl_base & SPEC_CTRL_STIBP) ?
> +			spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED ?
> +				   ", Enhanced IBRS" :
> +			    (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ?
>  				   ", STIBP" : "",
>  			boot_cpu_has(X86_FEATURE_RSB_CTXSW) ?
>  				   ", RSB filling" : "",

The "Enhanced IBRS" is one of the states of spectre_v2_enabled. So you
don't need to print that out one more time.

Cheers,
Longman

