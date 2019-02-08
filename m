Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D374721919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aQ7OB7rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfBHJ05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:26:57 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:26090 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfBHJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:26:57 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190208092653epoutp01ae460bf63e7896909de73d4e360b491b~BWV9-XTuv0864408644epoutp01P
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 09:26:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190208092653epoutp01ae460bf63e7896909de73d4e360b491b~BWV9-XTuv0864408644epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549618013;
        bh=/osGjCP/IF1nqVYae3oO19JgqDdjWsozCv7WcZi5OJc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aQ7OB7rW9Z80H/M2aXeLRQv6LUx1iTOIMONkqkMTp1lO7SLj9blMTjIHJEXH+qefc
         J+iltpjvK5Rlu3hb55weOPVAkXRGRHhdunQsXn29Pb8P5uhlbuNlrU2n3cOWmnRY2h
         0M3RGyEDo073+Xt+hHrbhoYIniqA1iswrYKdXncw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20190208092651epcas5p2ecfdccde5217a76cba019df1c1438d86~BWV8lOsYr3065330653epcas5p24;
        Fri,  8 Feb 2019 09:26:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.F9.04135.B5B4D5C5; Fri,  8 Feb 2019 18:26:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208092651epcas5p1f9cb7f99e4cb7e31aec450fbb1b757f3~BWV7-fbiF0708407084epcas5p1g;
        Fri,  8 Feb 2019 09:26:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208092651epsmtrp234ab955b7abad1c9a4231b41e31ea0f3~BWV798Pis2940029400epsmtrp2s;
        Fri,  8 Feb 2019 09:26:51 +0000 (GMT)
X-AuditID: b6c32a49-bc7ff70000001027-56-5c5d4b5b7ad3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.45.03601.B5B4D5C5; Fri,  8 Feb 2019 18:26:51 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190208092649epsmtip126f5e992dbf3f4822f6ed4509b47caf7~BWV58y3PX1016110161epsmtip1w;
        Fri,  8 Feb 2019 09:26:49 +0000 (GMT)
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
Message-ID: <2c0e5f03-0bb8-e5db-b5de-790da439fcfe@samsung.com>
Date:   Fri, 8 Feb 2019 14:39:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <81b85f39-49b5-901b-ec79-19708509965e@codeaurora.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmum60d2yMweUL5hb/TxpbvPx5lc3i
        9P53LBbTPvxktni9oJfR4uyyg2wWrfenM1nsWTSJyeLK43SLifvPsltc3jWHzaL7+g42i22f
        zzJbtBz7ymJxY/FONgd+j8tXvD1mN1xk8bjc18vk0b/uM6vHnWt72Dw2n6722LL/M6PH501y
        Hu0HupkCOKO4bFJSczLLUov07RK4Mr5cfMxa8Eqj4lB3N1sD43HFLkZODgkBE4kzq54wdTFy
        cQgJ7GaUWPP8NZTziVGiv3cvM4TzjVFi9pZpjDAtr85uZoRI7GWUWHf1CQuE85ZR4tSR2cwg
        VcIC8RITVl0FmyUiMI9R4tXRC2BVzAJbmCVO/rgPVsUmoC1xd/oWoCoODl4BO4k9T7NAwiwC
        KhJf1+xgAbFFBSIkDve+A1vNKyAocXLmE7A4p4CTxNUZF5lAbGYBcYlbT+ZD2fISzVtng90t
        IbCLXWLSzw0sEHe7SLxd9grKFpZ4dXwLO4QtJfH53V42kBskBLIlenYZQ4RrJJbOOwZVbi9x
        4MocFpASZgFNifW79CFW8Un0/n7CBNHJK9HRJgRRrSrR/O4qVKe0xMTublYI20Pi4OGLbJCw
        usUicabvCMsERoVZSD6bheSbWUi+mYWweQEjyypGydSC4tz01GLTAsO81HK94sTc4tK8dL3k
        /NxNjODUp+W5g3HWOZ9DjAIcjEo8vBe0Y2KEWBPLiitzDzFKcDArifAmu8XGCPGmJFZWpRbl
        xxeV5qQWH2KU5mBREuedKzs3WkggPbEkNTs1tSC1CCbLxMEp1cCYLOgQqfK7jlVMR+iK+NZi
        aaMZDRw/faU3VIpxzq++dzsxoKHJRlrv0mT2r501job2M2+9kXR71W5eyvDnwUe/u4/qIvOO
        /rJ516N/QaWJ6+zlL5cFTGYHHb3WrnwtjMU97Zb3aq7LH/r5ubafO/9kxhKn8/amNmxeXe9l
        b2yo/8345njxg2YlluKMREMt5qLiRABV6eNheQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnG60d2yMwYoHvBb/TxpbvPx5lc3i
        9P53LBbTPvxktni9oJfR4uyyg2wWrfenM1nsWTSJyeLK43SLifvPsltc3jWHzaL7+g42i22f
        zzJbtBz7ymJxY/FONgd+j8tXvD1mN1xk8bjc18vk0b/uM6vHnWt72Dw2n6722LL/M6PH501y
        Hu0HupkCOKO4bFJSczLLUov07RK4Mr5cfMxa8Eqj4lB3N1sD43HFLkZODgkBE4lXZzczdjFy
        cQgJ7GaUaLmykhEiIS1xfeMEdghbWGLlv+fsEEWvGSW2vLwIlhAWiJfoazrFCpIQEZjHKLFn
        2QIWEIdZYAuzxNtJP9ggWm6xSGzoPsoG0sImoC1xd/oWpi5GDg5eATuJPU+zQMIsAioSX9fs
        YAGxRQUiJD4+3ccEYvMKCEqcnPkELM4p4CRxdcZFsDizgJnEvM0PmSFscYlbT+ZDxeUlmrfO
        Zp7AKDQLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcKxq
        ae1gPHEi/hCjAAejEg/vBe2YGCHWxLLiytxDjBIczEoivMlusTFCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGON52V4YHll57vs/racafRxHA/kOrng2
        83TTS/VJHK4bSsOjlFvDbOt3/ZScYrM6sWnVmX3qD91WLVyq6paXEnltpbRKxAbJzG+SSist
        yp5tTVG81npyU9+p8mVJhWdjeP09zdeHXoyNPG4wk0v5fShHBWOCxOtQS/n0uSc6M3dYFvxt
        nPbukhJLcUaioRZzUXEiAARqudLRAgAA
X-CMS-MailID: 20190208092651epcas5p1f9cb7f99e4cb7e31aec450fbb1b757f3
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

On 07/02/19 8:22 PM, Jeffrey Hugo wrote:
> On 2/7/2019 1:50 AM, Alim Akhtar wrote:
>> Hi Marc,
>>
>> On 06/02/19 9:22 PM, Marc Gonzalez wrote:
>>> On 06/02/2019 16:27, Alim Akhtar wrote:
>>>
>>>> On 06/02/19 8:29 PM, Marc Gonzalez wrote:
>>>>
>>>>> [    2.405734] regulator_disable: ENTER vdd_l26
>>>>> [    2.405958] regulator_disable: EXIT vdd_l26
>>>>> [    2.406032]   regulator_set_load: vdd_l26 = 0 uA
>>>>> [    3.930447] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode 
>>>>> 0x04 for idn 13 failed, index 0, err = -11
>>>>> [    5.434358] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode 
>>>>> 0x04 for idn 13 failed, index 0, err = -11
>>>>> [    6.938318] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode 
>>>>> 0x04 for idn 13 failed, index 0, err = -11
>>>>> [    6.938414] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr_retry: 
>>>>> query attribute, idn 13, failed with error -11 after 3 retires
>>>>> [    6.946959] ufshcd-qcom 1da4000.ufshc: 
>>>>> ufshcd_disable_auto_bkops: failed to enable exception event -11
>>>>> [    6.958523] ufshcd-qcom 1da4000.ufshc: dme-peer-get: attr-id 
>>>>> 0x1587 failed 3 retries
>>>>> [    6.967730] ufshcd-qcom 1da4000.ufshc: dme-peer-get: attr-id 
>>>>> 0x1586 failed 3 retries
>>>>> [    6.975576] ufshcd-qcom 1da4000.ufshc: ufshcd_get_max_pwr_mode: 
>>>>> invalid max pwm tx gear read = 0
>>>>> [    6.983306] ufshcd-qcom 1da4000.ufshc: ufshcd_probe_hba: Failed 
>>>>> getting max supported power mode
>>>>> [    8.506314] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: 
>>>>> Sending flag query for idn 3 failed, err = -11
>>>>> [   10.010352] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: 
>>>>> Sending flag query for idn 3 failed, err = -11
>>>>> [   11.514313] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: 
>>>>> Sending flag query for idn 3 failed, err = -11
>>>>> [   11.514412] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: 
>>>>> query attribute, opcode 5, idn 3, failed with error -11 after 3 
>>>>> retires
>>>>> [   13.050354] ufshcd-qcom 1da4000.ufshc: 
>>>>> __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, 
>>>>> err = -11
>>>>> [   14.554313] ufshcd-qcom 1da4000.ufshc: 
>>>>> __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, 
>>>>> err = -11
>>>>> [   16.058313] ufshcd-qcom 1da4000.ufshc: 
>>>>> __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, 
>>>>> err = -11
>>>>> [   16.058421] ufshcd-qcom 1da4000.ufshc: ufshcd_read_desc_param: 
>>>>> Failed reading descriptor. desc_id 8, desc_index 0, param_offset 0, 
>>>>> ret -11
>>>>> [   16.067654] ufshcd-qcom 1da4000.ufshc: ufshcd_init_icc_levels: 
>>>>> Failed reading power descriptor.len = 98 ret = -11
>>>>> [   37.074334] ufshcd-qcom 1da4000.ufshc: link startup failed 1
>>>>
>>>> Can you check if your UFS device RESET_N is asserted correctly. It 
>>>> might
>>>> be connected to some regulator and may be you can try keeping that
>>>> regulator as "regulator-always-on" from your DT node.
>>>
>>> How do I check RESET_N? In software or hardware?
>>>
>> RST_N is the reset logic for UFS device core logic and it is input to
>> the device from UFS host controller.So, in your platform please check if
>> this line somehow connected to (pulled up) a PMIC supply. If that is the
>> case, please keep that regulator ON and see if this issue is resolved.
> 
> The reset line is routed though the global clock controller (GCC), and 
> must be explicitly asserted within the GCC to trigger a reset.  As far 
> as I am aware, Linux is not touching this.
> 
> Additionally, I fail to see how if this was a reset issue, reverting 
> 60f0187031c0 would have any impact (which doing so addresses our issue)
> 
OK, that's again implementation dependent and your platform used that 
way. My point was to make sure that reset part is ok, if reset/power is 
not proper to the UFS device core logic this kind of issues comes.

>>> Do you think it is not a good idea to revert 
>>> 60f0187031c05e04cbadffb62f557d0ff3564490 ?
>>>
>> Please hold on till we understand the real cause of this issue. Or we
>> have a consensuses for reverting the said commit.
>> Thanks!
> 
> Did you see https://lkml.org/lkml/2019/2/5/659 where I indicated VCCQ 
> powers components within the host controller, and by not setting load on 
> the regulator properly, we are likely undervolting those components due 
> to the current draw?
> 
In theory may be true. But looks like we dont have a solid evidence yet 
(correct me if I am wrong or misunderstood anything here)
So that means its some short of hardware/board quirk, right?
Can you please recheck the schematic and see what Bjorn is telling 
(about having right entries in the DT for regulator) resolve your issue?

Marc, Can you disabled pmic on that board (hope your board boots with 
default PMIC supply) and see if this issue still occurs?
I am just trying to understand and see what is the real cause.

@Yaniv Gardi, will you be able to comment on reason for adding 
60f0187031c05e04cbadffb62f557d0ff3564490 (any issue faced)?
