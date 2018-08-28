Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338FCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB002089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ib62ggPN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vmbm/ASy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB002089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeH1M5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:57:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeH1M5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:57:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 60B666021C; Tue, 28 Aug 2018 09:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535447203;
        bh=boyoPBWX0sBUCYwE5J8OaD2JwzNckJAUsN1dMXtK+1U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ib62ggPNMgibExVp+N4Qf8dmBsXyVErk5fk+JosmHVFJEqhdQAsyJwCstIC1StdU4
         6zqdgdQPoTX6hx/AKU6JN75JUHkj0AQdSy93cd1PjAGMbiadby3fath+u46zbW6KQA
         4315HrfE9lhWbc11HWVzTbRooT4uSIDwZ66yqJo0=
Received: from [192.168.225.247] (unknown [49.32.116.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81AAD6021C;
        Tue, 28 Aug 2018 09:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535447202;
        bh=boyoPBWX0sBUCYwE5J8OaD2JwzNckJAUsN1dMXtK+1U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vmbm/ASyazy5jKpI0PUonDS2QmMiw3eQ4IOSOSjr2+NkvLxku7QD6U5nj3rmM85eQ
         LAb1AUqsd0w6rE8A//zJ7HyT5c2CK8Cge9p5iVkxEyizDwG/iA8EUbVrbdCGIz7Q0w
         14IOoM0k0SefiL1FVazoyBzr49A1IMfqjMoPnA4g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81AAD6021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 0/2] clk: qcom: Add support for RCG to register for DFS
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533952436-17221-1-git-send-email-tdas@codeaurora.org>
 <153455835372.28926.7641705907931269497@swboyd.mtv.corp.google.com>
 <693d9cf4-4a6f-feb5-0c3f-ded842bbdf0a@codeaurora.org>
 <2db97037-b5f1-9234-862c-fa483b8aeb62@codeaurora.org>
 <153486545785.28926.5289007760649251969@swboyd.mtv.corp.google.com>
 <4cda3c7e-3ac3-af97-6d9f-24dd5a4efa28@codeaurora.org>
 <153504874119.28926.4197673432816461627@swboyd.mtv.corp.google.com>
 <153540388675.129321.14679244317392825384@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <531a5894-da72-fb38-dece-87a06c4ff7d6@codeaurora.org>
Date:   Tue, 28 Aug 2018 14:36:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153540388675.129321.14679244317392825384@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2018 2:34 AM, Stephen Boyd wrote:
> Quoting Stephen Boyd (2018-08-23 11:25:41)
>> Quoting Taniya Das (2018-08-22 03:28:31)
>>>
>>>>
>>>> Hmmmm. Ok. That won't work then. recalc_rate() better not try to
>>>> populate the frequency table then or it will not work. So I suppose it
>>>> needs to fallback to reading the registers and assuming the parent_rate
>>>> coming in is the actual frequency of it's parent until the frequency
>>>> table pointer is non-NULL. Would that work?
>>>>
>>> Yes that would work.
>>
>> Ok.
>>
>>>
>>>> BTW, does DFS switch parents without software knowing about it?
>>> DFS would not switch until a HW request is sent, but SW would be unware
>>> of the switch except the current_perf_state being updated with the
>>> requested level.
>>>
>>> What
>>>> happens in that case? Does the QUP driver make sure that the new parent
>>>> of this RCG is properly enabled so that it can switch to it when needed?
>>>
>>> I am not sure if they poll for any of their QUP HW state to make sure
>>> the switch is complete.
>>>
>>>> I'm still trying to understand this whole design. Who takes care of the
>>>> voltage requirements in this case? The QUP driver as well?
>>>>
>>>
>>> When the QUP driver requires to switch to new performance level, the
>>> first request would be to set_rate()(QUP driver would get the list of
>>> supported frequencies using the clk_round_rate()) which in QCOM clock
>>> driver would take care of setting the required voltage for the new
>>> parent switch.
>>
>> It would also make sure that the new parent is enabled if the QUP clk is
>> enabled. That's another concern. Does the PLL turn on automatically when
>> the RCG switches to it?
>>
>>> Then the QUP driver would request the HW for a new perf switch which
>>> would result to a DFS switch for the QUP clocks.
>>
>> It sounds like the QUP driver does half of the work via the clk APIs and
>> then the other half through the DFS register. Maybe the QUP driver
>> should be registering a clk as well for its DFS register so it can all
>> be clk API calls here. Something to consider. Anyway, that's not
>> important to this patch so here's the updated patch.
> 
> I've squashed this in and applied the patches.
> 
Thanks Stephen.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
