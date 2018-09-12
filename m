Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C2BC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D54620880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xV5wIItD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D54620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeILMqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:46:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47376 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeILMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:46:45 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8C7gjEn112425;
        Wed, 12 Sep 2018 02:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536738165;
        bh=gTYKEmnDkqiWAMclxDE6LUtyKQAX8BXds4eA3w4T5+o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xV5wIItDCl5PMZ5epbb22tHiT4unI5mcd21krwV98s1NZkNT8DJu8B6WKTwrW/PSu
         wPYTITxAtuzD1tzC/EAevWmiiWnFNT0jEN8LAEdL8uTSv7a0JDJLIQcjBBawbMcjFZ
         C2L3ziR9LLF0NfpawtJjnD5I2Jmiod6CTC9ciqsY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8C7gjdZ019160;
        Wed, 12 Sep 2018 02:42:45 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 12
 Sep 2018 02:42:44 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 12 Sep 2018 02:42:44 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8C7ge3I012410;
        Wed, 12 Sep 2018 02:42:40 -0500
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
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1a169fad-72b7-fac0-1254-cac5d8304740@ti.com>
Date:   Wed, 12 Sep 2018 13:12:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906145622.kwxvkcuerbeqsj6b@flea>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 06 September 2018 08:26 PM, Maxime Ripard wrote:
> Hi Kishon,
> 
> On Thu, Sep 06, 2018 at 02:57:58PM +0530, Kishon Vijay Abraham I wrote:
>> On Wednesday 05 September 2018 02:46 PM, Maxime Ripard wrote:
>>> The phy framework is only allowing to configure the power state of the PHY
>>> using the init and power_on hooks, and their power_off and exit
>>> counterparts.
>>>
>>> While it works for most, simple, PHYs supported so far, some more advanced
>>> PHYs need some configuration depending on runtime parameters. These PHYs
>>> have been supported by a number of means already, often by using ad-hoc
>>> drivers in their consumer drivers.
>>>
>>> That doesn't work too well however, when a consumer device needs to deal
>>> multiple PHYs, or when multiple consumers need to deal with the same PHY (a
>>> DSI driver and a CSI driver for example).
>>>
>>> So we'll add a new interface, through two funtions, phy_validate and
>>> phy_configure. The first one will allow to check that a current
>>> configuration, for a given mode, is applicable. It will also allow the PHY
>>> driver to tune the settings given as parameters as it sees fit.
>>>
>>> phy_configure will actually apply that configuration in the phy itself.
>>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>> ---
>>>  drivers/phy/phy-core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++-
>>>  include/linux/phy/phy.h | 42 ++++++++++++++++++++++++++++-
>>>  2 files changed, 104 insertions(+)
>>>
>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>> index 35fd38c5a4a1..6eaf655e370f 100644
>>> --- a/drivers/phy/phy-core.c
>>> +++ b/drivers/phy/phy-core.c
>>> @@ -408,6 +408,68 @@ int phy_calibrate(struct phy *phy)
>>>  EXPORT_SYMBOL_GPL(phy_calibrate);
>>>  
>>>  /**
>>> + * phy_configure() - Changes the phy parameters
>>> + * @phy: the phy returned by phy_get()
>>> + * @mode: phy_mode the configuration is applicable to.
>>
>> mode should be used if the same PHY can be configured in multiple modes. But
>> with phy_set_mode() and phy_calibrate() we could achieve the same.
> 
> So you would change the prototype to have a configuration applying
> only to the current mode set previously through set_mode?

yeah.
With phy_configure, if the PHY is not in @mode, it should return an error? Or
will it set the PHY to @mode and apply the configuration in @opts?
> 
> Can we have PHY that operate in multiple modes at the same time?

Not at the same time. But the same PHY can operate in multiple modes (For
example we have PHYs that can be used either with PCIe or USB3)
> 
>>> + * @opts: New configuration to apply
>>
>> Should these configuration come from the consumer driver?
> 
> Yes

How does the consumer driver get these configurations? Is it from user space or
dt associated with consumer device.
> 
>> Can't the helper functions be directly invoked by the PHY driver for
>> the configuration.
> 
> Not really. The helpers are here to introduce functions that give you
> the defaults provided by the spec for a given configuration, and to
> validate that a given configuration is within the spec boundaries. I
> expect some consumers to need to change the defaults for some more
> suited parameters that are still within the boundaries defined by the
> spec.
> 
> And I'd really want to have that interface being quite generic, and
> applicable to other phy modes as well. The allwinner USB PHY for
> example require at the moment an extra function that could be moved to
> this API:
> https://elixir.bootlin.com/linux/latest/source/drivers/phy/allwinner/phy-sun4i-usb.c#L512
> 
>>> + *
>>> + * Used to change the PHY parameters. phy_init() must have
>>> + * been called on the phy.
>>> + *
>>> + * Returns: 0 if successful, an negative error code otherwise
>>> + */
>>> +int phy_configure(struct phy *phy, enum phy_mode mode,
>>> +		  union phy_configure_opts *opts)
>>> +{> +	int ret;
>>> +
>>> +	if (!phy)
>>> +		return -EINVAL;
>>> +
>>> +	if (!phy->ops->configure)
>>> +		return 0;
>>> +
>>> +	mutex_lock(&phy->mutex);
>>> +	ret = phy->ops->configure(phy, mode, opts);
>>> +	mutex_unlock(&phy->mutex);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +/**
>>> + * phy_validate() - Checks the phy parameters
>>> + * @phy: the phy returned by phy_get()
>>> + * @mode: phy_mode the configuration is applicable to.
>>> + * @opts: Configuration to check
>>> + *
>>> + * Used to check that the current set of parameters can be handled by
>>> + * the phy. Implementations are free to tune the parameters passed as
>>> + * arguments if needed by some implementation detail or
>>> + * constraints. It will not change any actual configuration of the
>>> + * PHY, so calling it as many times as deemed fit will have no side
>>> + * effect.
>>> + *
>>> + * Returns: 0 if successful, an negative error code otherwise
>>> + */
>>> +int phy_validate(struct phy *phy, enum phy_mode mode,
>>> +		  union phy_configure_opts *opts)
>>
>> IIUC the consumer driver will pass configuration options (or PHY parameters)
>> which will be validated by the PHY driver and in some cases the PHY driver can
>> modify the configuration options? And these modified configuration options will
>> again be given to phy_configure?
>>
>> Looks like it's a round about way of doing the same thing.
> 
> Not really. The validate callback allows to check whether a particular
> configuration would work, and try to negotiate a set of configurations
> that both the consumer and the PHY could work with.

Maybe the PHY should provide the list of supported features to the consumer
driver and the consumer should select a supported feature?

> 
> For example, DRM requires this to filter out display modes (ie,
> resolutions) that wouldn't be achievable by the PHY so that it's never

Can't the consumer driver just tell the required resolution to the PHY and PHY
figuring out all the parameters for the resolution or an error if that
resolution cannot be supported?

Thanks
Kishon
