Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEF6C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380F32170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="KGaPKjXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380F32170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbeHGU4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:56:44 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:40586 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeHGU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:56:44 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id A70375C0187;
        Tue,  7 Aug 2018 20:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533667262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATgwHit8dvXpxrNpY0WH3WwDDUUt61gFxaeVzbN0cs4=;
        b=KGaPKjXYGv01qN6U1ZUzIpytS7Z2OrxLgubyY6Lasru+HBEgtkvhYWNRKW7Egd++0Nq7oM
        8DjyKY9QCv8kKYG2U/20Nd3mGgSM/JrENhdobNjnDHzmTlrpwt2ECJtKcw473b2xgPiypl
        eez8MjaecxRhYBwuZCG2WZlffde8srk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Aug 2018 20:41:02 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] drm/mxsfb: Add PM_SLEEP support
In-Reply-To: <948022edecc7af494e8bb6f55bc4ddbc33c74e3c.1533583611.git.leonard.crestez@nxp.com>
References: <cover.1533583611.git.leonard.crestez@nxp.com>
 <948022edecc7af494e8bb6f55bc4ddbc33c74e3c.1533583611.git.leonard.crestez@nxp.com>
Message-ID: <9cb6d504595a642c2010bddc0d4f35ef@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.2018 21:31, Leonard Crestez wrote:
> Since power to the lcdif block can be lost on suspend implement
> PM_SLEEP_OPS using drm_mode_config_helper_suspend/resume to save/restore
> the current mode.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 68d79f5dc0d3..d797dfd40d98 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -416,17 +416,38 @@ static int mxsfb_remove(struct platform_device *pdev)
>  	drm_dev_unref(drm);
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mxsfb_suspend(struct device *dev)
> +{
> +       struct drm_device *drm = dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_suspend(drm);
> +}
> +
> +static int mxsfb_resume(struct device *dev)
> +{
> +       struct drm_device *drm = dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_resume(drm);
> +}
> +#endif
> +
> +static const struct dev_pm_ops mxsfb_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(mxsfb_suspend, mxsfb_resume)
> +};
> +
>  static struct platform_driver mxsfb_platform_driver = {
>  	.probe		= mxsfb_probe,
>  	.remove		= mxsfb_remove,
>  	.id_table	= mxsfb_devtype,
>  	.driver	= {
>  		.name		= "mxsfb",
>  		.of_match_table	= mxsfb_dt_ids,
> +		.pm		= &mxsfb_pm_ops,
>  	},
>  };
>  
>  module_platform_driver(mxsfb_platform_driver);
