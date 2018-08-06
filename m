Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93853C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474AE21A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XOwgtVfi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XOwgtVfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474AE21A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeHFRON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:14:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45542 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732377AbeHFRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:14:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E8B2C60541; Mon,  6 Aug 2018 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533567881;
        bh=Ks+M+x+/4l8vooNjxrJS767hdHiAjuZNtDgXwYpIyjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOwgtVfik3qtzLcxFO6PffoBnQJMpdHU2UVA6+8XxMUEp4zQ1CyjO5s/0Td0zGufi
         69Y6WTX8SiTYG7BYx0DidlsdKDc3xlYAHnJlJemC+bqqLSeTq5lNgBosYcDyuLWvDK
         ijU0RdJ3rlE6GtUQzvY77prM5ZHyDgvKLbIP+2IQ=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 498526037C;
        Mon,  6 Aug 2018 15:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533567881;
        bh=Ks+M+x+/4l8vooNjxrJS767hdHiAjuZNtDgXwYpIyjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOwgtVfik3qtzLcxFO6PffoBnQJMpdHU2UVA6+8XxMUEp4zQ1CyjO5s/0Td0zGufi
         69Y6WTX8SiTYG7BYx0DidlsdKDc3xlYAHnJlJemC+bqqLSeTq5lNgBosYcDyuLWvDK
         ijU0RdJ3rlE6GtUQzvY77prM5ZHyDgvKLbIP+2IQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 498526037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 6 Aug 2018 09:04:37 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Amit Nischal <anischal@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
Message-ID: <20180806150437.GE21283@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Amit Nischal <anischal@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk-owner@vger.kernel.org
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
 <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
 <1e6d9fc284c3c118203728867f504ec6@codeaurora.org>
 <153250192252.48062.9210075387954345932@swboyd.mtv.corp.google.com>
 <07e0321116993d27d6585bd1a186328d@codeaurora.org>
 <153324986956.10763.5124619734269160725@swboyd.mtv.corp.google.com>
 <ee2113c9dd6a44e9669e60f760c76409@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee2113c9dd6a44e9669e60f760c76409@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:37:18PM +0530, Amit Nischal wrote:
> On 2018-08-03 04:14, Stephen Boyd wrote:
> >Quoting Amit Nischal (2018-07-30 04:28:56)
> >>On 2018-07-25 12:28, Stephen Boyd wrote:
> >>>
> >>> Ok. Sounds good! Is the rate range call really needed? It can't be
> >>> determined in the PLL code with some table or avoided by making sure
> >>> GPU
> >>> uses OPP table with only approved frequencies?
> >>>
> >>
> >>Currently fabia PLL code does not have any table to check this and
> >>intention
> >>was to avoid relying on the client to call set_rate with only approved
> >>frequencies so we have added the set_rate_range() call in the GPUCC
> >>driver
> >>in order to set the rate range.
> >>
> >
> >But GPU will use OPP so it doesn't seem like it really buys us anything
> >here. And it really doesn't matter when the clk driver implementation
> >doesn't use the min/max to clamp the values of the round_rate()
> >call. Is
> >that being done here? I need to double check. I would be more convinced
> >if the implementation was looking at min/max to constrain the rate
> >requested.
> >
> 
> So our understanding is that GPU(client) driver will always call the
> set_rate with approved frequencies only and we can completely rely
> on the
> client. Is our understanding is correct?


First: on sdm845 the software doesn't set the GPU clocks - we rely on the GMU
firmware to do that on our behalf but for the GPU at least this is an academic
exercise.

But that said: traditionally we've expected that the clock driver correctly
clamp the requested rate to the correct values. In the past we have taken
advantage of this and we may in the future. I don't think it is reasonable
to require the leaf driver to only pass "approved" frequencies especially
since we depend on our own OPP table that may or may not be similar to the
one used by the clock driver.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
