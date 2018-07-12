Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCB1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297A6208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o8ZyDf6Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DgFIWqZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297A6208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbeGLMjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:39:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeGLMjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:39:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 696C660C54; Thu, 12 Jul 2018 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531398622;
        bh=SqpsXWOCrY8D/scQfpHtksfXO2fbb/b7FxD6ArJkcRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o8ZyDf6YnxREnXHShLt6STipO0yV+qIKUCungRZO4Gv4t5d9TiWzIGwd0rn2y3Qn1
         qWe+o1SOqneeemT3/iVBHzgRQmA9eVCqRYOsRtPQsvBosCHHSaBrNr58LshZh6WmNx
         oWafkvXdBXpkmKYZIK1+hkNte+KHMNoreGCJlKus=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CC0FC60B81;
        Thu, 12 Jul 2018 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531398621;
        bh=SqpsXWOCrY8D/scQfpHtksfXO2fbb/b7FxD6ArJkcRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DgFIWqZZ7QWI8ITErouIxbDw8swboVxQtgbgQ5gEPX697wkCsdcUOtMFiLa7PphXM
         2Ymzyrtb/SNqdzOOoENNqtQA2UPmEhRrLIVlJvwMUqxzlaUM4gJ8a4L9/gqGNCvaIA
         BFNzEngVJ4imXSCeXC4drO3sXv+MkMwQUXIOtsQw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 12 Jul 2018 18:00:21 +0530
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
In-Reply-To: <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
 <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
Message-ID: <1e6d9fc284c3c118203728867f504ec6@codeaurora.org>
X-Sender: anischal@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-09 11:45, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-06-06 04:41:46)
>> To turn on the gpu_gx_gdsc, there is a hardware requirement to
>> turn on the root clock (GFX3D RCG) first which would be the turn
>> on signal for the gdsc along with the SW_COLLAPSE. As per the
>> current implementation of clk_rcg2_shared_ops, it clears the
>> root_enable bit in the enable() and set_rate() clock ops. But due
>> to the above said requirement for GFX3D shared RCG, root_enable bit
>> would be already set by gdsc driver and rcg2_shared_ops should not 
>> clear
>> the root unless the disable is called.
>> 
> 
> It sounds like the GDSC enable is ANDed with the RCG's root enable
> bit?

Here, the root clock (GFX3D RCG) needs to be enabled first before
writing to SW_COLLAPSE bit of the GDSC. RCG's CLK_ON signal would
power up the GDSC.

> Does the RCG need to be clocking for the GDSC to actually turn on?
> Or is it purely that the enable bit is logically combined that way so
> that if the RCG is parented to a PLL that's off the GDSC will still 
> turn
> on?
> 

Yes, the RCG needs to be clocking for the GPU_GX GDSC to actually turn 
on.

>> Add support for the same by reusing the existing clk_rcg2_shared_ops
>> and deriving "clk_rcg2_gfx3d_ops" clk_ops for GFX3D clock to
>> take care of the root set/clear requirement.
> 
> Anyway, this patch will probably significantly change given that the 
> RCG
> is a glorified div-2 that muxes between a safe CXO speed and a
> configurable PLL frequency. A lot of the logic can probably just be
> hardcoded then.
> 

Thanks for the suggestion.
We are planning to introduce the "clk_rcg2_gfx3d_determine_rate" op 
which will
always return the best parent as ‘GPU_CC_PLL0_OUT_EVEN’ and best_parent
rate equal to twice of the requested rate. With this approach frequency 
table
for rcg2 structure would not be required as all the supported 
frequencies would
be derived from the GPU_CC_PLL0_OUT_EVEN src with a divider of 2.

Also, we will add support to check the requested rate if falls within 
allowed
set_rate range. This will make sure that the source PLL would not go out 
of
the supported range. set_rate_range would be set by the GPUCC driver 
with min/max
value by calling below API.

clk_hw_set_rate_range(&gpu_cc_gx_gfx3d_clk_src.clkr.hw, 180000000, 
710000000)

>> 
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> 
> Patch looks sane.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
