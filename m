Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDE7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153A523D44
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153A523D44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966190AbeF2Nvh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:51:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9750 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966099AbeF2Nvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:51:35 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5TDmwFZ007522;
        Fri, 29 Jun 2018 15:51:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jwke40q4x-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Jun 2018 15:51:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CD1B642;
        Fri, 29 Jun 2018 13:51:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4AA002D2C;
        Fri, 29 Jun 2018 13:51:12 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.47) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 Jun
 2018 15:51:11 +0200
Subject: Re: [PATCH 00/19] mmc: mmci: add stm32 sdmmc variant
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <f475a8c7-5a48-bf40-bbd9-a7a513f8a70f@st.com>
Date:   Fri, 29 Jun 2018 15:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

I know that you very busy on other task,
but did you have time to look my serie.
do you have first feedback ?

BR
Ludo

On 06/12/2018 03:14 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series adapts mmci driver to add support for stm32
> sdmmc variant. stm32h7 SoC integrates the first revision of
> stm32 sdmmc.
> 
> This series is composed of 3 parts:
> -Prepare mmci driver to manage dma interfaces by adding property.
>   New mmci dma API is defined according to the legacy needs.
> -Adapt mmci driver to dedicated constraints of stm32 sdmmc variant,
>   defined under some specific properties.
> -Add stm32 sdmmc variant. As Internal DMA way satisfies data
> transfer, the mmci driver hasn't been modified for pio_read/write.
> Specific adds-ons to stm32 sdmmc:
>   + registers
>   + clk/power functions
>   + idma interface
> 
> Ludovic Barre (19):
>    mmc: mmci: regroup and define dma operations
>    mmc: mmci: merge qcom dml feature into mmci dma
>    mmc: mmci: add datactrl block size variant property
>    mmc: mmci: expand startbiterr to irqmask and error check
>    mmc: mmci: allow to overwrite clock/power procedure to specific
>      variant
>    mmc: mmci: add variant properties to define cpsm & cmdresp bits
>    mmc: mmci: add variant property to define dpsm bit
>    mmc: mmci: add variant property to define irq pio mask
>    mmc: mmci: add variant property to write datactrl before command
>    mmc: mmci: add variant property to allow remain data
>    mmc: mmci: add variant property to check specific data constraint
>    mmc: mmci: add variant property to request a reset
>    mmc: mmci: send stop cmd if a data command fail
>    mmc: mmci: add clock divider for stm32 sdmmc
>    mmc: mmci: add stm32 sdmmc registers
>    mmc: mmci: add DT bindings for STM32 sdmmc
>    mmc: mmci: add stm32 sdmmc idma support
>    mmc: mmci: add specific clk/pwr procedure for stm32 sdmmc
>    mmc: mmci: add stm32 sdmmc variant
> 
>   Documentation/devicetree/bindings/mmc/mmci.txt |  11 +
>   drivers/mmc/host/Makefile                      |   3 +-
>   drivers/mmc/host/mmci.c                        | 846 +++++++++++--------------
>   drivers/mmc/host/mmci.h                        | 237 ++++++-
>   drivers/mmc/host/mmci_dma.c                    | 780 +++++++++++++++++++++++
>   drivers/mmc/host/mmci_dma.h                    |  33 +
>   drivers/mmc/host/mmci_qcom_dml.c               | 177 ------
>   drivers/mmc/host/mmci_qcom_dml.h               |  31 -
>   8 files changed, 1410 insertions(+), 708 deletions(-)
>   create mode 100644 drivers/mmc/host/mmci_dma.c
>   create mode 100644 drivers/mmc/host/mmci_dma.h
>   delete mode 100644 drivers/mmc/host/mmci_qcom_dml.c
>   delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h
> 
