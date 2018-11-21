Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F7FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E97B2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E97B2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbeKVBOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:14:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:3044 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeKVBOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:14:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 06:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="106526595"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2018 06:39:41 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gPTfH-0004LD-TK; Wed, 21 Nov 2018 16:39:39 +0200
Date:   Wed, 21 Nov 2018 16:39:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] ALSA: hda: add fallback capabilities for SKL+
 platforms
Message-ID: <20181121143939.GQ10650@smile.fi.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120213644.19103-7-pierre-louis.bossart@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:36:44PM -0600, Pierre-Louis Bossart wrote:
> Enable fallback for select PCI IDs
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/pci/hda/Kconfig     | 40 +++++++++++++++++++++++++++++++++++++++
>  sound/pci/hda/hda_intel.c | 19 +++++++++++++------
>  sound/soc/intel/Kconfig   |  6 ++++++
>  3 files changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
> index 4235907b7858..9bb317fb3507 100644
> --- a/sound/pci/hda/Kconfig
> +++ b/sound/pci/hda/Kconfig
> @@ -228,4 +228,44 @@ config SND_HDA_POWER_SAVE_DEFAULT
>  
>  endif
>  
> +if SND_HDA_INTEL
> +
> +config SND_HDA_INTEL_LEGACY_FALLBACK_SKL
> +	bool
> +	help
> +	  This option enables HD-audio legacy fallback for
> +	  Skylake machines
> +
> +config SND_HDA_INTEL_LEGACY_FALLBACK_APL
> +	bool
> +	help
> +	  This option enables HD-audio legacy fallback for
> +	  Broxton/ApolloLake machines
> +
> +config SND_HDA_INTEL_LEGACY_FALLBACK_KBL
> +	bool
> +	help
> +	  This option enables HD-audio legacy fallback for
> +	  KabyLake machines
> +
> +config SND_HDA_INTEL_LEGACY_FALLBACK_GLK
> +	bool
> +	help
> +	  This option enables HD-audio legacy fallback for
> +	  GeminiLake machines
> +
> +config SND_HDA_INTEL_LEGACY_FALLBACK_CNL
> +	bool
> +	help
> +	  This option enables HD-audio legacy fallback for
> +	  CannonLake machines
> +
> +config SND_HDA_INTEL_LEGACY_FALLBACK_CFL
> +	bool
> +	help
> +	  This option enables HD-audio legacy fallback for
> +	  CoffeeLake machines
> +
> +endif ## SND_HDA_INTEL
> +
>  endmenu
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index eb00e37c1c27..569419242da3 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -360,6 +360,7 @@ enum {
>  	 AZX_DCAPS_NO_64BIT |\
>  	 AZX_DCAPS_4K_BDLE_BOUNDARY | AZX_DCAPS_SNOOP_OFF)
>  
> +#define AZX_DCAPS_INTEL_LEGACY_FALLBACK(conf) (IS_ENABLED(conf) ? AZX_DCAPS_INTEL_SHARED : 0)
>  /*
>   * vga_switcheroo support
>   */
> @@ -2416,34 +2417,40 @@ static const struct pci_device_id azx_ids[] = {
>  	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>  	/* Sunrise Point-LP */
>  	{ PCI_DEVICE(0x8086, 0x9d70),
> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
> +	  AZX_DCAPS_INTEL_LEGACY_FALLBACK(CONFIG_SND_HDA_INTEL_LEGACY_FALLBACK_SKL) },

Preprocessor may concatenate the same prefix for you.
I expect to see something like ..._FALLBACK(SKL) and so on.

Moreover, you can go further and create a macro that would consolidate all bits together.


>  	/* Kabylake */
>  	{ PCI_DEVICE(0x8086, 0xa171),
>  	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>  	/* Kabylake-LP */
>  	{ PCI_DEVICE(0x8086, 0x9d71),
> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
> +	  AZX_DCAPS_INTEL_LEGACY_FALLBACK(CONFIG_SND_HDA_INTEL_LEGACY_FALLBACK_KBL) },
>  	/* Kabylake-H */
>  	{ PCI_DEVICE(0x8086, 0xa2f0),
>  	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>  	/* Coffelake */
>  	{ PCI_DEVICE(0x8086, 0xa348),
> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
> +	  AZX_DCAPS_INTEL_LEGACY_FALLBACK(CONFIG_SND_HDA_INTEL_LEGACY_FALLBACK_CFL) },
>  	/* Cannonlake */
>  	{ PCI_DEVICE(0x8086, 0x9dc8),
> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE |
> +	  AZX_DCAPS_INTEL_LEGACY_FALLBACK(CONFIG_SND_HDA_INTEL_LEGACY_FALLBACK_CNL) },
>  	/* Icelake */
>  	{ PCI_DEVICE(0x8086, 0x34c8),
>  	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>  	/* Broxton-P(Apollolake) */
>  	{ PCI_DEVICE(0x8086, 0x5a98),
> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON |
> +	  AZX_DCAPS_INTEL_LEGACY_FALLBACK(CONFIG_SND_HDA_INTEL_LEGACY_FALLBACK_APL) },
>  	/* Broxton-T */
>  	{ PCI_DEVICE(0x8086, 0x1a98),
>  	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
>  	/* Gemini-Lake */
>  	{ PCI_DEVICE(0x8086, 0x3198),
> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON |
> +	  AZX_DCAPS_INTEL_LEGACY_FALLBACK(CONFIG_SND_HDA_INTEL_LEGACY_FALLBACK_GLK) },
>  	/* Haswell */
>  	{ PCI_DEVICE(0x8086, 0x0a0c),
>  	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index c02d08d31d0d..4c6abdbb0b90 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -197,6 +197,12 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
>  config SND_SOC_INTEL_SKL_LEGACY_SUPPORT
>  	bool "Fallback legacy HD-audio binding"
>  	depends on SND_HDA_INTEL=y || SND_SOC_INTEL_SKYLAKE_FAMILY=SND_HDA_INTEL
> +	select SND_HDA_INTEL_LEGACY_FALLBACK_SKL if SND_SOC_INTEL_SKL
> +	select SND_HDA_INTEL_LEGACY_FALLBACK_APL if SND_SOC_INTEL_APL
> +	select SND_HDA_INTEL_LEGACY_FALLBACK_KBL if SND_SOC_INTEL_KBL
> +	select SND_HDA_INTEL_LEGACY_FALLBACK_GLK if SND_SOC_INTEL_GLK
> +	select SND_HDA_INTEL_LEGACY_FALLBACK_CNL if SND_SOC_INTEL_CNL
> +	select SND_HDA_INTEL_LEGACY_FALLBACK_CFL if SND_SOC_INTEL_CFL
>  	help
>  	  Fallback binding with the legacy HD-audio driver when no DSP is
>  	  found
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


