Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07162C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958FF2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FgSgqBro";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oRmmgyol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958FF2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJDTgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:36:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48410 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeJDTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:36:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DAFB560C8A; Thu,  4 Oct 2018 12:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538657011;
        bh=FmzgTWgi+ZEA3uEWblw+2fSeC7lFKq0pebJF1yG+zEE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FgSgqBrot4ewGwDwkdb637zcRsXnnsFq/kAhTLA6ZuCgVLbIocZXi7MQC8ZFmED2m
         vceImziI6CzFD7ONbB+Axh6cSBDOz8hLUw49onVNH5wSoSwbnOSqEG+DS6BMqLJGhB
         vNfSA9RHz3eykH1tLAftNgvGbz2WxWFDVHfYGqXY=
Received: from [10.206.24.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81258607BD;
        Thu,  4 Oct 2018 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538657010;
        bh=FmzgTWgi+ZEA3uEWblw+2fSeC7lFKq0pebJF1yG+zEE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oRmmgyol6KNV1BOkooIDYvW8OMrJxmbWWvMURslhAtwcKVE4c+Bqo6/NDbJhbuDmr
         bqjy2VxJRnG0ZQa3C47SJJ/aGl2barRweke9Ai6wQmRCNpyW26DU8RzzzQlPLIouy6
         Ab9JabQkBhx9sscwP4HLD4pfiooEatR+eXLTVu9k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81258607BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH RFC 2/7] mmc: core: devfreq: Add devfreq based clock
 scaling support
To:     Rob Herring <robh@kernel.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        mark.rutland@arm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        Talel Shenhar <tatias@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
 <1531475583-7050-3-git-send-email-sayalil@codeaurora.org>
 <20180720152436.GA4566@rob-hp-laptop>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <17490ba5-42f6-f1c1-cb5c-be315dfdf197@codeaurora.org>
Date:   Thu, 4 Oct 2018 18:13:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180720152436.GA4566@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 7/20/2018 8:54 PM, Rob Herring wrote:
> On Fri, Jul 13, 2018 at 03:22:58PM +0530, Sayali Lokhande wrote:
>> This change adds the use of devfreq to MMC.
>> Both eMMC and SD card will use it.
>> For some workloads, such as video playback, it isn't
>> necessary for these cards to run at high speed.
>> Running at lower frequency, for example 52MHz, in such
>> cases can still meet the deadlines for data transfers.
>> Scaling down the clock frequency dynamically has power
>> savings not only because the bus is running at lower frequency
>> but also has an advantage of scaling down the system core
>> voltage, if supported.
>> Provide an ondemand clock scaling support similar to the
>> cpufreq ondemand governor having two thresholds,
>> up_threshold and down_threshold to decide whether to
>> increase the frequency or scale it down respectively.
>> The sampling interval is in the order of milliseconds.
>> If sampling interval is too low, frequent switching of
>> frequencies can lead to high power consumption and if
>> sampling interval is too high, the clock scaling logic
>> would take long time to realize that the underlying
>> hardware (controller and card) is busy and scale up
>> the clocks.
>>
>> Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> ---
>>   .../devicetree/bindings/mmc/sdhci-msm.txt          |  10 +
>>   drivers/mmc/core/core.c                            | 560 +++++++++++++++++++++
>>   drivers/mmc/core/core.h                            |   7 +
>>   drivers/mmc/core/debugfs.c                         |  46 ++
>>   drivers/mmc/core/host.c                            |   8 +
>>   drivers/mmc/core/mmc.c                             | 200 +++++++-
>>   drivers/mmc/core/sd.c                              |  72 ++-
>>   drivers/mmc/host/sdhci-msm.c                       |  37 ++
>>   drivers/mmc/host/sdhci-pltfm.c                     |  11 +
>>   drivers/mmc/host/sdhci.c                           |  27 +
>>   drivers/mmc/host/sdhci.h                           |   8 +
>>   include/linux/mmc/card.h                           |   5 +
>>   include/linux/mmc/host.h                           |  70 +++
>>   13 files changed, 1059 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 502b3b8..bd8470a 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -26,6 +26,15 @@ Required properties:
>>   	"cal"	- reference clock for RCLK delay calibration (optional)
>>   	"sleep"	- sleep clock for RCLK delay calibration (optional)
>>   
>> +Optional Properties:
>> +- qcom,devfreq,freq-table - specifies supported frequencies for clock scaling.
>> +				    Clock scaling logic shall toggle between these frequencies based
>> +				    on card load. In case the defined frequencies are over or below
>> +				    the supported card frequencies, they will be overridden
>> +				    during card init. In case this entry is not supplied,
>> +				    the driver will construct one based on the card
>> +				    supported max and min frequencies.
>> +				    The frequencies must be ordered from lowest to highest.
> This should be a common binding in which case will just a list of
> frequencies be sufficient.
[Sayali] : Can you please elaborate more on what do you mean by common 
binding here ? Like if you are referring to any already available 
property (by devfreq ?) to pass min-max frequencies ?
Any Documentation file to refer ?
>
> Rob

