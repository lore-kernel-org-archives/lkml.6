Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84808ECE566
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8D220657
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1sw30hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8D220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeIRTDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:03:08 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37075 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRTDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:03:08 -0400
Received: by mail-qt0-f193.google.com with SMTP id n6-v6so1649050qtl.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4uR4+vlmBwl9/GpXZsX1Eio01nbl3uyjdhLLXS7dBbc=;
        b=Q1sw30hmrMDy26I3tFdx4KaO8oycLgPd0lNk5k6y7+c0E9AbikKh62PCEJgghC3Znd
         J/5X/GBD6FTeboGyBPAZBBVLl3A9aV2o64W/jPxKks+Vl9c+TMemXZHRviEwSOMSKkwS
         Sf9pzXTL1s7DmP14MdGa7YKM/OdubSG/1WnQSPc7DKh7D1F3nbuAButkhlCYjcTzUMfu
         3+omf+CgmDUCteN7OVre4MQ4HC0iTYyMRV5yejw48HdoWamV7JFsogjaedNedevFcFyH
         0BV7UXt5jwE5WeUiUakmKQcxSrihCVowhsRZEaY9Webs774DRY59IPMytGO2QTlYaBX4
         GwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4uR4+vlmBwl9/GpXZsX1Eio01nbl3uyjdhLLXS7dBbc=;
        b=eRQRjw/IKGtxcFhPcZ5JyobPxoEZcBVvIQfKx/dlmKPKaV3Zz55TwofmIsvR9WKSSX
         5gNwgEnelNkuO6qazRYNnE16f8FFTFoaHt/zAB8glVDX+7cboBA6zaZw09uuZaF/qGHn
         HdtiSMrdFyGMV+0Fovfw9IFs3ZsE2LV8gvX52xlZ9FrMeZodeRk2xBjGWChvCWniAIgJ
         YiQfMrD2tq/K4vEIsv6d+rRKZDRnAMW5wn9I/mn/arJwJDKgG/nDx+Oc+/EmXyMyN7Z5
         IOSKLKIviOkSNB9lailkwDVNOf2rJQ8OE/caTn7u6bgGxyR4nf6mQdyyqHywiGUOLqjS
         F2Nw==
X-Gm-Message-State: APzg51Aw+/S8NhXAApgNncLXlrO8cukFVsCPcG4liJetrQO/Eb+9jJLC
        E8XB/HR1lT0Uo97rWXrWtw==
X-Google-Smtp-Source: ANB0VdZBc5rFw7gcLDFr97CTvfvnQY4TTckJwOQ2hBaoqRWTDxg6AxfCgv/SYdw+k6gDhffPxaX5Xw==
X-Received: by 2002:a0c:9e5a:: with SMTP id z26-v6mr21575141qve.15.1537277431122;
        Tue, 18 Sep 2018 06:30:31 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n41-v6sm12904292qtn.73.2018.09.18.06.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 06:30:30 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:30:27 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, mike.travis@hpe.com, sivanich@hpe.com
Subject: Re: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
Message-ID: <20180918133026.gzyix3oyrfcsrdcx@gabell>
References: <20180904151141.20264-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904151141.20264-1-msys.mizuma@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...
I would appreciate if someone could review it because this patch
fixes the real memory hotplug issue...

On Tue, Sep 04, 2018 at 11:11:40AM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> If each node of physical memory layout has huge space for hotplug,
> the padding used for the physical memory mapping section is not enough.
> For exapmle of the layout:
>   SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
>   SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
>   SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
>   SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
> 
> We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
> however, the needed padding size depends on the system environment.
> The kernel option is better than changing the config.
> 
> Change log from v2:
>  - Simplify the description. As Baoquan said, this is simillar SGI UV issue,
>    but a little different. Remove SGI UV description.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/kaslr.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 61db77b0eda9..aeb62615bd46 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -40,6 +40,7 @@
>   */
>  static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
>  
> +static int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>  /*
>   * Memory regions randomized by KASLR (except modules that use a separate logic
>   * earlier during boot). The list is ordered based on virtual addresses. This
> @@ -69,6 +70,20 @@ static inline bool kaslr_memory_enabled(void)
>  	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>  }
>  
> +static int __init rand_mem_physical_padding_setup(char *str)
> +{
> +	int max_padding = (1 << (MAX_PHYSMEM_BITS - TB_SHIFT)) - 1;
> +
> +	get_option(&str, &rand_mem_physical_padding);
> +	if (rand_mem_physical_padding < 0)
> +		rand_mem_physical_padding = 0;
> +	else if (rand_mem_physical_padding > max_padding)
> +		rand_mem_physical_padding = max_padding;
> +
> +	return 0;
> +}
> +early_param("rand_mem_physical_padding", rand_mem_physical_padding_setup);
> +
>  /* Initialize base and padding for each memory region randomized with KASLR */
>  void __init kernel_randomize_memory(void)
>  {
> @@ -102,7 +117,7 @@ void __init kernel_randomize_memory(void)
>  	 */
>  	BUG_ON(kaslr_regions[0].base != &page_offset_base);
>  	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> -		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> +		rand_mem_physical_padding;
>  
>  	/* Adapt phyiscal memory region size based on available memory */
>  	if (memory_tb < kaslr_regions[0].size_tb)
> -- 
> 2.18.0
> 
