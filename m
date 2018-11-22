Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC857C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F8920663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zAV9wHoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F8920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393238AbeKVT02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:26:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51732 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeKVT02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:26:28 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAM8l66f017896;
        Thu, 22 Nov 2018 02:47:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542876426;
        bh=qV+3756y+SRkMlQtdQG4JGIAiysFzHpm6q7U3aM2JxY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zAV9wHoFkEtMiq5fGy7PzH+vvj9p9QixuR3QBz/h6wgIQC0D6iGcoRgdzEacyy2j5
         aaYrZniCCAGq1WirQpeT3Jzx0ee9oC8ACf8EmWiYSLWLI2NOoeUfc6lBEPalsJsCnF
         suRQwJ7Bi98iF5Gmr5Q9Yo6DmtvGq/ZZRg1qYM3k=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAM8l6kg058837
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 02:47:06 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 02:47:05 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 02:47:06 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAM8l1vi029675;
        Thu, 22 Nov 2018 02:47:02 -0600
Subject: Re: [PATCH v2 8/9] phy: Add Cadence D-PHY support
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
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
 <4ec9e47fb5aa9794f69a8e75a04108055094c056.1541516029.git-series.maxime.ripard@bootlin.com>
 <5f5bcc06-51b2-d565-56a0-083c66c1f01a@ti.com>
 <8536050b-40ab-1ec4-d325-e59bb3a92e73@ti.com>
 <20181121101121.7rhe2hz2mnmc72cu@flea>
 <20c0fd85-95f6-9849-c10b-998a1e0f527d@ti.com>
 <20181121134756.aoj6otdcl4stpd6p@flea>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <69c49e08-97d2-650e-d201-466835d45ccd@ti.com>
Date:   Thu, 22 Nov 2018 14:16:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121134756.aoj6otdcl4stpd6p@flea>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/11/18 7:17 PM, Maxime Ripard wrote:
> Hi Kishon,
> 
> On Wed, Nov 21, 2018 at 03:59:43PM +0530, Kishon Vijay Abraham I wrote:
>> On 21/11/18 3:41 PM, Maxime Ripard wrote:
>>> Hi Kishon,
>>>
>>> On Tue, Nov 20, 2018 at 11:02:34AM +0530, Kishon Vijay Abraham I wrote:
>>>>>> +static int cdns_dphy_config_from_opts(struct phy *phy,
>>>>>> +				      struct phy_configure_opts_mipi_dphy *opts,
>>>>>> +				      struct cdns_dphy_cfg *cfg)
>>>>>> +{
>>>>>> +	struct cdns_dphy *dphy = phy_get_drvdata(phy);
>>>>>> +	unsigned int dsi_hfp_ext = 0;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	ret = phy_mipi_dphy_config_validate(opts);
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	ret = cdns_dsi_get_dphy_pll_cfg(dphy, cfg,
>>>>>> +					opts, &dsi_hfp_ext);
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	opts->wakeup = cdns_dphy_get_wakeup_time_ns(dphy);
>>>>
>>>> Is the wakeup populated here used by the consumer driver?
>>>
>>> It's supposed to, if it can yes.
>>
>> But I guess right now it's not using. I'm thinking the usefulness of validate
>> callback (only from this series point of view). Why should a consumer driver
>> invoke validate if it doesn't intend to configure the PHY?
>>
>> The 3 steps required are
>> 	* The consumer driver gets the default config
>> 	* The consumer driver changes some of the configuration and
>> 	* The consumer driver invokes phy configure callback.
>>
>> phy_configure anyways can validate the config before actually configuring the phy.
> 
> If you only want to configure the PHY, then yes, sure.
> 
> However, the point here is that validate helps negotiating what the
> source device (DSI controller for example) and what the sink device
> (say a panel) are capable of.
> 
> A panel for example might very well have multiple resolutions that it
> supports, and the DSI controller will have some as well. And the PHY
> will only be able to operate within certain boundaries too. However,
> they don't necessarily match, since there's so many panels, and so
> many SoCs.
> 
> Let's say our (very weird) panel is able to do 640x480, 1024x768 and
> 1280x800. Our DSI driver can only operate with 1024 pixels in both
> dimensions, and the PHY can only reach the bus frequency needed for
> around 800x600.
> 
> We'll want to filter out 1280x800 (because the DSI controller can't
> provide that) and 1024x768 (because the PHY can go fast enough), to
> only provide the 640x480 option to the user.
> 
> That's what validate bring you. The option to test whether a given
> configuration *would* work, without actually wanting to apply it right
> now.
> 
> Does that make sense?

Thank you for the explanation. It's clear now.

Thanks
Kishon
