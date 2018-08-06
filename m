Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C3CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9A4214FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JjxaPyr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9A4214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbeHGBL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:11:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47386 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbeHGBL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:11:26 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D64157;
        Tue,  7 Aug 2018 01:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533596407;
        bh=lMAO5PsykGXiW9/JHmop+nOm4kY6gvjAABaf72ci5PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjxaPyr5T39YiTwTwGz60rn40rTCD2tlUFxn8sO9WrRuwNF0jGKS39hlyTnZ4Pz2Q
         C730CfAlcC40D5423aqA/bnlonf15qTGDxi1kn+WmvMfDSjQNuvP6xKY7I7TZshgt/
         A9no4N2h9IOEPuYXam3rO2qTeXLrl9pz8MWjUukI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [media] uvcvideo: fix spelling mistake: "entites" -> "entities"
Date:   Tue, 07 Aug 2018 02:00:51 +0300
Message-ID: <8293370.T3EEA9t51a@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20170703093151.11285-1-colin.king@canonical.com>
References: <20170703093151.11285-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thank you for the patch.

On Monday, 3 July 2017 12:31:51 EEST Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in uvc_printk message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c
> b/drivers/media/usb/uvc/uvc_driver.c index 70842c5af05b..9901025c4605
> 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1995,7 +1995,7 @@ static int uvc_register_chains(struct uvc_device *dev)
> #ifdef CONFIG_MEDIA_CONTROLLER
>  		ret = uvc_mc_register_entities(chain);
>  		if (ret < 0) {
> -			uvc_printk(KERN_INFO, "Failed to register entites "
> +			uvc_printk(KERN_INFO, "Failed to register entities "
>  				"(%d).\n", ret);
>  		}

While at it, let's remove the string wrapping, and the unneeded curly braces.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree with that change.

>  #endif


-- 
Regards,

Laurent Pinchart



