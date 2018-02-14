Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeBNIXu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:23:50 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13586 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754556AbeBNIXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:23:47 -0500
Subject: Re: [PATCH v2 0/8] Add support for PWM input capture on STM32
To: <lee.jones@linaro.org>, <thierry.reding@gmail.com>
CC: <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <benjamin.gaignard@linaro.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <5ade7f05-f5cc-e272-842c-22effa78b716@st.com>
Date: Wed, 14 Feb 2018 09:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26/2018 04:11 PM, Fabrice Gasnier wrote:
> This series adds support for capture to stm32-pwm driver.
> Capture is based on DMAs.
> - First two patches are precursor patches
> - Subsequent two patches add support for requesting DMAs to MFD core
> - Next three patches add support for capture to stm32-pwm driver
> - This has been tested on stm32429i-eval board.
> 
> ---
> Changes in v2:
> - Abstract DMA handling from child driver: move it to MFD core
> - Rework pwm capture routines to adopt this change
> - Comment on optional dma support, beautify DMAs probe

Hi all,

Gentle ping for v2 driver review since DT Bindings has been reviewed by
Rob and the series by Benjamin.

Many thanks in advance
Regards
Fabrice

> 
> Fabrice Gasnier (8):
>   pwm: stm32: fix, remove unused struct device
>   pwm: stm32: protect common prescaler for all channels
>   dt-bindings: mfd: stm32-timers: add support for dmas
>   mfd: stm32-timers: add support for dmas
>   pwm: stm32: add capture support
>   pwm: stm32: improve capture by tuning counter prescaler
>   pwm: stm32: use input prescaler to improve period capture
>   ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
> 
>  .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
>  arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
>  drivers/mfd/stm32-timers.c                         | 215 +++++++++++++++-
>  drivers/pwm/pwm-stm32.c                            | 276 ++++++++++++++++++++-
>  include/linux/mfd/stm32-timers.h                   |  39 +++
>  5 files changed, 547 insertions(+), 6 deletions(-)
> 
