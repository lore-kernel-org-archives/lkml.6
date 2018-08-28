Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A947AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5178D20897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5178D20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeH1QMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:12:03 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:38730 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeH1QMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:12:03 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.208])
        by regular1.263xmail.com (Postfix) with ESMTP id 4D3AD2AE;
        Tue, 28 Aug 2018 20:20:15 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [192.168.60.164] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id B404F3A3;
        Tue, 28 Aug 2018 20:20:11 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: sandy.huang@rock-chips.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <efea084ff8402b27aa0b3c9b97b091ff>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from [192.168.60.164] (unknown [103.29.142.67])
        by smtp.263.net (Postfix) whith ESMTP id 1694BEGV0Z;
        Tue, 28 Aug 2018 20:20:15 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
Subject: Re: [PATCH v5 2/2] drm/rockchip: Add support for Rockchip Soc RGB
 output interface
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh@kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1535443954-38806-1-git-send-email-hjc@rock-chips.com>
 <1535443954-38806-3-git-send-email-hjc@rock-chips.com>
 <2164089.bDJbLuhFGU@phil>
Message-ID: <c203e409-d2e4-e534-7855-27c3503a78b1@rock-chips.com>
Date:   Tue, 28 Aug 2018 20:20:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2164089.bDJbLuhFGU@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hieko,

在 2018/8/28 16:31, Heiko Stuebner 写道:
> Hi Sandy,
> 
> Am Dienstag, 28. August 2018, 10:12:34 CEST schrieb Sandy Huang:
>> Some Rockchip CRTCs, like rv1108 and px30, can directly output parallel
>> and serial RGB data to panel or conversion chip, so we add this driver
>> to probe encoder and connector.
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>> Reviewed-by: Mark Yao <mark.yao@rock-chips.com>
>> Link: https://patchwork.freedesktop.org/patch/msgid/1509522851-128181-1-git-send-email-hjc@rock-chips.com
> 
> This does not really address, Rob's concern about not being an actual
> hardware block related to the devicetree node you are using.
> 
> I see your reply to my mail, but I guess you didn't see the alternative
> approach I described a bit below in that mail?
> 
> Actual (unfinished) code included below. (2 patches)
> 
> Heiko
> 
> 
yes,i didn't see the behind described:(
As you said devicetree describes hardware blocks,
I think you implement driver for rgb output interface is more 
reasonable,  i will adjust this driver refer to your implementation, 
thanks:)


> 
> ---- 8< -----
> From: Heiko Stuebner <heiko@sntech.de>
> Date: Sat, 25 Aug 2018 19:05:21 +0200
> Subject: [PATCH 1/2] drm/tockchip: add function to check if endpoint is a
>   subdriver
> 
> To be able to have both internal subdrivers and external bridge
> drivers as output endpoints of vops, add a function to be able
> to distinguish these.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 27 +++++++++++++++++++++
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 1d9c4a9201c8..d18f7f85aa23 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -24,6 +24,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/module.h>
>   #include <linux/of_graph.h>
> +#include <linux/of_platform.h>
>   #include <linux/component.h>
>   #include <linux/console.h>
>   #include <linux/iommu.h>
> @@ -267,6 +268,32 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
>   static struct platform_driver *rockchip_sub_drivers[MAX_ROCKCHIP_SUB_DRIVERS];
>   static int num_rockchip_sub_drivers;
>   
> +/*
> + * check if a vop output-endpoint is a subdriver or bridge.
> + */
> +bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
> +{
> +	struct device_node *node = of_graph_get_remote_port_parent(ep);
> +	struct platform_device *pdev;
> +	int i;
> +
> +	if (!node)
> +		return false;
> +
> +	pdev = of_find_device_by_node(node);
> +	if (!pdev)
> +		return false;
> +
> +	for (i = 0; i < num_rockchip_sub_drivers; i++) {
> +		struct device_driver *drv = pdev->dev.driver;
> +
> +		if (rockchip_sub_drivers[i] == to_platform_driver(drv))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static int compare_dev(struct device *dev, void *data)
>   {
>   	return dev == (struct device *)data;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> index d67ad0a3cf36..305b4858c522 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> @@ -64,6 +64,7 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
>   				    struct device *dev);
>   int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
>   
> +bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
>   extern struct platform_driver cdn_dp_driver;
>   extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
>   extern struct platform_driver dw_mipi_dsi_driver;
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

