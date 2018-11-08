Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377EBECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CA42081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CA42081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeKHW6r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:58:47 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:6416 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeKHW6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:58:47 -0500
Received: from [100.102.111.159] (unknown [77.136.17.41])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id EF58D13F8CC;
        Thu,  8 Nov 2018 14:23:00 +0100 (CET)
Date:   Thu, 08 Nov 2018 14:23:01 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <VI1PR0402MB348569B15DBAB6503303D41798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr> <e6e0105f-3135-e5b7-8224-419c9f730a09@free.fr> <85a73243-0c53-43e5-5002-90631c0a8c90@free.fr> <VI1PR0402MB3485342DB8A0F5C5791E213798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com> <VI1PR0402MB348569B15DBAB6503303D41798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
To:     Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <2ABE50FD-FF08-4E16-8D8F-A81A92722478@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 8, 2018 12:38:10 PM GMT+01:00, Horia Geanta <horia.geanta@nxp.com> wrote:
>On 11/8/2018 1:23 PM, Horia Geanta wrote:
>> On 11/7/2018 10:49 PM, Marc Gonzalez wrote:
>>> [ Add interested parties ]
>>>
>>> On 07/11/2018 21:18, Marc Gonzalez wrote:
>>>
>>>> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2
>SoCs")
>>>> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
>>>> which is not set.
>>>>
>> Thanks Marc.
>> 
>> Though I would prefer enabling the dependencies:
>> dpaa2-caam driver -> dpio driver (FSL_MC_DPIO) -> fsl-mc driver
>(FSL_MC_BUS).
>> 
>Could you instead incorporate below patch in your series?
>(I am pretty sure it won't apply clean)
>
>Thanks,
>Horia
>
>-- >8 --
>
>Subject: [PATCH] arm64: defconfig: enable DPAA2 fsl-mc bus and DPIO
>driver
>
>Enable fsl-mc bus and DPIO (Datapath I/O) driver, which are needed on
>Layerscape SoCs with QorIQ Data Path Acceleration Architecture (DPAA)
>v2.
>
>Suggested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
>---
> arch/arm64/configs/defconfig | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/arch/arm64/configs/defconfig
>b/arch/arm64/configs/defconfig
>index c9a57d11330b..7c3785e61ef9 100644
>--- a/arch/arm64/configs/defconfig
>+++ b/arch/arm64/configs/defconfig
>@@ -181,6 +181,7 @@ CONFIG_DMA_CMA=y
> CONFIG_CMA_SIZE_MBYTES=32
> CONFIG_HISILICON_LPC=y
> CONFIG_SIMPLE_PM_BUS=y
>+CONFIG_FSL_MC_BUS=y
> CONFIG_MTD=y
> CONFIG_MTD_BLOCK=y
> CONFIG_MTD_M25P80=y
>@@ -615,6 +616,7 @@ CONFIG_QCOM_IOMMU=y
> CONFIG_RPMSG_QCOM_GLINK_RPM=y
> CONFIG_RPMSG_QCOM_SMD=y
> CONFIG_RASPBERRYPI_POWER=y
>+CONFIG_FSL_MC_DPIO=y
> CONFIG_QCOM_SMEM=y
> CONFIG_QCOM_SMD_RPM=y
> CONFIG_QCOM_SMP2P=y
>-- 
>2.16.2

Are CRYPTO_DEV_FSL_DPAA2_CAAM and CONFIG_FSL_MC_DPIO required to boot the platform? If not, we will build them as modules. I can send a v3 tonight with that change, as well as the various Acks.

Regards
