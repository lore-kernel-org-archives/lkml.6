Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E268FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A438820844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wkOb/1HP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfBEMzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:55:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45818 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBEMzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:55:49 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x15CtjZ6115239;
        Tue, 5 Feb 2019 06:55:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549371345;
        bh=hS0THwAYe/mQRHkMP4CjM/jNFVcG5NRuO2iVML/f/ZE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wkOb/1HP9B0qW83jIz6+vEIfaOn6mO3ZS8RGIl+aI/IgnFV19cHHiKFHeJQWnVg4U
         sal+e+h196znNRuxY+8j1Jo5RLD4R/K8xgqv11j6wWypirQ0f4UD7eBOJD60mSVQvr
         2SMre3ZGsO6w0vduiRclDfyaRxx5FAbjc3T3N6js=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x15Ctjw9017636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 06:55:45 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 06:55:45 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 06:55:45 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x15CtfXi009019;
        Tue, 5 Feb 2019 06:55:42 -0600
Subject: Re: [PATCH 4/5] phy: tegra: xusb: Add support for power supplies
To:     Thierry Reding <thierry.reding@gmail.com>, jckuo <jckuo@nvidia.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
 <20190125112525.10697-4-thierry.reding@gmail.com>
 <786247a4-81d1-9c2e-21b5-258dc818ccb9@nvidia.com>
 <20190128080054.GB18124@ulmo>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7838bb0d-af30-e2dc-8bfd-e1256590f9d3@ti.com>
Date:   Tue, 5 Feb 2019 18:25:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128080054.GB18124@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/01/19 1:30 PM, Thierry Reding wrote:
> On Mon, Jan 28, 2019 at 03:22:09PM +0800, jckuo wrote:
>> Hi Thierry,
>>
>> I think any non-zero return value of
>> regulator_bulk_enable()/devm_regulator_bulk_get() means error.
>>
>> Thanks,
>>
>> JC
> 
> Theoretically I think only regulator_bulk_enable() could return a
> positive value, but even so it never will in practice because all of the
> regulator_enable() (see _regulator_enable()) calls will only ever return
> negative error codes.
> 
> I can change this and resend if you have strong concerns about this
> possibly missing legitimate error cases.

All error codes are negative, so this is fine IMO.

Thanks
Kishon
> 
> Thierry
> 
>> On 1/25/19 7:25 PM, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> Support enabling various supplies needed to provide power to the PLLs
>>> and logic used to drive the USB, PCI and SATA pads.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>   drivers/phy/tegra/xusb.c | 34 +++++++++++++++++++++++++++++++++-
>>>   drivers/phy/tegra/xusb.h |  5 +++++
>>>   2 files changed, 38 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>>> index 57a2d08ef6da..e510629f4f1c 100644
>>> --- a/drivers/phy/tegra/xusb.c
>>> +++ b/drivers/phy/tegra/xusb.c
>>> @@ -864,6 +864,7 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
>>>   	struct tegra_xusb_padctl *padctl;
>>>   	const struct of_device_id *match;
>>>   	struct resource *res;
>>> +	unsigned int i;
>>>   	int err;
>>>   	/* for backwards compatibility with old device trees */
>>> @@ -901,14 +902,38 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
>>>   		goto remove;
>>>   	}
>>> +	padctl->supplies = devm_kcalloc(&pdev->dev, padctl->soc->num_supplies,
>>> +					sizeof(*padctl->supplies), GFP_KERNEL);
>>> +	if (!padctl->supplies) {
>>> +		err = -ENOMEM;
>>> +		goto remove;
>>> +	}
>>> +
>>> +	for (i = 0; i < padctl->soc->num_supplies; i++)
>>> +		padctl->supplies[i].supply = padctl->soc->supply_names[i];
>>> +
>>> +	err = devm_regulator_bulk_get(&pdev->dev, padctl->soc->num_supplies,
>>> +				      padctl->supplies);
>>> +	if (err < 0) {
>>> +		dev_err(&pdev->dev, "failed to get regulators: %d\n", err);
>>> +		goto remove;
>>> +	}
>>> +
>>>   	err = reset_control_deassert(padctl->rst);
>>>   	if (err < 0)
>>>   		goto remove;
>>> +	err = regulator_bulk_enable(padctl->soc->num_supplies,
>>> +				    padctl->supplies);
>>> +	if (err < 0) {
>>> +		dev_err(&pdev->dev, "failed to enable supplies: %d\n", err);
>>> +		goto reset;
>>> +	}
>>> +
>>>   	err = tegra_xusb_setup_pads(padctl);
>>>   	if (err < 0) {
>>>   		dev_err(&pdev->dev, "failed to setup pads: %d\n", err);
>>> -		goto reset;
>>> +		goto power_down;
>>>   	}
>>>   	err = tegra_xusb_setup_ports(padctl);
>>> @@ -921,6 +946,8 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
>>>   remove_pads:
>>>   	tegra_xusb_remove_pads(padctl);
>>> +power_down:
>>> +	regulator_bulk_disable(padctl->soc->num_supplies, padctl->supplies);
>>>   reset:
>>>   	reset_control_assert(padctl->rst);
>>>   remove:
>>> @@ -936,6 +963,11 @@ static int tegra_xusb_padctl_remove(struct platform_device *pdev)
>>>   	tegra_xusb_remove_ports(padctl);
>>>   	tegra_xusb_remove_pads(padctl);
>>> +	err = regulator_bulk_disable(padctl->soc->num_supplies,
>>> +				     padctl->supplies);
>>> +	if (err < 0)
>>> +		dev_err(&pdev->dev, "failed to disable supplies: %d\n", err);
>>> +
>>>   	err = reset_control_assert(padctl->rst);
>>>   	if (err < 0)
>>>   		dev_err(&pdev->dev, "failed to assert reset: %d\n", err);
>>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>>> index bb60fc09c752..5d5d22f6cb41 100644
>>> --- a/drivers/phy/tegra/xusb.h
>>> +++ b/drivers/phy/tegra/xusb.h
>>> @@ -370,6 +370,9 @@ struct tegra_xusb_padctl_soc {
>>>   	} ports;
>>>   	const struct tegra_xusb_padctl_ops *ops;
>>> +
>>> +	const char * const *supply_names;
>>> +	unsigned int num_supplies;
>>>   };
>>>   struct tegra_xusb_padctl {
>>> @@ -393,6 +396,8 @@ struct tegra_xusb_padctl {
>>>   	unsigned int enable;
>>>   	struct clk *clk;
>>> +
>>> +	struct regulator_bulk_data *supplies;
>>>   };
>>>   static inline void padctl_writel(struct tegra_xusb_padctl *padctl, u32 value,
