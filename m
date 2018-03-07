Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeCGRZ5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:25:57 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42103 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCGRZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:25:52 -0500
X-Google-Smtp-Source: AG47ELvxe0vWoCYLafvSeDqYRTiLMp3FB2mU5v4AIrqMw75Rqwd+o6mwka+gR4fnxlEHQghghkuJOA==
Subject: Re: [PATCH v4 1/2] dt-binding: timer: document NPCM7xx timer DT
 bindings
To: Tomer Maimon <tmaimon77@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, tglx@linutronix.de, avifishman70@gmail.com,
        brendanhiggins@google.com, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <1519655769-25836-1-git-send-email-tmaimon77@gmail.com>
 <1519655769-25836-2-git-send-email-tmaimon77@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ff6b0bbb-31b1-b683-3061-4ad55a57eaa9@linaro.org>
Date: Wed, 7 Mar 2018 18:25:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519655769-25836-2-git-send-email-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 15:36, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton NPCM7xx timer.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  .../bindings/timer/nuvoton,npcm7xx-timer.txt       | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
> new file mode 100644
> index 000000000000..c5150522e618
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
> @@ -0,0 +1,25 @@
> +Nuvoton NPCM7xx timer
> +
> +Nuvoton NPCM7xx have three timer modules, each timer module provides five 24-bit
> +timer counters.
> +
> +Required properties:
> +- compatible      : "nuvoton,npcm750-timer" for Poleg NPCM750.
> +- reg             : Offset and length of the register set for the device.
> +- interrupts      : Contain the timer interrupt with flags for
> +                    falling edge.
> +
> +Required clocking property, have to be one of:
> +- clocks          : phandle of timer reference clock.
> +- clock-frequency : The frequency in Hz of the clock that drives the NPCM7xx
> +                    timer (usually 25000000).

Why one of these and not the phandle only ? That will make the driver
cleaner.

> +
> +Example:
> +
> +timer@f0008000 {
> +    compatible = "nuvoton,npcm750-timer";
> +    interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +    reg = <0xf0008000 0x1000>;
> +    clocks = <&clk NPCM7XX_CLK_TIMER>;
> +};
> +
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
