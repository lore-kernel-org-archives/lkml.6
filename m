Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFC8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2132F21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2132F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbeKVBCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:02:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:25118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKVBCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:02:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 06:27:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="102050657"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2018 06:27:22 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gPTTN-0004GY-Ao; Wed, 21 Nov 2018 16:27:21 +0200
Date:   Wed, 21 Nov 2018 16:27:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S support
Message-ID: <20181121142721.GO10650@smile.fi.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:36:39PM -0600, Pierre-Louis Bossart wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> It's with CNP, supposed to be equivalent with CNL entry.
> 

May you consider to switch to PCI_DEVICE_DATA() first?

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/intel/skylake/skl-messages.c | 8 ++++++++
>  sound/soc/intel/skylake/skl.c          | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
> index 8bfb8b0fa3d5..b0e6fb93eaf8 100644
> --- a/sound/soc/intel/skylake/skl-messages.c
> +++ b/sound/soc/intel/skylake/skl-messages.c
> @@ -247,6 +247,14 @@ static const struct skl_dsp_ops dsp_ops[] = {
>  		.init_fw = cnl_sst_init_fw,
>  		.cleanup = cnl_sst_dsp_cleanup
>  	},
> +	{
> +		.id = 0xa348,
> +		.num_cores = 4,
> +		.loader_ops = bxt_get_loader_ops,
> +		.init = cnl_sst_dsp_init,
> +		.init_fw = cnl_sst_init_fw,
> +		.cleanup = cnl_sst_dsp_cleanup
> +	},
>  };
>  
>  const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 3f0ac1312982..df36b8fe6d5e 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -1121,6 +1121,9 @@ static const struct pci_device_id skl_ids[] = {
>  	/* CNL */
>  	{ PCI_DEVICE(0x8086, 0x9dc8),
>  		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +	/* CFL */
> +	{ PCI_DEVICE(0x8086, 0xa348),
> +		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, skl_ids);
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


