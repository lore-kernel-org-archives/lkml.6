Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeCWP0g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:26:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40435 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751686AbeCWP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:26:34 -0400
Subject: Re: [RESEND PATCH v2 0/8] Add support for PWM input capture on STM32
To: <lee.jones@linaro.org>, <thierry.reding@gmail.com>,
        <alexandre.torgue@st.com>
CC: <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <09924ca3-f478-301f-b82b-1db03d31efb4@st.com>
Date: Fri, 23 Mar 2018 16:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-23_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 11:04 AM, Fabrice Gasnier wrote:
> This series adds support for capture to stm32-pwm driver.
> Capture is based on DMAs.
> - First two patches are precursor patches
> - Subsequent two patches add support for requesting DMAs to MFD core
> - Next three patches add support for capture to stm32-pwm driver
> - This has been tested on stm32429i-eval board.
> 

Hi all,

Gentle ping to review this series, since DT Bindings has been reviewed
by Rob and the series by Benjamin.

Many thanks in advance,
Regards,
Fabrice

> ---
> Resend v2:
> - Add collected Acks
> 
> Changes in v2:
> - Abstract DMA handling from child driver: move it to MFD core
> - Rework pwm capture routines to adopt this change
> - Comment on optional dma support, beautify DMAs probe
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
