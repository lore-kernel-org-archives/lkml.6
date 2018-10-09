Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D01C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24386213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dlxygLbp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ENhFX8r4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24386213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJINR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:17:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJINR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:17:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3408060D06; Tue,  9 Oct 2018 06:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539064932;
        bh=JfzbF1tXcuzUhd70We19sT1ZUU6HSDdMTqkDaSDO2bg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dlxygLbpPqSko66VaO6ip6NJQ7FVV43O+AqUDvLVKqV7dErnX6fTQMopxSkLq/Dq8
         nUcCe1sQnFPXtqERzF5Wp9U2em1P2DLrFvMt0WFraN0TGPHAM7AJb0yz9CmMZTAnFP
         TaTiJKWMP/bSZuf/Nfh6nHhpD7hPS2FMm7RfhtJc=
Received: from [10.206.25.139] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19296602D7;
        Tue,  9 Oct 2018 06:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539064931;
        bh=JfzbF1tXcuzUhd70We19sT1ZUU6HSDdMTqkDaSDO2bg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ENhFX8r4ctkN9csLUUw74iwXcUvJWXshu3cx0KmIi1a5WV7s0TU/L3JW37LEx9vxO
         zIn2qWYILX1O6T7WE8g7wH+PTdgB6TMwu1EX0EiMH/vkWMWUamSLEeobIvUD3lhJZI
         n+nNBw1v5clv8prGxGLtIomTmM+bxPyul5/zDS6A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19296602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Craig <ctatlor97@gmail.com>
Cc:     Vijay Viswanath <vviswana@codeaurora.org>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        riteshh@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
 <20180924194412.GA27477@arch>
 <bcdeaf0c-fb04-67f5-8580-a3f5110bcba5@codeaurora.org>
 <C01C1C07-13FA-4693-9493-2FAEE9153577@gmail.com>
 <74ABB71C-6B0C-44AE-BC30-1F385ADC3E42@gmail.com>
 <20181008065653.GB2550@tuxbook-pro>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <4881900d-c8e5-278f-012f-541ad13ffca8@codeaurora.org>
Date:   Tue, 9 Oct 2018 11:31:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008065653.GB2550@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


On 10/8/2018 12:26 PM, Bjorn Andersson wrote:
> On Sun 07 Oct 01:07 PDT 2018, Craig wrote:
>
>> Any updates on this?
>>
> FWIW I used qcom,sdhci-msm-v5 on QCS404 successfully.
>
> Regards,
> Bjorn

The base address and interrupt numbers needs to be updated in your dt.
you can refer the below link to update interrupt number and base address
https://android.googlesource.com/kernel/msm/+/android-msm-wahoo-4.4-oreo-m2/arch/arm/boot/dts/qcom/sdm660.dtsi

>> On 25 September 2018 16:39:33 BST, Craig <ctatlor97@gmail.com> wrote:
>>>
>>> On 25 September 2018 12:17:26 BST, Veerabhadrarao Badiganti
>>> <vbadigan@codeaurora.org> wrote:
>>>> On 9/25/2018 1:18 AM, Craig Tatlor wrote:
>>>>> What socs have you tested this on?
>>>>> On sdm660 it seems to crash device
>>>>> when writing pwr ctl.
>>>> Hi
>>>> We have tested this on SDM845.
>>>> SDM660 also has SDCC5 controller, so you would need to define
>>>> "qcom,sdhci-msm-v5" in your platform dt.
>>>> Can you confirm if you have defined this?
>>>>
>>> Hi,
>>> Yes my DT entry is as follows
>>>
>>> sdhc_1: sdhci@f9824900 {
Update this address. This could be the reason for the crash that you are 
observing.

>>>      
>>>               
>>> compatible = "qcom,sdhci-msm-v5";
>>>           
>>> reg = <0xc0c4000 0x1000>, <0xc0c5000 0x1000>;
>>>           
>>> interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>>>           

Please update this interrupt map aswell.

>>> interrupt-names = "pwr_irq";
>>>           
>>>                                                                        
>>> bus-width = <8>;
>>>           
>>> non-removable;
>>>           
>>>                                                                        
>>> vmmc-supply = <&pm660l_l4>;
>>>           
>>> vqmmc-supply = <&pm660_l8>;
>>>           
>>>                                                                        
>>> pinctrl-names = "default";
>>>           
>>> pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data &sdc1_rclk>;
>>>           
>>>                                                                        
>>> clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>>>           
>>> clock-names = "core", "iface";
>>>           
>>>         };
>>>
>>>> BTW, can you please share few details of the platform that you are
>>>> checking?
>>>> We are not aware of any dev platform based on SDM660. This is just for
>>>> my info
>>> I'm checking on the sony xperia xa2 (pioneer) smartphone.
>>>>> On Tue, Jun 19, 2018 at 11:09:17AM +0530, Vijay Viswanath wrote:
>>>>>> With SDCC5, the MCI register space got removed and the offset/order
>>>> of
>>>>>> several registers have changed. Based on SDCC version used and the
>>>> register,
>>>>>> we need to pick the base address and offset.
>>>>>>
>>>>>> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm:
>>> Configuring
>>>> IO_PAD support for sdhci-msm"
>>>>>> Changes since RFC:
>>>>>> 	Dropped voltage regulator changes in sdhci-msm
>>>>>> 	Split the "Register changes for sdcc V5" patch
>>>>>> 	Instead of checking mci removal for deciding which base addr to
>>>> use,
>>>>>> 	new function pointers are defined for the 2 variants of sdcc:
>>>>>> 		1) MCI present
>>>>>> 		2) V5 (mci removed)
>>>>>> 	Instead of string comparing with the compatible string from DT
>>>> file,
>>>>>> 	the sdhci_msm_probe will now pick the data associated with the
>>>>>> 	compatible entry and use it to load variant specific address
>>>> offsets
>>>>>> 	and msm variant specific read/write ops.
>>>>>>
>>>>>> Changes since V1:
>>>>>> 	Removed unused msm_reab & msm_writeb APIs
>>>>>> 	Changed certain register addresses from uppercase to lowercase hex
>>>>>> 	letters
>>>>>> 	Removed extra lines and spaces
>>>>>> 	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
>>>>>> 	one for Documentation and other for the driver changes.
>>>>>>
>>>>>> Changes since V2:
>>>>>> 	Used lower case for macro function defenitions
>>>>>> 	Removed unused function pointers for msm_readb & msm_writeb
>>>>>>
>>>>>>
>>>>>> Sayali Lokhande (3):
>>>>>>     mmc: sdhci-msm: Define new Register address map
>>>>>>     Documentation: sdhci-msm: Add new compatible string for SDCC v5
>>>>>>     mmc: host: Register changes for sdcc V5
>>>>>>
>>>>>> Vijay Viswanath (1):
>>>>>>     mmc: sdhci-msm: Add msm version specific ops and data structures
>>>>>>
>>>>>>    .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
>>>>>>    drivers/mmc/host/sdhci-msm.c                       | 511
>>>> ++++++++++++++++-----
>>>>>>    2 files changed, 391 insertions(+), 127 deletions(-)
>>>>>>
>>>>>> -- 
>>>>>>    Qualcomm India Private Limited, on behalf of Qualcomm Innovation
>>>> Center, Inc.
>>>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>>> a
>>>> Linux Foundation Collaborative Project.
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-arm-msm" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Thanks,
>>>> Veera
>> -- 
>> Sent from my Android device with K-9 Mail. Please excuse my brevity.

Thanks,
Veera
