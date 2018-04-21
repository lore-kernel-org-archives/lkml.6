Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeDUPg7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 11:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753120AbeDUPg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 11:36:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E2521742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 16:36:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: stm32-adc: add support for
 STM32MP1.
Message-ID: <20180421163651.2a9f19e1@archlinux>
In-Reply-To: <1524065874-434-2-git-send-email-fabrice.gasnier@st.com>
References: <1524065874-434-1-git-send-email-fabrice.gasnier@st.com>
        <1524065874-434-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 17:37:52 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Document support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
> Introduce "st,stm32mp1-adc" compatible to handle variants of this
> hardware such as vregready flag, interrupts, clock rate.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Pretty uncontroversial I think so I'll take this one with out
waiting Rob or Mark's time (though of course they are welcome
to offer feedback!)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index e8bb824..9994384 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -24,8 +24,11 @@ Required properties:
>  - compatible: Should be one of:
>    "st,stm32f4-adc-core"
>    "st,stm32h7-adc-core"
> +  "st,stm32mp1-adc-core"
>  - reg: Offset and length of the ADC block register set.
> -- interrupts: Must contain the interrupt for ADC block.
> +- interrupts: One or more interrupts for ADC block. Some parts like stm32f4
> +  and stm32h7 share a common ADC interrupt line. stm32mp1 has separate
> +  lines for each ADC within ADC block.
>  - clocks: Core can use up to two clocks, depending on part used:
>    - "adc" clock: for the analog circuitry, common to all ADCs.
>      It's required on stm32f4.
> @@ -53,6 +56,7 @@ Required properties:
>  - compatible: Should be one of:
>    "st,stm32f4-adc"
>    "st,stm32h7-adc"
> +  "st,stm32mp1-adc"
>  - reg: Offset of ADC instance in ADC block (e.g. may be 0x0, 0x100, 0x200).
>  - clocks: Input clock private to this ADC instance. It's required only on
>    stm32f4, that has per instance clock input for registers access.
