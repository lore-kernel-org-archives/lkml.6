Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9AEC0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BA8208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="or1erH1/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i6Q82yUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BA8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbeKLNdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:33:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKLNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:33:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 86CB660115; Mon, 12 Nov 2018 03:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541994117;
        bh=/Rn5yaq86YEcXCaeCpXfezBnHTiUPT8S6LJaIk19ZWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=or1erH1/rkWn+A3fJqMpoH5alWUnrv002VKgby+ZP9F6TmmR15K3DvmbptkEFNLEY
         3Elwu626RuiXHidbNf19BDy2AMEmGfNlUGjYy9IXA7hibSqnsDsYFflsAfr/E2Pn4Z
         +JnGc9GM/qTj18se4UHSsxXR5DzVZmpgPUufWA4M=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CE404606DD;
        Mon, 12 Nov 2018 03:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541994116;
        bh=/Rn5yaq86YEcXCaeCpXfezBnHTiUPT8S6LJaIk19ZWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i6Q82yUknbYb9ekJhEgXb5c2GHDLasaFvwnAvWcTHEsHr+5RfqO4HmkqRLkXl0GLF
         R11U1tnrgdG7AKhk5OSi7iz/0e3lFl0rVXZBGh9Sve0dW3vzvhe+CEyaZbCtudLAXh
         hcNRTFkuxmI8V27LOnMdITleNR3LUlzkevWPXLKw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 11 Nov 2018 19:41:56 -0800
From:   chandanu@codeaurora.org
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v1 2/2] clk: qcom : dispcc: Add support for display port
 clocks
In-Reply-To: <154152409835.88331.14046185859724133804@swboyd.mtv.corp.google.com>
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
 <153911726378.119890.5522594539667887860@swboyd.mtv.corp.google.com>
 <3c4cccca-2c5c-927f-f471-2bbbd71b4155@codeaurora.org>
 <9c359e26-3708-14b6-f22a-fb529446d325@codeaurora.org>
 <154083859263.98144.15690571729193618604@swboyd.mtv.corp.google.com>
 <f3e40308-d2dd-cce9-4b19-3af419841bc1@codeaurora.org>
 <154091723693.98144.6979314028521443413@swboyd.mtv.corp.google.com>
 <9c82010f-f3fd-2867-352e-3584ab4ba8f0@codeaurora.org>
 <154152409835.88331.14046185859724133804@swboyd.mtv.corp.google.com>
Message-ID: <b3882909df919f084fc580fcaa88985d@codeaurora.org>
X-Sender: chandanu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-06 09:08, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-31 22:02:22)
>> + Chandan from Display Port team,
>> 
>> On 10/30/2018 10:03 PM, Stephen Boyd wrote:
>> > Also, those
>> > numbers look like gigabits per second (Gbit/s) for the DP spec which
>> > isn't exactly the same as a clk frequency. What frequency does the PLL
>> > run at for these various DP link speeds?
>> >
>> Could you please help with the above query from Stephen?

Hello Stephen,
For DP link speed of 5.4Gbit/s, the PLL will be running at 10.8 Ghz. For 
all
the other DP link speeds, the PLL will be running at 8.1 Ghz.

> 
> Can I safely assume that it matches the link rate shown on Wikipedia 
> for
> display port[1]? I.e.
> 
>  RBR (Reduced Bit Rate): 1.62 Gbit/s bandwidth per lane (162 MHz link
>  symbol rate)
>  HBR (High Bit Rate): 2.70 Gbit/s bandwidth per lane (270 MHz link
>  symbol rate)
>  HBR2 (High Bit Rate 2): 5.40 Gbit/s bandwidth per lane (540 MHz link
>  symbol rate), introduced in DP 1.2
>  HBR3 (High Bit Rate 3): 8.10 Gbit/s bandwidth per lane (810 MHz link
>  symbol rate), introduced in DP 1.3
> 
> So then they're MHz but the table is written in kHz when it should be
> written in Hz. Either way, the table can be removed and then we just
> need to fix the DP PHY PLL code to accept Hz instead of kHz.
> 
> [1] https://en.wikipedia.org/wiki/DisplayPort#Main_link

