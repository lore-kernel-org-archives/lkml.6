Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A547ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A0E20836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MuU8mMyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A0E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJSS2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:28:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8179 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeJSS2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:28:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc9b0770000>; Fri, 19 Oct 2018 03:22:47 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 19 Oct 2018 03:22:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 19 Oct 2018 03:22:52 -0700
Received: from [10.26.11.35] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 19 Oct
 2018 10:22:49 +0000
Subject: Re: [PATCH v1 3/3] ASoC: soc-core: fix platform name vs. of_node
 assignement
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20181018111829.27056-1-marcel@ziswiler.com>
 <20181018111829.27056-4-marcel@ziswiler.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
Date:   Fri, 19 Oct 2018 11:22:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018111829.27056-4-marcel@ziswiler.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539944568; bh=bc0Q5U9+ahOH8rR9CBaPc/8DMVKaF9MvH5u9wZnq1YQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MuU8mMytmHfnbLmJvmD/clZ1WjYwtBpNHXVVNCMwlrvD4WflwDwdzBLqi8syGisfD
         9gaSYYaeYCyDRbAfDav9F2oae/NIiRQdnHyd/OkhTyk7wvzO88upTZ9C+jSJb1AKm2
         woZnPXlIoPQci7Arx1jNblkeXJ8ILB0vghp2Xq7qc1vBEJu8tj4yfUtAHik8ezwWMV
         atUL+5Du7fpjQL5rsE68tVjykwIzs9BDmlxTgPYeLN+ELntMP/6LNO1v3UKP4CDMd6
         dk4qBeTm1JoYzBgyhGp98oxGC/+6VPWb1zP4hSkRcKIUyG4ufATY5CqdtSF7jxXOMd
         6XPsrepnu+uXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/10/2018 12:18, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following error as seen post commit daecf46ee0e5
> ("ASoC: soc-core: use snd_soc_dai_link_component for platform") on
> Apalis TK1 after initial probe deferral:
> 
> tegra-snd-sgtl5000 sound: ASoC: Both platform name/of_node are set for
>  sgtl5000
> tegra-snd-sgtl5000 sound: ASoC: failed to init link sgtl5000
> tegra-snd-sgtl5000 sound: snd_soc_register_card failed (-22)
> tegra-snd-sgtl5000: probe of sound failed with error -22
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v1:
> - Split from the Tegra series as suggested by Mark.
> - Fix issue in soc-core rather than working around it in tegra_sgtl5000.
> 
>  sound/soc/soc-core.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 6ddcf12bc030..b97624005976 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2733,7 +2733,7 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
>  int snd_soc_register_card(struct snd_soc_card *card)
>  {
>  	int i, ret;
> -	struct snd_soc_dai_link *link;
> +	struct snd_soc_dai_link *link = NULL;
>  
>  	if (!card->name || !card->dev)
>  		return -EINVAL;
> @@ -2744,7 +2744,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
>  		if (ret) {
>  			dev_err(card->dev, "ASoC: failed to init link %s\n",
>  				link->name);
> -			return ret;
> +			goto err;
>  		}
>  	}
>  
> @@ -2763,7 +2763,17 @@ int snd_soc_register_card(struct snd_soc_card *card)
>  	mutex_init(&card->mutex);
>  	mutex_init(&card->dapm_mutex);
>  
> -	return snd_soc_bind_card(card);
> +	ret = snd_soc_bind_card(card);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	if (link && link->platform)
> +		link->platform = NULL;

Looking at snd_soc_init_platform(), it seems that the platform pointer
can be allocated by the machine driver and so if it is not allocated by
the core, then I don't think we should clear it here. Seems we need a
way to determine if this was allocated by the core.

Furthermore, it seems that it is possible that there is more than one
link that might be to be cleared.

Cheers
Jon

-- 
nvpublic
