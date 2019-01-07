Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E67EC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34128206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="muVIUbhx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="muVIUbhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfAGG0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:26:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAGG0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 01:26:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BCCFE6079C; Mon,  7 Jan 2019 06:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546842368;
        bh=NcvDkdHslQskU5FV0T++SVP5eAegMYAeilPH1q0w3X8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=muVIUbhxZs/TljBpG72XI4owXMJ6kMw+6EneYwx4GqtH2aRJDxtFXulBkhZEp8M2v
         uX2ZjGzYmyM0sHVaMuEKIn6t2pTAER+GsajnAv+e97K/Njs5pMsTfGpXpa2P13JrpO
         H2vsfmyFxeuZMD5cLOoiqO+Ev4x+DVAh78oqbZds=
Received: from [192.168.225.247] (unknown [49.33.229.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35AE96020A;
        Mon,  7 Jan 2019 06:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546842368;
        bh=NcvDkdHslQskU5FV0T++SVP5eAegMYAeilPH1q0w3X8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=muVIUbhxZs/TljBpG72XI4owXMJ6kMw+6EneYwx4GqtH2aRJDxtFXulBkhZEp8M2v
         uX2ZjGzYmyM0sHVaMuEKIn6t2pTAER+GsajnAv+e97K/Njs5pMsTfGpXpa2P13JrpO
         H2vsfmyFxeuZMD5cLOoiqO+Ev4x+DVAh78oqbZds=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35AE96020A
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
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <b6397ef1-a6df-0040-9dcc-c491b76a2f8f@codeaurora.org>
Date:   Mon, 7 Jan 2019 11:56:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154533989563.79149.10213938035592547726@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 12/21/2018 2:34 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-12-20 03:46:25)
>> The LPASS clocks has a dependency on the GCC lpass clocks to be enabled
>> before accessing them and that was the reason to mark the gcc lpass clocks
>> as critical. But in the case where the lpass subsystem would require a
>> restart, toggling the lpass reset would from HW clear the SW enable bits
>> of the GCC lpass clocks. Thus the next time bringing up the lpass subsystem
>> out of reset would fail.
>>
>> Allow the lpass clock driver to enable/disable the gcc lpass clocks and
>> mark the lpass clocks not be accessed during late_init if no client vote.
> 
> You need to add more details here. It feels like you wrote the beginning
> of a paragraph and then stopped abruptly, leaving the reader hanging for
> the whole story. Why is late_init important? Why do we need to leave
> them on from the bootloader? What if the bootloader doesn't leave them
> enabled? This is all rather hacky so I'm deeply confused. Does the lpass
> driver need to get these gcc clks and enable/prepare them during probe?
> But then it needs to also allow a reset happen and change the clk state?
> 
> I suspect this situation is circling a larger problem where a reset is
> toggled and that changes some clk state without the clk framework
> knowing. There's not much we can do about that besides having some
> mechanism for the clks to know that their state is now out of sync. If
> that can be done on the provider driver side then we should have an
> easier time not needing to write a bunch of framework code to handle
> this. OMAP folks are dealing with the same problems from what I recall.
> 

Hmm, if I mark the CLK_IS_CRITICAL, I don't see a way to handle it in 
provider. Please suggest if you think provider could handle it.

>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> 
>> @@ -77,6 +81,7 @@
>>                  .enable_mask = BIT(0),
>>                  .hw.init = &(struct clk_init_data){
>>                          .name = "lpass_qdsp6ss_sleep_clk",
>> +                       .flags = CLK_IGNORE_UNUSED,
> 
> All uses of CLK_IGNORE_UNUSED and CLK_IS_CRITICAL need comments about
> why they're there. It's never obvious why these things are being done.
> 

Sure, would add comments.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
