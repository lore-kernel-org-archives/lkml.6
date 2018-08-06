Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3BFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82303219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ksKoqAPY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nNu2j0vO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82303219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeHFLPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:15:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeHFLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:15:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2EAF860807; Mon,  6 Aug 2018 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533546439;
        bh=dCMyyhmy6YII78/IdVPDxL3meKVAScQ/RCbXuniUclo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ksKoqAPYx/4GCPG9Jq9ZK1GV2EzNT6PV+U/AY9bTJkrYUPU6Bh+XkkMZq9WsTR2H8
         39k1r8psU0b0o9SOk1WvAsm5xh6uEnXZa5m0Go9FM3+chbHYyIWv+pntlJfNLkdRIW
         +MM87LQFznGxe1Q2OFFaIlMP3BlOyn7UcexETqtQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 94B6960807;
        Mon,  6 Aug 2018 09:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533546438;
        bh=dCMyyhmy6YII78/IdVPDxL3meKVAScQ/RCbXuniUclo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nNu2j0vOtWfsrOwuc7oqAf7r+dris4/qr115G8S+hOTXbpgFBzm6GRL1JuDe8Igdp
         JZ95S7cEcax337675X249klKiQBVN0uM0kYRffYBkaZJyINL+v52fnqhYTex8j1Zj/
         LgSTeJk59DcCxUWIqb1hEhz/O13azz03U81cCy0A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Aug 2018 14:37:18 +0530
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
In-Reply-To: <153324986956.10763.5124619734269160725@swboyd.mtv.corp.google.com>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
 <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
 <1e6d9fc284c3c118203728867f504ec6@codeaurora.org>
 <153250192252.48062.9210075387954345932@swboyd.mtv.corp.google.com>
 <07e0321116993d27d6585bd1a186328d@codeaurora.org>
 <153324986956.10763.5124619734269160725@swboyd.mtv.corp.google.com>
Message-ID: <ee2113c9dd6a44e9669e60f760c76409@codeaurora.org>
X-Sender: anischal@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 04:14, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-07-30 04:28:56)
>> On 2018-07-25 12:28, Stephen Boyd wrote:
>> >
>> > Ok. Sounds good! Is the rate range call really needed? It can't be
>> > determined in the PLL code with some table or avoided by making sure
>> > GPU
>> > uses OPP table with only approved frequencies?
>> >
>> 
>> Currently fabia PLL code does not have any table to check this and
>> intention
>> was to avoid relying on the client to call set_rate with only approved
>> frequencies so we have added the set_rate_range() call in the GPUCC
>> driver
>> in order to set the rate range.
>> 
> 
> But GPU will use OPP so it doesn't seem like it really buys us anything
> here. And it really doesn't matter when the clk driver implementation
> doesn't use the min/max to clamp the values of the round_rate() call. 
> Is
> that being done here? I need to double check. I would be more convinced
> if the implementation was looking at min/max to constrain the rate
> requested.
> 

So our understanding is that GPU(client) driver will always call the
set_rate with approved frequencies only and we can completely rely on 
the
client. Is our understanding is correct?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
