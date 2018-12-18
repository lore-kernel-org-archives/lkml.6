Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6692E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbZ0nG9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLRJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:17:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44948 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeLRJRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:17:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so6890223plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xzlslNoG1OySK5gGb3sSkXp41ajzdgxbOTC1NFBdWug=;
        b=jbZ0nG9MRSgBPgEACGeY3RUiZuhob5HFaG9bJnAiRM7piKwUKYex70q0SdUoa8hHyT
         bDDFFrDQCiiqMqXCv2r596U8eR0mrYv1Tw1njK1rHfvGgGXPKJSTyVRiBpbn/DiDDyYK
         o74+wsfGZfEGmO91hoiOwEvKmp8njc/4Ge6XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xzlslNoG1OySK5gGb3sSkXp41ajzdgxbOTC1NFBdWug=;
        b=dUxydsrrlFUlllw2uf5D3lOHWI6U50iec+65R/OcMwFaJlya5TY86GK7u7AunT1ndC
         cD+00PGDnYyG4UVs1oxY92jV7YoWUS9YO8ClsyIiLrXvlERMxnPpfTc8japL7PunPNrc
         uhHxM3INU95o8Cbvpg5HYiRqJEg0Z151pKJck/u1fS42AnALPeowTpR9c+e0bkjq5H7p
         UtpSmnGMSmppQ0PokflvHGaM3nXu8Vf7Pwk+helxiRGfmyOdiI/RhZmKTFNf3e6AUvVg
         Tr7zaKqW2CkVYAwtXu3zommsowMxpXZrhcLd/hJn8gujlI08ug1BEAQ4YabdYkaigWEN
         SbbQ==
X-Gm-Message-State: AA+aEWZ2qW5PJnRYHiO6C32WL90oxsYMhGvDrsV8ONynAceI0Z0a8P6/
        2bzMADpuR8rytsExS+tVHq2fxkJEv1xyG8nc
X-Google-Smtp-Source: AFSGD/XrUreNf5631DWnATsf2G/ATUrtbyA1KtIT4eKbOuUNJGWI+5NXpYq7dhHhui384pMAVxv+qQ==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr15153105plz.75.1545124654324;
        Tue, 18 Dec 2018 01:17:34 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li547-117.members.linode.com. [198.74.50.117])
        by smtp.gmail.com with ESMTPSA id b2sm28474114pfm.3.2018.12.18.01.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 01:17:33 -0800 (PST)
Date:   Tue, 18 Dec 2018 17:17:30 +0800
From:   leo.yan@linaro.org
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/19] mailbox: hi6220: Use device-managed
 registration API
Message-ID: <20181218091730.GC1475@leoy-ThinkPad-X240s>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-8-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217150217.32435-8-thierry.reding@gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:02:05PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mailbox/hi6220-mailbox.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
> index 4fa9803cd204..c32cbfaf223a 100644
> --- a/drivers/mailbox/hi6220-mailbox.c
> +++ b/drivers/mailbox/hi6220-mailbox.c
> @@ -349,7 +349,7 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
>  		mbox->controller.txpoll_period = 5;
>  	}
>  
> -	err = mbox_controller_register(&mbox->controller);
> +	err = devm_mbox_controller_register(dev, &mbox->controller);
>  	if (err) {
>  		dev_err(dev, "Failed to register mailbox %d\n", err);
>  		return err;
> @@ -360,14 +360,6 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int hi6220_mbox_remove(struct platform_device *pdev)
> -{
> -	struct hi6220_mbox *mbox = platform_get_drvdata(pdev);
> -
> -	mbox_controller_unregister(&mbox->controller);
> -	return 0;
> -}
> -
>  static struct platform_driver hi6220_mbox_driver = {
>  	.driver = {
>  		.name = "hi6220-mbox",
> @@ -375,7 +367,6 @@ static struct platform_driver hi6220_mbox_driver = {
>  		.of_match_table = hi6220_mbox_of_match,
>  	},
>  	.probe	= hi6220_mbox_probe,
> -	.remove	= hi6220_mbox_remove,
>  };
>  
>  static int __init hi6220_mbox_init(void)
> -- 
> 2.19.1
> 
