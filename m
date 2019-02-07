Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F6C218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bcv4k8QN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBGJHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:07:49 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:59545 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfBGJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:07:49 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190207090746epoutp02fe657d3be2376f2cfba7378e2ffc9032~BCb-Mgn6A0084700847epoutp02-
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 09:07:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190207090746epoutp02fe657d3be2376f2cfba7378e2ffc9032~BCb-Mgn6A0084700847epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549530466;
        bh=vOWer8LSNKvz4AdlvC1ggM/QnRSDaxb5f0nSikAVFZA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Bcv4k8QNafNlw3JruOr7RqiXq41X4TKwxGIGeM4HgYTGlmEp+aDlPRZIIY6kB+bWa
         EYKyCfn+KgHCjUMLSAH7Yj+5YVU66DACxX6JgDvdQ2YCiEHw1TEQkdJHJHqaDnHhk9
         ZQul/bPlQSLFmdHdE70RCTZmlad/d+IodJ3cQQzw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20190207090744epcas5p2429055d9aff42f41ca3a525d8947768a~BCb9Yov2c0236702367epcas5p2y;
        Thu,  7 Feb 2019 09:07:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.B7.04137.065FB5C5; Thu,  7 Feb 2019 18:07:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190207090743epcas5p2e5b25af526d4bbe9115b6486739e2446~BCb8jr1S20674606746epcas5p2r;
        Thu,  7 Feb 2019 09:07:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190207090743epsmtrp1eec1269b50083ed6f63bd67a0ec68ae5~BCb8ibwcm0982609826epsmtrp1B;
        Thu,  7 Feb 2019 09:07:43 +0000 (GMT)
X-AuditID: b6c32a4a-aefff70000001029-91-5c5bf560ced8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.6D.03601.F55FB5C5; Thu,  7 Feb 2019 18:07:43 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190207090741epsmtip2cba6ad044935c3d7b58014b17f5cebfc~BCb6jWfEn0945909459epsmtip2Y;
        Thu,  7 Feb 2019 09:07:41 +0000 (GMT)
Subject: Re: [PATCH v3 5/5] Revert
 "scsi: ufs: disable vccq if it's not needed by UFS device"
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Message-ID: <90f24b35-89b0-cea0-1ab3-13c2a419b138@samsung.com>
Date:   Thu, 7 Feb 2019 14:20:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2a59c11a-037f-c8c3-235a-9b21183a0801@free.fr>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85Oztaq7dZ+KR0GxWppGZFB/MSUXEyKelDiVo68qCizrXT
        TevDpJtpy2ZkaKaWpKlQYWteS92oEabhZWpSibQvKkq4tKaEuR0jv/2e9/n9eZ/n5WVIuU3i
        xaSozvEalTJNQbtTRrOPz/aE6di4QMvUMnb+w0521GGl2Y7WSYot/OEg2fFyHWI7K9tp9vrw
        A4JteVJAsH3fk1h9a6eU7W0qodm8gQaaNdo7Sfba+2mKHaxopPet5Hr7jnAPtd0U13tHR3D5
        z+0S7kt/C8296rjMGVrtiLPXredutuURUW4x7iGJfFrKBV4TEJbgnlx4y0Kox9deyr9XTWvR
        /TW5yI0BvAumxwekucidkeNmBCZtBS0WUwjeaquQ05LjmYXCSP9LPOs2kKL0BoGxcJYQiwkE
        ObOzLssDx8PdGutCg2FW44vwy7TN6ZD4Mwml17NdDo394OsDA+FkGQ6DlqlbEidTeDN865h3
        8RocDWbdJBKdVfChyEY52Q3vhUbzoCtLYk8YspUt8gaonyhxTQfYKIUfH9uROPYBKKhzSEX2
        gDGLYZG9YDT/htQ5KOBUuN20Uzy+Ak9L31Mih0NbXwnlVEjsAy+aAsSrVoBuzkaISRnk3JCL
        9ha4OmldTHqDPi9PIjIH7ebuxcedIMFaNULeRRuLl2xWvGSb4iXbFP+/uRxRNWgtrxbSk3hh
        tzpIxV/0F5TpwnlVkv+ZjPQ65Pp7vhENqLIr0oQwgxTLZVFDMXFyifKCkJluQsCQitWy0z9j
        4+SyRGVmFq/JiNecT+MFE/JmKIWn7NG6R7FynKQ8x6fyvJrX/OsSjJuXFnkJd5I/HevSh0pf
        yq2WIxHB4RuS63tsAdkHjxsfG5l9RSGpJw3rq3115ujAXXpHf6NfSEGkI1H7uuFsrf/Noj1j
        c4dUlpEmz/jDY2GjdbOa1tDBYWQeOPq9Z6Y5JzOhTKoOzmoI3fiztnar1R51wpqi/x1UThfm
        vis6tXLT/rY/CkpIVu7wJTWC8i+DtcUIdwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSvG781+gYg82v+S3+nzS2ePnzKpvF
        6f3vWCymffjJbPF6QS+jxdllB9ksWu9PZ7LYs2gSk8WVx+kWE/efZbe4vGsOm0X39R1sFts+
        n2W2aDn2lcXixuKdbA78HpeveHvMbrjI4nG5r5fJo3/dZ1aPO9f2sHlsPl3tsWX/Z0aPz5vk
        PNoPdDMFcEZx2aSk5mSWpRbp2yVwZUzrPM5U8Fqyon/ySrYGxqmiXYycHBICJhIrLm5h7mLk
        4hAS2M0o0fp+GRtEQlri+sYJ7BC2sMTKf8/ZIYpeM0rMODODGSQhLBAv0dd0ihXEFhEolzjX
        +pYNpIhZ4DazxPqXW1khOt4yS3y9fY8FpIpNQFvi7vQtTCA2r4CdxJ5PnWDdLAIqEvdO/wez
        RQUiJD4+3QdVIyhxcuYTsF5OAWuJnYdvgMWZBcwk5m1+yAxhi0vcejIfKi4vsf3tHOYJjEKz
        kLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBMeqltYOxhMn
        4g8xCnAwKvHwBtyKihFiTSwrrsw9xCjBwawkwhv3JTpGiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA6P5l4fJNfpHqjdqe1jcZrnZfCTq6pJmswe7nzxa
        8vjFrRqmjTdvxSh4zprcZzNzD1PEBZmyI5+Xb686LBrZ8HuivHigmZ3860WPToj+sDz76YCp
        tW99wY3exuYZcrzcEfvypp72XXXm0qSdAvd1N/5/aWpmn7XlxZQ9YdPCLiTHdweaft3Q1Jut
        xFKckWioxVxUnAgAxW68w9ECAAA=
X-CMS-MailID: 20190207090743epcas5p2e5b25af526d4bbe9115b6486739e2446
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 06/02/19 9:22 PM, Marc Gonzalez wrote:
> On 06/02/2019 16:27, Alim Akhtar wrote:
> 
>> On 06/02/19 8:29 PM, Marc Gonzalez wrote:
>>
>>> [    2.405734] regulator_disable: ENTER vdd_l26
>>> [    2.405958] regulator_disable: EXIT vdd_l26
>>> [    2.406032]   regulator_set_load: vdd_l26 = 0 uA
>>> [    3.930447] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode 0x04 for idn 13 failed, index 0, err = -11
>>> [    5.434358] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode 0x04 for idn 13 failed, index 0, err = -11
>>> [    6.938318] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr: opcode 0x04 for idn 13 failed, index 0, err = -11
>>> [    6.938414] ufshcd-qcom 1da4000.ufshc: ufshcd_query_attr_retry: query attribute, idn 13, failed with error -11 after 3 retires
>>> [    6.946959] ufshcd-qcom 1da4000.ufshc: ufshcd_disable_auto_bkops: failed to enable exception event -11
>>> [    6.958523] ufshcd-qcom 1da4000.ufshc: dme-peer-get: attr-id 0x1587 failed 3 retries
>>> [    6.967730] ufshcd-qcom 1da4000.ufshc: dme-peer-get: attr-id 0x1586 failed 3 retries
>>> [    6.975576] ufshcd-qcom 1da4000.ufshc: ufshcd_get_max_pwr_mode: invalid max pwm tx gear read = 0
>>> [    6.983306] ufshcd-qcom 1da4000.ufshc: ufshcd_probe_hba: Failed getting max supported power mode
>>> [    8.506314] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 3 failed, err = -11
>>> [   10.010352] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 3 failed, err = -11
>>> [   11.514313] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 3 failed, err = -11
>>> [   11.514412] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: query attribute, opcode 5, idn 3, failed with error -11 after 3 retires
>>> [   13.050354] ufshcd-qcom 1da4000.ufshc: __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, err = -11
>>> [   14.554313] ufshcd-qcom 1da4000.ufshc: __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, err = -11
>>> [   16.058313] ufshcd-qcom 1da4000.ufshc: __ufshcd_query_descriptor: opcode 0x01 for idn 8 failed, index 0, err = -11
>>> [   16.058421] ufshcd-qcom 1da4000.ufshc: ufshcd_read_desc_param: Failed reading descriptor. desc_id 8, desc_index 0, param_offset 0, ret -11
>>> [   16.067654] ufshcd-qcom 1da4000.ufshc: ufshcd_init_icc_levels: Failed reading power descriptor.len = 98 ret = -11
>>> [   37.074334] ufshcd-qcom 1da4000.ufshc: link startup failed 1
>>
>> Can you check if your UFS device RESET_N is asserted correctly. It might
>> be connected to some regulator and may be you can try keeping that
>> regulator as "regulator-always-on" from your DT node.
> 
> How do I check RESET_N? In software or hardware?
> 
RST_N is the reset logic for UFS device core logic and it is input to 
the device from UFS host controller.So, in your platform please check if 
this line somehow connected to (pulled up) a PMIC supply. If that is the 
case, please keep that regulator ON and see if this issue is resolved.
> Do you think it is not a good idea to revert 60f0187031c05e04cbadffb62f557d0ff3564490 ?
> 
Please hold on till we understand the real cause of this issue. Or we 
have a consensuses for reverting the said commit.
Thanks!

> Regards.
> 
> 
