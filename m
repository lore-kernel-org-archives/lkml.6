Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B6A208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B6A208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeGMJnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:43:53 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50061 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbeGMJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:43:52 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6D9Sq5U021109;
        Fri, 13 Jul 2018 11:29:32 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k6nmf15pj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 11:29:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A964A7A;
        Fri, 13 Jul 2018 09:29:31 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F700281F;
        Fri, 13 Jul 2018 09:29:31 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Jul
 2018 11:29:30 +0200
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable STM32 DCMI media support
To:     Hugues Fruchet <hugues.fruchet@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>
References: <1530781532-7125-1-git-send-email-hugues.fruchet@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <605b6b51-a17a-eda3-4767-67c175ddcde2@st.com>
Date:   Fri, 13 Jul 2018 11:29:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530781532-7125-1-git-send-email-hugues.fruchet@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugues,

On 07/05/2018 11:05 AM, Hugues Fruchet wrote:
> Enables support of STM32 DCMI V4L2 media driver.
> 
> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 8f6be19..42ad73f76 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -578,6 +578,7 @@ CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
>   CONFIG_VIDEO_STI_BDISP=m
>   CONFIG_VIDEO_STI_HVA=m
>   CONFIG_VIDEO_STI_DELTA=m
> +CONFIG_VIDEO_STM32_DCMI=m
>   CONFIG_VIDEO_RENESAS_JPU=m
>   CONFIG_VIDEO_RENESAS_VSP1=m
>   CONFIG_V4L_TEST_DRIVERS=y
> 

Applied on stm32-next.

Thanks.
Alex
