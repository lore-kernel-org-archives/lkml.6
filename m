Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A1EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A65820834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CrN9zrmW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D3INFZXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A65820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeLECBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:01:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLECBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:01:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9CD15602F4; Wed,  5 Dec 2018 02:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543975311;
        bh=TvxMm7Sucx55ikDA538u6b6ED7efkicwLBxo8pQRcaM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CrN9zrmWbZjmiOiwt5EIZCLlelJSlhjiMUNzSPDjuBWbPMf26esPEWdDM11MC3XHs
         OMjtHur0bEg2wwkLghbY6FfdnciF/TiaeoPnt5Hs1o60LqLtz5BGdD3sFfYaYbsme6
         rAhJf8usk0kRSrt+Ffvqb8i/7BUFcLHXylL85pIU=
Received: from [10.46.162.234] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25055602F4;
        Wed,  5 Dec 2018 02:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543975310;
        bh=TvxMm7Sucx55ikDA538u6b6ED7efkicwLBxo8pQRcaM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D3INFZXM1bSnM0aBs31u2AUdzyLZ5q5Zk+C0Z/7o4uH7rvNLVRVCv5MBIsQwL18H2
         fE5dCU9nNx/9HSuFzYYL6+F3bOuzSmX4nnoGloShyBkTL9hWdE/hfwNPZxPoZ1h8L1
         BnY9HNb/MFz68DErx3XNXcyCIEPRvHekhtZI4ACY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25055602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
To:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org, elder@linaro.org
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
 <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
 <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <9f2f7aed-0dd1-3cea-fe90-9de75ff657ed@codeaurora.org>
Date:   Tue, 4 Dec 2018 18:01:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick feedback!


On 12/4/2018 11:24 AM, Stephen Boyd wrote:
> Quoting David Dai (2018-12-03 19:50:13)
>> Add IPA clock support by extending the current clk rpmh driver to support
>> clocks that are managed by a different type of RPMh resource known as
>> Bus Clock Manager(BCM).
> Yes, but why? Does the IPA driver need to set clk rates and that somehow
> doesn't work as a bandwidth request?
>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index 9f4fc77..42e2cd2 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -18,6 +18,32 @@
>>   #define CLK_RPMH_ARC_EN_OFFSET         0
>>   #define CLK_RPMH_VRM_EN_OFFSET         4
>>   
>> +#define BCM_TCS_CMD_COMMIT_MASK                0x40000000
>> +#define BCM_TCS_CMD_VALID_SHIFT                29
>> +#define BCM_TCS_CMD_VOTE_MASK          0x3fff
>> +#define BCM_TCS_CMD_VOTE_SHIFT         0
>> +
>> +#define BCM_TCS_CMD(valid, vote) \
>> +       (BCM_TCS_CMD_COMMIT_MASK |\
> Nitpick: Add space before the \ and align them all up on the right side
> of the page.
Ok.
>
>> +       ((valid) << BCM_TCS_CMD_VALID_SHIFT) |\
>> +       ((cpu_to_le32(vote) &\
>> +       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_SHIFT))
>> +
>> +/**
>> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(BCM)
>> + * @unit: divisor used to convert Hz value to an RPMh msg
>> + * @width: multiplier used to convert Hz value to an RPMh msg
>> + * @vcd: virtual clock domain that this bcm belongs to
>> + * @reserved: reserved to pad the struct
>> + */
>> +
> Nitpick: Please remove the newline between comment and struct.
Ok.
>> +struct bcm_db {
>> +       u32 unit;
>> +       u16 width;
>> +       u8 vcd;
>> +       u8 reserved;
> These would need __le32 and __le16 for the byte swap.
Ok.
>> +};
>> +
>>   /**
>>    * struct clk_rpmh - individual rpmh clock data structure
>>    * @hw:                        handle between common and hardware-specific interfaces
>> @@ -210,6 +249,91 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
>>          .recalc_rate    = clk_rpmh_recalc_rate,
>>   };
>>   
>> +static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
>> +{
>> +       struct tcs_cmd cmd = { 0 };
>> +       u32 cmd_state;
>> +       int ret;
>> +
>> +       cmd_state = enable ? (c->aggr_state ? c->aggr_state : 1) : 0;
>> +
>> +       if (c->last_sent_aggr_state == cmd_state)
>> +               return 0;
>> +
>> +       cmd.addr = c->res_addr;
>> +       cmd.data = BCM_TCS_CMD(enable, cmd_state);
>> +
>> +       ret = rpmh_write_async(c->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
>> +       if (ret) {
>> +               dev_err(c->dev, "set active state of %s failed: (%d)\n",
>> +                       c->res_name, ret);
>> +               return ret;
>> +       }
>> +
>> +       c->last_sent_aggr_state = cmd_state;
>> +
>> +       return 0;
>> +}
>> +
>> +static int clk_rpmh_bcm_prepare(struct clk_hw *hw)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +       int ret = 0;
> Don't initialize variables and then reassign them right after.
Ok.
>> +
>> +       mutex_lock(&rpmh_clk_lock);
>> +       ret = clk_rpmh_bcm_send_cmd(c, true);
>> +       mutex_unlock(&rpmh_clk_lock);
>> +
>> +       return ret;
>> +};
>> +
>> +static void clk_rpmh_bcm_unprepare(struct clk_hw *hw)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +
>> +       mutex_lock(&rpmh_clk_lock);
>> +       clk_rpmh_bcm_send_cmd(c, false);
>> +       mutex_unlock(&rpmh_clk_lock);
>> +};
>> +
>> +static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                unsigned long parent_rate)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +
>> +       c->aggr_state = rate / (c->aux_data.unit * 1000);
>> +
>> +       if (clk_hw_is_prepared(hw)) {
> Why do we need to check is_prepared? Add a comment indicating we can't
> send the request when the clk is disabled?

Since the BCM only takes in numerical values as part of its msg (as 
opposed to enable or disable of some sort), this is so that we don't 
actually enable the clock if it hasn't been prepared yet. Sending a 
value of zero vs a non-zero would be the equivalent turning the clocks 
on and off and the behavior I'm trying to emulate here is to only change 
the rate in the system if the clock is on.
>
>> +               mutex_lock(&rpmh_clk_lock);
>> +               clk_rpmh_bcm_send_cmd(c, true);
> This function is always inside mutex_lock()/unlock() pair, so push the
> lock into the function?
Makes sense, done.
>
>> +               mutex_unlock(&rpmh_clk_lock);
>> +       }
>> +
>> +       return 0;
>> +};
>> +
>> +static long clk_rpmh_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                               unsigned long *parent_rate)
>> +{
>> +       return rate;
>> +}
>> +
>> +static unsigned long clk_rpmh_bcm_recalc_rate(struct clk_hw *hw,
>> +                                       unsigned long prate)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +
>> +       return c->aggr_state * c->aux_data.unit * 1000;
> What is 1000 for?
The unit is in order of Khz, I can do the conversion for KHz to Hz the 
time when we fetch the aux data.
>
>> +}
>> +
>> +static const struct clk_ops clk_rpmh_bcm_ops = {
>> +       .prepare        = clk_rpmh_bcm_prepare,
>> +       .unprepare      = clk_rpmh_bcm_unprepare,
>> +       .set_rate       = clk_rpmh_bcm_set_rate,
>> +       .round_rate     = clk_rpmh_round_rate,
>> +       .recalc_rate    = clk_rpmh_bcm_recalc_rate,
>> +};
>> +
>>   /* Resource name must match resource id present in cmd-db. */
>>   DEFINE_CLK_RPMH_ARC(sdm845, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 2);
>>   DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 2);
>> @@ -275,6 +402,21 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>>                                  rpmh_clk->res_name);
>>                          return -ENODEV;
>>                  }
> Nitpick: Please add newline here.
Ok.
>> +               aux_data_len = cmd_db_read_aux_data_len(rpmh_clk->res_name);
>> +               if (aux_data_len == sizeof(struct bcm_db)) {
>> +                       ret = cmd_db_read_aux_data(rpmh_clk->res_name,
>> +                                                  (u8 *)&rpmh_clk->aux_data,
> Is the cast necessary? And I would just pick out the data you need from
> the aux_data instead of storing it forever (with the padding) in the
> rpmh_clk structure.

Sounds reasonable, the only thing we need from the aux_data is just the 
unit in this case.

>> +                                                  sizeof(struct bcm_db));
>> +                       if (ret < 0) {
>> +                               dev_err(&pdev->dev, "aux data read failure for %s (%d)\n",
>> +                               rpmh_clk->res_name, ret);
>> +                               return ret;
>> +                       }
>> +                       rpmh_clk->aux_data.unit =
>> +                                       le32_to_cpu(rpmh_clk->aux_data.unit);
>> +                       rpmh_clk->aux_data.width =
>> +                                       le16_to_cpu(rpmh_clk->aux_data.width);
>> +               }
> Nitpick: Newline here too.
Ok.
>>                  rpmh_clk->res_addr += res_addr;
>>                  rpmh_clk->dev = &pdev->dev;
>>   

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

