Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582A1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1372D218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H5rxtO1A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X8prDouE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbeLUINS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:13:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40998 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbeLUINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:13:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F5296053B; Fri, 21 Dec 2018 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545379996;
        bh=GjwTpVy9d8uEuliEBXqbCqXteFKRpN0TvzzwTpPcbXk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H5rxtO1AKd8W9jS5QauqQxKfvsZtQyFb6YCfdfMNPFGy09XEqwyeqlK9rWTuMTGu4
         hvaWckG8lPodgJlEY+qz1N3y5E8EVAScR21dQPanMM9Fj2h8Jfde/FrrNVqRCMdKSt
         DqTNTlK3n9gpvOxJ9UJoMwSuc1ggEV+u2V5fj2TA=
Received: from [10.206.25.155] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 060F8606FC;
        Fri, 21 Dec 2018 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545379995;
        bh=GjwTpVy9d8uEuliEBXqbCqXteFKRpN0TvzzwTpPcbXk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X8prDouEiy5KRHAjiNHD7Jev2JETQnSDAc6vXEf5VGxKuqpdAXLQyH60a0e2LYQRV
         OCWhWjmTS37j59z7XRaP7vSPi8NPPDHCnfpKdbwE9Tu+MWhk4CD4gyw/UYdAcLFdhB
         XoVytbaAx4bzLDClJTm+zEbxucmY3q1OgNXDGHAE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 060F8606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v6 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jack Pham <jackp@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <20181220010112.16824-1-shawn.guo@linaro.org>
 <20181220010112.16824-3-shawn.guo@linaro.org>
 <f106782b6d8e26ebf851f00563c68948@codeaurora.org>
 <20181220110956.GA17416@dragon>
From:   Manu Gautam <mgautam@codeaurora.org>
Message-ID: <f5981b24-b769-2f48-7f93-10fb4f61caec@codeaurora.org>
Date:   Fri, 21 Dec 2018 13:43:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181220110956.GA17416@dragon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/20/2018 4:39 PM, Shawn Guo wrote:
> Hi Manu,
>
> On Thu, Dec 20, 2018 at 09:33:43AM +0530, mgautam@codeaurora.org wrote:
>> Hi Shawn,
>>
>> On 2018-12-20 06:31, Shawn Guo wrote:
>>> It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
>>> is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
>>>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>> ---
>>
...
>>> +struct hsphy_priv {
>> nit-pick - indentation for following structure members?
> Hmm, my personal taste says no, because I found that it's hard to keep
> the indentation when adding new members later.
ok
>
>>> +	void __iomem *base;
>>> +	struct clk_bulk_data *clks;
>>> +	int num_clks;
>>> +	struct reset_control *phy_reset;
>>> +	struct reset_control *por_reset;
>>> +	struct regulator_bulk_data vregs[VREG_NUM];
>>> +	unsigned int voltages[VREG_NUM][VOL_NUM];
>>> +	const struct hsphy_data *data;
>>> +	bool cable_connected;
>> You can get cable-connected state from "enum phy_mode mode" which
>> is present in this driver.
>> E.g. cable_connected is false if mode is neither HOST nor DEVICE.
>>
>>
>>> +	struct extcon_dev *vbus_edev;
>>> +	struct notifier_block vbus_notify;
>> extcons not needed if you use "mode" for the same purpose.
> The extcon is there for indicating cable connection status.  I'm not
> sure that phy_mode can be used for that purpose.  For example, what
> value would phy core set phy_mode to, if we disconnect the cable from
> phy_mode being HOST or DEVICE?

it depends how it is used. Looks like it is used to decide whether to turn-off
regulators or not. Unless you plan to add low power support as part of
runtime-suspend of PHY during host mode, there is no reason to not turn-off
regulators on pm_suspend(). Please refer to my comments below.

>
>>
>>> +	enum phy_mode mode;
>>> +};
>>> +
>>
>>> +
>>> +static int qcom_snps_hsphy_vbus_notifier(struct notifier_block *nb,
>>> +					 unsigned long event, void *ptr)
>>> +{
>>> +	struct hsphy_priv *priv = container_of(nb, struct hsphy_priv,
>>> +						    vbus_notify);
>>> +	priv->cable_connected = !!event;
>>> +	return 0;
>>> +}
>>> +
>>> +static int qcom_snps_hsphy_power_on(struct phy *phy)
>> Can you instead merge this power_on function with phy_init?
> I can do that, but what's the gain/advantage from doing that?

dwc3 core calls phy_init() before power_on(). AFAIK, PHY regulators
need to be ON before initializing it.

>
>>> +{
>>> +	struct hsphy_priv *priv = phy_get_drvdata(phy);
>>> +	int ret;
>>> +
>>> +	if (priv->cable_connected) {
>> Why distinguish between cable connected vs not-connected?
> This is based on the vendor driver implementation.  It does a more
> aggressive low power management in case that cable is not connected,
> i.e. turning off regulator and entering retention mode.

I believe 'aggressive low power management' will be triggered on
pm_suspend?
And dwc3 core will in any case perform phy_exit()->phy_init() across
pm_suspend/resume which will reset PHYs. Hence, there is no need to check
for cable connected state here.


>
>>> +		ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
>>> +		if (ret)
>>> +			return ret;
>>> +		qcom_snps_hsphy_disable_hv_interrupts(priv);
>>> +	} else {
>>> +		ret = qcom_snps_hsphy_enable_regulators(priv);
>>> +		if (ret)
>>> +			return ret;
>>> +		ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
>>> +		if (ret)
>>> +			return ret;
>>> +		qcom_snps_hsphy_exit_retention(priv);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int qcom_snps_hsphy_power_off(struct phy *phy)
>>> +{
>>> +	struct hsphy_priv *priv = phy_get_drvdata(phy);
>>> +
>>> +	if (priv->cable_connected) {
>>> +		qcom_snps_hsphy_enable_hv_interrupts(priv);
>>> +		clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>>> +	} else {
>>> +		qcom_snps_hsphy_enter_retention(priv);
>>> +		clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>>> +		qcom_snps_hsphy_disable_regulators(priv);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>
>>
>> ..
>>> +static const struct phy_ops qcom_snps_hsphy_ops = {
>>> +	.init = qcom_snps_hsphy_init,
>>> +	.power_on = qcom_snps_hsphy_power_on,
>>> +	.power_off = qcom_snps_hsphy_power_off,
>>> +	.set_mode = qcom_snps_hsphy_set_mode,
>> .phy_exit()?
>> I believe that is needed as dwc3 core driver performs
>> phy_exit/phy_init across pm_suspend/resume.
> I just do not see anything that we should be doing in .exit hook right
> now.

After you merge power_on() with phy_init() as per my previous comment,
you can rely on phy_exit() to take care of putting PHY in low power state
and turn off regulators as well.

>
> Shawn
>
>>
>>> +	.owner = THIS_MODULE,
>>> +};
>>> +

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

