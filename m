Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B97C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD120660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UMyviwFB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OGpLhQi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfANGNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:13:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52620 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANGNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:13:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E7DE607F4; Mon, 14 Jan 2019 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547446384;
        bh=fW1r3TQqj2FVD409dPFR8ZPLfbWUYP9y0P5lXbVVAEY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UMyviwFBqlKo838J/ozNSQMuLzMf4WHLzWjNfcV8fgRYG4MZKna0hAv1TLIJS9WYG
         6SyKSXN+ZzsMxZYHilvKosH07rajJ6LS6XiTYM4I6ZakmUDMKCDFxQf8sF9bQ6ZfqT
         1aGoEYUKIyPcPLsX9vTNqUmXkNzTNADUFYoPaZNI=
Received: from [192.168.225.247] (unknown [49.32.202.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9E64607F4;
        Mon, 14 Jan 2019 06:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547446383;
        bh=fW1r3TQqj2FVD409dPFR8ZPLfbWUYP9y0P5lXbVVAEY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OGpLhQi9ehrmAgbF04J1kUxaU4kMj3Jd7f9WYq4WqIFjASeWZ+G3vEXByuFkMzKu4
         zuroMZqkXEAKJpeo4xmyV6Ro71rIfGXmC9DHqyl5dbGSK9hsSTwIk/2XtpsBEGr1LQ
         yOeFXVti+jLc0RsWN1Y1S8aaSNIm8FbMPQybIsto=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9E64607F4
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
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <adc9235a-3700-7730-a473-8a6baf47a1e0@codeaurora.org>
Date:   Mon, 14 Jan 2019 11:42:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154689507747.15366.6553307032295093169@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2019 2:34 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2019-01-06 22:26:00)
>> Hello Stephen,
>>
>> On 12/21/2018 2:34 AM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-12-20 03:46:25)
>>>> The LPASS clocks has a dependency on the GCC lpass clocks to be enabled
>>>> before accessing them and that was the reason to mark the gcc lpass clocks
>>>> as critical. But in the case where the lpass subsystem would require a
>>>> restart, toggling the lpass reset would from HW clear the SW enable bits
>>>> of the GCC lpass clocks. Thus the next time bringing up the lpass subsystem
>>>> out of reset would fail.
>>>>
>>>> Allow the lpass clock driver to enable/disable the gcc lpass clocks and
>>>> mark the lpass clocks not be accessed during late_init if no client vote.
>>>
>>> You need to add more details here. It feels like you wrote the beginning
>>> of a paragraph and then stopped abruptly, leaving the reader hanging for
>>> the whole story. Why is late_init important? Why do we need to leave
>>> them on from the bootloader? What if the bootloader doesn't leave them
>>> enabled? This is all rather hacky so I'm deeply confused. Does the lpass
>>> driver need to get these gcc clks and enable/prepare them during probe?
>>> But then it needs to also allow a reset happen and change the clk state?
>>>
>>> I suspect this situation is circling a larger problem where a reset is
>>> toggled and that changes some clk state without the clk framework
>>> knowing. There's not much we can do about that besides having some
>>> mechanism for the clks to know that their state is now out of sync. If
>>> that can be done on the provider driver side then we should have an
>>> easier time not needing to write a bunch of framework code to handle
>>> this. OMAP folks are dealing with the same problems from what I recall.
>>>
>>
>> Hmm, if I mark the CLK_IS_CRITICAL, I don't see a way to handle it in
>> provider. Please suggest if you think provider could handle it.
> 
> As far as I know, I'm not suggesting the use of CLK_IS_CRITICAL here.
> But removing CLK_IS_CRITICAL and relying on some random bootloader
> behavior also looks wrong. Can you clarify what's going on?
> 

To enable LPASS clocks the requirement is to enable the GCC_LPASS_SWAY 
clock.
1) If the LPASS drivers are enabled/probed before the clock late init 
the client would take care to maintain the dependency to enable the 
GCC_LPASS_SWAY clock before enabling the LPASS clocks.

2) There could be a condition where the LPASS drivers would probe/init 
later the clock late_init. When the clock_late_init would try to access 
the LPASS clocks, since we cannot maintain the dependency this access 
would fail. To avoid this the earlier patch has made the GCC_LPASS_SWAY 
clock as CRITICAL.

3) Marking the GCC_LPASS_SWAY clock as CRITICAL has a issue, in the case 
where the LPASS subsystem would be restarted due to some critical 
failure on LPASS. Toggling the restart register of LPASS would clear the 
hardware state of this clock and thus the next access of the LPASS 
clocks would result in failure of the system.

4) To avoid issues happening in (2) and (3) all the LPASS clocks chould 
be safely marked as CLK_IGNORE_UNUSED. And lpass drivers would take care 
of the dependency to enable the required clocks.

Hope the above helps.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
