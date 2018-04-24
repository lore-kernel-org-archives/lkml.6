Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932851AbeDXDZz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:25:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932776AbeDXDZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:25:53 -0400
Subject: Re: [PATCH v5 2/2] drivers: soc: Add LLCC driver
To: Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, kyan@codeaurora.org, ckadabi@codeaurora.org,
        evgreen@chromium.org, robh@kernel.org
References: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org>
 <1524524972-12014-3-git-send-email-rishabhb@codeaurora.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4856aba7-4a06-eb15-57d5-abfd28f8a15f@infradead.org>
Date: Mon, 23 Apr 2018 20:25:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524524972-12014-3-git-send-email-rishabhb@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2018 04:09 PM, Rishabh Bhatnagar wrote:

> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e050eb8..2b09321 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -21,6 +21,23 @@ config QCOM_GSBI
>            functions for connecting the underlying serial UART, SPI, and I2C
>            devices to the output pins.
> 
> +config QCOM_LLCC
> +	tristate "Qualcomm Technologies, Inc. LLCC driver"
> +	depends on ARCH_QCOM
> +	help
> +	  Qualcomm Technologies, Inc. platform specific
> +	  Last Level Cache Controller(LLCC) driver. This provides interfaces
> +	  to client's that use the LLCC. Say yes here to enable LLCC slice

	  to clients

> +	  driver.
> +
> +config QCOM_SDM845_LLCC
> +	tristate "Qualcomm Technologies, Inc. SDM845 LLCC driver"
> +	depends on QCOM_LLCC
> +	help
> +	  Say yes here to enable the LLCC driver for SDM845. This provides
> +	  data required to configure LLCC so that clients can start using the
> +	  LLCC slices.
> +
>  config QCOM_MDT_LOADER
>  	tristate
>  	select QCOM_SCM


-- 
~Randy
