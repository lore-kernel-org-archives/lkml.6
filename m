Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C87C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C406821834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hFPo1bQU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OJJ8eiOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C406821834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeHMJL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:11:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbeHMJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:11:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 31DD06079C; Mon, 13 Aug 2018 06:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534141839;
        bh=JFIoNl9Er/VoqPt1mhAeue2LOVGY0LIKAVioBD1huyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hFPo1bQUkpeUHnkwoB7mzhYXVHnTlA3Cnbpj2qg9puSeVHb0maBWjIlQWbBmsNipI
         LdzFrrh8/AnQPj1I/1YXmBmdTD45MNxHhfD6ZDigsU9EvdNzWK+MN8vNmr8UoRk6MU
         ITdsTaCIRavBQ4uMyF7xOZCfVKZnmf1syYdcj8JI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5D32C604BE;
        Mon, 13 Aug 2018 06:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534141838;
        bh=JFIoNl9Er/VoqPt1mhAeue2LOVGY0LIKAVioBD1huyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJJ8eiOCQEUYOTRP5Z9WFp2irf0Vl7nictFHq13rl0m1B/vY9iECBl70Ef61gZ1YN
         L3UGI8MNwyyHWD4zDkR9F/P7uVvKASnCLgEQ2rGQBtf4pFagDld8MBzLsTx+W0LeSZ
         oNf0RQ5vzS8/TIRoIJvkd7amwalSjIsWJf37aQ9c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Aug 2018 12:00:38 +0530
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
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
In-Reply-To: <153370789988.220756.1656616273823792690@swboyd.mtv.corp.google.com>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
 <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
 <1e6d9fc284c3c118203728867f504ec6@codeaurora.org>
 <153250192252.48062.9210075387954345932@swboyd.mtv.corp.google.com>
 <07e0321116993d27d6585bd1a186328d@codeaurora.org>
 <153324986956.10763.5124619734269160725@swboyd.mtv.corp.google.com>
 <ee2113c9dd6a44e9669e60f760c76409@codeaurora.org>
 <20180806150437.GE21283@jcrouse-lnx.qualcomm.com>
 <153370789988.220756.1656616273823792690@swboyd.mtv.corp.google.com>
Message-ID: <f8ccc09afc44c182a1b4add3dea4f437@codeaurora.org>
X-Sender: anischal@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-08 11:28, Stephen Boyd wrote:
> Quoting Jordan Crouse (2018-08-06 08:04:37)
>> On Mon, Aug 06, 2018 at 02:37:18PM +0530, Amit Nischal wrote:
>> > On 2018-08-03 04:14, Stephen Boyd wrote:
>> > >Quoting Amit Nischal (2018-07-30 04:28:56)
>> > >>On 2018-07-25 12:28, Stephen Boyd wrote:
>> > >>>
>> > >>> Ok. Sounds good! Is the rate range call really needed? It can't be
>> > >>> determined in the PLL code with some table or avoided by making sure
>> > >>> GPU
>> > >>> uses OPP table with only approved frequencies?
>> > >>>
>> > >>
>> > >>Currently fabia PLL code does not have any table to check this and
>> > >>intention
>> > >>was to avoid relying on the client to call set_rate with only approved
>> > >>frequencies so we have added the set_rate_range() call in the GPUCC
>> > >>driver
>> > >>in order to set the rate range.
>> > >>
>> > >
>> > >But GPU will use OPP so it doesn't seem like it really buys us anything
>> > >here. And it really doesn't matter when the clk driver implementation
>> > >doesn't use the min/max to clamp the values of the round_rate()
>> > >call. Is
>> > >that being done here? I need to double check. I would be more convinced
>> > >if the implementation was looking at min/max to constrain the rate
>> > >requested.
>> > >
>> >
>> > So our understanding is that GPU(client) driver will always call the
>> > set_rate with approved frequencies only and we can completely rely
>> > on the
>> > client. Is our understanding is correct?
>> 
>> 
>> First: on sdm845 the software doesn't set the GPU clocks - we rely on 
>> the GMU
>> firmware to do that on our behalf but for the GPU at least this is an 
>> academic
>> exercise.
> 
> So what is this GPU clk driver for then?
> 
>> 
>> But that said: traditionally we've expected that the clock driver 
>> correctly
>> clamp the requested rate to the correct values. In the past we have 
>> taken
>> advantage of this and we may in the future. I don't think it is 
>> reasonable
>> to require the leaf driver to only pass "approved" frequencies 
>> especially
>> since we depend on our own OPP table that may or may not be similar to 
>> the
>> one used by the clock driver.
>> 
> 
> Ok. Sounds like things can't be kept in sync between the clk driver and
> the OPP tables. Why is that hard to do?
> 
> Either way, I'd be fine if the code actually used the frequency limits
> to round the rate to something within range, but I don't recall seeing
> that being done here. So if the min/max limits stay, the clk driver
> should round to within that range.
> 

Thanks Stephen for your suggestion. I have modified the existing
determine_rate() op to use the min/max limits and round the requested
rate so that it stays withing the set_rate range. I will submit the
same in the next patch series.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
