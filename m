Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757872AbeD0Jb1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:31:27 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:28013 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeD0JbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:31:25 -0400
Subject: Re: [PATCH v7 0/7] clk: meson-axg: Add AO Cloclk and Reset driver
To: Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
References: <20180426084437.192394-1-yixun.lan@amlogic.com>
 <1524820841.4026.112.camel@baylibre.com>
CC: <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <fbd24a73-6793-76be-3ca5-04cbac5db198@amlogic.com>
Date: Fri, 27 Apr 2018 17:31:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1524820841.4026.112.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Jerome:


On 04/27/18 17:20, Jerome Brunet wrote:
> On Thu, 2018-04-26 at 16:44 +0800, Yixun Lan wrote:
>>   This patch try to add AO clock and Reset driver for Amlogic's
>> Meson-AXG SoC.
>>   Please note that patch 7 need to wait for the DTS changes[3] merged
>> into mainline first, otherwise it will break the serial console.
>>
>>  patch 2: factor the common code into a dedicated file
>>  patch 3-5: add the aoclk driver for AXG SoC
>>  patch 6-7: drop unnecessary clock flags
>>
>> changes since v6 at [7]: 
>>  - fix over 80 chars chechpatch error
>>  - add Philip's Ack on patch 5
>>  - drop extra end of newline
>>
>> changes since v5 at [6]: 
>>  - drop unnecessary header files
>>  - add 'axg_aoclk' prefix to clk driver, make them more consistent
>>  - add missing end new line..
>>
>> changes since v4 at [5]: 
>>  - fix return err
>>  - introduce CONFIG_COMMON_CLK_MESON_AO
>>  - format/style minor fix
>>
>> changes since v3 at [4]: 
>>  - add 'const' contraint to the read-only data
>>  - switch to devm_of_clk_add_hw_provider API
>>  - check return value of devm_reset_controller_register
>>
>> changes since v2 at [2]: 
>>  - rework meson_aoclkc_probe() which leverage the of_match_data
>>  - merge patch 5-6 into this series
>>  - seperate DTS patch, will send to Kevin Hilman independently
>>  
>> changes since v1 at [0]: 
>>  - rebase to clk-meson's branch 'next/drivers' [1]
>>  - fix license, update to BSD-3-Clause
>>  - drop un-used include header file
>>
>> [0] https://lkml.kernel.org/r/20180209070026.193879-1-yixun.lan@amlogic.com
>> [1] git://github.com/BayLibre/clk-meson.git branch: next-drivers
>> [2] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com
>> [3] https://lkml.kernel.org/r/20180326081809.49493-4-yixun.lan@amlogic.com
>> [4] https://lkml.kernel.org/r/20180328025050.221585-1-yixun.lan@amlogic.com
>> [5] https://lkml.kernel.org/r/20180408031938.153474-1-yixun.lan@amlogic.com
>> [6] https://lkml.kernel.org/r/20180409143749.71197-1-yixun.lan@amlogic.com
>> [7] https://lkml.kernel.org/r/20180419135426.155794-1-yixun.lan@amlogic.com
> 
> Yixun,
> 
> Your series looks mostly Ok to me, apart from the problem reported by Philipp.
> 
> However, once applied, if the clkc ao controller is enabled, both gxl and axg
> fail to complete the boot. Could you please explain how this was tested ??
> 

isn't this caused by the patch 7?
 [PATCH v7 7/7] clk: meson: drop CLK_IGNORE_UNUSED flag


you need to also apply this DT patch which I've sent[1]:
 [PATCH v3 3/3] ARM64: dts: meson: fix clock source of the pclk for UART_AO

could you exclude the patch 7 for now until Kevin merged the DT part?

[1] https://lkml.kernel.org/r/20180328030130.240336-4-yixun.lan@amlogic.com


> Not merging it until we get to the bottom of this.
> 
>>
>>
>> Qiufang Dai (1):
>>   clk: meson-axg: Add AO Clock and Reset controller driver
>>
>> Yixun Lan (6):
>>   clk: meson: migrate to devm_of_clk_add_hw_provider API
>>   clk: meson: aoclk: refactor common code into dedicated file
>>   dt-bindings: clock: axg-aoclkc: New binding for Meson-AXG SoC
>>   dt-bindings: clock: reset: Add AXG AO Clock and Reset Bindings
>>   clk: meson: drop CLK_SET_RATE_PARENT flag
>>   clk: meson: drop CLK_IGNORE_UNUSED flag
>>
>>  .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
>>  drivers/clk/meson/Kconfig                     |   8 +
>>  drivers/clk/meson/Makefile                    |   3 +-
>>  drivers/clk/meson/axg-aoclk.c                 | 163 ++++++++++++++++++
>>  drivers/clk/meson/axg-aoclk.h                 |  29 ++++
>>  drivers/clk/meson/gxbb-aoclk.c                |  95 ++++------
>>  drivers/clk/meson/gxbb-aoclk.h                |   5 +
>>  drivers/clk/meson/meson-aoclk.c               |  81 +++++++++
>>  drivers/clk/meson/meson-aoclk.h               |  34 ++++
>>  include/dt-bindings/clock/axg-aoclkc.h        |  26 +++
>>  include/dt-bindings/reset/axg-aoclkc.h        |  20 +++
>>  11 files changed, 401 insertions(+), 64 deletions(-)
>>  create mode 100644 drivers/clk/meson/axg-aoclk.c
>>  create mode 100644 drivers/clk/meson/axg-aoclk.h
>>  create mode 100644 drivers/clk/meson/meson-aoclk.c
>>  create mode 100644 drivers/clk/meson/meson-aoclk.h
>>  create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
>>  create mode 100644 include/dt-bindings/reset/axg-aoclkc.h
>>
> 
> .
> 
