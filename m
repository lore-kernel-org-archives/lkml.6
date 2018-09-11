Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A03C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08B620880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="os9iVLKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08B620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeILCU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:20:58 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46432 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeILCU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:20:58 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7721A992;
        Tue, 11 Sep 2018 23:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536700786;
        bh=g7HymV+duBi27pLSItGQXOOdK89tbB5iq+hhrnffhvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=os9iVLKU4n+POaEXv6zXqOygVAnyYwMAd3eT74IoYdn1NG8LHJOAMj2FhHn7mr0AP
         mbkHdw8dwX+PgRzh5FzVwplJ/JqkQMhKPG+uO87JCmG2ndmYuO6XcCuxtphe9KJ3HX
         EuJxIdkYaUITmRq9Fz04yy6CGLghBIPf8Q2qCSd0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     airlied@linux.ie, tomi.valkeinen@ti.com, sre@kernel.org,
        afd@ti.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/omap: Use ERR_CAST directly instead of RR_PTR(PTR_ERR())
Date:   Wed, 12 Sep 2018 00:19:58 +0300
Message-ID: <2081575.ibfeOaj4ye@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1536666875-11252-1-git-send-email-zhongjiang@huawei.com>
References: <1536666875-11252-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhong Jiang,

Thank you for the patch.

On Tuesday, 11 September 2018 14:54:35 EEST zhong jiang wrote:
> We prefer to use ERR_CAST to do so.
> The issue is detected with the help of Coccinelle.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I expect Tomi to take this patch in his tree, but I also applied it to mine to 
make sure it won't be forgotten.

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



