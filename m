Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291132147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6iqVvlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfBSS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:56:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44630 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfBSS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:56:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id y1so10537099pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eCJsi/sClMlcGZSq/RzjhArlVntOHBohk5vpJvo7ZjM=;
        b=Y6iqVvlEO/r1Y5Dwp65PqH+aKevXK9DYc8MX1wthWIyEg4LRTrkVqzH+CtXq/FHdg6
         DMBmKqcIxWwqjpr7R2ZBBN2L6JEC7Vn7uvWVwBcsYqTRxxBQRbyoDubTAtMfAlutq/jx
         0n/52RLdCorJ+zjlCIreYyN5/EeENNsKUI67oFSUVc0FL9qvxVyzPxT9uzg0k9Ktxixn
         XudFdFC/jhKJWejH3OgbnB54z7DuH/5Nh0t6rkZTjI6Lrw38K3AxDx4sdKjESRHrbch2
         SjXHuURWHFUMzlYzh2VFs4IEjAOUvv/O4RDGsyV8Btz+wsPpvJblGE0zLxemae3Gh0yh
         tvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eCJsi/sClMlcGZSq/RzjhArlVntOHBohk5vpJvo7ZjM=;
        b=XF3cMtU9DTBRVTR3utTCEoflIYqvrXkVOYprBC/ybA4KKQCThWzxMHUeJS4pqDEF0w
         IgVdJqs6yWIRkry8hbLdt4MfHvUUPYDkHBm2c1LDm4SSZ5Gc5o0XWi7cEfUGIhXJkVVi
         14aAHWql9bsF+9LqNBpcGfcGRiQvlbZhzDNb4Nqjiio5W8VhIF6FoCNjTS0vLTAKxkqD
         dfwG15+mEqIbG0x34zCtEPzGQsKYGM4iRmz45rsvrD0Lmn0fVYBvcY8YhaSWZrgSSPbj
         A3DIbJwGkS/ghiRCrX1gT8uv3bG2x3gu3e4zU0F2KxdQNjN0zAKM0hEsJwBYAqPHEeoF
         SwAg==
X-Gm-Message-State: AHQUAubkRgeCHSOneIaG55C/oMF0V21/lZWirPZBazAOOETOsRZsX3qH
        L5/sdF4FpahkpGiGYLT00by2pMyA
X-Google-Smtp-Source: AHgI3Ia8YGCOHNXxfyPw+ya7GUVeO9IAeGhZymLzD9yXk+drMvtXm3p9oSvcW81vx75zs4BQcHnOUA==
X-Received: by 2002:a65:628e:: with SMTP id f14mr25326479pgv.193.1550602572110;
        Tue, 19 Feb 2019 10:56:12 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w10sm18334151pgr.42.2019.02.19.10.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 10:56:11 -0800 (PST)
Date:   Tue, 19 Feb 2019 10:56:07 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: fix TXCLK_DF mask
Message-ID: <20190219185606.GA13373@Asurada-Nvidia.nvidia.com>
References: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 02:12:17PM +0000, Viorel Suman wrote:
> According to RM SPDIF TXCLK_DF mask is 7-bit wide.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
> index 7666dab..e6c61e0 100644
> --- a/sound/soc/fsl/fsl_spdif.h
> +++ b/sound/soc/fsl/fsl_spdif.h
> @@ -152,7 +152,7 @@ enum spdif_gainsel {
>  #define STC_TXCLK_ALL_EN_MASK		(1 << STC_TXCLK_ALL_EN_OFFSET)
>  #define STC_TXCLK_ALL_EN		(1 << STC_TXCLK_ALL_EN_OFFSET)
>  #define STC_TXCLK_DF_OFFSET		0
> -#define STC_TXCLK_DF_MASK		(0x7ff << STC_TXCLK_DF_OFFSET)
> +#define STC_TXCLK_DF_MASK		(0x7f << STC_TXCLK_DF_OFFSET)
>  #define STC_TXCLK_DF(x)		((((x) - 1) << STC_TXCLK_DF_OFFSET) & STC_TXCLK_DF_MASK)
>  #define STC_TXCLK_SRC_MAX		8
>  
> -- 
> 2.7.4
> 
