Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C56BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159E32147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpCPBdYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfBSTB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:01:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34154 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSTB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:01:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so3391403pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 11:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dqjN7Y98iax4DhXzFYlyCN9SeqrXCABc0VZJksvSrg=;
        b=OpCPBdYpV/MVzsOY/FJDzxu9itQFe/UOGjHD0ybqauWRJ1hDHVwxDvYU5l8xnRmvrr
         wunWiqX/3I0WN7fmLSbQHw8awF74Xhoq6kEJUh4dGQ6kKPe1kjZcw6wTtCE9oJtAFS0/
         GzMX0H5Omog4gvlMzHpydKSRMSu9KXt8CtbG9xdEB9uSSL8G7mTda/RHoxCNH4/jiUQL
         gAshgwbpcZG3qWfxPFtz79hCV6EzVKNDBEe2DA+OkExRFGPzGYn0wfZc9HD/6PcBWXP2
         A9aSRX20CFArm15E++f8Ovr0U3m2KJll4f8WfmlL5bk+VgTpxwCifTmhptUJr6M16YL3
         y9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dqjN7Y98iax4DhXzFYlyCN9SeqrXCABc0VZJksvSrg=;
        b=WQ2rj7zOChsZX7Y9j2BIFjZ+PIao0et1rUi9ZTUI3kbSuCdE/BfYyBD/Dtek7LwEyv
         VN/0aq+P0JJ3lLLaU00MKwB2wcLPNV9KNQpwm+3xnx252Wy5DzmTjnjGISONrH8i+kN4
         iwOrPLfGUE8MsbI7IkzFpsNRAk7UtfHBhBXUhteHD0Tj3fB2t3Mmlbn/7zEfbpgwkUBB
         xCOIzcMDzDATHKqrQqq/hTVd2BVoMo2a7iRMR4eDurPDGc1d/FCK1A2GV+lHb+ZYvL4j
         BpllwlDoo9gbPkjCZ+l90X56oBm8SM5cd4Cu0nBa1/gfl2E6O1geJE626bQwNeANNYiG
         6Q/A==
X-Gm-Message-State: AHQUAuaXOEbYedcLi67/76ioeuWmts1ZIVYMQcS7dYw0Oz0/V3Pfq1tP
        HARbsJKgFZuw5RqmzULbd9I=
X-Google-Smtp-Source: AHgI3IYqYw9XQFEL1T9dxKHLkN7bHPB12de5CGE6uR/8W+tHvImJqcLEcShlhwebSAROw/U/X1Qszg==
X-Received: by 2002:aa7:92da:: with SMTP id k26mr16119756pfa.216.1550602885893;
        Tue, 19 Feb 2019 11:01:25 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h3sm2004611pgv.38.2019.02.19.11.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:01:25 -0800 (PST)
Date:   Tue, 19 Feb 2019 11:01:22 -0800
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
Subject: Re: [PATCH] ASoC: fsl_spdif: fix sysclk_df type
Message-ID: <20190219190121.GB13373@Asurada-Nvidia.nvidia.com>
References: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 03:25:00PM +0000, Viorel Suman wrote:
> According to RM SPDIF STC SYSCLK_DF field is 9-bit wide, values
> being in 0..511 range. Use a proper type to handle sysclk_df.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index a26686e..4842e6d 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -96,7 +96,7 @@ struct fsl_spdif_priv {
>  	bool dpll_locked;
>  	u32 txrate[SPDIF_TXRATE_MAX];
>  	u8 txclk_df[SPDIF_TXRATE_MAX];
> -	u8 sysclk_df[SPDIF_TXRATE_MAX];
> +	u16 sysclk_df[SPDIF_TXRATE_MAX];
>  	u8 txclk_src[SPDIF_TXRATE_MAX];
>  	u8 rxclk_src;
>  	struct clk *txclk[SPDIF_TXRATE_MAX];
> @@ -376,7 +376,8 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
>  	struct platform_device *pdev = spdif_priv->pdev;
>  	unsigned long csfs = 0;
>  	u32 stc, mask, rate;
> -	u8 clk, txclk_df, sysclk_df;
> +	u16 sysclk_df;
> +	u8 clk, txclk_df;
>  	int ret;
>  
>  	switch (sample_rate) {
> @@ -1109,8 +1110,9 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
>  	static const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
>  	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
>  	u64 rate_ideal, rate_actual, sub;
> -	u32 sysclk_dfmin, sysclk_dfmax;
> -	u32 txclk_df, sysclk_df, arate;
> +	u32 arate;
> +	u16 sysclk_dfmin, sysclk_dfmax, sysclk_df;
> +	u8 txclk_df;
>  
>  	/* The sysclk has an extra divisor [2, 512] */
>  	sysclk_dfmin = is_sysclk ? 2 : 1;
> -- 
> 2.7.4
> 
