Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F3DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8382184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X3Th7uAF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X3Th7uAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAXSYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:24:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35988 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAXSYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:24:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CD0BF6081E; Thu, 24 Jan 2019 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548354274;
        bh=sGhXTN4sVvxQchcKscYG3PbTsnzJFDPlFi6FXprtFCI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X3Th7uAF93Qr0Zh/GramsiAyOvYrnkeVk/yp+t11c75k1VXW3tQzHhIiSw92WO9PJ
         H1gLNnYvQ2cwhSVA67RpJ/QkSaPUvXH9fZqwMCn8KxLDDtZXOnx15wrbMboELtRYgc
         7XR9GDWhVs1/F31f0xwKoDsWxqDb2K4EVLhDHWRs=
Received: from [192.168.1.101] (unknown [157.45.230.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 498F36063A;
        Thu, 24 Jan 2019 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548354274;
        bh=sGhXTN4sVvxQchcKscYG3PbTsnzJFDPlFi6FXprtFCI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X3Th7uAF93Qr0Zh/GramsiAyOvYrnkeVk/yp+t11c75k1VXW3tQzHhIiSw92WO9PJ
         H1gLNnYvQ2cwhSVA67RpJ/QkSaPUvXH9fZqwMCn8KxLDDtZXOnx15wrbMboELtRYgc
         7XR9GDWhVs1/F31f0xwKoDsWxqDb2K4EVLhDHWRs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 498F36063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        John Horley <john.horley@arm.com>
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
 <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
 <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
 <CANLsYkxLJS-N0V4eOHM5rfe8MXMZHQApZFsDQns+DAS7xhGCoQ@mail.gmail.com>
 <71ae9f41-50ff-742b-3e12-ca2ce84e0d3c@codeaurora.org>
 <f246f0b1-896f-d51f-5327-14188c2cd1b4@free.fr>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <ab4ef233-ef46-e87e-55c5-923b6f65eb87@codeaurora.org>
Date:   Thu, 24 Jan 2019 23:54:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f246f0b1-896f-d51f-5327-14188c2cd1b4@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2019 9:37 PM, Marc Gonzalez wrote:
> On 23/01/2019 21:17, Sai Prakash Ranjan wrote:
> 
>> On 1/24/2019 12:44 AM, Mathieu Poirier wrote:
>>
>>> What version of the Kryo CPU?
>>
>> There is no Kryo version for MSM8996 (its only given as Kryo), MSM8998
>> onwards we have Kryo versions like Kryo 280 and so on. Hence I skipped
>> for this one and added the version for SDM845.
> 
> Speaking of MSM8998 (aka SDM835) ... could you take a stab at adding
> coresight support for that platform as well? ^_^
> 
> Regards.
> 

Sure Marc, I can do it on the next spin probably.

- Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
