Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9309DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CE12084A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OSCxktxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfA2JEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:04:01 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5191 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfA2JEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:04:01 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5016d70001>; Tue, 29 Jan 2019 01:03:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 01:03:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 01:03:58 -0800
Received: from [192.168.88.246] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:03:56 +0000
Subject: Re: [2/2] mfd: max77620: Add low battery monitor support
To:     Billy Laws <blaws05@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
References: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
 <bd942195-4f1c-1a39-283f-610354308f45@nvidia.com>
 <CAFUUQHM88kVh0ov1G30Sz9WQKJRY4p78hBMporL1xU=aY_tNCA@mail.gmail.com>
From:   Mark Zhang <markz@nvidia.com>
Message-ID: <e1ebcd02-2d25-a6b7-081b-578878be15b4@nvidia.com>
Date:   Tue, 29 Jan 2019 17:03:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFUUQHM88kVh0ov1G30Sz9WQKJRY4p78hBMporL1xU=aY_tNCA@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548752599; bh=LEKN0pWJxFEfhGNWctmxQOOU2/CPfWgvdGEacLOgS5w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OSCxktxSHjSfmW7gC5etZ6I9Fm/Jkx5Re5h05aGbSr9NZTnYj+0BLjQYz4TWd/u0f
         cgIR5brteP82YhbrHlBqNM/OqW3ze8yDd86rQFJUnrbMnTwPrEIGBgmkdrRChpyLET
         FLz6/C7BbH9M2Rt5aFsFIJnrc1z0xnWRyTwPNS/288KIDcq/QF9+gezAtesklfDx/O
         xQjdbApK/0mmcFIdl+x85vTueWnwt5CFRK7aFAqVCMhZDKiUxMHbjPr0nkgyRtRHxB
         AYbuC1CjC3RbKSyCv+GUWtwwI75YKosxDbXQaY3N1Fj+bTPQMTNPu6SAfMkCfM7Bo8
         c65rFmMNEC+cQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/2019 3:36 PM, Billy Laws wrote:
> Sure, that's fine with me, will send then this gets accepted. Two
> other things: you should probably set the reg to 0 if the property
> isn't specified as regmap_add_irqchip sets it to 0xff (basically all
> enabled on highest limit), and you haven't updated the dt-bindings.

Billy, v2 is out, dt-bindings patches are added.
But after a second thought, I don't think regmap_add_irqchip might set
registers to 0xff. I mean, for 2 registers which this patch set touches,
they're not IRQ registers(mask/status/...), so regmap_add_irqchip should
not touch them so I didn't make changes to driver codes in v2.

Mark

> 
> On Tue, Jan 29, 2019 at 6:52 AM Mark Zhang <markz@nvidia.com> wrote:
>>
>> On 1/27/2019 10:54 PM, Billy Laws wrote:
>>>  >This patch adds PMIC configurations for low-battery
>>>  >monitoring by handling max77620 register CNFGGLBL1.
>>>  >
>>> It might be an idea to add lbhyst configuration here and support using
>>> custom lbdac values to specify a different cutoff point.
>>
>> Yeah this patch doesn't have support to program LBHYST & LBDAC because
>> according to our experiences, we don't have requirement to modify them
>> when low battery monitor support added.
>>
>> I think we can create a new patch to support these 2 fields in the future
>> when we really need them. Or you can create a patch if you have requirement
>> for them, is this OK to you Billy?
>>
>> Mark
>>
>>>
>>> See: https://datasheetspdf.com/pdf-file/924230/Maxim/MAX8698C/1  pg 46
>>>  >Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>>>  >Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
>>>  >Signed-off-by: Mark Zhang <markz@nvidia.com>
>>>  >---
>>>  > drivers/mfd/max77620.c | 57 +++++++++++++++++++++++++++++++++++++++++-
>>>  > 1 file changed, 56 insertions(+), 1 deletion(-)
>>>  >
>>>  >diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
>>>  >index f58143103185..9e50d145afd8 100644
>>>  >--- a/drivers/mfd/max77620.c
>>>  >+++ b/drivers/mfd/max77620.c
>>>  >@@ -474,6 +474,57 @@ static int
>>> max77620_init_backup_battery_charging(struct max77620_chip *chip)
>>>  >  return ret;
>>>  > }
>>>  >
>>>  >+static int max77620_init_low_battery_monitor(struct max77620_chip *chip)
>>>  >+{
>>>  >+ struct device *dev = chip->dev;
>>>  >+ struct device_node *np;
>>>  >+ bool pval;
>>>  >+ u8 mask = 0;
>>>  >+ u8 val = 0;
>>>  >+ int ret;
>>>  >+
>>>  >+ np = of_get_child_by_name(dev->of_node, "low-battery-monitor");
>>>  >+ if (!np) {
>>>  >+ dev_info(dev, "Low battery monitoring support disabled\n");
>>>  >+ return 0;
>>>  >+ }
>>>  >+
>>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-dac-enable");
>>>  >+ if (pval) {
>>>  >+ mask |= MAX77620_CNFGGLBL1_LBDAC_EN;
>>>  >+ val |= MAX77620_CNFGGLBL1_LBDAC_EN;
>>>  >+ }
>>>  >+
>>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-dac-disable");
>>>  >+ if (pval)
>>>  >+ mask |= MAX77620_CNFGGLBL1_LBDAC_EN;
>>>  >+
>>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-shutdown-enable");
>>>  >+ if (pval) {
>>>  >+ mask |= MAX77620_CNFGGLBL1_MPPLD;
>>>  >+ val |= MAX77620_CNFGGLBL1_MPPLD;
>>>  >+ }
>>>  >+
>>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-shutdown-disable");
>>>  >+ if (pval)
>>>  >+ mask |= MAX77620_CNFGGLBL1_MPPLD;
>>>  >+
>>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-reset-enable");
>>>  >+ if (pval) {
>>>  >+ mask |= MAX77620_CNFGGLBL1_LBRSTEN;
>>>  >+ val |= MAX77620_CNFGGLBL1_LBRSTEN;
>>>  >+ }
>>>  >+
>>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-reset-disable");
>>>  >+ if (pval)
>>>  >+ mask |= MAX77620_CNFGGLBL1_LBRSTEN;
>>>  >+
>>>  >+ ret = regmap_update_bits(chip->rmap, MAX77620_REG_CNFGGLBL1, mask, val);
>>>  >+ if (ret < 0)
>>>  >+ dev_err(dev, "Reg CNFGGLBL1 update failed: %d\n", ret);
>>>  >+ return ret;
>>>  >+}
>>>  >+
>>>  > static int max77620_read_es_version(struct max77620_chip *chip)
>>>  > {
>>>  >  unsigned int val;
>>>  >@@ -563,7 +614,11 @@ static int max77620_probe(struct i2c_client *client,
>>>  >  if (ret < 0)
>>>  >  return ret;
>>>  >
>>>  >- ret =  devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
>>>  >+ ret = max77620_init_low_battery_monitor(chip);
>>>  >+ if (ret < 0)
>>>  >+ return ret;
>>>  >+
>>>  >+ ret = devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
>>>  >      mfd_cells, n_mfd_cells, NULL, 0,
>>>  >      regmap_irq_get_domain(chip->top_irq_data));
>>>  >  if (ret < 0) {
>>>
