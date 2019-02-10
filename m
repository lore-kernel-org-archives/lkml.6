Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADDBC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA5120863
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L8f1IlKa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mpb+WRBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfBJP64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:58:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBJP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 10:58:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A452B6085F; Sun, 10 Feb 2019 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549814334;
        bh=jmOHNU0CmRxZY54rSe05cXFEg36E2/HFEJVI9ZJsafA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L8f1IlKas4X4MazTn+BdSu/q5jp/9UcbLNVphyeCY+OwSDIZXG7O9wefEqV9QOVSB
         Y/B951Rc+FXcZkuHer+midAfi0ku2qHt13nTls9IA2RzpU/QqFTe5s+78owRnOaR6N
         289qChVqLb3d4gcjYFPl52RpzXJ6jLz5vAVlqpkU=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A44F60274;
        Sun, 10 Feb 2019 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549814332;
        bh=jmOHNU0CmRxZY54rSe05cXFEg36E2/HFEJVI9ZJsafA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mpb+WRBtqiPaqrBpr2gmJuT75zwDWludi0lcge+ZXHsBNPjDDFdglyorU0TUy8Mjs
         opo8VoSZX8Q6Oa/mEw96oiw/rM2zvGEY92grBKlGG9ECWN+CBdCLzeWWv+KiK4tyos
         HseoELyI3pbnKY0b1GhkLhzJUBlJaXLyh1GEdwCA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A44F60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <CGME20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c@epcas4p4.samsung.com>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
 <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
 <05d2d193-4181-12ce-b4fb-4e8dec5aef27@free.fr>
 <7610c262-1451-9bb2-48a6-4daf6f534f6c@free.fr>
 <42c86292-22e9-4c5e-d64d-bc6107af45bf@free.fr>
 <740e6332-b54f-ab62-915a-0aec6be450d3@samsung.com>
 <2a59c11a-037f-c8c3-235a-9b21183a0801@free.fr>
 <90f24b35-89b0-cea0-1ab3-13c2a419b138@samsung.com>
 <81b85f39-49b5-901b-ec79-19708509965e@codeaurora.org>
 <2c0e5f03-0bb8-e5db-b5de-790da439fcfe@samsung.com>
 <349da668-6bb5-fcf4-c3f2-f7f7e113ed67@codeaurora.org>
 <fb4c17d4-977f-7737-6c2c-016b9f024d6c@samsung.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <91a85bc0-0bea-d1fc-0352-ada0f6d9d75e@codeaurora.org>
Date:   Sun, 10 Feb 2019 08:58:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fb4c17d4-977f-7737-6c2c-016b9f024d6c@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/2019 1:42 AM, Alim Akhtar wrote:
> 
> 
> On 08/02/19 8:29 PM, Jeffrey Hugo wrote:
>> On 2/8/2019 2:09 AM, Alim Akhtar wrote:
>>> Hi Jeffrey,
>>>
>>> On 07/02/19 8:22 PM, Jeffrey Hugo wrote:
>>>> On 2/7/2019 1:50 AM, Alim Akhtar wrote:
>>>>> Hi Marc,
>>>>>
>>>>> On 06/02/19 9:22 PM, Marc Gonzalez wrote:
>>>>>> On 06/02/2019 16:27, Alim Akhtar wrote:
>>>>>>
>>>>>>> On 06/02/19 8:29 PM, Marc Gonzalez wrote:
>>>>>>>
>>>>>>>> [    2.405734] regulator_disable: ENTER vdd_l26
>>>>>>>> [    2.405958] regulator_disable: EXIT vdd_l26
>>>>>>>> [    2.406032]   regulator_set_load: vdd_l26 = 0 uA
>>>>>>>> [    3.930447] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode
>>>>>>>> 0x04 for idn 13 failed, index 0, err = -11
>>>>>>>> [    5.434358] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode
>>>>>>>> 0x04 for idn 13 failed, index 0, err = -11
>>>>>>>> [    6.938318] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode
>>>>>>>> 0x04 for idn 13 failed, index 0, err = -11
>>>>>>>> [    6.938414] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr_retry:
>>>>>>>> query attribute, idn 13, failed with error -11 after 3 retires
>>>>>>>> [    6.946959] ufshcd-qcom 1da4000.ufshc:
>>>>>>>> ufshcd_disable_auto_bkops: failed to enable exception event -11
>>>>>>>> [    6.958523] ufshcd-qcom 1da4000.ufshc: dme-peer-get: attr-id
>>>>>>>> 0x1587 failed 3 retries
>>>>>>>> [    6.967730] ufshcd-qcom 1da4000.ufshc: dme-peer-get: attr-id
>>>>>>>> 0x1586 failed 3 retries
>>>>>>>> [    6.975576] ufshcd-qcom 1da4000.ufshc: ufshcd_get_max_pwr_mode:
>>>>>>>> invalid max pwm tx gear read = 0
>>>>>>>> [    6.983306] ufshcd-qcom 1da4000.ufshc: ufshcd_probe_hba: Failed
>>>>>>>> getting max supported power mode
>>>>>>>> [    8.506314] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag:
>>>>>>>> Sending flag query for idn 3 failed, err = -11
>>>>>>>> [   10.010352] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag:
>>>>>>>> Sending flag query for idn 3 failed, err = -11
>>>>>>>> [   11.514313] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag:
>>>>>>>> Sending flag query for idn 3 failed, err = -11
>>>>>>>> [   11.514412] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry:
>>>>>>>> query attribute, opcode 5, idn 3, failed with error -11 after 3
>>>>>>>> retires
>>>>>>>> [   13.050354] ufshcd-qcom 1da4000.ufshc:
>>>>>>>> __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0,
>>>>>>>> err = -11
>>>>>>>> [   14.554313] ufshcd-qcom 1da4000.ufshc:
>>>>>>>> __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0,
>>>>>>>> err = -11
>>>>>>>> [   16.058313] ufshcd-qcom 1da4000.ufshc:
>>>>>>>> __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0,
>>>>>>>> err = -11
>>>>>>>> [   16.058421] ufshcd-qcom 1da4000.ufshc: ufshcd_read_desc_param:
>>>>>>>> Failed reading descriptor. desc_id 8, desc_index 0, param_offset 0,
>>>>>>>> ret -11
>>>>>>>> [   16.067654] ufshcd-qcom 1da4000.ufshc: ufshcd_init_icc_levels:
>>>>>>>> Failed reading power descriptor.len = 98 ret = -11
>>>>>>>> [   37.074334] ufshcd-qcom 1da4000.ufshc: link startup failed 1
>>>>>>>
>>>>>>> Can you check if your UFS device RESET_N is asserted correctly. It
>>>>>>> might
>>>>>>> be connected to some regulator and may be you can try keeping that
>>>>>>> regulator as "regulator-always-on" from your DT node.
>>>>>>
>>>>>> How do I check RESET_N? In software or hardware?
>>>>>>
>>>>> RST_N is the reset logic for UFS device core logic and it is input to
>>>>> the device from UFS host controller.So, in your platform please
>>>>> check if
>>>>> this line somehow connected to (pulled up) a PMIC supply. If that is
>>>>> the
>>>>> case, please keep that regulator ON and see if this issue is resolved.
>>>>
>>>> The reset line is routed though the global clock controller (GCC), and
>>>> must be explicitly asserted within the GCC to trigger a reset.  As far
>>>> as I am aware, Linux is not touching this.
>>>>
>>>> Additionally, I fail to see how if this was a reset issue, reverting
>>>> 60f0187031c0 would have any impact (which doing so addresses our issue)
>>>>
>>> OK, that's again implementation dependent and your platform used that
>>> way. My point was to make sure that reset part is ok, if reset/power is
>>> not proper to the UFS device core logic this kind of issues comes.
>>
>> We are following the Hardware Programming Guide written by the platform
>> designers with regard to UFS, including the reset logic.  I really don't
>> think the reset logic is an issue here.
>>
>>>
>>>>>> Do you think it is not a good idea to revert
>>>>>> 60f0187031c05e04cbadffb62f557d0ff3564490 ?
>>>>>>
>>>>> Please hold on till we understand the real cause of this issue. Or we
>>>>> have a consensuses for reverting the said commit.
>>>>> Thanks!
>>>>
>>>> Did you see https://lkml.org/lkml/2019/2/5/659 where I indicated VCCQ
>>>> powers components within the host controller, and by not setting load on
>>>> the regulator properly, we are likely undervolting those components due
>>>> to the current draw?
>>>>
>>> In theory may be true. But looks like we dont have a solid evidence yet
>>> (correct me if I am wrong or misunderstood anything here
>> The evidence seems simple.  We have properly described in DT all the
>> regulators that are consumed by the UFS host controller, and by
>> extension, the UFS storage chip as well.
>>
>> By default, with no kernel changes, UFS does not work.
>>
>> Marc and I debugged the issue, and found that the VCCQ regulator was not
>> being handled properly, and reverting the change we are discussing fixes
>> the the VCCQ regulator issue, and as a result UFS works.
>>
> Ok, fair, before we revert this patch, Marc can you try below patch, or
> let me know if you have already tried this and share your
> result/observation:
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index 50e9033aa7f6..b08e8d1ea0f3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -212,6 +212,7 @@
>                   vreg_l26a_1p2: l26 {
>                           regulator-min-microvolt = <1200000>;
>                           regulator-max-microvolt = <1200000>;
> +                       regulator-always-on;
>                   };
>                   vreg_l28_3p0: l28 {
>                           regulator-min-microvolt = <3008000>;
> ---
> 
> I believe "vreg_l26a_1p2" is supply for ufs's vccq.
> 
> check the result of this patch /wo reverting
> 60f0187031c05e04cbadffb62f557d0ff3564490
> 
>> Again, despite the fact that we may have a Samsung UFS storage chip,
>> which triggers the quirk, the UFS host controller which talks to that
>> chip requires VCCQ, therefore this quirk breaks us.
>>
>>> So that means its some short of hardware/board quirk, right?
>>
>> No
>>
>>> Can you please recheck the schematic and see what Bjorn is telling
>>> (about having right entries in the DT for regulator) resolve your issue?
>>
>> Already done.  The schematic defines vcc, vccq, and vccq2.  All of those
>> are listed in DT, and have been since Marc and I have been trying to
>> utilize UFS.
>>
>>>
>>> Marc, Can you disabled pmic on that board (hope your board boots with
>>> default PMIC supply) and see if this issue still occurs?
>>
>> The PMIC is required the boot the board.  I doubt the board will be
>> functional with the PMIC disabled.
>>
>>> I am just trying to understand and see what is the real cause.
>>
>> Our analysis is that VCCQ is required and
>> 60f0187031c05e04cbadffb62f557d0ff3564490 prevents the proper
>> configuration of VCCQ, thus a required resource (VCCQ) is not in the
>> proper state.
>>
> Not in proper state or vccq regulator is disabled?

Proper state.  The PHY also consumes VCCQ, so it should be on, however 
the regulators have multiple power savings states based on the amount of 
load expressed.  The amount of load the PHY puts on the regulator is 
minimal.  The load the controller puts on the regulator is significant 
(which would result in a non-default state that would consume more 
power), however the quirk prevents that load from being expressed, and 
thus the regulator is in the wrong state for the system needs.

>>>
>>> @Yaniv Gardi, will you be able to comment on reason for adding
>>> 60f0187031c05e04cbadffb62f557d0ff3564490 (any issue faced)?
>>>
>>
>>


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
