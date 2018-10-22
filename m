Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1AECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 04:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF6B20876
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 04:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ERwvKObS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MjFPXS0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF6B20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJVM0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 08:26:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60790 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJVM0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 08:26:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B34A66021C; Mon, 22 Oct 2018 04:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540181353;
        bh=z6FqOa/XSOoctBykfcv0+4BKYmTQ/5R9gT+O5WYx9V4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ERwvKObSibXb+l/YWzYSF/nF2CNyOtfn4E7hBRyauiWgZGKuEJH9pQBo10A3/J/OX
         eq+sb3K14E6RIT/Ghh9Fqgd/1xMNvaD6bGaY31JYrMaJOV15JmWx4bbEgFQze6+Yv7
         TqxH4isBU/uJ0oo8jUzcWbjL7Q3cigXn/3IZMPHU=
Received: from [10.201.3.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DBC56021C;
        Mon, 22 Oct 2018 04:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540181352;
        bh=z6FqOa/XSOoctBykfcv0+4BKYmTQ/5R9gT+O5WYx9V4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=MjFPXS0Gm9zS00CJUlDaR8kT5H+CTa1qJABtpJpRDLnYUzE/n8BM3r9nBmfSivREn
         5L1due8BXjRxNWLTSv4g2/Hfdw2hyewcvop8pEwWPkARH/Bd4C21DQo8rN2NImZifh
         15njT1YphE+i8OkCVAB0w3J7atxJSJWrzNM2YtX0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DBC56021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH V12 00/14] Krait clocks + Krait CPUfreq
To:     Stephen Boyd <sboyd@kernel.org>, Craig <ctatlor97@gmail.com>,
        andy.gross@linaro.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux@arm.linux.org.uk,
        linux@armlinux.org.uk, mark.rutland@arm.com,
        mturquette@baylibre.com, niklas.cassel@linaro.org,
        rjw@rjwysocki.net, robh@kernel.org, sboyd@codeaurora.org,
        sudeep.holla@arm.com, thierry.escande@linaro.org,
        viresh.kumar@linaro.org
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <2ae96741-94c0-ba4c-fc19-05d33179683c@codeaurora.org>
 <d682580d-5070-0271-197f-29d988172937@codeaurora.org>
 <D8FC68C0-2572-4A86-81D9-D0099D314A45@gmail.com>
 <F5A89365-C613-4FE2-AD32-DC0AC6DF380B@gmail.com>
 <fb81b8d5-3d24-b413-8d59-33cb70e46f8b@codeaurora.org>
 <153979105280.5275.841088095583550635@swboyd.mtv.corp.google.com>
 <153980741313.5275.10376918222904341760@swboyd.mtv.corp.google.com>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <c5f492c0-19a2-db8f-a114-d3cfe17ae6c6@codeaurora.org>
Date:   Mon, 22 Oct 2018 09:39:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153980741313.5275.10376918222904341760@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 10/18/2018 1:46 AM, Stephen Boyd wrote:
> Quoting Stephen Boyd (2018-10-17 08:44:12)
>> Quoting Sricharan R (2018-09-20 06:03:31)
>>>
>>>
>>> On 9/20/2018 1:54 AM, Craig wrote:
>>>> Yup, this patch seems to have fixed the higher frequencies from the quick test I did.
>>>>
>>>       Thanks !!. Can i take that as 
>>>           Tested-by: Craig Tatlor <ctatlor97@gmail.com>  ?
>>>
>>
>> Is this patch series going to be resent?
>>
> 
> Nevermind. Looking at it I think I can apply all the clk ones and we're
> good to go. If you can send a followup patch series to change the
> registration and provider APIs to be clk_hw instead of clk based I would
> appreciate it.
> 

Sorry for the late response. Was away.
Only pending thing was separating out the binding documentation for the cpu-freq
driver and fixing the text in documentation.  That means, yes its fine to merge
the clk ones as you said. I will resend that. Also, will send a follow up series for clk_hw to
clk change as you mentioned separately.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
