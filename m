Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BE2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02492175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KbN6i8F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfA2Guc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:50:32 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11438 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfA2Gub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:50:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4ff79a0001>; Mon, 28 Jan 2019 22:50:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 28 Jan 2019 22:50:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 28 Jan 2019 22:50:30 -0800
Received: from [10.19.108.140] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 06:50:28 +0000
Subject: Re: [PATCH 4/5] phy: tegra: xusb: Add support for power supplies
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
 <20190125112525.10697-4-thierry.reding@gmail.com>
 <786247a4-81d1-9c2e-21b5-258dc818ccb9@nvidia.com>
 <20190128080054.GB18124@ulmo>
From:   jckuo <jckuo@nvidia.com>
Message-ID: <b4ca21c3-5803-acb6-27e1-44eb5a2f107e@nvidia.com>
Date:   Tue, 29 Jan 2019 14:50:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128080054.GB18124@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548744603; bh=EMW2sYywOoq57B/lQe/zNv/jtIH5UFMnsuxTIZWItt4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=KbN6i8F1uslfgJhPoMAHrF09/C0C/uHMlJej7z7+9+TGtOCVpgsgxHTvwlGbveY7t
         OuGhz/EZ5F4WqDlxgpLaeVSiKIS/Yq5DH3J8w6vQYvqPhDlyCWBSMZRmZERAqEm2ve
         L4i5pXQNsAKl+RbjdYBSNejy9O5R/YKNEdsu7W5sBQn24h+xDGCLcCFwLESzZ6nM8X
         32T/I7eP33I9AxbcojIr7UhEG3URmDbKnKDlBYz1BmsdW4xW/gkTxRtFc6VQqgXzGv
         C3TOwIerxquRRwR4Lt1NGejRJedEj4B4cAz5PqY1AggcaB8tNDQNBTQyNkMgFKQWii
         GCrhCHimev8VQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Thierry.

Reviewed-by: JC Kuo <jckuo@nvidia.com>

On 1/28/19 4:00 PM, Thierry Reding wrote:
> On Mon, Jan 28, 2019 at 03:22:09PM +0800, jckuo wrote:
>> Hi Thierry,
>>
>> I think any non-zero return value of
>> regulator_bulk_enable()/devm_regulator_bulk_get() means error.
>>
>> Thanks,
>>
>> JC
> Theoretically I think only regulator_bulk_enable() could return a
> positive value, but even so it never will in practice because all of the
> regulator_enable() (see _regulator_enable()) calls will only ever return
> negative error codes.
>
> I can change this and resend if you have strong concerns about this
> possibly missing legitimate error cases.
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
>>>    drivers/phy/tegra/xusb.c | 34 +++++++++++++++++++++++++++++++++-
>>>    drivers/phy/tegra/xusb.h |  5 +++++
>>>    2 files changed, 38 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>>> index 57a2d08ef6da..e510629f4f1c 100644
>>> --- a/drivers/phy/tegra/xusb.c
>>> +++ b/drivers/phy/tegra/xusb.c
>>> @@ -864,6 +864,7 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
>>>    	struct tegra_xusb_padctl *padctl;
>>>    	const struct of_device_id *match;
>>>    	struct resource *res;
>>> +	unsigned int i;
>>>    	int err;
>>>    	/* for backwards compatibility with old device trees */
>>> @@ -901,14 +902,38 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
>>>    		goto remove;
>>>    	}
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
>>>    	err = reset_control_deassert(padctl->rst);
>>>    	if (err < 0)
>>>    		goto remove;
>>> +	err = regulator_bulk_enable(padctl->soc->num_supplies,
>>> +				    padctl->supplies);
>>> +	if (err < 0) {
>>> +		dev_err(&pdev->dev, "failed to enable supplies: %d\n", err);
>>> +		goto reset;
>>> +	}
>>> +
>>>    	err = tegra_xusb_setup_pads(padctl);
>>>    	if (err < 0) {
>>>    		dev_err(&pdev->dev, "failed to setup pads: %d\n", err);
>>> -		goto reset;
>>> +		goto power_down;
>>>    	}
>>>    	err = tegra_xusb_setup_ports(padctl);
>>> @@ -921,6 +946,8 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
>>>    remove_pads:
>>>    	tegra_xusb_remove_pads(padctl);
>>> +power_down:
>>> +	regulator_bulk_disable(padctl->soc->num_supplies, padctl->supplies);
>>>    reset:
>>>    	reset_control_assert(padctl->rst);
>>>    remove:
>>> @@ -936,6 +963,11 @@ static int tegra_xusb_padctl_remove(struct platform_device *pdev)
>>>    	tegra_xusb_remove_ports(padctl);
>>>    	tegra_xusb_remove_pads(padctl);
>>> +	err = regulator_bulk_disable(padctl->soc->num_supplies,
>>> +				     padctl->supplies);
>>> +	if (err < 0)
>>> +		dev_err(&pdev->dev, "failed to disable supplies: %d\n", err);
>>> +
>>>    	err = reset_control_assert(padctl->rst);
>>>    	if (err < 0)
>>>    		dev_err(&pdev->dev, "failed to assert reset: %d\n", err);
>>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>>> index bb60fc09c752..5d5d22f6cb41 100644
>>> --- a/drivers/phy/tegra/xusb.h
>>> +++ b/drivers/phy/tegra/xusb.h
>>> @@ -370,6 +370,9 @@ struct tegra_xusb_padctl_soc {
>>>    	} ports;
>>>    	const struct tegra_xusb_padctl_ops *ops;
>>> +
>>> +	const char * const *supply_names;
>>> +	unsigned int num_supplies;
>>>    };
>>>    struct tegra_xusb_padctl {
>>> @@ -393,6 +396,8 @@ struct tegra_xusb_padctl {
>>>    	unsigned int enable;
>>>    	struct clk *clk;
>>> +
>>> +	struct regulator_bulk_data *supplies;
>>>    };
>>>    static inline void padctl_writel(struct tegra_xusb_padctl *padctl, u32 value,
