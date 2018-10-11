Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5408C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C912077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C912077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeJKTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:44:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39391 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726212AbeJKTo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:44:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9BCFrEq031455;
        Thu, 11 Oct 2018 14:17:34 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n0muy6s56-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 11 Oct 2018 14:17:34 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7CB538;
        Thu, 11 Oct 2018 12:17:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 880C850CC;
        Thu, 11 Oct 2018 12:17:32 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.50) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 11 Oct
 2018 14:17:31 +0200
Subject: Re: [PATCH V6 00/23] mmc: mmci: add sdmmc variant for stm32
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFp0oHHS=bkXj_AbiLmbNxW07pFnk-4m9kwQtYkh_ogKgw@mail.gmail.com>
 <cb919bf8-caa2-b2fe-fee4-ae2f0f4c04b5@st.com>
 <CAPDyKFp4DEtavAqDg-ymaCcus+Hddv0OrgfS54HsTX+aWdzN+w@mail.gmail.com>
 <CAPDyKFqTNUihEk-i+t4OU1Eq5iBS57XZ4d8P2QbecgW_uT6NnA@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <00baaa9b-f630-1e59-0074-7d6fd35eff06@st.com>
Date:   Thu, 11 Oct 2018 14:17:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqTNUihEk-i+t4OU1Eq5iBS57XZ4d8P2QbecgW_uT6NnA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

On 10/11/2018 12:33 PM, Ulf Hansson wrote:
> On 9 October 2018 at 13:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 9 October 2018 at 09:54, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>> hi Ulf
>>>
>>> On 10/09/2018 09:30 AM, Ulf Hansson wrote:
>>>>
>>>> Applied for next, thanks!
>>>>
>>>> FYI, I made little fixup of the help text in the Kconfig for the last
>>>> patch.
>>>
>>>
>>> Thanks for your review.
>>> Did you had a feedback on Qcom platform tests?
>>
>> Nope. I am leaving the tests for Qcom platforms to be done by
>> kernelci, let's see what the reports are.
> 
> FYI:
> 
> https://kernelci.org/boot/id/5bbdcd2b59b5147001b435a4/
> 
> Looks good!

Thanks for the boot tests on qcom

BR
Ludo

> 
> Kind regards
> Uffe
> 
