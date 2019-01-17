Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C7420859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCtBB3nZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfAQWAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:00:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39844 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfAQWAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:00:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so5348516pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 14:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SsOaaCSSXWMYBSprY2bua07xhAURJKtBDTpbO+78cJI=;
        b=WCtBB3nZCUOV0qq/63/UoZnpV2wKOKi7lS0JzOeZ7JlMCUPYzB3QG03zdSuxIzgYC1
         sY8qd4RLcHyPPMMq328H3lq3QIGNx6rjYNHf08ivyvUTCpK5beVkMk8NO2mWaKh9Fh/x
         STBS9R10GZyqS2sNxohN0PFaI1E+6e/YnQ9xN8d1qn2RQP8vAKb6ZU624r2GRylSRpZw
         BGObaSdxQ/aLbgqL80OSquPxhonGKoUC4fZdkfdzSO0537c7T81v80M122PAm0es7kXk
         gxR4yJQOphfitDDv2Fb6v7bA6ViP8dMJKOXnYjuB4pHLkgBElP5kHvHTAUENtr6+DGrk
         Dzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SsOaaCSSXWMYBSprY2bua07xhAURJKtBDTpbO+78cJI=;
        b=OuBEXfa/yK9sRIukOb43GfhehU1hrRnV7z02egkil3SiPQ4XTtVEke9rcPBPrj/2Ce
         ajAQRZ6ypE/vU4EUg1hMUG/+lbJOXsZAgzo3RzRSWGm4z17Izwb+mRhBiEoGuSm7mm5q
         3wsUYjTm914uLyZsq6EammfqqVTtXBS0n8wh5s05XY2cddu6byAthMgVN0M2C8xpfDFH
         Fos1yEJfrWu/YwrVT3Ib7OrM2GAKQhlm8kqTImyfBBTy+AM8ESQDUgzQbENm0xcqOooE
         3Uzl+WfWpOw/xXjyhtdpFK2lOHXryUgaKNQVxnnQiwKVz93JPYiAyvn0MKWtKZ2Ybz0v
         tSIQ==
X-Gm-Message-State: AJcUukeEqmo1atlqilb4KQhc/0hyisL479Ppk+uYcr4t0tw8MzsSsSol
        qn2i4lYX/QsBbN7DDrEYu4iPFtKw
X-Google-Smtp-Source: ALg8bN6S0+8IGO2GWH9+6BscnG1b+OCoM2WEkrhW5kWVgqU9ylQNMk0C7x2OssJ5lvyy//nnx8rEFg==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr16570394plq.77.1547762445606;
        Thu, 17 Jan 2019 14:00:45 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 5sm5497623pfz.149.2019.01.17.14.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:00:45 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:00:42 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ASoC: imx-spdif: don't print EPROBE_DEFER as error
Message-ID: <20190117220041.GB16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
 <20190117090640.12972-2-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-2-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:06:37AM +0100, Stefan Agner wrote:

> Removing the goto would not be strictly necessary. However, if
> code gets added later, the cleanup in the EPROBE_DEFER case likely
> would get missed.

Considering there is no code being added between them over the
years, I am okay to remove it since it makes things clean. But
as you mentioned, we gotta be careful if code gets added later.

> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-spdif.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
> index fb896b2c9ba3..797d66e43d49 100644
> --- a/sound/soc/fsl/imx-spdif.c
> +++ b/sound/soc/fsl/imx-spdif.c
> @@ -67,10 +67,8 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
>  		goto end;
>  
>  	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
> -	if (ret) {
> +	if (ret && ret != -EPROBE_DEFER)
>  		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
> -		goto end;
> -	}
>  
>  end:
>  	of_node_put(spdif_np);
> -- 
> 2.20.1
> 
