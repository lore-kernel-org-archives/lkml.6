Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DD1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAB9223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAB9223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeKMSHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:07:12 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43119 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728379AbeKMSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:07:12 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAD85nM7003258;
        Tue, 13 Nov 2018 09:09:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nq0j2yajq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 13 Nov 2018 09:09:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66A4C3A;
        Tue, 13 Nov 2018 08:09:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11E3C16B4;
        Tue, 13 Nov 2018 08:09:49 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 13 Nov
 2018 09:09:49 +0100
Subject: Re: [PATCH v3 0/4] Add support of STM32 hwspinlock
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e252e4c7-ec95-b4c2-f988-526fd8bda942@st.com>
Date:   Tue, 13 Nov 2018 09:09:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112152342.6561-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 11/12/18 4:23 PM, Benjamin Gaignard wrote:
> This serie adds the support of the hardware semaphore block for stm32mp1 SoC.
> 
> version 3:
> - fix clock name in properties description.
> - use postcore_initcall() instead of module_platform_driver()
> 
> version 2:
> - fix comments done by Bjorn about clock naming, license terms in header,
>    alphabetic ordering in Makefile and Kconfig and remove function
> - Do not push test module in this version while waiting for feedbacks about it
> 
> 
> Benjamin Gaignard (4):
>    dt-bindings: hwlock: Document STM32 hwspinlock bindings
>    hwspinlock: add STM32 hwspinlock device
>    ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
>    ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1

DT patches applied on stm32-next.

Regards
Alex

> 
>   .../bindings/hwlock/st,stm32-hwspinlock.txt        |  23 +++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts              |   4 +
>   arch/arm/boot/dts/stm32mp157c.dtsi                 |   9 ++
>   drivers/hwspinlock/Kconfig                         |   9 ++
>   drivers/hwspinlock/Makefile                        |   1 +
>   drivers/hwspinlock/stm32_hwspinlock.c              | 156 +++++++++++++++++++++
>   6 files changed, 202 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
>   create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c
> 
