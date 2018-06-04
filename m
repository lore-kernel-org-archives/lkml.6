Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeFDGKK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:10:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35917 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeFDGKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:10:08 -0400
X-Google-Smtp-Source: ADUXVKL6XtL4/fbtq5nsRG3CAwKam3Wv4cIKrTPvo3kWfdh2XRGhP8/cEnlNB6Pc9xDC6gDh3BXOBw==
Date: Mon, 4 Jun 2018 07:10:04 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: alexandre.torgue@st.com, thierry.reding@gmail.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH v5 2/6] mfd: stm32-timers: add support for dmas
Message-ID: <20180604061004.GA25455@dell>
References: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
 <1526456161-27865-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526456161-27865-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018, Fabrice Gasnier wrote:

> STM32 Timers can support up to 7 DMA requests:
> - 4 channels, update, compare and trigger.
> Optionally request part, or all DMAs from stm32-timers MFD core.
> 
> Also add routine to implement burst reads using DMA from timer registers.
> This is exported. So, it can be used by child drivers, PWM capture
> for instance (but not limited to).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
> Changes in v5:
> - fix warning on dma_mapping_error() that doesn't return an error code.
> - move stm32_timers_dma struct to header file as discussed with Lee.
>   This allows to remove alloc for this struct in stm32_timers_dma_probe.
> 
> Changes in v4:
> - Lee's comments: Add kerneldoc header, better format comments.
> 
> Changes in v3:
> - Basically Lee's comments:
> - rather create a struct stm32_timers_dma, and place a reference to it
>   in existing ddata (instead of adding priv struct).
> - rather use a struct device in exported routine prototype, and use
>   standard helpers instead of ddata. Get rid of to_stm32_timers_priv().
> - simplify error handling in probe (remove a goto)
> - comment on devm_of_platform_*populate() usage.
> 
> Changes in v2:
> - Abstract DMA handling from child driver: move it to MFD core
> - Add comments on optional dma support
> ---
>  drivers/mfd/stm32-timers.c       | 201 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/stm32-timers.h |  46 +++++++++
>  2 files changed, 245 insertions(+), 2 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
