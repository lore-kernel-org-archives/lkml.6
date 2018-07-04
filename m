Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23951C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13AB240F9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjmBS+Xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13AB240F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeGDTxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:53:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41277 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeGDTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:53:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so3367099pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mJtVWFIyiNtBuSDSTubhNtsk0HIsvaw7yNS9JqPSJVs=;
        b=AjmBS+XjIE5M8NX4MMKytUYEthoeGvbkYNzlJ3kFXsMtVXtWgc8RIpXhJha18NBLI8
         umezi5PWzGYWx0NcmbHUtdc0c4nF83AwGDyRNHm2p4w+rhctOf6EQMUHR5+0TYPLs4NN
         XRy4/tZyRbE1rCGjWf4wDyFbnECf+X3eTXu4ZIwZXtgdnW/q8Ys8JtzFJhufwtj6KHY2
         EOOoqh5CCO0gpXj4OerL5b73V9wAjCRM5bmOnkjgBz/MFxkgjCUU7Sw7Brztya+PKB9c
         1DYP0WUewnvBGo7z5ELfpRmExcbFPcqFAKJnfCBSxxGMjrEqEggIFJ2+UYa1Rloyodt8
         Isxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJtVWFIyiNtBuSDSTubhNtsk0HIsvaw7yNS9JqPSJVs=;
        b=F3tAfY2n5hbKWvnMohYJtG5Hi/wlOi4lhixXU04w/Fr+AGmb/t4v4A96S6E+ZSLkOr
         NKUmpgdlCByI8kjapzJ4Gw5LoqAhGTRhVrP/NTzeQXqsAUeTt7ExpKvaJESlPrvq2Kl5
         2uk9CRS3nYSDpvi6K8GEraao4Xumqdp2dMRGHRq0KVpWJvbjWWa8CHq3qt6F45B9Z4qZ
         BxTFBb+jwNFf2XAfeS5ENjZMR/2OF36vS+k0y0/5oYVz4IoTavmH4fW2XVbcj4Az0/gy
         UhHX9eajek44DA67PPZ/vYMBq5sDg3PcMGWymH3iYpQLhMp4ePAo/9eysi0fhKoMv2DD
         4K+Q==
X-Gm-Message-State: APt69E1O3gey1go0DeINrXTg7wIn6ohBYk1HDvY/XOURaAFHzO8n+tMs
        MlZELA7uupTi2OfIlwKm0Fc=
X-Google-Smtp-Source: AAOMgpcyB7Jmen/rTupHMxpmd6qaU40FZPa5Z2H3pTs1rs3/7lER5kG1COVmPQqy3We8fDkdImVGrQ==
X-Received: by 2002:a62:a8e:: with SMTP id 14-v6mr3475508pfk.57.1530734012241;
        Wed, 04 Jul 2018 12:53:32 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id s8-v6sm10988085pfi.154.2018.07.04.12.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 12:53:31 -0700 (PDT)
Date:   Wed, 4 Jul 2018 12:53:26 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_spdif: Use 64-bit arithmetic
 instead of 32-bit
Message-ID: <20180704195325.GA7800@Asurada>
References: <20180704141833.GA6702@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704141833.GA6702@embeddedor.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 09:18:33AM -0500, Gustavo A. R. Silva wrote:
> Add suffix ULL to constant 64 in order to give the compiler complete
> information about the proper arithmetic to use.
> 
> Notice that such constant is used in a context that expects an
> expression of type u64 (64 bits, unsigned) and the following
> expression is currently being evaluated using 32-bit arithmetic:
> 
> rate[index] * txclk_df * 64
> 
> Addresses-Coverity-ID: 1222129 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks.

> ---
>  sound/soc/fsl/fsl_spdif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 9b59d87..740b90d 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1118,7 +1118,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
>  
>  	for (sysclk_df = sysclk_dfmin; sysclk_df <= sysclk_dfmax; sysclk_df++) {
>  		for (txclk_df = 1; txclk_df <= 128; txclk_df++) {
> -			rate_ideal = rate[index] * txclk_df * 64;
> +			rate_ideal = rate[index] * txclk_df * 64ULL;
>  			if (round)
>  				rate_actual = clk_round_rate(clk, rate_ideal);
>  			else
> -- 
> 2.7.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
