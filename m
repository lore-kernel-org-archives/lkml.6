Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE818FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8312520892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SEqqDFPi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QsjhwPsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8312520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeG3NDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:03:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeG3NDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:03:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EE78A61AA9; Mon, 30 Jul 2018 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532950137;
        bh=ig38JyyqkBaBdZT3VZW2rzEWTXuwd1vtanJH6ZVmU58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SEqqDFPi6uoCjbX7OsL4olf7lKOG5XxxCKMU2wc+cnmKQN88GeU7QgkyPEutkQNeX
         Y1xeRK2OqFqI7NyWK7+auWyFf+4GUZHlee3lKp5/z1lNSCnZBvWux/3Ap5d7kReheP
         OP6Z5StdSS4qQba1sCzj39L0rS1I+ucNP7BMvhJk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2C85C61AA9;
        Mon, 30 Jul 2018 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532950136;
        bh=ig38JyyqkBaBdZT3VZW2rzEWTXuwd1vtanJH6ZVmU58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QsjhwPsq9939/pn3jHvUbF55O5HccMDKRXgGWaMLRSQLaGo7IyUWZG8ybTvCV7L1P
         1X3R2J2CKmdBbtuOkRQSJ8prmvFQ491kSBGpsI6QddWblHz4vhXlqvLtHVp7CLcyLO
         OnzMVv4FGfQOyMeUxI1x/HvCBj5kHnGECNW6W0CM=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Jul 2018 16:58:56 +0530
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
In-Reply-To: <153250192252.48062.9210075387954345932@swboyd.mtv.corp.google.com>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
 <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
 <1e6d9fc284c3c118203728867f504ec6@codeaurora.org>
 <153250192252.48062.9210075387954345932@swboyd.mtv.corp.google.com>
Message-ID: <07e0321116993d27d6585bd1a186328d@codeaurora.org>
X-Sender: anischal@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-25 12:28, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-07-12 05:30:21)
>> On 2018-07-09 11:45, Stephen Boyd wrote:
>> > Quoting Amit Nischal (2018-06-06 04:41:46)
>> >> To turn on the gpu_gx_gdsc, there is a hardware requirement to
>> >> turn on the root clock (GFX3D RCG) first which would be the turn
>> >> on signal for the gdsc along with the SW_COLLAPSE. As per the
>> >> current implementation of clk_rcg2_shared_ops, it clears the
>> >> root_enable bit in the enable() and set_rate() clock ops. But due
>> >> to the above said requirement for GFX3D shared RCG, root_enable bit
>> >> would be already set by gdsc driver and rcg2_shared_ops should not
>> >> clear
>> >> the root unless the disable is called.
>> >>
>> >
>> > It sounds like the GDSC enable is ANDed with the RCG's root enable
>> > bit?
>> 
>> Here, the root clock (GFX3D RCG) needs to be enabled first before
>> writing to SW_COLLAPSE bit of the GDSC. RCG's CLK_ON signal would
>> power up the GDSC.
>> 
>> > Does the RCG need to be clocking for the GDSC to actually turn on?
>> > Or is it purely that the enable bit is logically combined that way so
>> > that if the RCG is parented to a PLL that's off the GDSC will still
>> > turn
>> > on?
>> >
>> 
>> Yes, the RCG needs to be clocking for the GPU_GX GDSC to actually turn
>> on.
> 
> Cool, please add these details to the commit text.

Thanks. I will add these details in the commit text in the next patch 
series.

> 
>> 
>> >> Add support for the same by reusing the existing clk_rcg2_shared_ops
>> >> and deriving "clk_rcg2_gfx3d_ops" clk_ops for GFX3D clock to
>> >> take care of the root set/clear requirement.
>> >
>> > Anyway, this patch will probably significantly change given that the
>> > RCG
>> > is a glorified div-2 that muxes between a safe CXO speed and a
>> > configurable PLL frequency. A lot of the logic can probably just be
>> > hardcoded then.
>> >
>> 
>> Thanks for the suggestion.
>> We are planning to introduce the "clk_rcg2_gfx3d_determine_rate" op
>> which will
>> always return the best parent as ‘GPU_CC_PLL0_OUT_EVEN’ and 
>> best_parent
>> rate equal to twice of the requested rate. With this approach 
>> frequency
>> table
>> for rcg2 structure would not be required as all the supported
>> frequencies would
>> be derived from the GPU_CC_PLL0_OUT_EVEN src with a divider of 2.
>> 
>> Also, we will add support to check the requested rate if falls within
>> allowed
>> set_rate range. This will make sure that the source PLL would not go 
>> out
>> of
>> the supported range. set_rate_range would be set by the GPUCC driver
>> with min/max
>> value by calling below API.
>> 
>> clk_hw_set_rate_range(&gpu_cc_gx_gfx3d_clk_src.clkr.hw, 180000000,
>> 710000000)
> 
> Ok. Sounds good! Is the rate range call really needed? It can't be
> determined in the PLL code with some table or avoided by making sure 
> GPU
> uses OPP table with only approved frequencies?
> 

Currently fabia PLL code does not have any table to check this and 
intention
was to avoid relying on the client to call set_rate with only approved
frequencies so we have added the set_rate_range() call in the GPUCC 
driver
in order to set the rate range.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
