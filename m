Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeEVSKW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:10:22 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45629 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEVSKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:10:20 -0400
X-Google-Smtp-Source: AB8JxZpD1JtxG4wrzlQuXFI0uhfJ6N1LyF70KSsaQPcF1Hf9SXhvgzOziz1Zq4UIkCpuO4Dg0rsEhQ==
MIME-Version: 1.0
References: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org> <1526552938-21292-2-git-send-email-vviswana@codeaurora.org>
In-Reply-To: <1526552938-21292-2-git-send-email-vviswana@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 22 May 2018 11:09:40 -0700
X-Gmail-Original-Message-ID: <CAE=gft7uoUSDmfrpzEQ_AGKPD3E25X6xwPiTkgsJwZn-zHaYuQ@mail.gmail.com>
Message-ID: <CAE=gft7uoUSDmfrpzEQ_AGKPD3E25X6xwPiTkgsJwZn-zHaYuQ@mail.gmail.com>
Subject: Re: [PATCH V1 1/3] mmc: sdhci-msm: Define new Register address map
To: vviswana@codeaurora.org
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>,
        sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,
On Thu, May 17, 2018 at 3:30 AM Vijay Viswanath <vviswana@codeaurora.org>
wrote:

> From: Sayali Lokhande <sayalil@codeaurora.org>

> For SDCC version 5.0.0, MCI registers are removed from SDCC
> interface and some registers are moved to HC.
> Define a new data structure where we can statically define
> the address offsets for the registers in different SDCC versions.

> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>   drivers/mmc/host/sdhci-msm.c | 89
++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 89 insertions(+)

> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index bb11916..2524455 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -137,6 +137,95 @@
>   /* Timeout value to avoid infinite waiting for pwr_irq */
>   #define MSM_PWR_IRQ_TIMEOUT_MS 5000

> +struct sdhci_msm_offset {
> +       u32 core_hc_mode;
> +       u32 core_mci_data_cnt;
> +       u32 core_mci_status;
> +       u32 core_mci_fifo_cnt;
> +       u32 core_mci_version;
> +       u32 core_generics;
> +       u32 core_testbus_config;
> +       u32 core_testbus_sel2_bit;
> +       u32 core_testbus_ena;
> +       u32 core_testbus_sel2;
> +       u32 core_pwrctl_status;
> +       u32 core_pwrctl_mask;
> +       u32 core_pwrctl_clear;
> +       u32 core_pwrctl_ctl;
> +       u32 core_sdcc_debug_reg;
> +       u32 core_dll_config;
> +       u32 core_dll_status;
> +       u32 core_vendor_spec;
> +       u32 core_vendor_spec_adma_err_addr0;
> +       u32 core_vendor_spec_adma_err_addr1;
> +       u32 core_vendor_spec_func2;
> +       u32 core_vendor_spec_capabilities0;
> +       u32 core_ddr_200_cfg;
> +       u32 core_vendor_spec3;
> +       u32 core_dll_config_2;
> +       u32 core_ddr_config;
> +       u32 core_ddr_config_2;
> +};
> +
> +static const struct sdhci_msm_offset sdhci_msm_v5_offset = {
> +       .core_mci_data_cnt = 0x35c,
> +       .core_mci_status = 0x324,
> +       .core_mci_fifo_cnt = 0x308,
> +       .core_mci_version = 0x318,
> +       .core_generics = 0x320,
> +       .core_testbus_config = 0x32c,
> +       .core_testbus_sel2_bit = 3,
> +       .core_testbus_ena = (1 << 31),
> +       .core_testbus_sel2 = (1 << 3),
> +       .core_pwrctl_status = 0x240,
> +       .core_pwrctl_mask = 0x244,
> +       .core_pwrctl_clear = 0x248,
> +       .core_pwrctl_ctl = 0x24c,
> +       .core_sdcc_debug_reg = 0x358,
> +       .core_dll_config = 0x200,
> +       .core_dll_status = 0x208,
> +       .core_vendor_spec = 0x20c,
> +       .core_vendor_spec_adma_err_addr0 = 0x214,
> +       .core_vendor_spec_adma_err_addr1 = 0x218,
> +       .core_vendor_spec_func2 = 0x210,
> +       .core_vendor_spec_capabilities0 = 0x21c,
> +       .core_ddr_200_cfg = 0x224,
> +       .core_vendor_spec3 = 0x250,
> +       .core_dll_config_2 = 0x254,
> +       .core_ddr_config = 0x258,
> +       .core_ddr_config_2 = 0x25c,
> +};
> +
> +static const struct sdhci_msm_offset sdhci_msm_mci_offset = {
> +       .core_hc_mode = 0x78,
> +       .core_mci_data_cnt = 0x30,
> +       .core_mci_status = 0x34,
> +       .core_mci_fifo_cnt = 0x44,
> +       .core_mci_version = 0x050,
> +       .core_generics = 0x70,
> +       .core_testbus_config = 0x0CC,
> +       .core_testbus_sel2_bit = 4,
> +       .core_testbus_ena = (1 << 3),
> +       .core_testbus_sel2 = (1 << 4),
> +       .core_pwrctl_status = 0xDC,
> +       .core_pwrctl_mask = 0xE0,
> +       .core_pwrctl_clear = 0xE4,
> +       .core_pwrctl_ctl = 0xE8,
> +       .core_sdcc_debug_reg = 0x124,
> +       .core_dll_config = 0x100,
> +       .core_dll_status = 0x108,
> +       .core_vendor_spec = 0x10C,
> +       .core_vendor_spec_adma_err_addr0 = 0x114,
> +       .core_vendor_spec_adma_err_addr1 = 0x118,
> +       .core_vendor_spec_func2 = 0x110,
> +       .core_vendor_spec_capabilities0 = 0x11C,
> +       .core_ddr_200_cfg = 0x184,
> +       .core_vendor_spec3 = 0x1B0,
> +       .core_dll_config_2 = 0x1B4,
> +       .core_ddr_config = 0x1B8,
> +       .core_ddr_config_2 = 0x1BC,
> +};
> +

I notice a lot of these are never used in the subsequent patches of this
series. I guess more register definitions are always better than fewer,
it's just a shame that they take up space now. Did you just add everything
that was different between v4 and v5, or how did you come up with this set?

Also, I think lowercase hex letters are preferred.

I verified that the v5 register offsets look good, at least for the
registers I have documentation for.

-Evan
