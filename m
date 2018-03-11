Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932440AbeCKWmp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:42:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39086 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932314AbeCKWmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:42:43 -0400
X-Google-Smtp-Source: AG47ELsHzY0enm2QwxkqBdg8Exw6pb/K+r+ol6qucOfrHiI1eXWBNM3lsW4IAE1TdygFArZI6D/QJQ==
Date: Sun, 11 Mar 2018 15:42:37 -0700
From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 00/12] Introduce STM32MP1 clock driver
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        sboyd@kernel.org
Cc: benjamin GAIGNARD <benjamin.gaignard@st.com>,
        devicetree@vger.kernel.org, gabriel.fernandez.st@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Loic PALLARDY <loic.pallardy@st.com>,
        olivier.bideau@st.com
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
User-Agent: astroid/8ea8c2a3 (https://github.com/astroidmail/astroid)
Message-Id: <1520808064.5otv3fo1pe.astroid@resonance.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2BMgoYL015616

Excerpts from gabriel.fernandez@st.com's message of March 8, 2018 8:53 am:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> v2:
>   - Don't use MFD, use existing binding of STM32 RCC.
>   - Rework Peripheral and Kernel clocks
>   - cosmetic changes
> 
> This patch-set introduces clock driver for STM32MP157 based on Arm Cortex-A7.
> The driver patch is split in several patches (by kind of clock) to facilitate
> code reviewing.

Applied to clk-stm32mp1 towards v4.17.

Regards,
Mike

> 
> Gabriel Fernandez (12):
>   dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings
>   clk: stm32mp1: Introduce STM32MP1 clock driver
>   clk: stm32mp1: add MP1 gate for hse/hsi/csi oscillators
>   clk: stm32mp1: add Source Clocks for PLLs
>   clk: stm32mp1: add PLL clocks
>   clk: stm32mp1: add Post-dividers for PLL
>   clk: stm32mp1: add Sub System clocks
>   clk: stm32mp1: add Kernel timers
>   clk: stm32mp1: add Peripheral & Kernel Clocks
>   clk: stm32mp1: add RTC clock
>   clk: stm32mp1: add MCO clocks
>   clk: stm32mp1: add Debug clocks
> 
>  .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  |   60 +
>  drivers/clk/Kconfig                                |    6 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/clk-stm32mp1.c                         | 2117 ++++++++++++++++++++
>  include/dt-bindings/clock/stm32mp1-clks.h          |  254 +++
>  5 files changed, 2438 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
>  create mode 100644 drivers/clk/clk-stm32mp1.c
>  create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h
> 
> -- 
> 1.9.1
> 
> 
