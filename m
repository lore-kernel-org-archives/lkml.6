Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633CFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A9120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T5t57aFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A9120853
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeINODu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:03:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55476 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeINODt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:03:49 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8E8mppK083641;
        Fri, 14 Sep 2018 03:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536914931;
        bh=nE9hYNM4zS7gs0Maoj1Z5X00bxHm5fLJD3F62ueB/Kw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T5t57aFy2A+bMknAlcXm0qPcOmJr2fymFNNMMlkxPSUwv9lawHmLSSvnqFM2eadBf
         23uPfrCofRFrfqbMgVmM+Gnf0p5C59aU6a25gB4LK0R0DyjG7Wf80wTVCAzUJXyvIg
         jjK80YiEj8vksGspWMFtMDMUTloN/4TbcDDN0gb4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8E8mpMV022736;
        Fri, 14 Sep 2018 03:48:51 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 14
 Sep 2018 03:48:51 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 14 Sep 2018 03:48:51 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8E8ml6d009801;
        Fri, 14 Sep 2018 03:48:47 -0500
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
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e0d7db11-7ec1-cb98-4e62-12d78d1ba65b@ti.com>
Date:   Fri, 14 Sep 2018 14:18:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912084242.skxbwbgluakakyg6@flea>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wednesday 12 September 2018 02:12 PM, Maxime Ripard wrote:
> Hi!
> 
> On Wed, Sep 12, 2018 at 01:12:31PM +0530, Kishon Vijay Abraham I wrote:
>> On Thursday 06 September 2018 08:26 PM, Maxime Ripard wrote:
>>> Hi Kishon,
>>>
>>> On Thu, Sep 06, 2018 at 02:57:58PM +0530, Kishon Vijay Abraham I wrote:
>>>> On Wednesday 05 September 2018 02:46 PM, Maxime Ripard wrote:
>>>>> The phy framework is only allowing to configure the power state of the PHY
>>>>> using the init and power_on hooks, and their power_off and exit
>>>>> counterparts.
>>>>>
>>>>> While it works for most, simple, PHYs supported so far, some more advanced
>>>>> PHYs need some configuration depending on runtime parameters. These PHYs
>>>>> have been supported by a number of means already, often by using ad-hoc
>>>>> drivers in their consumer drivers.
>>>>>
>>>>> That doesn't work too well however, when a consumer device needs to deal
>>>>> multiple PHYs, or when multiple consumers need to deal with the same PHY (a
>>>>> DSI driver and a CSI driver for example).
>>>>>
>>>>> So we'll add a new interface, through two funtions, phy_validate and
>>>>> phy_configure. The first one will allow to check that a current
>>>>> configuration, for a given mode, is applicable. It will also allow the PHY
>>>>> driver to tune the settings given as parameters as it sees fit.
>>>>>
>>>>> phy_configure will actually apply that configuration in the phy itself.
>>>>>
>>>>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>>>> ---
>>>>>  drivers/phy/phy-core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++-
>>>>>  include/linux/phy/phy.h | 42 ++++++++++++++++++++++++++++-
>>>>>  2 files changed, 104 insertions(+)
>>>>>
>>>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>>>> index 35fd38c5a4a1..6eaf655e370f 100644
>>>>> --- a/drivers/phy/phy-core.c
>>>>> +++ b/drivers/phy/phy-core.c
>>>>> @@ -408,6 +408,68 @@ int phy_calibrate(struct phy *phy)
>>>>>  EXPORT_SYMBOL_GPL(phy_calibrate);
>>>>>  
>>>>>  /**
>>>>> + * phy_configure() - Changes the phy parameters
>>>>> + * @phy: the phy returned by phy_get()
>>>>> + * @mode: phy_mode the configuration is applicable to.
>>>>
>>>> mode should be used if the same PHY can be configured in multiple modes. But
>>>> with phy_set_mode() and phy_calibrate() we could achieve the same.
>>>
>>> So you would change the prototype to have a configuration applying
>>> only to the current mode set previously through set_mode?
>>
>> yeah.
>> With phy_configure, if the PHY is not in @mode, it should return an error? Or
>> will it set the PHY to @mode and apply the configuration in @opts?
> 
> I wanted to have it return an error either if it was configured in
> another mode or if the mode was unsupported yes.
> 
>>> Can we have PHY that operate in multiple modes at the same time?
>>
>> Not at the same time. But the same PHY can operate in multiple modes (For
>> example we have PHYs that can be used either with PCIe or USB3)
> 
> Ok, that makes sense. I guess we could rely on phy_set_mode then if
> you prefer.
> 
>>>>> + * @opts: New configuration to apply
>>>>
>>>> Should these configuration come from the consumer driver?
>>>
>>> Yes
>>
>> How does the consumer driver get these configurations? Is it from user space or
>> dt associated with consumer device.
> 
> It really depends on multiple factors (and I guess on what mode the
> PHY is actually supposed to support), but in the case covered by this
> serie, the info mostly come from multiple places:
>   - The resolutions supported by the panel
>   - The resolutions supported by the phy consumer (and its
>     integration, for things like the clock rates it can output)
>   - The resolutions and timings supported by the phy itself (once
>     again, the integration is mostly involved here since it really
>     only depends on which clock rates can be achieved)
>   - The timings boundaries that the specification has
>   - The resolution selected by the user
> 
> So we'd have that information coming from multiple places: the
> userspace would select the resolution, drivers would be able to filter
> out unsupported resolutions, and the DT will provide the integration
> details to help them do so.
> 
> But I guess from an API standpoint, it really is expected to be
> assembled by the phy consumer driver.
> 
>>>>> +/**
>>>>> + * phy_validate() - Checks the phy parameters
>>>>> + * @phy: the phy returned by phy_get()
>>>>> + * @mode: phy_mode the configuration is applicable to.
>>>>> + * @opts: Configuration to check
>>>>> + *
>>>>> + * Used to check that the current set of parameters can be handled by
>>>>> + * the phy. Implementations are free to tune the parameters passed as
>>>>> + * arguments if needed by some implementation detail or
>>>>> + * constraints. It will not change any actual configuration of the
>>>>> + * PHY, so calling it as many times as deemed fit will have no side
>>>>> + * effect.
>>>>> + *
>>>>> + * Returns: 0 if successful, an negative error code otherwise
>>>>> + */
>>>>> +int phy_validate(struct phy *phy, enum phy_mode mode,
>>>>> +		  union phy_configure_opts *opts)
>>>>
>>>> IIUC the consumer driver will pass configuration options (or PHY parameters)
>>>> which will be validated by the PHY driver and in some cases the PHY driver can
>>>> modify the configuration options? And these modified configuration options will
>>>> again be given to phy_configure?
>>>>
>>>> Looks like it's a round about way of doing the same thing.
>>>
>>> Not really. The validate callback allows to check whether a particular
>>> configuration would work, and try to negotiate a set of configurations
>>> that both the consumer and the PHY could work with.
>>
>> Maybe the PHY should provide the list of supported features to the consumer
>> driver and the consumer should select a supported feature?
> 
> It's not really about the features it supports, but the boundaries it
> might have on those features. For example, the same phy integrated in
> two different SoCs will probably have some limit on the clock rate it
> can output because of the phy design itself, but also because of the
> clock that is fed into that phy, and that will be different from one
> SoC to the other.
> 
> This integration will prevent us to use some clock rates on the first
> SoC, while the second one would be totally fine with it.

If there's a clock that is fed to the PHY from the consumer, then the consumer
driver should model a clock provider and the PHY can get a reference to it
using clk_get(). Rockchip and Arasan eMMC PHYs has already used something like
that.

Assuming the PHY can get a reference to the clock provided by the consumer,
what are the parameters we'll be able to get rid of in struct
phy_configure_opts_mipi_dphy?

I'm sorry but I'm not convinced a consumer driver should have all the details
that are added in phy_configure_opts_mipi_dphy.
> 
> Obviously, the consumer driver shouldn't care about the phy
> integration details, especially since some of those consumer drivers
> need to interact with multiple phy designs (or the same phy design can
> be used by multiple consumers).
> 
> So knowing that a feature is supported is really not enough.
> 
> With MIPI-DPHY at least, the API is generic enough so that another
> mode where the features would make sense could implement a feature
> flag if that makes sense.
> 
>>> For example, DRM requires this to filter out display modes (ie,
>>> resolutions) that wouldn't be achievable by the PHY so that it's never
>>
>> Can't the consumer driver just tell the required resolution to the PHY and PHY
>> figuring out all the parameters for the resolution or an error if that
>> resolution cannot be supported?
> 
> Not really either. With MIPI D-PHY, the phy is fed a clock that is
> generated by the phy consumer, which might or might not be an exact
> fit for the resolution. There's so many resolutions that in most case,
> the clock factors don't allow you to have a perfect match. And
> obviously, this imprecision should be taken into account by the PHY as
> well.
> 
> And then, there's also the matter than due to design constraints, some
> consumers would have fixed timings that are not at the spec default
> value, but still within the acceptable range. We need to communicate
> that to the PHY.

Here do you mean videomode timings?

Thanks
Kishon
