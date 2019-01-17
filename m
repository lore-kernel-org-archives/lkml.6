Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0CE20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lfY1i0hC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XiBC7rtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfAQAyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:54:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfAQAym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:54:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 47D8F60807; Thu, 17 Jan 2019 00:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547686481;
        bh=hAG9Mhht14pGQ5VVgDO7B7l2OK2TC68VXcahyGf/CqA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lfY1i0hC91jD6aorzsbZ246lVdEM3vYv3l/vJHsAdSBBPcIFo6JAYLeAGbVvLfEYI
         KX0Ivpot3F1NiMHh/c5+qf7rMefdg2B2TQsdIzJD5cRyd7wwEm34yAAVmjks/u1U9L
         xvef0xdF5xh1wSDWeIC7kt6XooOkM5X3bh6+SjtU=
Received: from [10.46.162.234] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 452E56024C;
        Thu, 17 Jan 2019 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547686480;
        bh=hAG9Mhht14pGQ5VVgDO7B7l2OK2TC68VXcahyGf/CqA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XiBC7rtf32x7j6wral3WKU1OX4CBuRRL0nEYvpMa0m/nf3Sj0rXMCG1/xBq461J53
         EV2P0lCog2MAZQ3HCUDg2AW/ClToKmOnVnTJNAHQ5xlZeEgU9qTg59qn2T6oraa4xa
         FQwISkgOEuJzSjtWcChglhGdXSX87RngY9gfhFR4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 452E56024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH v1] clk: qcom: clk-rpmh: Add IPA clock support
To:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org, elder@linaro.org
References: <1544754904-18951-1-git-send-email-daidavid1@codeaurora.org>
 <154706211110.15366.8008755843113316822@swboyd.mtv.corp.google.com>
 <11f948dc-3045-762f-b6bf-63c32d51772a@codeaurora.org>
 <154748442276.169631.994019688641603420@swboyd.mtv.corp.google.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <7db43e9e-0f5c-9c26-6f26-c601ec69f964@codeaurora.org>
Date:   Wed, 16 Jan 2019 16:54:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154748442276.169631.994019688641603420@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/2019 8:47 AM, Stephen Boyd wrote:
> Quoting David Dai (2019-01-11 16:56:14)
>> On 1/9/2019 11:28 AM, Stephen Boyd wrote:
>>> Quoting David Dai (2018-12-13 18:35:04)
>>>> +
>>>> +#define BCM_TCS_CMD(valid, vote)                               \
>>>> +       (BCM_TCS_CMD_COMMIT_MASK |                              \
>>>> +       ((valid) << BCM_TCS_CMD_VALID_SHIFT) |                  \
>>>> +       ((cpu_to_le32(vote) &                                   \
>>> Why?
>> Sorry, could you clarify this question? If you're referring to the
>> cpu_to_le32, shouldn't we be explicit about converting endianness even
>> if it might be redundant for this particular qcom platform?
> Is only the vote part of the message in little endian format and the
> rest is native CPU endianess? It's very odd to see that jammed in the
> middle of a bit packing statement like that. Typically the whole u32
> would be in one or the other endianness. Also, sparse right complains
> about this macro and it's usage, so something is wrong.
Point taken, I'll leave it out of the macro for now.
> I think one other problem is that rpmh API doesn't really talk about
> endianness here and that's busted. So if you want to fix endianness
> issues that needs to be fixed first.

Since a similar macro is being used as part of the interconnect provider 
driver, I was thinking a better place for this macro might be in the 
tcs.h as part of the rpmh driver? I could submit a different patch for 
rpmh that mentions endianness along with this change.

>>>> @@ -29,6 +54,7 @@
>>>>     * @aggr_state:                rpmh clock aggregated state
>>>>     * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
>>>>     * @valid_state_mask:  mask to determine the state of the rpmh clock
>>>> + * @aux_data:          data specific to the bcm rpmh resource
>>> But there isn't aux_data. Is this supposed to be unit? And what is unit
>>> going to be? 1000?
>> Supposed to be unit, the value is on the order of Khz.
> Ok, hopefully the kernel-doc comes out easy to understand.
>
>>>> @@ -217,6 +340,7 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
>>>>    DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 1);
>>>>    DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 1);
>>>>    DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 1);
>>>> +DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
>>> It's really IP0?! What was wrong with IPA?
>> Yeah... convention seems to be 2 letters and then a number for most BCM
>> resources.
> OK.
>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

