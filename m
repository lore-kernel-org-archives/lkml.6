Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF4C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD54218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GoZ1FlVH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bczxgM06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfAXSb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:31:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAXSb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:31:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E0FAA607DD; Thu, 24 Jan 2019 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548354685;
        bh=xuCijXfAk1T6OPLysp/p8ggboqusyrHlNrRZbB6m2YU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GoZ1FlVHyqXkxe6hXTUgQEZMLvq098GyHyWVVbszi7V2AnI9D8M5imhWL6t8stIK0
         TeVp2KPtS9qAtxyolJA/E/nzUEwpnnbZKPcBuP3sUHj0GWV6V8dCsp90ufV/L91+pu
         W1SK0wg8WSXcJJwsVvzKFtifz97mYtQimkjgEkO4=
Received: from [192.168.1.101] (unknown [157.45.230.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47D62607DD;
        Thu, 24 Jan 2019 18:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548354681;
        bh=xuCijXfAk1T6OPLysp/p8ggboqusyrHlNrRZbB6m2YU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bczxgM06CzAj3VAkb4WKdTCBYr1skicRoHtFMgClfqu3IvwvFFE/Eix1/wbakfkLQ
         IWdSCkCczdR3JL7tb3joiy8gm4uE6QdJwczr2StwLlZpg+I/bCkSVWi7RmnEtcSPvw
         vvegSmzjQ1fKwbr1o+HD5qI/s1zRFRYdAvPhppY8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47D62607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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
 <CANLsYkyeG4mZTJbFPnAsTNpt_2OBy5JYP6g80rbmZv-F8KTrUA@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <1384cbbb-6e3e-f2e3-5ea4-8d0b237d64c7@codeaurora.org>
Date:   Fri, 25 Jan 2019 00:01:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkyeG4mZTJbFPnAsTNpt_2OBy5JYP6g80rbmZv-F8KTrUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Mathieu,

On 1/24/2019 9:37 PM, Mathieu Poirier wrote:
> Good day Sai,
> 
> On Wed, 23 Jan 2019 at 13:18, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
>> Hi Mathieu,
>>
>> On 1/24/2019 12:44 AM, Mathieu Poirier wrote:
>>> On Wed, 23 Jan 2019 at 05:12, Sai Prakash Ranjan
>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>
>>> That depends on whether the ETMs have been modified at all, something
>>> Suzuki has asked to be clarified.  If ETMs have been modified then we
>>> need to understand how they differ from the driver's implementation.
>>
>> We had asked hardware team for clarification regarding this. Let me
>> poke them again. As for the driver, downstream implementation also
>> uses the same driver, so I am not sure what do you mean by differing
>> from the driver's implementation.
> 
> The driver has been implemented in accordance to ARM's coresight
> technical reference manual and expects the HW to behave in accordance
> to that specification.  Here we want to make sure the IP on your board
> is conformant to the same specification.  If not then the driver needs
> to be made flexible to handle both kind IPs.
> 

The HW does behave as per the specification. As discussed in reply to
Suzuki, Coresight peripherals do use JEP106 ID of ARM for SDM845 and for 
MSM8996, the ID is of QCOM(0x70) since it was not based on any ARM 
derivative.
And the etm4x driver handles it all well. Other values of PID registers
are implementation defined and can be different from standard ARM cpu
core types.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
