Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5223320856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbikUgm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfAQHM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:12:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39574 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfAQHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:12:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so4375231pfc.6;
        Wed, 16 Jan 2019 23:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vVhx/gwmdibkZ9GwVR2GK59FMz6ZFGLkL2ElhFrhI8w=;
        b=gbikUgm1rrEaLXJgtwaXH6iNc64k8pet99/E0gCFwWS8CbgFcjOIcEZbMvcu39gzFW
         LWlMAp9/zES4Moyn72Emg7/mQcseIrvevQaAx8SwPGwUw0Kj0gTwt7FKzkrhaiIHvv+P
         KIhB3tsreSL9HBPIOiS1xjKpNaaVxrir4efUaLEF/uWyeZpvQqs/YmLLd2kz6e67Gj9V
         4NaCre+6ad7FBvaNnjAIKfVPyf6abPwAfl2um2DMQKl/J+vbB5FbXHzl3RBvQHtcBbKu
         Ww+LFurP8viy0woEpnBKiczEkuGq+O05DVc9KH4eIu+e1rn/7gQFI04ya5HcV3ZZBDFL
         UhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vVhx/gwmdibkZ9GwVR2GK59FMz6ZFGLkL2ElhFrhI8w=;
        b=nLFzus2alnXFGLvVsFl1L1ffnoaebEn9pwsfhv8Qsg4m/9iSW+hXv1ibHEIrAxzxXp
         pE6ad8ts4ng1p3SMp7lkUZFMdQFoFgag0BUaS7bPynoRfZqN23QqH1PCc/6UMh5wCUuL
         g4Q6co1/TYdB+cZO6OXV+0k+lK3GBEHZ65FPtkbF7Lqz04av7PUnYlH2tJVrl172wR2n
         mRf+M4j/f0lZJ5Itzg5EANdB4JLRqLVNF7+9G1w+QrK16EgK9NPIeb8Ufm8nZsWLPC2L
         68brMzgeDCZgz7fS9pKt0lFLoZN/4m+9sY5sp8Qc62oeqBGDDem/JuuggLBB69o0nEkj
         ZfDw==
X-Gm-Message-State: AJcUukd77tWsitc+9L3p3W+NPErvw4O43IctGioQW7ugfGdGbbknbFFc
        0gxJ/rEu7nGyo9Iu32oGquY=
X-Google-Smtp-Source: ALg8bN6O5FONsOpBFc+lpWEMrx+1OMb4XLjXOYJD0GFG4LmGtU8qCc9IMWjaD+s2NTlW05SUm8rDOQ==
X-Received: by 2002:a63:680a:: with SMTP id d10mr12518942pgc.396.1547709145517;
        Wed, 16 Jan 2019 23:12:25 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 84sm1186877pfk.134.2019.01.16.23.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 23:12:24 -0800 (PST)
Date:   Wed, 16 Jan 2019 23:12:23 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Input: olpc_apsp - assign priv->dev earlier
Message-ID: <20190117071223.GB8109@dtor-ws>
References: <20190116094438.1921667-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116094438.1921667-1-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:44:38AM +0100, Lubomir Rintel wrote:
> The dev field needs to be set when serio_register_port() is called,
> because the open callback may use it (in the error handling path).
> 
> Cc: stable@vger.kernel.org # v4.18+
> Fixes: commit af518342effd ("Input: olpc_apsp - check FIFO status on open(), not probe()")
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied, thank you.

> ---
>  drivers/input/serio/olpc_apsp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> index 0aece9777087..554f4b8228d2 100644
> --- a/drivers/input/serio/olpc_apsp.c
> +++ b/drivers/input/serio/olpc_apsp.c
> @@ -198,6 +198,8 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	priv->dev = &pdev->dev;
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->base)) {
> @@ -261,7 +263,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  		goto err_irq;
>  	}
>  
> -	priv->dev = &pdev->dev;
>  	device_init_wakeup(priv->dev, 1);
>  	platform_set_drvdata(pdev, priv);
>  
> -- 
> 2.20.1
> 

-- 
Dmitry
