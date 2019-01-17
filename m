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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EB8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D0D20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6zmxOpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfAQWEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:04:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41152 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfAQWEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:04:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so5341260plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 14:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oqFR0VKse0SEm8pzVFQSvNgeI7TCxCQt1e5jG1tzGeE=;
        b=l6zmxOpr56M2IVJ87zvCq0+Ixm6ZZOVvnocS7ZEjOMA/w3FQumCiyXVbeGqWdL1Y8o
         Vp60Oe7PcoIbDUd3orVEd++mnEbxxnH7+6tQbR44usi8q6Woevkn6cM+IPNR8J+P4xtT
         TQERoMjAdoHUMwNhMKhUQRBobfauQalTWmq+Ss1tQLNfUrBSZ5InFWyHhYHvFpjZD/Fh
         DjfMQ+x9fWFX8ed48vg8Y6LLSBICRSf9DNtvHZQdpwSlH/oo95ozEasT93+DtsI9WVP6
         N7aTqF39tQThE/mSQp4gXlGlXmaq/KvSBhCdO9X2EpYnnPNhVdFomSOjZl/T4U4zrBr6
         u/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oqFR0VKse0SEm8pzVFQSvNgeI7TCxCQt1e5jG1tzGeE=;
        b=d897k9RS02Vq8eT0wK6yMa2xZvOowufzL1F5GDu55LLLvm8RkjloNoe2F9n31qdlm/
         547eRpXsmPJQDL0ks25ETTC3WhkunSDRNX192fJFoMbCy11mGkpyE/0bqgwnbX7kQLTS
         dyitZa60kTuLJW3+SCYPIhZfr1jabRflOskophgNI7IdfY71haS0tAfvzs+juV3TBqzy
         JNe0X5cy0KQNc0FG1JJzeJNDIx4YU6vKc0fLDuhT9+3wyUrnHQlDzDbp7Zh4fQEIaJrs
         BP9k0dO7nVlomzEirijUGPE5cNLKixo1r6deCKZ2cAd6kMpsTRXYGnGNt54KucJuRuHA
         rD5Q==
X-Gm-Message-State: AJcUuke+KpKbtHI9UBArTOkzF2f0InNKQySxdirbTxMyizh6EFyz857G
        mO3bsc6xf5PXDFpWUR18r2w=
X-Google-Smtp-Source: ALg8bN7B6o7j34Mk5JC7xLa0w0Ao9zCRO6/ZRojEKZ92IS+Vz1ITIY2yugKndUZCOESjVXaduvxccA==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr16780854ply.65.1547762691086;
        Thu, 17 Jan 2019 14:04:51 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e128sm3612126pfe.67.2019.01.17.14.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:04:50 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:04:48 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] ASoC: imx-sgtl5000: put of nodes if finding codec
 fails
Message-ID: <20190117220448.GE16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
 <20190117090640.12972-4-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-4-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:06:39AM +0100, Stefan Agner wrote:
> Make sure to properly put the of node in case finding the codec
> fails.
> 
> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-sgtl5000.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index e1e20499b2f1..45969e6dfad7 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -111,7 +111,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	codec_dev = of_find_i2c_device_by_node(codec_np);
>  	if (!codec_dev) {
>  		dev_err(&pdev->dev, "failed to find codec platform device\n");
> -		return -EPROBE_DEFER;
> +		ret = -EPROBE_DEFER;
> +		goto fail;
>  	}
>  
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> -- 
> 2.20.1
> 
