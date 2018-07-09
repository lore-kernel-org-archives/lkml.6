Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0585C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF9E20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="veYPrFIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF9E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932881AbeGIWNn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:13:43 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43532 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932801AbeGIWNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:13:41 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so38825644oib.10;
        Mon, 09 Jul 2018 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcdvwuHmdUC6Aj35xCoePooy4VHEIBTm2tR2Oy/DgZo=;
        b=veYPrFIYSnb3wwk1zKn2WYUTX+g3HG+7Wv6FWNo5bIBnGAeyVgHgkYO4ar3SIfkt8C
         2QwCHSyTgwooxHi9LT9dWUf/XeQDwI/srCG6bVovvVwObiNT78LLoz+7LjxKdkisgiPf
         uF/iMagegTk/+xJZ/JC7vWg6Po6HHRI5ftoF5dziX9SDnY9wdhv+qHFemG8S87/JTHmV
         IvZJDaSFetVU3y38AU1/M4YheJyon6yszTTmm805dhYEJ0uOCPwo8rf5taoBL3WPfv+P
         n4IATNZgWoJOU0Ue81oGhFm5gSBsz0W1KoPFV76OeXbxAVA9UmIVo12zgYdhpZRBPDf0
         OtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcdvwuHmdUC6Aj35xCoePooy4VHEIBTm2tR2Oy/DgZo=;
        b=ItYMqMtl4QGrMsbR3BfL0u00N26W+fZoOIvLw0L4uJJRv8eteCaLrtElmbhLME6Fm/
         ox8Cr+sDAyrQtAR4+dijBOu3AgWkeIHkt5fMCXR12Q84Xgypj7zn8xNBfUzAtd2rTTuP
         w0Pc2ksNU3DVOpv/Zgzo0ZGj7aVChYB7fL73jQjMRRxywpC+s7XQiPrgf+s/5oMRcWsg
         XCej7L8cyl9c7iQtzHqe/fZmq26wIDlO95r8RZUoHtOlYUFUZO8sMg6wv/NedYGIzEBU
         /8Md4imAmG2yuWKigfYOByGqO7BZpTO37jFfc5Z6OxUWN9fMov4yYxf4SaKBYk6hVJxt
         YQIw==
X-Gm-Message-State: APt69E2DXvioVL5eLye/T+1QGsK0OD96r02AA3jD+2khIdMi5hzL2hzQ
        cgHTnkQISiEjlrsGE2mew7u6JT/ywH8Agb04CU8=
X-Google-Smtp-Source: AAOMgpc8WRceTUxzBeultcpP/U56ENaaTb27AdXOpC3xC1sUn0RFBMxSonrZbk38xCn35hdidh8fXBA9fP+Fdj7mmNo=
X-Received: by 2002:aca:68a2:: with SMTP id o34-v6mr26797939oik.267.1531174420698;
 Mon, 09 Jul 2018 15:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com> <1531134767-29927-3-git-send-email-jian.hu@amlogic.com>
In-Reply-To: <1531134767-29927-3-git-send-email-jian.hu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 10 Jul 2018 00:13:29 +0200
Message-ID: <CAFBinCB6LS=PT1cw-j-LZ+vWo-RFe81qVZ6uLeGfWKtKfHz7ag@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
To:     jian.hu@amlogic.com
Cc:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        qianggui.song@amlogic.com, devicetree@vger.kernel.org,
        sboyd@kernel.org, khilman@baylibre.com, mturquette@baylibre.com,
        yixun.lan@amlogic.com, linux-kernel@vger.kernel.org,
        bo.yang@amlogic.com, qiufang.dai@amlogic.com,
        linux-arm-kernel@lists.infradead.org, carlo@caione.org,
        linux-amlogic@lists.infradead.org, sunny.luo@amlogic.com,
        linux-clk@vger.kernel.org, xingyu.chen@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 1:13 PM Jian Hu <jian.hu@amlogic.com> wrote:
>
> Add dt-bindings headers for the Meson-G12A's Everything-Else
> part clock controller.
I wonder if this should be folded into patch #1 along with an update
to Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt so
it's clear which header has to be used for G12A

>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  include/dt-bindings/clock/g12a-clkc.h | 93 +++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
>
> diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
> new file mode 100644
> index 0000000..1473225
> --- /dev/null
> +++ b/include/dt-bindings/clock/g12a-clkc.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Meson-G12A clock tree IDs
> + *
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __G12A_CLKC_H
> +#define __G12A_CLKC_H
> +
> +#define CLKID_SYS_PLL                          0
> +#define CLKID_FIXED_PLL                                1
> +#define CLKID_FCLK_DIV2                                2
> +#define CLKID_FCLK_DIV3                                3
> +#define CLKID_FCLK_DIV4                                4
> +#define CLKID_FCLK_DIV5                                5
> +#define CLKID_FCLK_DIV7                                6
> +#define CLKID_GP0_PLL                          7
> +#define CLKID_CLK81                                    10
> +#define CLKID_MPLL0                                    11
> +#define CLKID_MPLL1                                    12
> +#define CLKID_MPLL2                                    13
> +#define CLKID_MPLL3                                    14
> +#define CLKID_DDR                                      15
> +#define CLKID_DOS                                      16
> +#define CLKID_AUDIO_LOCKER                     17
> +#define CLKID_MIPI_DSI_HOST                    18
> +#define CLKID_ETH_PHY                          19
> +#define CLKID_ISA                                      20
> +#define CLKID_PL301                                    21
> +#define CLKID_PERIPHS                          22
> +#define CLKID_SPICC0                           23
> +#define CLKID_I2C                                      24
> +#define CLKID_SANA                                     25
> +#define CLKID_SD                                       26
> +#define CLKID_RNG0                                     27
> +#define CLKID_UART0                                    28
> +#define CLKID_SPICC1                           29
> +#define CLKID_HIU_IFACE                                30
> +#define CLKID_MIPI_DSI_PHY                     31
> +#define CLKID_ASSIST_MISC                      32
> +#define CLKID_SD_EMMC_A                                33
> +#define CLKID_SD_EMMC_B                                34
> +#define CLKID_SD_EMMC_C                                35
> +#define CLKID_AUDIO_CODEC                      36
> +#define CLKID_AUDIO                                    37
> +#define CLKID_ETH                                      38
> +#define CLKID_DEMUX                                    39
> +#define CLKID_AUDIO_IFIFO                      40
> +#define CLKID_ADC                                      41
> +#define CLKID_UART1                                    42
> +#define CLKID_G2D                                      43
> +#define CLKID_RESET                                    44
> +#define CLKID_PCIE_COMB                                45
> +#define CLKID_PARSER                           46
> +#define CLKID_USB                                      47
> +#define CLKID_PCIE_PHY                         48
> +#define CLKID_AHB_ARB0                         49
> +#define CLKID_AHB_DATA_BUS                     50
> +#define CLKID_AHB_CTRL_BUS                     51
> +#define CLKID_HTX_HDCP22                       52
> +#define CLKID_HTX_PCLK                         53
> +#define CLKID_BT656                                    54
> +#define CLKID_USB1_DDR_BRIDGE          55
> +#define CLKID_MMC_PCLK                         56
> +#define CLKID_UART2                                    57
> +#define CLKID_VPU_INTR                         58
> +#define CLKID_GIC                                      59
> +#define CLKID_SD_EMMC_B_CLK0           60
> +#define CLKID_SD_EMMC_C_CLK0           61
> +#define CLKID_HIFI_PLL                         71
> +
is this empty line here on purpose? a comment would be great if
there's a reason behind it (there's already a gap in the numbering
between CLKID_GP0_PLL and CLKID_CLK81, but there's no empty line there
- either way is fine, please just keep it consistent)


Regards
Martin
