Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0D2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536F2214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8yxjfU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeLZRxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:53:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43223 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeLZRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:53:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so16227384wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TNirGdkUcf3Cw8WFDHP/QCy1UKqmCA+QklM1/KofVEU=;
        b=R8yxjfU7UJ8Twl5kOv7IFyA/getGkGQ3MV9PvYLUBJLZME6Qw58+GvfJ0bA70SxqoC
         b6hy0GBs2bysiD2XUVbhK4FeOWc3yvMqatJsH7kqYNqQeSvJXR9qM0x3or3dWIbyo66X
         Sf/tmYZpx5XCnsbwiJCr8H9dfmSTPSkO8rTg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNirGdkUcf3Cw8WFDHP/QCy1UKqmCA+QklM1/KofVEU=;
        b=J7jwyemO+pADx0HHqSWekn/l8Ad/0QoZ9vAl2DxpQPghwnCn0RlTbQMnZStSjF+3k+
         0otYW53NClXCDs4yzLXiGUz85hhN9swDfECkREw4oyIEqOf9v/ckTLKgWK7e/c3rrClQ
         +8RfNkJBykAMjfSoEcYyuN2/lfPaTGAAyupg/2NXR+AEukSMCmT6yFWN14szIZIiW1Td
         WM3Il+4HkuxCqI+Bcs66YQ/7VVPoVZn5H72wCVxJrosGtCxoUQ4TpqmLXEvPsqgNfxhl
         xywuHiGZEw98d9uXAlyzSe1y7AWzK/J1UeEmCb2ehbTb7V/qH3zJIf/14hq1XP9aiHAa
         m2tA==
X-Gm-Message-State: AJcUukce2uxM+JjUFmblYoEhm2a0jk0j7jGl4UdZmelIvXpuxI2HSYRU
        1Qyr8kx1B6q1X0vqRYXqmICXOH5I8LU=
X-Google-Smtp-Source: ALg8bN6gsp7fXKBaprBJKgsDAtrsVk14rrw+2Csye7q7L9TzOGtbzFlZTh5WoTgBk3v2ptBqSjJ7Cg==
X-Received: by 2002:adf:9246:: with SMTP id 64mr14898973wrj.130.1545846791362;
        Wed, 26 Dec 2018 09:53:11 -0800 (PST)
Received: from [192.168.1.2] (227.red-79-146-82.dynamicip.rima-tde.net. [79.146.82.227])
        by smtp.gmail.com with ESMTPSA id h184sm19171323wmf.0.2018.12.26.09.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 09:53:10 -0800 (PST)
Subject: Re: [PATCH 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154533779333.79149.17234544366247143930@swboyd.mtv.corp.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <2f38642e-27a0-0fd7-928e-8e782d0bc7c6@linaro.org>
Date:   Wed, 26 Dec 2018 18:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154533779333.79149.17234544366247143930@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 21:29, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz (2018-12-07 01:55:58)
>> From: Shawn Guo <shawn.guo@linaro.org>
>>
>> Driver to control the Synopsys SS PHY 1.0.0 implemeneted in QCS404
>>
>> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original code.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> chain should be swapped?

ok.

Shawn asked me to remove him from the authors list so will remove.

> 
>> Reviewed-by: Vinod Koul <vkoul@kernel.org>

will remove the reviewed-by line as well.

>> ---
>> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-ss.c b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>> new file mode 100644
>> index 0000000..7b6a55e
>> --- /dev/null
>> +++ b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>> +
>> +struct ssphy_priv {
>> +       void __iomem *base;
>> +       struct device *dev;
>> +       struct reset_control *reset_com;
>> +       struct reset_control *reset_phy;
>> +       struct clk *clk_ref;
>> +       struct clk *clk_phy;
>> +       struct clk *clk_pipe;
> 
> Use bulk clk APIs? And just get and enable all the clks?

yes.

> 
>> +       struct regulator *vdda1p8;
>> +       struct regulator *vbus;
>> +       struct regulator *vdd;
>> +       unsigned int vdd_levels[LEVEL_NUM];
>> +};
>> +
>> +static inline void qcom_ssphy_updatel(void __iomem *addr, u32 mask, u32 val)
>> +{
>> +       writel((readl(addr) & ~mask) | val, addr);
>> +}
>> +
>> +static int qcom_ssphy_config_vdd(struct ssphy_priv *priv,
>> +                                enum phy_vdd_level level)
>> +{
>> +       return regulator_set_voltage(priv->vdd,
>> +                                    priv->vdd_levels[level],
>> +                                    priv->vdd_levels[LEVEL_MAX]);
> 
> regulator_set_voltage(reg, 0, max) is very suspicious. It's voltage
> corners where the voltages are known?

sorry I dont understand the question

this regulator on the ss phy wold be
vreg_l3_1p05: l3 {
		regulator-min-microvolt = <976000>;
		regulator-max-microvolt = <1160000>;
};
> 
>> +}
>> +
>> +static int qcom_ssphy_ldo_enable(struct ssphy_priv *priv)
>> +{
>> +       int ret;
>> +
>> +       ret = regulator_set_load(priv->vdda1p8, 23000);
> 
> Do you need to do this? Why can't the regulator be in high power mode
> all the time and then go low power when it's disabled?

this regulator is shared with the usb hs phy and each (ss/hs) have 
different load requirements. why would it be wrong for the ss phy to 
announce its needs (which will differ from those of the hs phy)?

> 
>> +       if (ret < 0) {
>> +               dev_err(priv->dev, "Failed to set regulator1p8 load\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = regulator_set_voltage(priv->vdda1p8, 1800000, 1800000);
> 
> This looks unnecessary. The 1.8V regulator sounds like it better be 1.8V
> so board constraints should enforce that. All that should be here is
> enabling the regulator.

ok

> 
>> +       if (ret) {
>> +               dev_err(priv->dev, "Failed to set regulator1p8 voltage\n");
>> +               goto put_vdda1p8_lpm;
>> +       }
>> +
>> +       ret = regulator_enable(priv->vdda1p8);
>> +       if (ret) {
>> +               dev_err(priv->dev, "Failed to enable regulator1p8\n");
>> +               goto unset_vdda1p8;
>> +       }
>> +
>> +       return ret;
>> +
>> +       /* rollback regulator changes */
>> +
>> +unset_vdda1p8:
>> +       regulator_set_voltage(priv->vdda1p8, 0, 1800000);
>> +
>> +put_vdda1p8_lpm:
>> +       regulator_set_load(priv->vdda1p8, 0);
>> +
>> +       return ret;
>> +}
>> +
>> +static void qcom_ssphy_ldo_disable(struct ssphy_priv *priv)
>> +{
>> +       regulator_disable(priv->vdda1p8);
>> +       regulator_set_voltage(priv->vdda1p8, 0, 1800000);
> 
> Urgh why?

since it is being shared with the hs phy I understand this is required 
to vote the transition to the lowest voltage state.
> 
>> +       regulator_set_load(priv->vdda1p8, 0);
>> +}
> 

