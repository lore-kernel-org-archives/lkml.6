Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89932ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B401214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oOPh1kch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B401214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeJQU2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:28:14 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9221 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeJQU2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:28:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc72be90000>; Wed, 17 Oct 2018 05:32:41 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 05:32:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Oct 2018 05:32:44 -0700
Received: from [10.26.11.110] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 12:32:40 +0000
Subject: Re: [PATCH v2 9/9] ASoC: tegra_sgtl5000: fix platform name vs.
 of_node assignement
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <alsa-devel@alsa-project.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
 <20181016104730.4598-10-marcel@ziswiler.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <35848cb7-36ee-6698-ff17-7f0e73567914@nvidia.com>
Date:   Wed, 17 Oct 2018 13:32:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181016104730.4598-10-marcel@ziswiler.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539779561; bh=YL2JHS4TpWtu7co5aSzUufDQkFRW1ZFRW2N+mCZc1BI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oOPh1kch0g5C7EpaKxbncLQE0wz7yLsvVOB8qDvEonjiyMBL76FRjAqhP2eUAysfu
         3cbWZo8q7da8MTK1Ftvykr61fyFfC74pqLGfKQ1+dBIlQjqYcDQNFjMHWvN8hbe5tX
         2RmOdc9YIWBS3r4RP9MZRgYd7c6RryinNe02fNQzRZPx2FW1waBAxI5mIv3D4Rk5DD
         Xo1gwjDNQ7PQYNLWR7j9VpYDhZ8m13IqK8tMjhQW8q+3MUzkVSG73bHeFtJbUfszqm
         BUotIw1TxciZi77flF9ESeXUoOuy5nC6ys5Yv/EpX3b7zekjCV8QRkO2JOGptEBa+D
         SBiNcyNiZQGqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/10/2018 11:47, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following error as seen post commit daecf46ee0e5
> ("ASoC: soc-core: use snd_soc_dai_link_component for platform"):
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
> Changes in v2: New patch
> 
>  sound/soc/tegra/tegra_sgtl5000.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/tegra/tegra_sgtl5000.c b/sound/soc/tegra/tegra_sgtl5000.c
> index 901457da25ec..eb702925cac3 100644
> --- a/sound/soc/tegra/tegra_sgtl5000.c
> +++ b/sound/soc/tegra/tegra_sgtl5000.c
> @@ -168,6 +168,11 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_fini_utils:
> +	if (tegra_sgtl5000_dai.platform) {
> +		devm_kfree(&pdev->dev, tegra_sgtl5000_dai.platform);
> +		tegra_sgtl5000_dai.platform = NULL;
> +	}
> +
>  	tegra_asoc_utils_fini(&machine->util_data);
>  err_put_cpu_of_node:
>  	of_node_put(tegra_sgtl5000_dai.cpu_of_node);
>

Where is the above allocated? I don't see it allocated in this driver
AFAICT. If it is not then it does not seem right to free something that
we have not allocated in this driver. I would have assumed it was
allocated by snd_soc_init_platform() in which case it should not be
necessary to free because that function uses devm_kzalloc(). What am I
missing here?

Cheers
Jon

-- 
nvpublic
