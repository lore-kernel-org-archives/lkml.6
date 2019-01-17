Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E6BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A950420859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhn0I3wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfAQWDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:03:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39000 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfAQWDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:03:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so5351890pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B00rvx8w1qaGLmnjIVj3ZrmlkxjPJYojZcbSv08jglA=;
        b=Dhn0I3wjXpxaAoZqlX3fUvgHycKhvr7li4c3BoGjNWsajKQ2RVRRMaGWOjPKHX9Tu8
         RGOxgg43rR5jLm85G0P2OY8zFDKCHiGFYv35wzKMpSq0DtY/X99SARcrieaYnOledOxi
         6tkX3SqmVNe+EIRkZYuvTi4y63FxPVu13ACuCCexz5i8m1bzMGUBbwf8ACtXIEZdgvzC
         TRUdIQ3OUNdhuRN+OeErx1KnV2u+IzOnXBNtW2Kl8ac0xvTJ46Uj1bXR8rgxoAW1eeiV
         synpe2dJdgR0RLlxlhsWZWp6wPwITVduL3+ERCx4x7ROHjD22fWjKsLPGO0BuTaduw2E
         EZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B00rvx8w1qaGLmnjIVj3ZrmlkxjPJYojZcbSv08jglA=;
        b=CrxIi5LanguKgrTdgD4SYcmizlNpUcrw61GjF9a5SmfwY3dZBixD7XZWgII3jExF7a
         gB655ipt+CGYVAt8f7PSAk/XSedqV+YS077c08itFS2zxVHaIWdmeezTH4obYXnN51cO
         AWPDKsZ82KSJNfvIspWwDjCuyTeHikXP9yQ43uIFI/us2pa8DMoggZ8mrgwSxN59ldVf
         NjA6xMJVQA5U8K5EWBdqcaEOuX9hgxHqlQtNYmWtPDpaOKJlD5r2/OjI9zWVi0qsac9b
         GbeVpAh1/zDNXhzQAdI9uIg1IO9eLUI3mgSu42yBiyneiEX/cZE//+cgGiylWvPynhP4
         oIPA==
X-Gm-Message-State: AJcUukdjHUKg3c0UEJ8WSNJyVE9EvUKfgFDClCfxdAmPy9V+cKXiWng9
        WwfGPu4vWs4/JKFFFSDeaLA=
X-Google-Smtp-Source: ALg8bN4BHbJy2TFsS1m/s+uXmSeuezMFIY8qo1uORnZhlMZYuOJNY/m18LHYy+S82higTORgL0O5hQ==
X-Received: by 2002:a17:902:e20b:: with SMTP id ce11mr16160537plb.251.1547762626464;
        Thu, 17 Jan 2019 14:03:46 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l22sm3705765pfj.179.2019.01.17.14.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:03:45 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:03:43 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ASoC: imx-sgtl5000: don't print EPROBE_DEFER as error
Message-ID: <20190117220342.GD16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
 <20190117090640.12972-3-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-3-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:06:38AM +0100, Stefan Agner wrote:
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-sgtl5000.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index c29200cf755a..e1e20499b2f1 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -156,7 +156,9 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  
>  	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
>  	if (ret) {
> -		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
> +				ret);
>  		goto fail;
>  	}
>  
> -- 
> 2.20.1
> 
