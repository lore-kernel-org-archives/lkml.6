Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449F6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E1520C48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E1520C48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbeGKM5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:57:51 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:35518 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732978AbeGKM5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:57:50 -0400
Received: from [10.28.16.194] (10.28.16.194) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 11 Jul
 2018 20:53:35 +0800
Subject: Re: [PATCH 2/3] dt-bindings: clk: meson-g12a: Add G12A EE Clock
 Bindings
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        <qianggui.song@amlogic.com>, <devicetree@vger.kernel.org>,
        <sboyd@kernel.org>, <khilman@baylibre.com>,
        <mturquette@baylibre.com>, <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>, <bo.yang@amlogic.com>,
        <qiufang.dai@amlogic.com>, <linux-arm-kernel@lists.infradead.org>,
        <carlo@caione.org>, <linux-amlogic@lists.infradead.org>,
        <sunny.luo@amlogic.com>, <linux-clk@vger.kernel.org>,
        <xingyu.chen@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-3-git-send-email-jian.hu@amlogic.com>
 <CAFBinCB6LS=PT1cw-j-LZ+vWo-RFe81qVZ6uLeGfWKtKfHz7ag@mail.gmail.com>
 <1531214774.2708.49.camel@baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <d09961d5-2674-fd8c-ee90-05dd423391f3@amlogic.com>
Date:   Wed, 11 Jul 2018 20:53:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531214774.2708.49.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.16.194]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/10 17:26, Jerome Brunet wrote:
> On Tue, 2018-07-10 at 00:13 +0200, Martin Blumenstingl wrote:
>> On Mon, Jul 9, 2018 at 1:13 PM Jian Hu <jian.hu@amlogic.com> wrote:
>>>
>>> Add dt-bindings headers for the Meson-G12A's Everything-Else
>>> part clock controller.
>>
>> I wonder if this should be folded into patch #1 along with an update
>> to Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt so
>> it's clear which header has to be used for G12A
>>
> 
> Yes, please squash patch 1 and 2.
I have squashed patch 1 and 2.
> 
>>>
>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>>> ---
>>>   include/dt-bindings/clock/g12a-clkc.h | 93 +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 93 insertions(+)
>>>   create mode 100644 include/dt-bindings/clock/g12a-clkc.h
>>>
>>> diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
>>> new file mode 100644
>>> index 0000000..1473225
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/g12a-clkc.h
>>> @@ -0,0 +1,93 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>> +/*
>>> + * Meson-G12A clock tree IDs
>>> + *
>>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +#ifndef __G12A_CLKC_H
>>> +#define __G12A_CLKC_H
>>> +
>>> +#define CLKID_SYS_PLL                          0
>>> +#define CLKID_FIXED_PLL                                1
>>> +#define CLKID_FCLK_DIV2                                2
>>> +#define CLKID_FCLK_DIV3                                3
>>> +#define CLKID_FCLK_DIV4                                4
>>> +#define CLKID_FCLK_DIV5                                5
>>> +#define CLKID_FCLK_DIV7                                6
>>> +#define CLKID_GP0_PLL                          7
> 
> Please fix the alignement.
> 
>>> +#define CLKID_CLK81                                    10
>>> +#define CLKID_MPLL0                                    11
>>> +#define CLKID_MPLL1                                    12
>>> +#define CLKID_MPLL2                                    13
>>> +#define CLKID_MPLL3                                    14
>>> +#define CLKID_DDR                                      15
>>> +#define CLKID_DOS                                      16
>>> +#define CLKID_AUDIO_LOCKER                     17
>>> +#define CLKID_MIPI_DSI_HOST                    18
>>> +#define CLKID_ETH_PHY                          19
>>> +#define CLKID_ISA                                      20
>>> +#define CLKID_PL301                                    21
>>> +#define CLKID_PERIPHS                          22
>>> +#define CLKID_SPICC0                           23
>>> +#define CLKID_I2C                                      24
>>> +#define CLKID_SANA                                     25
>>> +#define CLKID_SD                                       26
>>> +#define CLKID_RNG0                                     27
>>> +#define CLKID_UART0                                    28
>>> +#define CLKID_SPICC1                           29
>>> +#define CLKID_HIU_IFACE                                30
>>> +#define CLKID_MIPI_DSI_PHY                     31
>>> +#define CLKID_ASSIST_MISC                      32
>>> +#define CLKID_SD_EMMC_A                                33
>>> +#define CLKID_SD_EMMC_B                                34
>>> +#define CLKID_SD_EMMC_C                                35
>>> +#define CLKID_AUDIO_CODEC                      36
>>> +#define CLKID_AUDIO                                    37
>>> +#define CLKID_ETH                                      38
>>> +#define CLKID_DEMUX                                    39
>>> +#define CLKID_AUDIO_IFIFO                      40
>>> +#define CLKID_ADC                                      41
>>> +#define CLKID_UART1                                    42
>>> +#define CLKID_G2D                                      43
>>> +#define CLKID_RESET                                    44
>>> +#define CLKID_PCIE_COMB                                45
>>> +#define CLKID_PARSER                           46
>>> +#define CLKID_USB                                      47
>>> +#define CLKID_PCIE_PHY                         48
>>> +#define CLKID_AHB_ARB0                         49
>>> +#define CLKID_AHB_DATA_BUS                     50
>>> +#define CLKID_AHB_CTRL_BUS                     51
>>> +#define CLKID_HTX_HDCP22                       52
>>> +#define CLKID_HTX_PCLK                         53
>>> +#define CLKID_BT656                                    54
>>> +#define CLKID_USB1_DDR_BRIDGE          55
>>> +#define CLKID_MMC_PCLK                         56
>>> +#define CLKID_UART2                                    57
>>> +#define CLKID_VPU_INTR                         58
>>> +#define CLKID_GIC                                      59
>>> +#define CLKID_SD_EMMC_B_CLK0           60
>>> +#define CLKID_SD_EMMC_C_CLK0           61
>>> +#define CLKID_HIFI_PLL                         71
>>> +
>>
>> is this empty line here on purpose? a comment would be great if
>> there's a reason behind it (there's already a gap in the numbering
>> between CLKID_GP0_PLL and CLKID_CLK81, but there's no empty line there
>> - either way is fine, please just keep it consistent)
> 
> Please drop the empty line.
> Otherwise, looks good.
> I have dropped it ,and I will push another email later.Thanks.
>>
>>
>> Regards
>> Martin
> 
> .
> 
