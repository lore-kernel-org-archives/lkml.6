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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70C3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF98B20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOPPOH0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfAQVws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:52:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41436 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfAQVwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:52:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so5328533plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NHUsbp9tuoBt7tyqG8KfIUlUd2m+SP3Ifiu6qGhDUB4=;
        b=fOPPOH0tpgHfcDcYZAXZgGVlmE1T8nIx5qSPQ8WDF1zoAFhhNcmE0jccuiTT3ranJZ
         mVPEXJ/0usoejMKPg3N31hD7KC6Ntf2jE4H4OrqZpPQr2NBY+rwIte2PBXllJalB4Bkv
         3ITorYNKiiaKnvKJfOEKIkxPwP0rk5yLW56lzJeiWz/hxZEru5ZvSP84CJY4pjg6g3pk
         PmrdlWlzIBPepw3/6fTrU19M9mdrQGTLHEaLE8ugg6ipw+Lc+IfOriFQ44RXxo27hwQm
         iZyPLR3r2+5zaw3PSt4+Y08qn5WpZkN598dl3NqECms27CcTmfpbzVp91QUJ0w4AVBOz
         FkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NHUsbp9tuoBt7tyqG8KfIUlUd2m+SP3Ifiu6qGhDUB4=;
        b=JgO5dFejmQAZ8CQIVOq3JCfRTgV0+P6ug8K+EHphgZss76BVIXHgZ53ybOtaBqCczf
         d6ZMRVhz4TOCTE+roed7qQQw+5IQudXB2Mju9/LdZ4HCxfGykBsJDIOJb/u+p+FdbiFq
         s51vGqw/RdTxPnfSVaiv+XYN8qWhUtjVLnKfINbb4CWmvKLu+wA70u4b4zU8DdVh8U7a
         pqp9lB+V99yFfexnY8zB+dFPL+OXzmh9RvYQUxvfCfQoZeSJTVdksKlPrHse04iFaMD2
         4y8JjOSVUMII/LhDeFcuYHvumbPFwApmyLdvfZWbSY82SLG62SHGcF2e0cCqQsSckOJN
         BRMA==
X-Gm-Message-State: AJcUukfBprp89PYZfh/pJyuHIzXf8FTpsQ1vor0BQvCPXeG7mXdQBMJN
        W41VNCZ+kSTE/NVMzsaGyrI=
X-Google-Smtp-Source: ALg8bN4rdYr7+Ok465I/pDtyvZHtEbtGCjbHtUaemUDS9hPvnoc6eJB6Z++8j5Shlr4+QH8Gr2A8gw==
X-Received: by 2002:a17:902:2868:: with SMTP id e95mr16665182plb.317.1547761966696;
        Thu, 17 Jan 2019 13:52:46 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j73sm406546pge.13.2019.01.17.13.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 13:52:46 -0800 (PST)
Date:   Thu, 17 Jan 2019 13:52:41 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ASoC: fsl_spdif: don't print EPROBE_DEFER as error
Message-ID: <20190117215240.GA16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-1-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:06:36AM +0100, Stefan Agner wrote:
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 740b90df44bb..a26686e7281c 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1320,7 +1320,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
> -	if (ret)
> +	if (ret && ret != -EPROBE_DEFER)
>  		dev_err(&pdev->dev, "imx_pcm_dma_init failed: %d\n", ret);
>  
>  	return ret;
> -- 
> 2.20.1
> 
