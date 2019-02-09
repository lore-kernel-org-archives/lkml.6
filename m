Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1707C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653B520818
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bYynaomj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBII7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 03:59:36 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40803 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBII7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 03:59:35 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190209085932epoutp017ab978bb827751046b0fbf69022ce65f~BpnX9-67Z0706107061epoutp01p
        for <linux-kernel@vger.kernel.org>; Sat,  9 Feb 2019 08:59:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190209085932epoutp017ab978bb827751046b0fbf69022ce65f~BpnX9-67Z0706107061epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549702772;
        bh=ILzyDak/DaK6fMBM1k5qIwX79tqKNdWK/wd1crLcuA8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bYynaomjkYjZzlR0KNDnuIenuAHa1eNykEAi8Eh6nL4wuGm4bdzPuSJXG6WV9nrya
         jBABuqR56B6r/sEQpe4vDErDXtUYuSVhpyblcwvlEOleaPXC5zs2uOwCbL2UZMar1+
         hsbN2gwvXmGhS4rqJoFiHVkzYhsVeWHjJIOJbBgg=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20190209085931epcas5p498b5330e21e399b9da8454087b402939~BpnXaPL7M1541215412epcas5p4x;
        Sat,  9 Feb 2019 08:59:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.4F.04137.3769E5C5; Sat,  9 Feb 2019 17:59:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190209085931epcas5p3c70a6582e7b70de7732c2495a598d1f4~BpnXA2ayM0255502555epcas5p3y;
        Sat,  9 Feb 2019 08:59:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190209085931epsmtrp22b8a104437b780f5466ffcae10587bba~BpnW-jYiN2525625256epsmtrp2H;
        Sat,  9 Feb 2019 08:59:31 +0000 (GMT)
X-AuditID: b6c32a4a-aefff70000001029-ac-5c5e9673c268
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.3D.03971.3769E5C5; Sat,  9 Feb 2019 17:59:31 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190209085929epsmtip2589223c03668fd8ac7e3d108b97ca2b1~BpnU856RX2161421614epsmtip2k;
        Sat,  9 Feb 2019 08:59:29 +0000 (GMT)
Subject: Re: [PATCH v3 5/5] Revert
 "scsi: ufs: disable vccq if it's not needed by UFS device"
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
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
From:   Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <fb4c17d4-977f-7737-6c2c-016b9f024d6c@samsung.com>
Date:   Sat, 9 Feb 2019 14:12:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <349da668-6bb5-fcf4-c3f2-f7f7e113ed67@codeaurora.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUwTQRTGM7vTZSFW14rhWe+KiUgEFcExUTSG6HolGv+AKIqNbAoCFbuC
        ZwxGVGzBgihqOcNlghFEKiKHhTZCEBFJQQweJEo8UOtRL6KJ0i5G/vu9ed/33nyTYWnFa5mS
        jdXuF3RadbyK8cK1Nr95C8ScnZELr7xYQv60B5G3w70M6bA4MMn5NEyTd0UZiHSWtzDk5MBF
        ijQWn6NIz0sNybJ0ehB7fR5DDH11DKl1dtIktfUbJo9LbjOrJvD2ng18bko35u1nMyjeWOmU
        8U8fNTJ8TccR3mxxIt55YwZ/utlAbfbc5rU8WoiPTRZ0gaG7vGKGH5XQiS0rDhrTHSgFdS/S
        I08WuCXQdd2O9ciLVXANCM7+qKGl4gsC+50uSiq+I2jKr6L+WZ4UtcqkRhOCoUwjIxUfEFg+
        pslcqklcFGRW9Lrt3lzBiOruQ/cWmjPT0P5zgHapGM4fnl00u+fKuVBo/653uzHnC4ZrJ908
        mYsAW4YDSZqJ0H55ELvYk1sN1uN6xsU05wP9g4WUxDPhxM1cdwrgaj1AbyylpYuHQWPqCw+J
        J8FQm3mUleB0NI0MYkc4DtLrg6Tjo1BW0IolXgnNPXnYJaE5P6iqD5RWjYeMX4OU5JRD2imF
        pJ4LJxy9o86pkGUwyCTmocXWPfpYbTLos13HmWiWaUwy05g0pjFpTP83FyFcgaYIiWKCRhCD
        ExdrhQMBojpBTNJqAnbvTbiB3N9v/vo6VP5goxVxLFKNk0ek7ohUyNTJ4qEEKwKWVnnLhfM7
        IxXyaPWhw4Jub5QuKV4QrWgqi1U+8vzp+dsVnEa9X4gThERB969LsZ7KFFS6zeNCp5WbfivO
        0vC8OuRVhU1viAsrLHbkfX1ozVL5mcKznf25ignBWhr7fCr5rU9hsCY0M8s34lfUmn2bZicX
        DN0LyVGXzgk3TrvKG+WrB8oIs45UvzdWCv7ZG27eX3qG8fkWX71sbZI5G9dsScOCcvhS37E9
        fVtbA998VqqwGKNeNJ/Wieq/sj4K1noDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSvG7xtLgYg08vhS3+nzS2ePnzKpvF
        6f3vWCymffjJbPF6QS+jxdllB9ksWu9PZ7LYs2gSk8WVx+kWE/efZbe4vGsOm0X39R1sFts+
        n2W2aDn2lcXixuKdbA78HpeveHvMbrjI4nG5r5fJo3/dZ1aPO9f2sHlsPl3tsWX/Z0aPz5vk
        PNoPdDMFcEZx2aSk5mSWpRbp2yVwZfy8tpi54KBtRX/PO8YGxouGXYycHBICJhK3Fxxj7WLk
        4hAS2M0o8XzqUUaIhLTE9Y0T2CFsYYmV/56zQxS9ZpRYdnMOWJGwQLxEX9MpsG4RgXmMEnuW
        LWABcZgFtjBLvJ30gw2i5TirRM+5ZiaQFjYBbYm707eA2bwCdhInv3WxgtgsAioS3WtbwWxR
        gQiJj0/3QdUISpyc+YQFxOYUcJI41NjFBmIzC5hJzNv8kBnCFpe49WQ+E4QtL9G8dTbzBEah
        WUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKjVUtzB+Pl
        JfGHGAU4GJV4eCNaYmOEWBPLiitzDzFKcDArifCmTomLEeJNSaysSi3Kjy8qzUktPsQozcGi
        JM77NO9YpJBAemJJanZqakFqEUyWiYNTqoExbt4V/gK/RbMO5i4usdjLv0pT/clt1tnJYo+s
        Lpqr80Wn37FfyXwl8KpfSkRicn7qJcb6phMFkcvLPm7auHL7ulItjg+fFTiPhdRusG79oHfj
        7UyRzb84dme8mVM3895hT6+7eZOn9jN92PBdMN3+2YFE0X2dHk81ZEJu6Ps7GVz70nf9TL+i
        EktxRqKhFnNRcSIAuu2TldICAAA=
X-CMS-MailID: 20190209085931epcas5p3c70a6582e7b70de7732c2495a598d1f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/19 8:29 PM, Jeffrey Hugo wrote:
> On 2/8/2019 2:09 AM, Alim Akhtar wrote:
>> Hi Jeffrey,
>>
>> On 07/02/19 8:22 PM, Jeffrey Hugo wrote:
>>> On 2/7/2019 1:50 AM, Alim Akhtar wrote:
>>>> Hi Marc,
>>>>
>>>> On 06/02/19 9:22 PM, Marc Gonzalez wrote:
>>>>> On 06/02/2019 16:27, Alim Akhtar wrote:
>>>>>
>>>>>> On 06/02/19 8:29 PM, Marc Gonzalez wrote:
>>>>>>
>>>>>>> [    2.405734] regulator_disable: ENTER vdd_l26
>>>>>>> [    2.405958] regulator_disable: EXIT vdd_l26
>>>>>>> [    2.406032]   regulator_set_load: vdd_l26 = 0 uA
>>>>>>> [    3.930447] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode
>>>>>>> 0x04 for idn 13 failed, index 0, err = -11
>>>>>>> [    5.434358] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode
>>>>>>> 0x04 for idn 13 failed, index 0, err = -11
>>>>>>> [    6.938318] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode
>>>>>>> 0x04 for idn 13 failed, index 0, err = -11
>>>>>>> [    6.938414] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr_retry:
>>>>>>> query attribute, idn 13, failed with error -11 after 3 retires
>>>>>>> [    6.946959] ufshcd-qcom 1da4000.ufshc:
>>>>>>> ufshcd_disable_auto_bkops: failed to enable exception event -11
>>>>>>> [    6.958523] ufshcd-qcom 1da4000.ufshc: dme-peer-get: attr-id
>>>>>>> 0x1587 failed 3 retries
>>>>>>> [    6.967730] ufshcd-qcom 1da4000.ufshc: dme-peer-get: attr-id
>>>>>>> 0x1586 failed 3 retries
>>>>>>> [    6.975576] ufshcd-qcom 1da4000.ufshc: ufshcd_get_max_pwr_mode:
>>>>>>> invalid max pwm tx gear read = 0
>>>>>>> [    6.983306] ufshcd-qcom 1da4000.ufshc: ufshcd_probe_hba: Failed
>>>>>>> getting max supported power mode
>>>>>>> [    8.506314] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag:
>>>>>>> Sending flag query for idn 3 failed, err = -11
>>>>>>> [   10.010352] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag:
>>>>>>> Sending flag query for idn 3 failed, err = -11
>>>>>>> [   11.514313] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag:
>>>>>>> Sending flag query for idn 3 failed, err = -11
>>>>>>> [   11.514412] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry:
>>>>>>> query attribute, opcode 5, idn 3, failed with error -11 after 3
>>>>>>> retires
>>>>>>> [   13.050354] ufshcd-qcom 1da4000.ufshc:
>>>>>>> __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0,
>>>>>>> err = -11
>>>>>>> [   14.554313] ufshcd-qcom 1da4000.ufshc:
>>>>>>> __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0,
>>>>>>> err = -11
>>>>>>> [   16.058313] ufshcd-qcom 1da4000.ufshc:
>>>>>>> __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0,
>>>>>>> err = -11
>>>>>>> [   16.058421] ufshcd-qcom 1da4000.ufshc: ufshcd_read_desc_param:
>>>>>>> Failed reading descriptor. desc_id 8, desc_index 0, param_offset 0,
>>>>>>> ret -11
>>>>>>> [   16.067654] ufshcd-qcom 1da4000.ufshc: ufshcd_init_icc_levels:
>>>>>>> Failed reading power descriptor.len = 98 ret = -11
>>>>>>> [   37.074334] ufshcd-qcom 1da4000.ufshc: link startup failed 1
>>>>>>
>>>>>> Can you check if your UFS device RESET_N is asserted correctly. It
>>>>>> might
>>>>>> be connected to some regulator and may be you can try keeping that
>>>>>> regulator as "regulator-always-on" from your DT node.
>>>>>
>>>>> How do I check RESET_N? In software or hardware?
>>>>>
>>>> RST_N is the reset logic for UFS device core logic and it is input to
>>>> the device from UFS host controller.So, in your platform please 
>>>> check if
>>>> this line somehow connected to (pulled up) a PMIC supply. If that is 
>>>> the
>>>> case, please keep that regulator ON and see if this issue is resolved.
>>>
>>> The reset line is routed though the global clock controller (GCC), and
>>> must be explicitly asserted within the GCC to trigger a reset.  As far
>>> as I am aware, Linux is not touching this.
>>>
>>> Additionally, I fail to see how if this was a reset issue, reverting
>>> 60f0187031c0 would have any impact (which doing so addresses our issue)
>>>
>> OK, that's again implementation dependent and your platform used that
>> way. My point was to make sure that reset part is ok, if reset/power is
>> not proper to the UFS device core logic this kind of issues comes.
> 
> We are following the Hardware Programming Guide written by the platform 
> designers with regard to UFS, including the reset logic.  I really don't 
> think the reset logic is an issue here.
> 
>>
>>>>> Do you think it is not a good idea to revert
>>>>> 60f0187031c05e04cbadffb62f557d0ff3564490 ?
>>>>>
>>>> Please hold on till we understand the real cause of this issue. Or we
>>>> have a consensuses for reverting the said commit.
>>>> Thanks!
>>>
>>> Did you see https://lkml.org/lkml/2019/2/5/659 where I indicated VCCQ
>>> powers components within the host controller, and by not setting load on
>>> the regulator properly, we are likely undervolting those components due
>>> to the current draw?
>>>
>> In theory may be true. But looks like we dont have a solid evidence yet
>> (correct me if I am wrong or misunderstood anything here
> The evidence seems simple.  We have properly described in DT all the 
> regulators that are consumed by the UFS host controller, and by 
> extension, the UFS storage chip as well.
> 
> By default, with no kernel changes, UFS does not work.
> 
> Marc and I debugged the issue, and found that the VCCQ regulator was not 
> being handled properly, and reverting the change we are discussing fixes 
> the the VCCQ regulator issue, and as a result UFS works.
> 
Ok, fair, before we revert this patch, Marc can you try below patch, or 
let me know if you have already tried this and share your 
result/observation:

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi 
b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 50e9033aa7f6..b08e8d1ea0f3 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -212,6 +212,7 @@
                 vreg_l26a_1p2: l26 {
                         regulator-min-microvolt = <1200000>;
                         regulator-max-microvolt = <1200000>;
+                       regulator-always-on;
                 };
                 vreg_l28_3p0: l28 {
                         regulator-min-microvolt = <3008000>;
---

I believe "vreg_l26a_1p2" is supply for ufs's vccq.

check the result of this patch /wo reverting 
60f0187031c05e04cbadffb62f557d0ff3564490

> Again, despite the fact that we may have a Samsung UFS storage chip, 
> which triggers the quirk, the UFS host controller which talks to that 
> chip requires VCCQ, therefore this quirk breaks us.
> 
>> So that means its some short of hardware/board quirk, right?
> 
> No
> 
>> Can you please recheck the schematic and see what Bjorn is telling
>> (about having right entries in the DT for regulator) resolve your issue?
> 
> Already done.  The schematic defines vcc, vccq, and vccq2.  All of those 
> are listed in DT, and have been since Marc and I have been trying to 
> utilize UFS.
> 
>>
>> Marc, Can you disabled pmic on that board (hope your board boots with
>> default PMIC supply) and see if this issue still occurs?
> 
> The PMIC is required the boot the board.  I doubt the board will be 
> functional with the PMIC disabled.
> 
>> I am just trying to understand and see what is the real cause.
> 
> Our analysis is that VCCQ is required and 
> 60f0187031c05e04cbadffb62f557d0ff3564490 prevents the proper 
> configuration of VCCQ, thus a required resource (VCCQ) is not in the 
> proper state.
> 
Not in proper state or vccq regulator is disabled?
>>
>> @Yaniv Gardi, will you be able to comment on reason for adding
>> 60f0187031c05e04cbadffb62f557d0ff3564490 (any issue faced)?
>>
> 
> 
