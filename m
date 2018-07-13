Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DBC208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DBC208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbeGMNXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:23:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42095 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729284AbeGMNXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:23:46 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6DD4cuo001269;
        Fri, 13 Jul 2018 15:08:49 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k6tcs0mbe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 15:08:49 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BE773A;
        Fri, 13 Jul 2018 13:08:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3DC1C5362;
        Fri, 13 Jul 2018 13:08:47 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.45) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Jul
 2018 15:08:46 +0200
Subject: Re: [PATCH 02/19] mmc: mmci: merge qcom dml feature into mmci dma
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-3-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqOOvbNc79hdWhdS4pxkYrh48At-BLuGmX0jDMER3Akdw@mail.gmail.com>
 <c09e8f7a-3bf7-abb3-b49c-011ae29f8d67@st.com>
 <CAPDyKFrN3GMez1vyc6xQUH_Qp7UrDj88rG9pAP_oTLHOB6k91g@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <ed45398d-552c-7bae-d77a-4e0d99b21759@st.com>
Date:   Fri, 13 Jul 2018 15:08:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrN3GMez1vyc6xQUH_Qp7UrDj88rG9pAP_oTLHOB6k91g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/13/2018 01:17 PM, Ulf Hansson wrote:
> On 11 July 2018 at 17:19, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>>
>> On 07/05/2018 05:26 PM, Ulf Hansson wrote:
>>>
>>> On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> This patch integrates qcom dml feature into mmci_dma file.
>>>> Qualcomm Data Mover lite/local is already a variant of mmci dmaengine.
>>>>
>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>> ---
>>>>    drivers/mmc/host/Makefile        |   1 -
>>>>    drivers/mmc/host/mmci.c          |   1 -
>>>>    drivers/mmc/host/mmci.h          |  35 ++++++++
>>>>    drivers/mmc/host/mmci_dma.c      | 135 ++++++++++++++++++++++++++++-
>>>>    drivers/mmc/host/mmci_qcom_dml.c | 177
>>>> ---------------------------------------
>>>>    drivers/mmc/host/mmci_qcom_dml.h |  31 -------
>>>>    6 files changed, 169 insertions(+), 211 deletions(-)
>>>>    delete mode 100644 drivers/mmc/host/mmci_qcom_dml.c
>>>>    delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h
>>>
>>>
>>> No, this is not the way to go. Instead I I think there are two options.
>>>
>>> 1) Keep mmci_qcom_dml.c|h and thus add new files for the stm32 dma
>>> variant.
>>>
>>> 2) Start by renaming mmci_qcom_dml.* to mmc_dma.* and then in the next
>>> step add the code for stm32 dma into the renamed files.
>>>
>>> I guess if there is some overlap in functionality, 2) may be best as
>>> it could easier avoid open coding. However, I am fine with whatever
>>> option and I expect that you knows what is best.
>>
>>
>> After patch 01 & 05 comments:
>> I will try to define a mmci_ops which contain some functions pointer
>> called by mmci.c (core).
>> A variant defines its mmci_ops.
>> where do you define the specific function:
>> -in a single file, mmci-ops.c or other (for the name, I'm not inspirated)
>> -or in specific file for each variant mmci-qcom.c or mmci-stm32.c
>>
>> following the comment (above), I think we define a single file?
> 
> If I understand the question, the problem is how we should assign the
> mmc host ops, which corresponds to the probed variant data!?
> 
> I took a stub at it and posted two patches which I think you should be
> able to build upon. Please have a look.

I review your patch on mmci_host_ops and init, I agree with your series,
I was going in the same direction.
The comment above was on file organization, what do you prefer?
-a single file with: all callback and all mmci_host_ops of each variant
-or each variant in specific file (like sdhci): mmci-qcom.c | 
mmci-stm32.c ...

> 
> [...]
> 
> Kind regards
> Uffe
> 
