Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C20ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4AA208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4AA208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeGMJo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:44:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29415 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbeGMJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:44:57 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6D9TB9e030293;
        Fri, 13 Jul 2018 11:30:30 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k6rkwr9nu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 11:30:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9C49234;
        Fri, 13 Jul 2018 09:30:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78531282E;
        Fri, 13 Jul 2018 09:30:29 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Jul
 2018 11:30:28 +0200
Subject: Re: [PATCH V5 0/5] add iwdg2 support for stm32mp157c
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f9a5836b-f740-6fb2-85c6-f77608283cf5@st.com>
Date:   Fri, 13 Jul 2018 11:30:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ludovic

On 06/25/2018 05:42 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series updates stm32_iwdg driver to manage pclk
> clock by compatible. stm32mp1 requires a pclk clock.
> 
> v5:
> -update stm32f429.dtsi
> 
> v4:
> -dt-bindings: split and review
> 
> v3:
> -remove stm32_iwdg_config structure, just assign the
>   boolean directly to .dat
> 
> Ludovic Barre (5):
>    dt-bindings: watchdog: add stm32mp1 support
>    watchdog: stm32: add pclk feature for stm32mp1
>    ARM: dts: stm32: add iwdg2 support for stm32mp157c
>    ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1
>    ARM: dts: stm32: update iwdg with lsi clock name for stm32f429
> 
>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  13 ++-
>   arch/arm/boot/dts/stm32f429.dtsi                   |   1 +
>   arch/arm/boot/dts/stm32mp157c-ed1.dts              |   5 +
>   arch/arm/boot/dts/stm32mp157c.dtsi                 |   8 ++
>   drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++++++--------
>   5 files changed, 98 insertions(+), 45 deletions(-)
> 

STM32 DT patches applied on stm32-next.

Regards
Alex
