Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E78ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D966720C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zVL34hOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D966720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeIXOuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:50:32 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56412 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeIXOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:50:32 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8O8mpLi082537;
        Mon, 24 Sep 2018 03:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537778931;
        bh=OZyLBK6lo22H+xZoWKXnRwbI7vP0pBcVRVv4FeSlXEI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zVL34hOklXjHaQssZbhLRs9zsGu2O9YyGPFkL6xET4+OrD/Uiry1geDf+ms5aQmvj
         qcpvjphuttvuYjsZZsd1Z6oyBa1wZHt1C/39obTx6EnI2Pk1DMq5MGGfMQUoDJaFM2
         FUiW4OHtdiCshXytlZLLEuRB8PUy1Noxti4l7jQw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8O8mphG017182;
        Mon, 24 Sep 2018 03:48:51 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 24
 Sep 2018 03:48:51 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 24 Sep 2018 03:48:51 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8O8mlfA007037;
        Mon, 24 Sep 2018 03:48:47 -0500
Subject: Re: [PATCH 02/10] phy: Add configuration interface
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
 <1ed01c1f-76d5-fa96-572b-9bfd269ad11b@ti.com>
 <20180906145622.kwxvkcuerbeqsj6b@flea>
 <1a169fad-72b7-fac0-1254-cac5d8304740@ti.com>
 <20180912084242.skxbwbgluakakyg6@flea>
 <e0d7db11-7ec1-cb98-4e62-12d78d1ba65b@ti.com>
 <20180919121436.ztjnxofe66quddeq@flea>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <93088385-126b-6bfb-70e4-16f7b949d299@ti.com>
Date:   Mon, 24 Sep 2018 14:18:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919121436.ztjnxofe66quddeq@flea>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wednesday 19 September 2018 05:44 PM, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Sep 14, 2018 at 02:18:37PM +0530, Kishon Vijay Abraham I wrote:
>>>>>>> +/**
>>>>>>> + * phy_validate() - Checks the phy parameters
>>>>>>> + * @phy: the phy returned by phy_get()
>>>>>>> + * @mode: phy_mode the configuration is applicable to.
>>>>>>> + * @opts: Configuration to check
>>>>>>> + *
>>>>>>> + * Used to check that the current set of parameters can be handled by
>>>>>>> + * the phy. Implementations are free to tune the parameters passed as
>>>>>>> + * arguments if needed by some implementation detail or
>>>>>>> + * constraints. It will not change any actual configuration of the
>>>>>>> + * PHY, so calling it as many times as deemed fit will have no side
>>>>>>> + * effect.
>>>>>>> + *
>>>>>>> + * Returns: 0 if successful, an negative error code otherwise
>>>>>>> + */
>>>>>>> +int phy_validate(struct phy *phy, enum phy_mode mode,
>>>>>>> +		  union phy_configure_opts *opts)
>>>>>>
>>>>>> IIUC the consumer driver will pass configuration options (or PHY parameters)
>>>>>> which will be validated by the PHY driver and in some cases the PHY driver can
>>>>>> modify the configuration options? And these modified configuration options will
>>>>>> again be given to phy_configure?
>>>>>>
>>>>>> Looks like it's a round about way of doing the same thing.
>>>>>
>>>>> Not really. The validate callback allows to check whether a particular
>>>>> configuration would work, and try to negotiate a set of configurations
>>>>> that both the consumer and the PHY could work with.
>>>>
>>>> Maybe the PHY should provide the list of supported features to the consumer
>>>> driver and the consumer should select a supported feature?
>>>
>>> It's not really about the features it supports, but the boundaries it
>>> might have on those features. For example, the same phy integrated in
>>> two different SoCs will probably have some limit on the clock rate it
>>> can output because of the phy design itself, but also because of the
>>> clock that is fed into that phy, and that will be different from one
>>> SoC to the other.
>>>
>>> This integration will prevent us to use some clock rates on the first
>>> SoC, while the second one would be totally fine with it.
>>
>> If there's a clock that is fed to the PHY from the consumer, then the consumer
>> driver should model a clock provider and the PHY can get a reference to it
>> using clk_get(). Rockchip and Arasan eMMC PHYs has already used something like
>> that.
> 
> That would be doable, but no current driver has had this in their
> binding. So that would prevent any further rework, and make that whole
> series moot. And while I could live without the Allwinner part, the
> Cadence one is really needed.

We could add a binding and modify the driver to to register a clock provider.
That could be included in this series itself.
> 
>> Assuming the PHY can get a reference to the clock provided by the consumer,
>> what are the parameters we'll be able to get rid of in struct
>> phy_configure_opts_mipi_dphy?
> 
> hs_clock_rate and lp_clock_rate. All the other ones are needed.

For a start we could use that and get rid of hs_clock_rate and lp_clock_rate in
phy_configure_opts_mipi_dphy.

We could also use phy_set_bus_width() for lanes.
> 
>> I'm sorry but I'm not convinced a consumer driver should have all the details
>> that are added in phy_configure_opts_mipi_dphy.
> 
> If it can convince you, here is the parameters that are needed by all
> the MIPI-DSI drivers currently in Linux to configure their PHY:
> 
>   - cdns-dsi (drivers/gpu/drm/bridge/cdns-dsi.c)
>     - hs_clk_rate
>     - lanes
>     - videomode
> 
>   - kirin (drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c)
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lpx
>     - ta_get
>     - ta_go
>     - wakeup
> 
>   - msm (drivers/gpu/drm/msm/dsi/*)
>     - clk_post
>     - clk_pre
>     - clk_prepare
>     - clk_trail
>     - clk_zero
>     - hs_clk_rate
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lp_clk_rate
>     - ta_get
>     - ta_go
>     - ta_sure
> 
>   - mtk (drivers/gpu/drm/mediatek/mtk_dsi.c)
>     - hs_clk_rate
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lpx
> 
>   - sun4i (drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c)
>     - clk_post
>     - clk_pre
>     - clk_prepare
>     - clk_zero
>     - hs_prepare
>     - hs_trail
>     - lanes
>     - lp_clk_rate
> 
>   - tegra (drivers/gpu/drm/tegra/dsi.c)
>     - clk_post
>     - clk_pre
>     - clk_prepare
>     - clk_trail
>     - clk_zero
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lpx
>     - ta_get
>     - ta_go
>     - ta_sure
> 
>   - vc4 (drivers/gpu/drm/vc4/vc4_dsi.c)
>     - hs_clk_rate
>     - lanes
> 
> Now, for MIPI-CSI receivers:
> 
>   - marvell-ccic (drivers/media/platform/marvell-ccic/mcam-core.c)
>     - clk_term_en
>     - clk_settle
>     - d_term_en
>     - hs_settle
>     - lp_clk_rate
> 
>   - omap4iss (drivers/staging/media/omap4iss/iss_csiphy.c)
>     - clk_miss
>     - clk_settle
>     - clk_term
>     - hs_settle
>     - hs_term
>     - lanes
> 
>   - rcar-vin (drivers/media/platform/rcar-vin/rcar-csi2.c)
>     - hs_clk_rate
>     - lanes
> 
>   - ti-vpe (drivers/media/platform/ti-vpe/cal.c)
>     - clk_term_en
>     - d_term_en
>     - hs_settle
>     - hs_term

Thank you for providing the exhaustive list.
> 
> So the timings expressed in the structure are the set of all the ones
> currently used in the tree by DSI and CSI drivers. I would consider
> that a good proof that it would be useful.

The problem I see here is each platform (PHY) will have it's own set of
parameters and we have to keep adding members to phy_configure_opts which is
not scalable. We should try to find a correlation between generic PHY modes and
these parameters (at-least for a subset).

Thanks
Kishon
