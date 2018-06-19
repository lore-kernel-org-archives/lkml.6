Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E630C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B1020874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S0TckD8X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NWTLe8UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B1020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937408AbeFSHx2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:53:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937236AbeFSHx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:53:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2CA7360B18; Tue, 19 Jun 2018 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529394806;
        bh=RPUJ8AILVZQ8jx+vpPcIY6VPeDI38fVfgWoanULBXxw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S0TckD8XXestAShcRZLZxcIIhz2/tJ0J9CiSpwNaAxJ/wo0cldjbNEFUokh4ssX/m
         8n1XL9NTK/Ns5HnnpwjxtS23/bW6T0DI+hjspxam9eAPpF1xJ2Dtftnztm7tCQyTCn
         7SD6Jdf/moS5aNEaTSaePXFfQBZZ/kiDWxN0H7zI=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C19B604A6;
        Tue, 19 Jun 2018 07:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529394805;
        bh=RPUJ8AILVZQ8jx+vpPcIY6VPeDI38fVfgWoanULBXxw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NWTLe8UHI2Kcw5Myc46gh2JtWH59m9MANc0mE4196ETemD3UjUAbf9s1kOCSNbvVP
         c/KILq5jEU1ztTzb7QYA2cexSHRUvJUHKTFBM32PTCHODiupxkMYQF4he5mgIoczt8
         oNmhkAuUVBgZao4NsJMtJtCvz1vKWq7Mh0yzjE1o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C19B604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
 <fad24065-bb2d-33f9-e877-425db3391e8f@arm.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <514eea88-1f98-7959-2341-3d57cff6f66b@codeaurora.org>
Date:   Tue, 19 Jun 2018 13:23:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fad24065-bb2d-33f9-e877-425db3391e8f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2018 2:51 PM, Sudeep Holla wrote:
> 
> 
> On 15/06/18 18:40, Taniya Das wrote:
>>
>>
>> On 6/15/2018 5:29 PM, Amit Kucheria wrote:
> 
> [...]
> 
>>> A future version of the HW engine, or more likely, a firmware
>>> revision, will make more functionality available. Say, this needs
>>> access to another register or two. This will require changing the DT
>>> bindings. Instead, if you map the entire address space, you can just
>>> add offsets to the new registers.
>>>
>>> So in this case, I think you should define the following addresses
>>> (size 0x1400) for the two frequency domains
>>>
>>> 0x17d43000, 0x1400 (power cluster)
>>> 0x17d45800, 0x1400 (perf cluster)
>>>
>>> And in the driver simply add offsets as follows:
>>>
>>> #define ENABLE_OFFSET               0x0
>>> #define LUT_OFFSET                      0x110
>>> #define PERF_DESIRED_OFFSET 0x920
>>>
>>
>> The offsets could vary across versions of this IP and that is the reason
>> to provide them through the DT and not define any such offsets.
>>
> 
> Just get compatibles to identify the version of the hardware if it can't
> be probed and detected. Please don't use DT to get the addresses of each
> register you use in the driver. That's neither scalable nor nice
> solution to the problem.
> Hello Sudeep and Amit,

Thanks for the comments, I am consolidating the understanding from the 
other emails in a single one.

I understand that you are looking for this IP to map the full region and 
define offsets according to access them.

But I still not sure how do you want this common driver to scale in the 
cases where the offsets could vary across version change.

  DT
====
   freq-node {
	reg = < X x_size>;   Where X is the start of the IP address.
   }

Driver code (The below representation is just for example).
=============

V1
#define ENABLE	0x0
#define LUT_V1	0x110
#define PERF_V1	0x920

V2
#define LUT_V2	0x150
#define PERF_V2	0x980

V3
#define LUT_V3	0x120
....

Do you want me to use "compatible" flag to

if (compatible == v1)
  enable =  readl_relaxed(X + LUT_V1);
else if (compatible == v2)
  enable = readl_relaxed(X + LUT_V2);
else if (compatible == v3)
  enable = readl_relaxed(X + LUT_V2);

With the current design I do not need such compatible checks and unmap 
the ones which are not required after probe. Please let me know your 
comments.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
