Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF780C07E85
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D99214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dUFg9wcd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="atW9KhNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D99214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeLFBYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:24:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48394 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFBYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:24:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 840D4607B5; Thu,  6 Dec 2018 01:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544059469;
        bh=uPuVvwmlovBcz43fkaEatKqEB1zRkymirZeAXk5lStI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dUFg9wcdY9EJix4x+saoUWNTV9ELxoMekYLtHR3w9LM6ItydfEnVdTwevq4RRK7+x
         9ZltX5oAZR6iVUhU2vk6dxoE0EpD2oT5amGSfTg1nZwpEqAAm0wAQaMul4JE2sdcd5
         QuvQ22CAKTT6SPh5hTxWCxCNgDb9KHUbnRy5vrFI=
Received: from [10.46.162.234] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0099260397;
        Thu,  6 Dec 2018 01:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544059459;
        bh=uPuVvwmlovBcz43fkaEatKqEB1zRkymirZeAXk5lStI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=atW9KhNPgnH/SzcdygqTHtUuPAoD/7bUBdhGsB4iryiEjLEKahMlfr0JtkzjF/Xax
         FvYj3NITqMy/7ddMw2yr5OwjVDptbFK6dvcWs3BGQaE/HgFovFgIcpKg5NuxWvZx6A
         eUhGuvt2PoFZOhg5rYOJlic0v3KrDJ8eUvJrMVZE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0099260397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
To:     Stephen Boyd <sboyd@kernel.org>, Alex Elder <elder@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
 <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
 <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
 <8dafe631-4b16-94cd-392e-84728f2bb382@linaro.org>
 <154396284056.88331.12279283832884556349@swboyd.mtv.corp.google.com>
 <edeebce5-24a2-b844-6bff-781017949e2d@codeaurora.org>
 <154399414865.88331.2447825064224349951@swboyd.mtv.corp.google.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <6ffdf6ca-51b5-a968-bb4e-c4d6d46f63aa@codeaurora.org>
Date:   Wed, 5 Dec 2018 17:24:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154399414865.88331.2447825064224349951@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2018 11:15 PM, Stephen Boyd wrote:
> Quoting David Dai (2018-12-04 17:14:10)
>> On 12/4/2018 2:34 PM, Stephen Boyd wrote:
>>> Quoting Alex Elder (2018-12-04 13:41:47)
>>>> On 12/4/18 1:24 PM, Stephen Boyd wrote:
>>>>> Quoting David Dai (2018-12-03 19:50:13)
>>>>>> Add IPA clock support by extending the current clk rpmh driver to support
>>>>>> clocks that are managed by a different type of RPMh resource known as
>>>>>> Bus Clock Manager(BCM).
>>>>> Yes, but why? Does the IPA driver need to set clk rates and that somehow
>>>>> doesn't work as a bandwidth request?
>>>> The IPA core clock is a *clock*, not a bus.  Representing it as if
>>>> it were a bus, abusing the interconnect interface--pretending a bandwidth
>>>> request is really a clock rate request--is kind of kludgy.  I think Bjorn
>>>> and David (and maybe Georgi? I don't know) decided a long time ago that
>>>> exposing this as a clock is the right way to do it.  I agree with that.
>>>>
>>> But then we translate that clock rate into a bandwidth request to the
>>> BCM hardware? Seems really weird because it's doing the opposite of what
>>> you say is abusive. What does the IPA driver plan to do with this clk?
>>> Calculate a frequency by knowing that it really boils down to some
>>> bandwidth that then gets converted back into some clock frequency? Do we
>>> have the user somewhere that can be pointed to?
>> The clock rate is translated into a unitless threshold value sent as
>> part of the rpmh msg
>> that BCM takes to select a performance. In this case, the unit
>> conversion is based on
>> the unit value read from the aux data which is in Khz. I understand that
>> this wasn't
>> explicitly mentioned anywhere and I'll improve on that next patch.
> How is this different from bus bandwidth requests? In those cases the
> bandwidth is calculated in bits per second or something like that, and
> written to the hardware so it can convert that bandwidth into kHz and
> set a bus clk frequency in the clock controller? So in the IPA case
> we've skipped the bps to kHz conversion step and gone straight to the
> clk frequency setting part? Is a BCM able to aggregate units of
> bandwidth or kHz depending on how it's configured and this BCM is
> configured for kHz?

The data written to the hardware is just a 14bit scalar value that it 
takes to select a performance/frequency from a preset table. It's not 
really doing any sort of conversion in hardware in this case, instead 
the value is computed by software based on the aux data given. Think of 
it as a generic aggregator as opposed to being strictly bandwidth and 
the aggregator itself does not care what type of value it is(be it Khz 
or BW/s).

>
>> Here's a link to
>> the IPA driver implementation: https://lkml.org/lkml/2018/11/7/220
> Thanks for the link. It looks like the IPA driver hard codes a rate of
> 75 MHz.
>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

