Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754040AbeDPMYd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:24:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39778 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753413AbeDPMYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:24:30 -0400
X-Google-Smtp-Source: AIpwx4/CwilAg6y96iZoJkA33+vHVzjlwLkV994D5yVNkC9Ph61Fq1A2micgEfSC4q94R71LH4ntSQ==
Date: Mon, 16 Apr 2018 13:24:26 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] pwm: stm32: add capture support
Message-ID: <20180416122426.72lhi3hrk2g7y526@dell>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
 <1522404084-24903-4-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522404084-24903-4-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018, Fabrice Gasnier wrote:

> Add support for PMW input mode on pwm-stm32. STM32 timers support
> period and duty cycle capture as long as they have at least two PWM
> channels. One capture channel is used for period (rising-edge), one
> for duty-cycle (falling-edge).
> When there's only one channel available, only period can be captured.
> Duty-cycle is simply zero'ed in such a case.
> 
> Capture requires exclusive access (e.g. no pwm output running at the
> same time, to protect common prescaler).
> Timer DMA burst mode (from MFD core) is being used, to take two
> snapshots of capture registers (upon each period rising edge).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
> Changes in v3:
> - update stm32_timers_dma_burst_read() call: don't pass ddata structure,
>   use MFD parent device structure instead since MFD core update.
> 
> Changes in v2:
> - DMA handling has been moved to MFD core. Rework capture routines to
>   use it.
> ---
>  drivers/pwm/pwm-stm32.c          | 176 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stm32-timers.h |  11 +++

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 187 insertions(+)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
