Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF20C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8341C21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8341C21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbeITSiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:38:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:65339 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387683AbeITSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:38:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8KCmcj0030606;
        Thu, 20 Sep 2018 14:52:19 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mgquteegj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 20 Sep 2018 14:52:19 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 958F938;
        Thu, 20 Sep 2018 12:52:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 61B2B28E9;
        Thu, 20 Sep 2018 12:52:18 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 20 Sep
 2018 14:52:17 +0200
Subject: Re: [PATCH 0/4] Remove cd-inverted property for STM32Fx boards
To:     <patrice.chotard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lee.jones@linaro.org>
CC:     <mcoquelin.stm32@gmail.com>
References: <1532589596-22181-1-git-send-email-patrice.chotard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <00fc6168-58be-4381-7406-9e2518a27236@st.com>
Date:   Thu, 20 Sep 2018 14:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532589596-22181-1-git-send-email-patrice.chotard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice

On 07/26/2018 09:19 AM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This series remove cd-inverted property from STM32Fx boards DT files.
> As GPIOS are used for card detect, the polarity can be indicated using
> GPIO_ACTIVE_(HIGH|LOW), so cd-inverted becomes useless.
> 
> Patrice Chotard (4):
>    ARM: dts: stm32: Remove cd-inverted property for stm32429i-eval
>    ARM: dts: stm32: Remove cd-inverted property for stm32f469-disco
>    ARM: dts: stm32: Remove cd-inverted property for stm32f769-disco
>    ARM: dts: stm32: Remove cd-inverted property for stm32f746-disco
> 
>   arch/arm/boot/dts/stm32429i-eval.dts  | 3 +--
>   arch/arm/boot/dts/stm32f469-disco.dts | 3 +--
>   arch/arm/boot/dts/stm32f746-disco.dts | 3 +--
>   arch/arm/boot/dts/stm32f769-disco.dts | 3 +--
>   4 files changed, 4 insertions(+), 8 deletions(-)
> 

Series applied on stm32-next.

Regards
Alex
