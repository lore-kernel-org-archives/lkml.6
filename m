Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4D1C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D032081D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GJ2HdwEI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hccufbbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D032081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725759AbeLBCYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:24:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeLBCYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:24:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7165160A9B; Sun,  2 Dec 2018 02:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543717482;
        bh=k15vZyvNADly0cPqm+XJLMvhlWerI7txNOIFSaVZfck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GJ2HdwEIT9N+DxWKI8nXg5jb3roRh+AfW2gokDohJGR+8/hZsg0RlhEKcLoEKTtVf
         kQDnZRnmQ6A/1HbK7P85gR55u6mqIGz5IhAvacoRYFnrCDnarnikKXIeAqImn/ugWl
         gbzDHll/Ur7qju+PBBom6iM3N/v3oDYLGw9YgPLo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C661E60350;
        Sun,  2 Dec 2018 02:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543717481;
        bh=k15vZyvNADly0cPqm+XJLMvhlWerI7txNOIFSaVZfck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HccufbbrubefAwnkGyHVxuv+ctluLG83YHBrfyS8idrw7GWXgeKCX+8HKDLVtRx0g
         yGfJTN5nOzJJmLY2u9AsNMiLpsoyu3JMXEnyKPzgFglxVKxdQuxgPEPVi0D4jM6t7i
         jwxhlrBmnPFT/oUtxBX3qd554ZoRi7mwkbKgka04=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 01 Dec 2018 18:24:41 -0800
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, chandanu@codeaurora.org,
        nganji@codeaurora.org
Subject: =?UTF-8?Q?Re=3A_=5BPatch_v3=C2=A0=5D_drm/msm/dpu=3A_Correct_dpu_?=
 =?UTF-8?Q?destroy_and_disable_order?=
In-Reply-To: <1542608738-3315-1-git-send-email-jshekhar@codeaurora.org>
References: <1542608738-3315-1-git-send-email-jshekhar@codeaurora.org>
Message-ID: <2b15d68ebafebe0c7f40bcb09b3d1ba6@codeaurora.org>
X-Sender: jsanka@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-18 22:25, Jayant Shekhar wrote:
> In case of msm drm bind failure, pm runtime put sync
> is called from dsi driver which issues an asynchronous
> put on mdss device. Subsequently when dpu_mdss_destroy
> is triggered the change will make sure to put the mdss
> device in suspend and clearing pending work if not
> scheduled.
> 
> Changes in v2:
>    - Removed double spacings [Jeykumar]
> 
> Changes in v3:
>    - Fix clock on issue during bootup [Rajendra]
> 
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
> ---

Acked-by: Jeykumar Sankaran <jsanka@codeaurora.org>

>  drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> index fd9c893..df8127b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> @@ -156,18 +156,16 @@ static void dpu_mdss_destroy(struct drm_device 
> *dev)
>  	struct dpu_mdss *dpu_mdss = to_dpu_mdss(priv->mdss);
>  	struct dss_module_power *mp = &dpu_mdss->mp;
> 
> +	pm_runtime_suspend(dev->dev);
> +	pm_runtime_disable(dev->dev);
>  	_dpu_mdss_irq_domain_fini(dpu_mdss);
> -
>  	free_irq(platform_get_irq(pdev, 0), dpu_mdss);
> -
>  	msm_dss_put_clk(mp->clk_config, mp->num_clk);
>  	devm_kfree(&pdev->dev, mp->clk_config);
> 
>  	if (dpu_mdss->mmio)
>  		devm_iounmap(&pdev->dev, dpu_mdss->mmio);
>  	dpu_mdss->mmio = NULL;
> -
> -	pm_runtime_disable(dev->dev);
>  	priv->mdss = NULL;
>  }

-- 
Jeykumar S
