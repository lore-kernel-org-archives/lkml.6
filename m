Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E98C4363B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966082184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nCOclVH4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aS7nstyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfADFdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:33:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfADFdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:33:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2D8E6602FC; Fri,  4 Jan 2019 05:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546579995;
        bh=QfVDK0arXJGcMqczJKialiExv6QEPIjm00eAICy65tM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nCOclVH4NqMf0jncIMg8xna1LeYRD1OO4i3yUnWqZMx3cLeRMpPnWQRBKAn6UBFhV
         03cL22W5l/6rWZj5MBgNgIzGabspD5sqE2S1w/SAkwRgxzApKeG1aw44pJlbVGRCCC
         H5xH6phGBFlbIAhl9FR0w/8kzk07FcJFMdr7S9lI=
Received: from [10.79.129.4] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF36760364;
        Fri,  4 Jan 2019 05:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546579994;
        bh=QfVDK0arXJGcMqczJKialiExv6QEPIjm00eAICy65tM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aS7nstynPOwykpEwuJYVJKNkNpBKbHLNkngoX5xonHYDPNstBbvK7j51mUQ1sTlRT
         3GNJpVe3tYQyQPPSV8cNPS8vLbhup8z2pNIaSJvfordrtkblo/EzoyibwpZeiQad+m
         ay7IFy1XUTTeeny8YyK9IK0bdtWfP6yyJoNjzxa8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF36760364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v8 01/10] dt-bindings: opp: Introduce qcom-opp bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181221085622.25573-1-rnayak@codeaurora.org>
 <20181221085622.25573-2-rnayak@codeaurora.org>
 <CAL_Jsq+d=38WZ90i=HbUAQvNFvH-qLJEvw_H-g8kQegdw75FZA@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <5696a7ff-86ef-d751-525e-ff5e296b9b60@codeaurora.org>
Date:   Fri, 4 Jan 2019 11:03:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+d=38WZ90i=HbUAQvNFvH-qLJEvw_H-g8kQegdw75FZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/2019 12:13 AM, Rob Herring wrote:
> On Fri, Dec 21, 2018 at 2:56 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>> On Qualcomm Technologies, Inc. platforms, an OPP node needs
>> to describe an additional level/corner value that is then communicated
>> to a remote microprocessor by the CPU, which then takes some
>> actions (like adjusting voltage values across various rails)
>> based on the value passed.
>>
>> Describe these bindings in the qcom-opp bindings document.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> And rescinded...
> 
> [...]
> 
>> +Required properties:
>> +- qcom,level: On Qualcomm platforms an OPP node can describe a positive value
>> +representing a corner/level that's communicated with a remote microprocessor
>> +(usually called the RPM) which then translates it into a certain voltage on
>> +a voltage rail.
> 
> Now we have Mediatek adding mtk,level...[1]
> 
> Create something common. Just 'opp-level' perhaps.

Sure Rob, I will resubmit with something more generic so it can
be used across SoC vendors.
