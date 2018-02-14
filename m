Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031605AbeBNPi5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:38:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27120 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934301AbeBNPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:38:55 -0500
Subject: Re: [PATCH v3 0/9] irqchip: stm32: add stm32h7 support
To: Ludovic Barre <ludovic.Barre@st.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <37eef294-12ef-e3a3-df93-10c0ed8b1a57@st.com>
Date: Wed, 14 Feb 2018 16:38:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 11/06/2017 06:03 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This series adds:
> -Management of multi-bank of external interrupts
> stm32h7 has up to 96 inputs (3 banks of  32 inputs).
> -Fix initial value after cold/hot boot (wakeup issue).
> 
> Changes v3:
> -remove chip.name and handler, already done by
> irq_alloc_domain_generic_chips
> -add Rob ack in dt-bindings commit
> 
> Changes v2:
> -Remove irq_mask and adds const on struct stm32_exti_bank
> -Add wrapper functions pending and ack
> -Replace BITS_PER_LONG by IRQS_PER_BANK
> -Fill commit message on
> "ARM: dts: stm32: add support of exti on stm32h743"
> -Add system config bank for stm32h7
> 
> Ludovic Barre (9):
>    irqchip: stm32: select GENERIC_IRQ_CHIP
>    irqchip: stm32: add multi-bank management
>    dt-bindings: interrupt-controllers: add compatible string for stm32h7
>    irqchip: stm32: add stm32h7 support
>    irqchip: stm32: fix initial values
>    irqchip: stm32: move the wakeup on interrupt mask
>    ARM: dts: stm32: add exti support for stm32h743
>    ARM: dts: stm32: add system config bank node for stm32h743
>    ARM: dts: stm32: add support of exti on stm32h743 pinctrl

patches 7/8/9 (DT part) applied on stm32-next.

Thanks
Alex

> 
>   .../interrupt-controller/st,stm32-exti.txt         |   4 +-
>   arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  24 +++
>   arch/arm/boot/dts/stm32h743.dtsi                   |  13 ++
>   drivers/irqchip/Kconfig                            |   1 +
>   drivers/irqchip/irq-stm32-exti.c                   | 206 ++++++++++++++++-----
>   5 files changed, 198 insertions(+), 50 deletions(-)
> 
