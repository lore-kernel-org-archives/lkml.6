Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D40C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277E020684
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PZnlFPSJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PZnlFPSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277E020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeKSSzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:55:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeKSSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:55:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B20D360767; Mon, 19 Nov 2018 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542616330;
        bh=URtFBdyjHbtpoXUpQoCtBvRn7w04cFXmiPcdAGReB6E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PZnlFPSJpXP848i1xgl7AKAU8OMlFPARloyR6QtjtevUK3zGgbyTmGojL3TPnnvmC
         bd1Q6kG11xM+49ugEfpVO23vVv93QHTU93a91ywP2VYzn6ArMcz4sd3WF2wUMcJr+Z
         o+5bfXuyOj6jQ56/6hYMfCbEm3qgP4H422DvR5p4=
Received: from [10.79.128.20] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 066E560712;
        Mon, 19 Nov 2018 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542616330;
        bh=URtFBdyjHbtpoXUpQoCtBvRn7w04cFXmiPcdAGReB6E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PZnlFPSJpXP848i1xgl7AKAU8OMlFPARloyR6QtjtevUK3zGgbyTmGojL3TPnnvmC
         bd1Q6kG11xM+49ugEfpVO23vVv93QHTU93a91ywP2VYzn6ArMcz4sd3WF2wUMcJr+Z
         o+5bfXuyOj6jQ56/6hYMfCbEm3qgP4H422DvR5p4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 066E560712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: =?UTF-8?Q?Re=3a_=5bPatch_v3=c2=a0=5d_drm/msm/dpu=3a_Correct_dpu_des?=
 =?UTF-8?Q?troy_and_disable_order?=
To:     Jayant Shekhar <jshekhar@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
References: <1542608738-3315-1-git-send-email-jshekhar@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <9b31405e-a9dd-3571-a969-caf2c27dd792@codeaurora.org>
Date:   Mon, 19 Nov 2018 14:02:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542608738-3315-1-git-send-email-jshekhar@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/2018 11:55 AM, Jayant Shekhar wrote:
> In case of msm drm bind failure, pm runtime put sync
> is called from dsi driver which issues an asynchronous
> put on mdss device. Subsequently when dpu_mdss_destroy
> is triggered the change will make sure to put the mdss
> device in suspend and clearing pending work if not
> scheduled.
> 
> Changes in v2:
>     - Removed double spacings [Jeykumar]
> 
> Changes in v3:
>     - Fix clock on issue during bootup [Rajendra]
> 
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>

So I no longer see the clock usecount mismatch with this patch now,
that I had earlier reported with the v2.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> index fd9c893..df8127b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> @@ -156,18 +156,16 @@ static void dpu_mdss_destroy(struct drm_device *dev)
>   	struct dpu_mdss *dpu_mdss = to_dpu_mdss(priv->mdss);
>   	struct dss_module_power *mp = &dpu_mdss->mp;
>   
> +	pm_runtime_suspend(dev->dev);
> +	pm_runtime_disable(dev->dev);
>   	_dpu_mdss_irq_domain_fini(dpu_mdss);
> -
>   	free_irq(platform_get_irq(pdev, 0), dpu_mdss);
> -
>   	msm_dss_put_clk(mp->clk_config, mp->num_clk);
>   	devm_kfree(&pdev->dev, mp->clk_config);
>   
>   	if (dpu_mdss->mmio)
>   		devm_iounmap(&pdev->dev, dpu_mdss->mmio);
>   	dpu_mdss->mmio = NULL;
> -
> -	pm_runtime_disable(dev->dev);
>   	priv->mdss = NULL;
>   }
>   
> 
