Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D77C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AE420862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aJPcy2pV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ehRFKpQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AE420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbeG1Bkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 21:40:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388735AbeG1Bkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 21:40:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83AF760B15; Sat, 28 Jul 2018 00:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532736985;
        bh=bRnmGzBJyHYcn2UujAiPFLa15I//CXTIMObbK2W94LQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aJPcy2pVetyvx2YlvNpI2bgLquBkQRz9nNqnB1XahwsGTIy/niKUZbIs5mA4YEwX8
         iHch1WlrG3ghJcTEuqZQ14o2u7hEzrD20zAYy4lM1cR1Xa1ja6o2uTAmKnAwkPUpAB
         Xg7CZQMXve/quD4q1el7rb2UiovnGpXGTu+E3gzM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4BA1A60594;
        Sat, 28 Jul 2018 00:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532736984;
        bh=bRnmGzBJyHYcn2UujAiPFLa15I//CXTIMObbK2W94LQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ehRFKpQVDoL6IvojCyzNWiAIH0PZbBFuKFE9KIRFhnzhVAjRL4WJpDYvboTUjTNVa
         7tuo2RVlSYLIWkXglj9IYA2IEjjHQg9W88eCrVah6AMks4Mcbl3/TLl16lqPJGGiol
         gDJcKOMcv2iAByGDT+5NFWWJ9vQkZ9VwO0h+P/K8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Jul 2018 17:16:24 -0700
From:   skannan@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM / devfreq: Add support for QCOM devfreq firmware
In-Reply-To: <CAL_JsqL8W5219_rCQFCbo+Vc0Yv6HvrpXTpOpgixH4sNg7gg1w@mail.gmail.com>
References: <1526629965-28729-1-git-send-email-skannan@codeaurora.org>
 <20180522180838.GA13423@rob-hp-laptop> <5B0461D1.1050900@codeaurora.org>
 <CAL_JsqL8W5219_rCQFCbo+Vc0Yv6HvrpXTpOpgixH4sNg7gg1w@mail.gmail.com>
Message-ID: <5838c2cc0020af7e4c3aa9c92b9886d8@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-23 07:39, Rob Herring wrote:

Reviving an old thread. Sorry about the late reply. Got busy.

> On Tue, May 22, 2018 at 1:30 PM, Saravana Kannan 
> <skannan@codeaurora.org> wrote:
>> On 05/22/2018 11:08 AM, Rob Herring wrote:
>>> 
>>> On Fri, May 18, 2018 at 12:52:40AM -0700, Saravana Kannan wrote:
>>>> 
>>>> The firmware present in some QCOM chipsets offloads the steps 
>>>> necessary
>>>> for
>>>> changing the frequency of some devices (Eg: L3). This driver 
>>>> implements
>>>> the
>>>> devfreq interface for this firmware so that various governors could 
>>>> be
>>>> used
>>>> to scale the frequency of these devices.
>>>> 
>>>> Each client (say cluster 0 and cluster 1) that wants to vote for a
>>>> particular device's frequency (say, L3 frequency) is represented as 
>>>> a
>>>> separate voter device (qcom,devfreq-fw-voter) that's a child of the
>>>> firmware device (qcom,devfreq-fw).
>>>> 
>>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>>> ---
>>>>   .../bindings/devfreq/devfreq-qcom-fw.txt           |  41 +++
>>>>   drivers/devfreq/Kconfig                            |  14 +
>>>>   drivers/devfreq/Makefile                           |   1 +
>>>>   drivers/devfreq/devfreq_qcom_fw.c                  | 330
>>>> +++++++++++++++++++++
>>>>   4 files changed, 386 insertions(+)
>>>>   create mode 100644
>>>> Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>>>   create mode 100644 drivers/devfreq/devfreq_qcom_fw.c
>>>> 
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>>> b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>>> new file mode 100644
>>>> index 0000000..f882a0b
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>>> @@ -0,0 +1,41 @@
>>>> +QCOM Devfreq firmware device
>>>> +
>>>> +Some Qualcomm Technologies, Inc. (QTI) chipsets have a firmware 
>>>> that
>>>> +offloads the steps for frequency switching. It provides a table of
>>>> +supported frequencies and a register to request one of the 
>>>> supported
>>>> +freqencies.
>>>> +
>>>> +The qcom,devfreq-fw represents this firmware as a device. 
>>>> Sometimes,
>>>> +multiple entities want to vote on the frequency request that is 
>>>> sent to
>>>> the
>>>> +firmware. The qcom,devfreq-fw-voter represents these voters as 
>>>> child
>>>> +devices of the corresponding qcom,devfreq-fw device.
>>>> +
>>>> +Required properties:
>>>> +- compatible:          Must be "qcom,devfreq-fw" or
>>>> "qcom,devfreq-fw-voter"
>>> 
>>> 
>>> No versions of firmware?
>> 
>> 
>> Sure, I can add a v1. Right now the interface has always been 
>> identical. I
>> thought if it changed in the future I'll add -v2.
> 
> Sounds like you are making up version numbers. If you don't have real
> h/w or firmware version numbers, then use an SoC specific compatible
> string.
> 
>>>> +Only for qcom,devfreq-fw:
>>>> +- reg:                 Pairs of physical base addresses and region 
>>>> sizes
>>>> of
>>>> +                       memory mapped registers.
>>> 
>>> 
>>> Registers? Is this firmware or h/w block?
>> 
>> 
>> It's a HW block that has its own firmware.
> 
> So you have 2 things that could change: the h/w interface and the
> firmware version. Make sure the compatible string(s) is specific
> enough for the OS to know the exact combination.

For all practical purposes, the FW is opaque to the OS. It doesn't 
affect anything the OS can do with the IP block. So, the HW version is 
what matters. I'll figure out the actual HW version and use that.

>>>> +- reg-names:           Names of the bases for the above registers.
>>>> +                       Required register regions are:
>>>> +                       - "en-base": address of register to check if 
>>>> the
>>>> +                         firmware is enabled.
>>>> +                       - "ftbl-base": address region for the 
>>>> frequency
>>>> +                         table.
>>>> +                       - "perf-base": address of register to 
>>>> request a
>>>> +                         frequency.
>>>> +
>>>> +Example:
>>>> +
>>>> +       qcom,devfreq-l3 {
>>>> +               compatible = "qcom,devfreq-fw";
>>>> +               reg-names = "en-base", "ftbl-base", "perf-base";
>>>> +               reg = <0x18321000 0x4>, <0x18321110 0x600>, 
>>>> <0x18321920
>>>> 0x4>;
>>>> +
>>>> +               qcom,cpu0-l3 {
>>>> +                       compatible = "qcom,devfreq-fw-voter";
>>> 
>>> 
>>> There's no point in these nodes. They don't have any properties or
>>> resources.
>> 
>> 
>> These nodes decide how many voters this device supports. Each voter 
>> would be
>> a devfreq node that will have its own governor set. For example, one 
>> of them
>> would use this governor:
>> http://lkml.iu.edu/hypermail/linux/kernel/1805.2/02474.html
>> 
>> You can also attach different devfreq-event devices to each one of 
>> these
>> voter devices based on what events you want to use for scaling each 
>> voter.
>> So, the devices are definitely needed in the larger context.
> 
> Sorry, I still don't understand.

Ok, let me try to explain. Let's take L3 as an example. Different other 
IPs might have different requirements on the L3 frequency. For example, 
little CPUs might want L3 to run at 400 MHz, big CPUs might want L3 to 
run at 1000 MHz, GPU or some other peripheral might want L3 to run at 
800 MHz. The L3 freq needs to be set to max of these requests -- in this 
case 1000 MHz. I'm trying to represent each of these "votes" on L3 as a 
device. Once I register these with devfreq, each of these devices will 
have a devfreq device created for them (devfreq framework does this) and 
we can have different governors for each of these voters. So, I need 
these child devices to represent each voter. There's no getting around 
needing one device per voter and having to aggregate their votes into a 
parent device.

Does that make sense?

Thanks,
Saravana
