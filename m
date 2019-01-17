Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D408AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A912054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I6mXoR1P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PvnaG38v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfAQLTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:19:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfAQLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:19:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7ED3260807; Thu, 17 Jan 2019 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547723992;
        bh=BCZR8UQDjYKKai5NpFpjklSk3mT5UK7jcQhOw69F3T4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I6mXoR1Py35p+W8awHHCCTQ5O3N3x+hJ85aAFLdWbaki6d9UOzgn77Z34TT9gQxCM
         ir8bwOGvZIQ1w2h9laY5cAC0SY8DLYRP84aZ0+EHGAry4gy3R/Ac+oKDyMfBSbVq/4
         TMkyXSMKnudlnAGBlXDegwY5mCwZozbu8my3VsPg=
Received: from [192.168.225.247] (unknown [49.33.245.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0829606E1;
        Thu, 17 Jan 2019 11:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547723991;
        bh=BCZR8UQDjYKKai5NpFpjklSk3mT5UK7jcQhOw69F3T4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PvnaG38vg/6+ek02L4IMa++e5aBViaSvZFpYNbGnpQdtDsiWjg6U9JAUHAdWey+8u
         R/A//gAWyh6XJtQvLJ4glViqXb5ZGZ26lClXYpBHeVX0LHlfi0H4NhfEjJFMIu6wDb
         /gICebHf3rzt2KhUm1fcF8/14wrsMJWZ9rcI4Cs0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0829606E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1] clk: qcom: lpass: Add CLK_IGNORE_UNUSED for lpass
 clocks
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1545306385-31240-1-git-send-email-tdas@codeaurora.org>
 <154533989563.79149.10213938035592547726@swboyd.mtv.corp.google.com>
 <b6397ef1-a6df-0040-9dcc-c491b76a2f8f@codeaurora.org>
 <154689507747.15366.6553307032295093169@swboyd.mtv.corp.google.com>
 <adc9235a-3700-7730-a473-8a6baf47a1e0@codeaurora.org>
 <154750471090.169631.5712250327468594228@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <6ad2f27c-0afc-af6a-8198-679a88dcc2f9@codeaurora.org>
Date:   Thu, 17 Jan 2019 16:49:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154750471090.169631.5712250327468594228@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/2019 3:55 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2019-01-13 22:12:39)
>>
>>
>> On 1/8/2019 2:34 AM, Stephen Boyd wrote:
>>>
>>> As far as I know, I'm not suggesting the use of CLK_IS_CRITICAL here.
>>> But removing CLK_IS_CRITICAL and relying on some random bootloader
>>> behavior also looks wrong. Can you clarify what's going on?
>>>
>>
>> To enable LPASS clocks the requirement is to enable the GCC_LPASS_SWAY
>> clock.
>> 1) If the LPASS drivers are enabled/probed before the clock late init
>> the client would take care to maintain the dependency to enable the
>> GCC_LPASS_SWAY clock before enabling the LPASS clocks.
>>
>> 2) There could be a condition where the LPASS drivers would probe/init
>> later the clock late_init. When the clock_late_init would try to access
>> the LPASS clocks, since we cannot maintain the dependency this access
>> would fail. To avoid this the earlier patch has made the GCC_LPASS_SWAY
>> clock as CRITICAL.
>>
>> 3) Marking the GCC_LPASS_SWAY clock as CRITICAL has a issue, in the case
>> where the LPASS subsystem would be restarted due to some critical
>> failure on LPASS. Toggling the restart register of LPASS would clear the
>> hardware state of this clock and thus the next access of the LPASS
>> clocks would result in failure of the system.
>>
>> 4) To avoid issues happening in (2) and (3) all the LPASS clocks chould
>> be safely marked as CLK_IGNORE_UNUSED. And lpass drivers would take care
>> of the dependency to enable the required clocks.
>>
> 
> Ok, so why can't we enable/disable the lpass sway clk in the
> prepare/unprepare phase of the lpass clk driver paths? Or why can't we
> forcibly enable this lpass sway clk after the reset is deasserted? Which
> clk controller is the reset part of? GCC or LPASS?

It is part of Always On Subsystem.

> 
> It still sounds like the LPASS clk driver isn't handling dependencies it
> has on accessing registers, but maybe we can get away with not handling
> the dependency still if we make the reset "do the right thing" and turn
> the clk back on so it stays "critical".
>

This is a reset from hardware and it does not bring back the clock to 
the previous state and so we can not mark it "critical". I would submit 
the next series with comments updated. Please let me know in case you 
have any comments.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
