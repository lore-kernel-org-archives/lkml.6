Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E960ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34682208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oHkmtJ3z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e2CdToz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34682208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeGMIj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:39:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeGMIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:39:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 607EC60B6B; Fri, 13 Jul 2018 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531470350;
        bh=q+9mA2cCWRUVLdfSS8fbRg3vLFgnj6Xa1Tn/se3TMIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oHkmtJ3zvl03Bf60wnpd1of939IeC2LjmoaOLe1Vvhzgk2o0ct1y3JF1kKd/XPFcI
         jY/poYtaJLUL/bGdHOr4OE0DbLdIB7CAqPjslpIbxMNTm15v6+d4KcdgvClhbbpejb
         /leCshOmKlebXJ6grfQ/BXcP736nwxK8FNu6RVdM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AE4366060A;
        Fri, 13 Jul 2018 08:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531470349;
        bh=q+9mA2cCWRUVLdfSS8fbRg3vLFgnj6Xa1Tn/se3TMIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e2CdToz76Om73zomu4SRQrHoV/mDfNR3Qd3RiwfIa7GKep8y3IOpksfLlE9Z04zXH
         PJ1P0CcOT8dIlWkQCLgbAUowlJTYdg1zeguj78l7EnK+UqkabrfcXBWn4UDf0ktYGc
         pXm0A2TA7pzZx9KnN4zo/GglwVlkHj+7OvmYAxpg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Jul 2018 13:55:49 +0530
From:   spanda@codeaurora.org
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, ryadav@codeaurora.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for
 SDM845
In-Reply-To: <153142449680.48062.13809855257701591509@swboyd.mtv.corp.google.com>
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
 <153109408562.143105.15954380130353645468@swboyd.mtv.corp.google.com>
 <10f87216-caa2-d523-e134-6cf3acd268a7@codeaurora.org>
 <153111701079.143105.13387458941681113476@swboyd.mtv.corp.google.com>
 <436cc6a3-7406-c695-7879-3b9d042262cc@codeaurora.org>
 <153112184177.143105.15452587215679149679@swboyd.mtv.corp.google.com>
 <288770be-a763-b287-f62a-72ab7616efdb@codeaurora.org>
 <153114876561.143105.465317097490450694@swboyd.mtv.corp.google.com>
 <e0203471-85ef-456a-d7f3-85c66a82b8c1@codeaurora.org>
 <153142449680.48062.13809855257701591509@swboyd.mtv.corp.google.com>
Message-ID: <9509c88c112d59874e28459d8f87509f@codeaurora.org>
X-Sender: spanda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-13 01:11, Stephen Boyd wrote:
> Quoting Taniya Das (2018-07-12 10:21:33)
>> ++ Display driver team,
>> 
>> On 7/9/2018 8:36 PM, Stephen Boyd wrote:
>> > Quoting Taniya Das (2018-07-09 02:34:07)
>> >>
>> >>
>> >> On 7/9/2018 1:07 PM, Stephen Boyd wrote:
>> >>> Quoting Taniya Das (2018-07-09 00:07:21)
>> >>>>
>> >>>>
>> >>>> On 7/9/2018 11:46 AM, Stephen Boyd wrote:
>> >>>>>>
>> >>>>>>     > Why is the nocache flag needed? Applies to all clks in this file.
>> >>>>>>     >
>> >>>>>>
>> >>>>>> This flag is required for all RCGs whose PLLs are controlled outside the
>> >>>>>> clock controller. The display code would require the recalculated rate
>> >>>>>> always.
>> >>>>>
>> >>>>> Right. Why is the PLL controlled outside of the clock controller? The
>> >>>>> rate should propagate upward to the PLL from here, so who's going
>> >>>>> outside of that?
>> >>>>>
>> >>>> The DSI0/1 PLL are not part of the display clock controller, but in the
>> >>>> display subsystem which are managed by the DRM drivers. When DRM drivers
>> >>>> query for the rate clock driver should always return the non cached rates.
>> >>>
>> >>> Why? Is the DSI PLL changing rate all the time, randomly, without going
>> >>> through the clk APIs to do so?
>> >>>
>> >>
>> >> Hmm, I am afraid I do not have an answer for this, but this was the
>> >> requirement to always return the non cached rates from the clock driver.
>> >>
>> >
>> > Ok. Who knows about this requirement? Can we add someone from the
>> > display driver to understand more?
>> >
>> As per my discussions offline with the display teams,
>> 
>> There is a use-case where the clock framework is unaware of the PLL 
>> VCO
>> frequency change and thus the drivers would query to get the actual HW
>> frequency rather than the cached one.
>> 
>> Do you think keeping these flags would have any impact other than 
>> always
>> getting the non-cached rates?
>> 
> 
> The flag will make it so clk_get_rate() works in spite of something
> changing the frequency behind the framework's back, but I want to
> understand what and why it's changing without framework involvement. We
> shouldn't need the flag here, because this flag is typically for clks
> that are controlled by some other entity that the kernel doesn't have
> control over. In this case, it seems like we have full control of the
> clk tree for the display PLL down to this clk, so it should be 
> perfectly
> fine to not have this flag. The presence of the flag means that the
> display driver is doing something wrong.

These clocks are sourced from DSI PLL. In dsi command mode there is an 
idle use case when there
is no activity on display, we switch of the source DSI PLL to save power 
by calling clk_disable_unprepare().
In this scenario if some client queries the clk_get_rate(), then if 
NO_CACHE flag is used the clk
driver will return the cached rate which is some non-zero value set when 
we last called clk_set_rate(),
before enabling the clock, whereas actually in HW this clk is disabled. 
So we used the NO_CACHE flag
for the call to land in clk_recalc_rate and we return zero if the PLL is 
disabled.
I remember some customer had scripts that runs through all the clocks 
during idle screen scenario
and call clk_get_rate(), where they complained display clk_get_rate 
returns none zero value.


