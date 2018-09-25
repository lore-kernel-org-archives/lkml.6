Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B56C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9432098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Adkc6W7N";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PKFg/L1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9432098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeIYRYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:24:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYRYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:24:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 82396608C9; Tue, 25 Sep 2018 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537874261;
        bh=nMZp3HAyLR8XPSACPXnZfhTDG/5/QUipwzrpOJ9zWqA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Adkc6W7NJtd4ZaxrIRS/v41fmx/TTzMng+BUcV5qzUAZQ2Wmqe8l5dVd2oNexJz1c
         57Un7dvxz+xC3FnDjAZXJ7husw/ECEjP8bj/nToPN2E/ifNlsZQiQ9xrDZBgRPJch8
         Q9lUKd5oV7BFJ1SWD45L4gM3IHOOcDqDfSAsxHY4=
Received: from [10.206.25.139] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 492E3606DC;
        Tue, 25 Sep 2018 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537874260;
        bh=nMZp3HAyLR8XPSACPXnZfhTDG/5/QUipwzrpOJ9zWqA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PKFg/L1flmT8dG7weO/69ZWWJNRH3vYAUom9NbsVyWhU+NTxz1oGWDY9Pe06GqBwq
         3CAf5oBG76mdrh31c/6XPF9vB2+LoZpIw2L4xB2X1hkrtMsFqSxXBekRuU6OFyPQY6
         qP8dNiriBQ+c3Fugz9OS3KuF0fugUOQidEE8JTIc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 492E3606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
To:     Craig Tatlor <ctatlor97@gmail.com>,
        Vijay Viswanath <vviswana@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        dianders@google.com, sayalil@codeaurora.org
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
 <20180924194412.GA27477@arch>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <bcdeaf0c-fb04-67f5-8580-a3f5110bcba5@codeaurora.org>
Date:   Tue, 25 Sep 2018 16:47:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924194412.GA27477@arch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/25/2018 1:18 AM, Craig Tatlor wrote:
> What socs have you tested this on?
> On sdm660 it seems to crash device
> when writing pwr ctl.

Hi
We have tested this on SDM845.
SDM660 also has SDCC5 controller, so you would need to define
"qcom,sdhci-msm-v5" in your platform dt.
Can you confirm if you have defined this?

BTW, can you please share few details of the platform that you are checking?
We are not aware of any dev platform based on SDM660. This is just for 
my info.

> On Tue, Jun 19, 2018 at 11:09:17AM +0530, Vijay Viswanath wrote:
>> With SDCC5, the MCI register space got removed and the offset/order of
>> several registers have changed. Based on SDCC version used and the register,
>> we need to pick the base address and offset.
>>
>> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm"
>>
>> Changes since RFC:
>> 	Dropped voltage regulator changes in sdhci-msm
>> 	Split the "Register changes for sdcc V5" patch
>> 	Instead of checking mci removal for deciding which base addr to use,
>> 	new function pointers are defined for the 2 variants of sdcc:
>> 		1) MCI present
>> 		2) V5 (mci removed)
>> 	Instead of string comparing with the compatible string from DT file,
>> 	the sdhci_msm_probe will now pick the data associated with the
>> 	compatible entry and use it to load variant specific address offsets
>> 	and msm variant specific read/write ops.
>>
>> Changes since V1:
>> 	Removed unused msm_reab & msm_writeb APIs
>> 	Changed certain register addresses from uppercase to lowercase hex
>> 	letters
>> 	Removed extra lines and spaces
>> 	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
>> 	one for Documentation and other for the driver changes.
>>
>> Changes since V2:
>> 	Used lower case for macro function defenitions
>> 	Removed unused function pointers for msm_readb & msm_writeb
>>
>>
>> Sayali Lokhande (3):
>>    mmc: sdhci-msm: Define new Register address map
>>    Documentation: sdhci-msm: Add new compatible string for SDCC v5
>>    mmc: host: Register changes for sdcc V5
>>
>> Vijay Viswanath (1):
>>    mmc: sdhci-msm: Add msm version specific ops and data structures
>>
>>   .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
>>   drivers/mmc/host/sdhci-msm.c                       | 511 ++++++++++++++++-----
>>   2 files changed, 391 insertions(+), 127 deletions(-)
>>
>> -- 
>>   Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Veera
