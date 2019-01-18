Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181D3C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F052086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8oxMwSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfARUIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:08:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32997 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbfARUIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:08:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so6566418pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TpQ7f4JIfT5vxWNrpGua0+h+ogoriA4vjhHt/TsyXjQ=;
        b=s8oxMwSyzVceaQGocQJOR40qLC3FpyIro82oGoHmSdgDwzVfj9Cm2whWoMMQ1A8wxH
         nGa6BgZJYAEkJbMNTnOZHhl1xOlsolHaRaWR0QYwAXwusHe+MNn50DCQMmt0allQFTUN
         Z2gnk0UhjT8mBSZqV8zC50s8DBfcdK5ZHxTUD4XU/TUIxcs4NZDWxmPHpvZmcUJXCGZG
         fZfGMzkUvkGlHlpKPXFH3syoWqc2UBargoDkJiUcpNF5FczZ5kWNUa1P5Xq10avPa7Jo
         o8IajoLc8QrByMNrv4q5UauEoqFGlf0DfB8QrFoP4tyRja8+AGq0KXT8ACko6BNdJVUg
         3R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TpQ7f4JIfT5vxWNrpGua0+h+ogoriA4vjhHt/TsyXjQ=;
        b=rNPtZU91MJsLBwMVX6nb2x5sCtwB6BdFAl/Q7DVSoFWL8r5zK38LZ3WdYl4v1AxPVG
         BCOiG1ODA8ob5xvSADxKMbssf9PXyWd5Dw5fAkvVIegdoudF5bmj0IeOdjzXhohnQsX0
         DY/3g85fpl/Dtqk+H1CW7B9DUkZYnghTMPbxWrS8k+mGl+tAAf8qlo1RaIYdqcK0c1zj
         7kaG4zIKPaQG+GK6NDWBil9zCxJVwN7ksBTeLIwnWqM0Xfqa0iprj3YKTfoWaOvUT3Yi
         AuLhpGdrw3egabN/JCXHFQbzX/kKq2pOgyZCTH8yXwQtFwUU2QYLEoe/+Ek1zWdToZta
         gZCQ==
X-Gm-Message-State: AJcUukf4mvAEHLRXwscKy0fowae56BOoAbk1GEdQJ6XrnOgOxl4TEbTq
        qlSqUokxkIOsE/zy254jZPg=
X-Google-Smtp-Source: ALg8bN5/DHrMARH0q9cuc0yLDIslbVlxYsU00fMamaPQewQBops7j+IS6PqsAuoJxlCBsDK6ALHP2w==
X-Received: by 2002:a62:c613:: with SMTP id m19mr20831446pfg.207.1547842115013;
        Fri, 18 Jan 2019 12:08:35 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i193sm19474379pgc.22.2019.01.18.12.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 12:08:34 -0800 (PST)
Date:   Fri, 18 Jan 2019 12:08:32 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Remove expensive print in irq handler
Message-ID: <20190118200831.GB11798@Asurada-Nvidia.nvidia.com>
References: <20190118142623.17720-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118142623.17720-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:26:46PM +0000, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> When stopping audio, ASoC will first stop DMA then CPU DAI.
> Sometimes there is a delay between DMA stop and CPU DAI stop, which
> triggers an underrun error. Now, because of the delay introduced
> by dev_err another underrun error will occur causing a vicious circle
> making impossible to stop CPU DAI.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 4163f2cfc06f..db9e0872f73d 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -62,10 +62,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
>  		dev_dbg(dev, "isr: Start of Tx word detected\n");
>  
>  	if (flags & FSL_SAI_CSR_SEF)
> -		dev_warn(dev, "isr: Tx Frame sync error detected\n");
> +		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
>  
>  	if (flags & FSL_SAI_CSR_FEF) {
> -		dev_warn(dev, "isr: Transmit underrun detected\n");
> +		dev_dbg(dev, "isr: Transmit underrun detected\n");
>  		/* FIFO reset for safety */
>  		xcsr |= FSL_SAI_CSR_FR;
>  	}
> @@ -96,10 +96,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
>  		dev_dbg(dev, "isr: Start of Rx word detected\n");
>  
>  	if (flags & FSL_SAI_CSR_SEF)
> -		dev_warn(dev, "isr: Rx Frame sync error detected\n");
> +		dev_dbg(dev, "isr: Rx Frame sync error detected\n");
>  
>  	if (flags & FSL_SAI_CSR_FEF) {
> -		dev_warn(dev, "isr: Receive overflow detected\n");
> +		dev_dbg(dev, "isr: Receive overflow detected\n");
>  		/* FIFO reset for safety */
>  		xcsr |= FSL_SAI_CSR_FR;
>  	}
> -- 
> 2.17.1
> 
