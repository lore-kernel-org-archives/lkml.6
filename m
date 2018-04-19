Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDSE7s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:59:48 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38654 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbeDSE7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:59:45 -0400
X-Google-Smtp-Source: AIpwx4+EbXqI7XQBug94cDha9iUPwW1C0paoq9DNt8iSnFWJPf+fZaIkCRzhaEMhVV07IdiVk8+fpg==
Date: Wed, 18 Apr 2018 21:59:42 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Evan Green <evgreen@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] soc: Unconditionally include qcom Makefile
Message-ID: <20180419045942.GU18510@minitux>
References: <20180418232847.17020-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418232847.17020-1-evgreen@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18 Apr 16:28 PDT 2018, Evan Green wrote:

> From: Guenter Roeck <groeck@chromium.org>
> 
> Incoming Qualcomm changes for GENI, i2c [1], and cmd-db [2] are enabled
> with COMPILE_TEST in drivers/soc/qcom. For this to work, the Makefile
> in that directory has to be included unconditionally, rather than only
> if ARCH_QCOM is enabled.
> 
> Example of the errors seen on allmodconfig with the GENI, i2c, and
> cmd-db patches applied:
> 
> Kernel: arch/x86/boot/bzImage is ready  (#1)
> ERROR: "geni_se_select_mode" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
> ERROR: "geni_se_init" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
> ERROR: "geni_se_config_packing" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
> ERROR: "geni_se_resources_on" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
> ERROR: "geni_se_resources_off" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
> ERROR: "geni_se_tx_dma_unprep" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> ERROR: "geni_se_tx_dma_prep" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> ERROR: "geni_se_rx_dma_unprep" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> ERROR: "geni_se_rx_dma_prep" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> ERROR: "geni_se_select_mode" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> ERROR: "geni_se_config_packing" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> ERROR: "geni_se_init" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> ERROR: "geni_se_resources_off" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> ERROR: "geni_se_resources_on" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
> make: *** [Makefile:1237: modules] Error 2
> 
> [1] https://patchwork.ozlabs.org/cover/893437/
> [2] https://lkml.org/lkml/2018/4/10/714
> 

Thanks, we have been working around this for a while now, let's just fix
it!

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/soc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 40523577bdaa..113e884697fd 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -14,7 +14,7 @@ obj-$(CONFIG_ARCH_MXC)		+= imx/
>  obj-$(CONFIG_SOC_XWAY)		+= lantiq/
>  obj-y				+= mediatek/
>  obj-$(CONFIG_ARCH_MESON)	+= amlogic/
> -obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> +obj-y				+= qcom/
>  obj-y				+= renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
> -- 
> 2.17.0.484.g0c8726318c-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
