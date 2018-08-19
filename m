Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4AAC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 10:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDA721523
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 10:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rwU7r0xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDA721523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeHSN7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 09:59:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45208 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeHSN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 09:59:34 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 653ACCE;
        Sun, 19 Aug 2018 12:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534675710;
        bh=fnY801T83chIWIC35UZ7IteSKn4TJm7xHFL+ICenTCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwU7r0xeFLbQCkPUQ+pco6yFA0MdhBjZ16oLU1lK3DCr+cHyRz04xzvzMBAqPXXcK
         4gh8zxGs8/flXdARYsSIWikDZbMCCSF9KgoyoEBDdoGTA3uxCMat8ta59hs5uPLKKk
         iSg2v1MJMVEZ9/3lpA0RN1RfkzVnyigDfsg6cd4k=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     tomi.valkeinen@ti.com, airlied@linux.ie, sre@kernel.org,
        afd@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: Use ERR_CAST to replace ERR_PTR(PTR_ERR())
Date:   Sun, 19 Aug 2018 13:49:24 +0300
Message-ID: <1568006.WDkDHT9mlz@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1534589832-65325-1-git-send-email-zhongjiang@huawei.com>
References: <1534589832-65325-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhong Jiang,

Thank you for the patch.

On Saturday, 18 August 2018 13:57:12 EEST zhong jiang wrote:
> We prefer to ERR_CAST rather than ERR_PTR(PTR_ERR()), So just
> replace it.
> 
> The issue is detected with the help of Coccinelle
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/omapdrm/dss/dss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c
> b/drivers/gpu/drm/omapdrm/dss/dss.c index cb80dda..1fc46b2 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dss.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dss.c
> @@ -956,7 +956,7 @@ struct dss_debugfs_entry *
>  				&dss_debug_fops);
>  	if (IS_ERR(d)) {
>  		kfree(entry);
> -		return ERR_PTR(PTR_ERR(d));
> +		return ERR_CAST(d);
>  	}
> 
>  	entry->dentry = d;

-- 
Regards,

Laurent Pinchart



