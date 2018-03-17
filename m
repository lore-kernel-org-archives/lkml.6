Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeCQXwq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:52:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37568 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeCQXwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:52:44 -0400
Subject: Re: [PATCH v4 3/8] doc: Add doc for the Ingenic TCU hardware
To: Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Cc: James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
 <20180317232901.14129-4-paul@crapouillou.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1e5b82ca-5ac3-6e98-d40b-67916008b485@infradead.org>
Date: Sat, 17 Mar 2018 16:52:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317232901.14129-4-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17/2018 04:28 PM, Paul Cercueil wrote:
> Add a documentation file about the Timer/Counter Unit (TCU)
> present in the Ingenic JZ47xx SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/mips/00-INDEX        |  3 +++
>  Documentation/mips/ingenic-tcu.txt | 50 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/mips/ingenic-tcu.txt
> 
>  v4: New patch in this series

> diff --git a/Documentation/mips/ingenic-tcu.txt b/Documentation/mips/ingenic-tcu.txt
> new file mode 100644
> index 000000000000..2508e5793da8
> --- /dev/null
> +++ b/Documentation/mips/ingenic-tcu.txt
> @@ -0,0 +1,50 @@
> +Ingenic JZ47xx SoCs Timer/Counter Unit hardware
> +-----------------------------------------------
> +
> +The Timer/Counter Unit (TCU) in Ingenic JZ47xx SoCs is a multi-function
> +hardware block. It features eight channels, that can be used as counters,

                    drop comma ............. ^

> +timers, or PWM.
> +
> +- JZ4770 introduced a separate channel, called Operating System Timer (OST).
> +  It is a 64-bit programmable timer.
> +
> +- Each one of the eight channels has its own clock, which can be reparented
> +  to three different clocks (pclk, ext, rtc), gated, and reclocked, through
> +  their TCSR register.
> +  * The watchdog and OST hardware blocks also feature a TCSR register with
> +	the same format in their register space.
> +  * The TCU registers used to gate/ungate can also gate/ungate the watchdog
> +	and OST clocks.
> +
> +- On SoCs >= JZ4770, there are two different modes:
> +  * Channels 0, 3-7 operate in TCU1 mode: they cannot work in sleep mode,
> +	but are easier to operate.
> +  * Channels 1-2 operate in TCU2 mode: they can work in sleep mode, but
> +	the operation is a bit more complicated than with TCU1 channels.
> +
> +- Each channel can generate an interrupt. Some channels share an interrupt	
> +  line, some don't, and this changes between SoC versions:
> +  * on JZ4740, timer 0 and timer 1 have their own interrupt line; others share
> +	one interrupt line.
> +  * on JZ4770 and JZ4780, timer 5 has its own interrupt; timers 0-4 and 6-7 all
> +	use one interrupt line; the OST uses the last interrupt.

"The OST uses the last interrupt." is not clear to someone who doesn't know
about this hardware. (I can read it several ways.)

Does it mean that the 4770 and 4780 have 3 interrupt lines used like so?

- timer 5 uses one interrupt line
- timers 0-4 and 6-7 use a second interrupt line
- the OST uses a third interrupt line


thanks,
-- 
~Randy
