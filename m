Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E91C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C829C21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EXvoUfxs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dzaVdsym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeLZJo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 04:44:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbeLZJo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 04:44:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6E67160559; Wed, 26 Dec 2018 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545817495;
        bh=RyM5XHEEwM9grgi2XBCQq4Xq//qjem2KxwzJCtOZKrg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EXvoUfxs+qqQNVkoFtzWb/e885hZ9jIz/hLMhJWRegAtmZxpwlWIkxLJHrcWj4StN
         PW77N9mS23qP3P7owTfybW/1cIVzrLTWdJVJPphyVUu40KBsYPltW4hZKW+1oR0AK/
         xwJUhM7NFU/n1zhUc1/uvLUU6sQFfNQ8DAwWPf6M=
Received: from [10.206.16.36] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E77426053B;
        Wed, 26 Dec 2018 09:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545817494;
        bh=RyM5XHEEwM9grgi2XBCQq4Xq//qjem2KxwzJCtOZKrg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dzaVdsymUeHj/VHQO9/UqvWTRZxm+DwW8jWHOVlcJ4Fiq86TLnjMmH9GSLEnqkfHW
         hJwx3MvU7qULHhF07ZcsQDRGkshTeYQYi4azIMeDUnrVHUQWQG5r8xb5Gn70aeetRj
         1xWeCRHEcPVM21lDVp8hv/pJtgHJyNM6NQikhRSM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E77426053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
To:     Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, devicetree@vger.kernel.org
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
Date:   Wed, 26 Dec 2018 15:14:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2018 1:09 PM, Stephen Boyd wrote:
>> +If an RSC needs to program next wake-up in the PDC timer, it must specify the
>> +binding as child node with the following properties:
>> +
>> +Properties:
>> +- compatible:
>> +    Usage: required
>> +       Value type: <string>
>> +       Definition: must be "qcom,pdc-timer".
>> +
>> +- reg:
>> +    Usage: required
>> +       Value type: <prop-encoded-array>
>> +       Definition: Specifies the offset of the control register.
>> +
>>   Example 1:
>>   
>>   For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
>> @@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
>>                        <0x179d0000 0x10000>,
>>                        <0x179e0000 0x10000>;
>>                  reg-names = "drv-0", "drv-1", "drv-2";
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges;
>>                  interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>>                               <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>>                               <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
>>                                    <SLEEP_TCS   3>,
>>                                    <WAKE_TCS    3>,
>>                                    <CONTROL_TCS 1>;
>> +
>> +               pdc_timer@38 {
>> +                       compatible = "qcom,pdc-timer";
>> +                       reg = <0x38 0x1>,
>> +                             <0x40 0x1>;
> I don't understand this whole binding. Why can't the pdc timer be
> programmed within the rpmh driver? This looks like a node is being added
> as a child just to make a platform driver and device match up in the
> linux kernel. And that in turn causes a regmap to need to be created?
> Sorry, it just looks really bad.


There are two RSC devices in SoC one for application processor subsystem 
& other display subsystem. Both RSC contain registers for PDC timers 
(one for each subsystem). But only for application processor the PDC 
timer needs to be programmed when application processor enters 
sleep/suspend. As the driver is common between both RSC devices, this 
approach is taken. Do you have any other suggestions to distinguish 
between the two? Perhaps, by additional compatible string?

Thanks for the review.

- Raju
