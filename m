Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6A5C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C3D218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAXR1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:27:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:9225 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbfAXR1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:27:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 09:27:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,517,1539673200"; 
   d="scan'208";a="269609851"
Received: from npillai-mobl1.amr.corp.intel.com (HELO [10.254.19.186]) ([10.254.19.186])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2019 09:27:14 -0800
Subject: Re: [alsa-devel] [PATCH][next] ASoC: Intel: bytcht_es8316: make
 mic_name static, reduces object code size
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
References: <20190124170621.7583-1-colin.king@canonical.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <08226544-958f-cf49-2a39-2a281f792954@linux.intel.com>
Date:   Thu, 24 Jan 2019 11:27:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124170621.7583-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index fa9c4cf97686..1364e4e601d8 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -437,7 +437,7 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
>   
>   static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   {
> -	const char * const mic_name[] = { "in1", "in2" };
> +	static const char * const mic_name[] = { "in1", "in2" };
>   	struct byt_cht_es8316_private *priv;
>   	struct device *dev = &pdev->dev;
>   	struct snd_soc_acpi_mach *mach;

We have the same code pattern in two other files, so if we care about 
this we should fix it across the board(s), no?

bytcht_es8316.c:    const char * const mic_name[] = { "in1", "in2" };
bytcr_rt5640.c:    const char * const map_name[] = { "dmic1", "dmic2", 
"in1", "in3" };
bytcr_rt5651.c:    const char * const mic_name[] = { "dmic", "in1", 
"in2", "in12" };

