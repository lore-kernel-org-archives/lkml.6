Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6226BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C90C222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbfBMKQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:16:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29348 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732639AbfBMKQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:16:04 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DAD72S004087;
        Wed, 13 Feb 2019 11:15:47 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qhv0m6fv8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Feb 2019 11:15:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F3CE31;
        Wed, 13 Feb 2019 10:15:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59EC12D3A;
        Wed, 13 Feb 2019 10:15:45 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Feb
 2019 11:15:44 +0100
Subject: Re: [PATCH 0/4] Add nvmem support on STM32
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lionel.debieve@st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <4aaa83b2-35a6-e2c2-a3f4-6579b5d67038@st.com>
Date:   Wed, 13 Feb 2019 11:15:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 5:38 PM, Fabrice Gasnier wrote:
> Non volatile memory area is available on STM32. It contains various
> factory programmed information such as unique device ID, analog calibration...
> This patchset adds NVMEM support to access these data.

Hello,

Gentle reminder for this new driver review

Best Regards,
Fabrice

> 
> Fabrice Gasnier (4):
>   dt-bindings: nvmem: Add STM32 factory-programmed romem
>   nvmem: Add driver for STM32 factory-programmed read only mem
>   nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
>   ARM: dts: stm32: Add romem and temperature calibration on stm32mp157c
> 
>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   |  31 ++++
>  arch/arm/boot/dts/stm32mp157c.dtsi                 |  13 ++
>  drivers/nvmem/Kconfig                              |  10 +
>  drivers/nvmem/Makefile                             |   2 +
>  drivers/nvmem/stm32-romem.c                        | 202 +++++++++++++++++++++
>  5 files changed, 258 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>  create mode 100644 drivers/nvmem/stm32-romem.c
> 
