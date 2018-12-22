Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8416C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C482190A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W0Fy0rMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404922AbeLVAjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:39:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbeLVAju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NrEK+YusRCovVTNvcNspMx0mn5oZh6ckEmmAj4Y8Oac=; b=W0Fy0rMQ7q40St1BChhXPqLfk
        bxxJq23U0XGjTy/UhS32aSLFJb8a6Blomk3zkqzQch9+0ZD3VXRQ+mD/WrtkvRRUfV+ZXEZFvH8Pm
        9kAK0C+69hus8V4sVhFGdL5MAZ3l+370uannuejBt2GgKF9qhtGE2fZjOGCfP0LwifLQcWmt2CxEQ
        BZD3ZZTzp6+gX5p+pRSl/mPkyoSBHgHPPUAxlaImDn/GVechwS23uA33VxTgYrYFB47nXACFOD+bq
        vEmTcWz317Fh+EmwkgdswhD7y1doy3MhYCJ3I6osfeheflYftMUYp/T4l2abrDFOr3OSXvHAqg2EP
        jodjSTFww==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaVKW-0005py-0x; Sat, 22 Dec 2018 00:39:48 +0000
Subject: Re: [PATCH] ASoC: Intel: fix unmet dependencies in Kconfig
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20181221204955.30993-1-pierre-louis.bossart@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c4588b86-0746-f05a-6b3f-304d170ecca3@infradead.org>
Date:   Fri, 21 Dec 2018 16:39:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181221204955.30993-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 12:49 PM, Pierre-Louis Bossart wrote:
> Remove warnings by selecting SND_HDA_INTEL_DSP_DETECTION_XYZ only when
> SND_HDA_INTEL is part of the config.
> 
> Fixes: c337104b1a16 ('ALSA: HD-Audio: SKL+: abort probe if DSP is present and Skylake driver selected')
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  sound/soc/intel/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 2fd1b61e8331..555cdb1d87d4 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -188,12 +188,12 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
>  	select SND_SOC_TOPOLOGY
>  	select SND_SOC_INTEL_SST
>  	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
> -	select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL
> -	select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL
> -	select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL
> -	select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK
> -	select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL
> -	select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL
> +	select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL && SND_HDA_INTEL
>  	select SND_SOC_ACPI_INTEL_MATCH
>  	help
>  	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
> 


-- 
~Randy
