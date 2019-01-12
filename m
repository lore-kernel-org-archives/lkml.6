Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E53C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E4320878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="inYM6MFe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h7oB4vRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfALA4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:56:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfALA4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:56:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1127C607F4; Sat, 12 Jan 2019 00:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547254576;
        bh=p6roF1IPES67DV0WA5ZzSTDEfg8WLtmbs3pPh6Hn7QY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=inYM6MFeQ7jerAPwuYank2hoevoI+nzXhPU8igbSVdgG9ZJ/iLpjvV+GjzcE+6bSj
         KTF0VqniKW8E4NF5vdUK/1EkwhkyiMY+CyPxxV8UuwKuKltutM6lYedijyohyCOKAl
         EBfyzfxDh6ynGgUSIA5eDrmSefZURjMLKFNci0XQ=
Received: from [10.46.162.234] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D34E6079B;
        Sat, 12 Jan 2019 00:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547254574;
        bh=p6roF1IPES67DV0WA5ZzSTDEfg8WLtmbs3pPh6Hn7QY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h7oB4vRfbJ1wlCqCarDa7Tkh34B6+Ss0bURmXaEmS2DZAZL6P2yyN8V1o02MVa+wM
         QvnsUVqK4JPKxfrQoWFT1tJ6Dwnt2Kh4/51pSBzoH4GZm+pIixoBxDZ3SRnFsujs6/
         UgukywVbMpk2bOu5EZwbT4ab/TO1/fUXcCq3RXtY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D34E6079B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH v1] clk: qcom: clk-rpmh: Add IPA clock support
To:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org, elder@linaro.org
References: <1544754904-18951-1-git-send-email-daidavid1@codeaurora.org>
 <154706211110.15366.8008755843113316822@swboyd.mtv.corp.google.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <11f948dc-3045-762f-b6bf-63c32d51772a@codeaurora.org>
Date:   Fri, 11 Jan 2019 16:56:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154706211110.15366.8008755843113316822@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/2019 11:28 AM, Stephen Boyd wrote:
> Quoting David Dai (2018-12-13 18:35:04)
>> The current clk-rpmh driver only supports on and off RPMh clock resources,
>> let's extend the current driver by add support for clocks that are managed
>> by a different type of RPMh resource known as Bus Clock Manager(BCM).
>> The BCM is a configurable shared resource aggregator that scales performance
>> based on a preset of frequency points. The Qualcomm IP Accelerator (IPA) clock
>> is an example of a resource that is managed by the BCM and this a requirement
>> from the IPA driver in order to scale its core clock.
> Please use this commit text instead:
>
>      
> The clk-rpmh driver only supports on and off RPMh clock resources. Let's
> extend the driver by add support for clocks that are managed by a
> different type of RPMh resource known as Bus Clock Manager(BCM). The BCM
> is a configurable shared resource aggregator that scales performance
> based on a set of frequency points. The Qualcomm IP Accelerator (IPA)
> clock is an example of a resource that is managed by the BCM and this a
> requirement from the IPA driver in order to scale its core clock.
Ok.
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>>   drivers/clk/qcom/clk-rpmh.c           | 141 ++++++++++++++++++++++++++++++++++
>>   include/dt-bindings/clock/qcom,rpmh.h |   1 +
>>   2 files changed, 142 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index 9f4fc77..ee78c4b 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -18,6 +18,31 @@
>>   #define CLK_RPMH_ARC_EN_OFFSET         0
>>   #define CLK_RPMH_VRM_EN_OFFSET         4
>>   
>> +#define BCM_TCS_CMD_COMMIT_MASK                0x40000000
>> +#define BCM_TCS_CMD_VALID_SHIFT                29
>> +#define BCM_TCS_CMD_VOTE_MASK          0x3fff
>> +#define BCM_TCS_CMD_VOTE_SHIFT         0
>> +
>> +#define BCM_TCS_CMD(valid, vote)                               \
>> +       (BCM_TCS_CMD_COMMIT_MASK |                              \
>> +       ((valid) << BCM_TCS_CMD_VALID_SHIFT) |                  \
>> +       ((cpu_to_le32(vote) &                                   \
> Why?
Sorry, could you clarify this question? If you're referring to the 
cpu_to_le32, shouldn't we be explicit about converting endianness even 
if it might be redundant for this particular qcom platform?
>
>> +       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_SHIFT))
>> +
>> +/**
>> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(BCM)
>> + * @unit: divisor used to convert Hz value to an RPMh msg
>> + * @width: multiplier used to convert Hz value to an RPMh msg
>> + * @vcd: virtual clock domain that this bcm belongs to
>> + * @reserved: reserved to pad the struct
>> + */
>> +struct bcm_db {
>> +       __le32 unit;
>> +       __le16 width;
>> +       u8 vcd;
>> +       u8 reserved;
>> +};
>> +
>>   /**
>>    * struct clk_rpmh - individual rpmh clock data structure
>>    * @hw:                        handle between common and hardware-specific interfaces
>> @@ -29,6 +54,7 @@
>>    * @aggr_state:                rpmh clock aggregated state
>>    * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
>>    * @valid_state_mask:  mask to determine the state of the rpmh clock
>> + * @aux_data:          data specific to the bcm rpmh resource
> But there isn't aux_data. Is this supposed to be unit? And what is unit
> going to be? 1000?
Supposed to be unit, the value is on the order of Khz.
>>    * @dev:               device to which it is attached
>>    * @peer:              pointer to the clock rpmh sibling
>>    */
>> @@ -42,6 +68,7 @@ struct clk_rpmh {
>>          u32 aggr_state;
>>          u32 last_sent_aggr_state;
>>          u32 valid_state_mask;
>> +       u32 unit;
>>          struct device *dev;
>>          struct clk_rpmh *peer;
>>   };
>> @@ -210,6 +248,91 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
>>          .recalc_rate    = clk_rpmh_recalc_rate,
>>   };
>>   
>> +static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
>> +{
>> +       struct tcs_cmd cmd = { 0 };
>> +       u32 cmd_state;
>> +       int ret;
>> +
>> +       mutex_lock(&rpmh_clk_lock);
>> +
>> +       cmd_state = enable ? (c->aggr_state ? c->aggr_state : 1) : 0;
> Make this into an if statement instead of double ternary?
Ok.
> 	cmd_state = 0;
> 	if (enable) {
> 		cmd_state = 1;
> 		if (c->aggr_state)
> 			cmd_state = c->aggr_state;
>
> 	}
>
>> +
>> +       if (c->last_sent_aggr_state == cmd_state)
>> +               return 0;
> We just returned with a mutex held. Oops!
Oops, will fix.
>> +
>> +       cmd.addr = c->res_addr;
>> +       cmd.data = BCM_TCS_CMD(enable, cmd_state);
>> +
>> +       ret = rpmh_write_async(c->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
>> +       if (ret) {
>> +               dev_err(c->dev, "set active state of %s failed: (%d)\n",
>> +                       c->res_name, ret);
>> +               return ret;
> Again!
>> +       }
>> +
>> +       c->last_sent_aggr_state = cmd_state;
>> +
>> +       mutex_unlock(&rpmh_clk_lock);
>> +
>> +       return 0;
>> +}
>> +
>> +static int clk_rpmh_bcm_prepare(struct clk_hw *hw)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +       int ret;
>> +
>> +       ret = clk_rpmh_bcm_send_cmd(c, true);
>> +
>> +       return ret;
> Just write return clk_rpmh_bcm_send_cmd(...)
Ok.
>
>> +};
>> +
>> +static void clk_rpmh_bcm_unprepare(struct clk_hw *hw)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +
>> +       clk_rpmh_bcm_send_cmd(c, false);
>> +};
>> +
>> +static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                unsigned long parent_rate)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +
>> +       c->aggr_state = rate / c->unit;
>> +       /*
>> +        * Since any non-zero value sent to hw would result in enabling the
>> +        * clock, only send the value if the clock has already been prepared.
>> +        */
>> +       if (clk_hw_is_prepared(hw))
> This is sad, but OK.
>
>> +               clk_rpmh_bcm_send_cmd(c, true);
>> +
>> +       return 0;
>> +};
>> +
> [...]
>> @@ -217,6 +340,7 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
>>   DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 1);
>>   DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 1);
>>   DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 1);
>> +DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
> It's really IP0?! What was wrong with IPA?
Yeah... convention seems to be 2 letters and then a number for most BCM 
resources.
>>   
>>   static struct clk_hw *sdm845_rpmh_clocks[] = {
>>          [RPMH_CXO_CLK]          = &sdm845_bi_tcxo.hw,
>> @@ -275,6 +402,20 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>>                                  rpmh_clk->res_name);
>>                          return -ENODEV;
>>                  }
>> +
>> +               data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
>> +               if (IS_ERR(data)) {
>> +                       ret = PTR_ERR(data);
>> +                       dev_err(&pdev->dev,
>> +                               "error reading RPMh aux data for %s (%d)\n",
>> +                               rpmh_clk->res_name, ret);
>> +                               return ret;
> Weird indent here.
will fix.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

