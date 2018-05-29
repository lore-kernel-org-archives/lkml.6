Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965222AbeE2Q5q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:57:46 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:32838 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935486AbeE2Q5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:57:44 -0400
Date: Tue, 29 May 2018 09:57:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com,
        avifishman70@gmail.com, yuenn@google.com, brendanhiggins@google.com,
        venture@google.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v1 1/2] dt-binding: hwmon: Add NPCM7xx PWM documentation
Message-ID: <20180529165742.GE2162@roeck-us.net>
References: <1527588141-18639-1-git-send-email-tmaimon77@gmail.com>
 <1527588141-18639-2-git-send-email-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527588141-18639-2-git-send-email-tmaimon77@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 01:02:20PM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM7xx Pulse Width Modulation (PWM) controller.
> 

As mentioned in the other commit, this should be a pwm driver,
not a hwmon driver.

Guenter

> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/npcm7xx-pwm.txt      | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/npcm7xx-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/npcm7xx-pwm.txt b/Documentation/devicetree/bindings/hwmon/npcm7xx-pwm.txt
> new file mode 100644
> index 000000000000..2d8a7ccdc8cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/npcm7xx-pwm.txt
> @@ -0,0 +1,25 @@
> +Nuvoton NPCM7xx Pulse-width modulation (PWM) controller device driver
> +
> +The NPCM7xx has two identical PWM controller modules,
> +Each module has four PWM controller outputs.
> +NPCM7xx PWM controller module 0 outputs PWM0-3 and NPCM7xx PWM controller
> +module 1 outputs PWM4-7.
> +
> +Required properties:
> +- compatible	: "nuvoton,npcm750-pwm" for Poleg NPCM7XX.
> +- reg		: Offset and length of the registers set for the device.
> +- clocks	: phandle of pwm reference clock.
> +- pinctrl-names	: a pinctrl state named "default" must be defined.
> +- pinctrl-0 	: phandle referencing pin configuration of the PWM ports.
> +
> +pwm:pwm@f0103000 {
> +	compatible = "nuvoton,npcm750-pwm";
> +	reg = <0xf0103000 0x50
> +		0xf0104000 0x50>;
> +	clocks = <&clk NPCM7XX_CLK_APB3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm0_pins &pwm1_pins
> +			&pwm2_pins &pwm3_pins
> +			&pwm4_pins &pwm5_pins
> +			&pwm6_pins &pwm7_pins>;
> +};
> -- 
> 2.14.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
