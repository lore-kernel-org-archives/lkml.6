Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC0AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09C520844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDwKOLyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfA3LiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:38:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37047 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfA3LiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:38:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so21211609wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pws+GKp8yzQgeZUGmCTNNkAjBgitoirunLrvoyopzpM=;
        b=BDwKOLyGOAN8UF7lWBQZog94zQTb43MRJqfkAK4C1R7Wssy3/boI+Y4T8691aR1Fwu
         Yq2kCu9MPzNq9K+tqg0uw8uO2pltj1lI6fcyPHvS2FjhKdRyM7z+JZ5A0VhcqA9ylC8p
         NCvrunMUFv/w9Tc1LojR3yB7smTcKf6p5o/Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pws+GKp8yzQgeZUGmCTNNkAjBgitoirunLrvoyopzpM=;
        b=A75pXpz6IAf2XfmyuqbKhMKM0cVRGHuhOaWK9Ryhq13HpeUhQO2L5hcrMNVn3X7mFI
         2aLCOe+jHE66d6GieEDiLXJVbpMNrU0nlZUzu6rq4uMNpIrXOCTWMEN1eSuisyAmh46K
         IHxB3oB+3fp8N9x5PJG3fbvwuYJDpRsJKA0sXFMDKVaHkIPGEw8JNX/W1+9rqnKLsGGC
         hr143OVDsEPRT0aS38GGySyiLnT7PAQEk7k6FKtcRFScFcbbkIDYvunO6w6BGquVe1gk
         ERXj527WXDoyx54ykvF0KqvN8KVCbkbcqVrhPY2uFXySzU+5YBQNRZebm52kzr+LVouK
         ym7Q==
X-Gm-Message-State: AJcUukcdn1/oQy9OLJ7Pw4XDTuZAyA7EDAo/PKRVtM4YzQbqOJkWqO8v
        VovQlSUBi7LF/cwv2CN/iKEjniuTnM0=
X-Google-Smtp-Source: ALg8bN4hXEAXeE1ZjOjDi69zhQEtsFcJvcuJdc21L/CLrsWUSckv/gAjPnplD1LpbI1kOyifRDg66A==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr24454264wme.1.1548848302712;
        Wed, 30 Jan 2019 03:38:22 -0800 (PST)
Received: from [192.168.1.2] (99.red-79-146-83.dynamicip.rima-tde.net. [79.146.83.99])
        by smtp.gmail.com with ESMTPSA id y34sm3326299wrd.68.2019.01.30.03.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 03:38:21 -0800 (PST)
Subject: Re: [PATCH v2 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org,
        shawn.guo@linaro.org, vkoul@kernel.org, khasim.mohammed@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190129202726.GA3036@builder>
 <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Message-ID: <8986d1ea-e009-6f15-e9ca-93cd64284ff7@linaro.org>
Date:   Wed, 30 Jan 2019 12:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 10:53, Jorge Ramirez wrote:
> On 1/29/19 21:27, Bjorn Andersson wrote:
>> On Tue 29 Jan 03:35 PST 2019, Jorge Ramirez-Ortiz wrote:
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-ss.c b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>>> new file mode 100644
>>> index 0000000..e6ae96e
>>> --- /dev/null
>>> +++ b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>>> @@ -0,0 +1,347 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2012-2014,2017 The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2018, Linaro Limited
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/phy/phy.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#define PHY_CTRL0			0x6C
>>> +#define PHY_CTRL1			0x70
>>> +#define PHY_CTRL2			0x74
>>> +#define PHY_CTRL4			0x7C
>>> +
>>> +/* PHY_CTRL bits */
>>> +#define REF_PHY_EN			BIT(0)
>>> +#define LANE0_PWR_ON			BIT(2)
>>> +#define SWI_PCS_CLK_SEL			BIT(4)
>>> +#define TST_PWR_DOWN			BIT(4)
>>> +#define PHY_RESET			BIT(7)
>>> +
>>> +enum phy_vdd_ctrl { ENABLE, DISABLE, };
>>
>> Use bool to describe boolean values.
> 
> um, ok, but these are not booleans, they are actions (ie ctrl = action
> not true or false).
> 
> anyway will change it to something else
> 
>>
>>> +enum phy_regulator { VDD, VDDA1P8, };
>>
>> It doesn't look like you need either of these if you remove the
>> set_voltage calls.
> 
> we need to point to the regulator in the array so we need an index to it
> somehow.

you are right, we dont

> 
>>
>>> +
>>> +struct ssphy_priv {
>>> +	void __iomem *base;
>>> +	struct device *dev;
>>> +	struct reset_control *reset_com;
>>> +	struct reset_control *reset_phy;
>>> +	struct regulator *vbus;
>>> +	struct regulator_bulk_data *regs;
>>> +	int num_regs;
>>> +	struct clk_bulk_data *clks;
>>> +	int num_clks;
>>> +	enum phy_mode mode;
>>> +};
>>> +
>>> +static inline void qcom_ssphy_updatel(void __iomem *addr, u32 mask, u32 val)
>>> +{
>>> +	writel((readl(addr) & ~mask) | val, addr);
>>> +}
>>> +
>>> +static inline int qcom_ssphy_vbus_enable(struct regulator *vbus)
>>> +{
>>> +	return !regulator_is_enabled(vbus) ? regulator_enable(vbus) : 0;
>>
>> regulator_is_enabled() will check if the actual regulator is on, not if
>> you already voted for it.
>>
>> So if something else is enabling the vbus regulator you will skip your
>> enable and be in the mercy of them not releasing it. Presumably there's
>> only one consumer of this particular regulator, but it's a bad habit.
> 
> yep
> 
>>
>> Please keep track of this drivers requested state in this driver, if
>> qcom_ssphy_vbus_ctrl() is called not only for the state changes.
> 
> um, there is not such a function: the ctrl function is not for vbus but
> for vdd

argh, sorry, it is me who misread my own driver. ok I know what you
mean. will send the updated driver shortly.
