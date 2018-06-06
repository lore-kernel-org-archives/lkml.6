Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B7E5607F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeFFGbq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:31:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:22681 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932097AbeFFGbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:31:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,482,1520924400";
   d="scan'208";a="47659498"
Subject: Re: [PATCH V2 1/4] mmc: sdhci-msm: Define new Register address map
To: Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-2-git-send-email-vviswana@codeaurora.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2adfe55e-1c75-046b-594c-aa80b732c68d@intel.com>
Date: Wed, 6 Jun 2018 09:30:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527587561-27448-2-git-send-email-vviswana@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/18 12:52, Vijay Viswanath wrote:
> From: Sayali Lokhande <sayalil@codeaurora.org>
> 
> For SDCC version 5.0.0, MCI registers are removed from SDCC
> interface and some registers are moved to HC.
> Define a new data structure where we can statically define
> the address offsets for the registers in different SDCC versions.
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>

It would be prettier to line up the '=' and use BIT() not << but nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-msm.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index bb11916..4050c99 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -137,6 +137,95 @@
>  /* Timeout value to avoid infinite waiting for pwr_irq */
>  #define MSM_PWR_IRQ_TIMEOUT_MS 5000
>  
> +struct sdhci_msm_offset {
> +	u32 core_hc_mode;
> +	u32 core_mci_data_cnt;
> +	u32 core_mci_status;
> +	u32 core_mci_fifo_cnt;
> +	u32 core_mci_version;
> +	u32 core_generics;
> +	u32 core_testbus_config;
> +	u32 core_testbus_sel2_bit;
> +	u32 core_testbus_ena;
> +	u32 core_testbus_sel2;
> +	u32 core_pwrctl_status;
> +	u32 core_pwrctl_mask;
> +	u32 core_pwrctl_clear;
> +	u32 core_pwrctl_ctl;
> +	u32 core_sdcc_debug_reg;
> +	u32 core_dll_config;
> +	u32 core_dll_status;
> +	u32 core_vendor_spec;
> +	u32 core_vendor_spec_adma_err_addr0;
> +	u32 core_vendor_spec_adma_err_addr1;
> +	u32 core_vendor_spec_func2;
> +	u32 core_vendor_spec_capabilities0;
> +	u32 core_ddr_200_cfg;
> +	u32 core_vendor_spec3;
> +	u32 core_dll_config_2;
> +	u32 core_ddr_config;
> +	u32 core_ddr_config_2;
> +};
> +
> +static const struct sdhci_msm_offset sdhci_msm_v5_offset = {
> +	.core_mci_data_cnt = 0x35c,
> +	.core_mci_status = 0x324,
> +	.core_mci_fifo_cnt = 0x308,
> +	.core_mci_version = 0x318,
> +	.core_generics = 0x320,
> +	.core_testbus_config = 0x32c,
> +	.core_testbus_sel2_bit = 3,
> +	.core_testbus_ena = (1 << 31),
> +	.core_testbus_sel2 = (1 << 3),
> +	.core_pwrctl_status = 0x240,
> +	.core_pwrctl_mask = 0x244,
> +	.core_pwrctl_clear = 0x248,
> +	.core_pwrctl_ctl = 0x24c,
> +	.core_sdcc_debug_reg = 0x358,
> +	.core_dll_config = 0x200,
> +	.core_dll_status = 0x208,
> +	.core_vendor_spec = 0x20c,
> +	.core_vendor_spec_adma_err_addr0 = 0x214,
> +	.core_vendor_spec_adma_err_addr1 = 0x218,
> +	.core_vendor_spec_func2 = 0x210,
> +	.core_vendor_spec_capabilities0 = 0x21c,
> +	.core_ddr_200_cfg = 0x224,
> +	.core_vendor_spec3 = 0x250,
> +	.core_dll_config_2 = 0x254,
> +	.core_ddr_config = 0x258,
> +	.core_ddr_config_2 = 0x25c,
> +};
> +
> +static const struct sdhci_msm_offset sdhci_msm_mci_offset = {
> +	.core_hc_mode = 0x78,
> +	.core_mci_data_cnt = 0x30,
> +	.core_mci_status = 0x34,
> +	.core_mci_fifo_cnt = 0x44,
> +	.core_mci_version = 0x050,
> +	.core_generics = 0x70,
> +	.core_testbus_config = 0x0cc,
> +	.core_testbus_sel2_bit = 4,
> +	.core_testbus_ena = (1 << 3),
> +	.core_testbus_sel2 = (1 << 4),
> +	.core_pwrctl_status = 0xdc,
> +	.core_pwrctl_mask = 0xe0,
> +	.core_pwrctl_clear = 0xe4,
> +	.core_pwrctl_ctl = 0xe8,
> +	.core_sdcc_debug_reg = 0x124,
> +	.core_dll_config = 0x100,
> +	.core_dll_status = 0x108,
> +	.core_vendor_spec = 0x10c,
> +	.core_vendor_spec_adma_err_addr0 = 0x114,
> +	.core_vendor_spec_adma_err_addr1 = 0x118,
> +	.core_vendor_spec_func2 = 0x110,
> +	.core_vendor_spec_capabilities0 = 0x11c,
> +	.core_ddr_200_cfg = 0x184,
> +	.core_vendor_spec3 = 0x1b0,
> +	.core_dll_config_2 = 0x1b4,
> +	.core_ddr_config = 0x1b8,
> +	.core_ddr_config_2 = 0x1bc,
> +};
> +
>  struct sdhci_msm_host {
>  	struct platform_device *pdev;
>  	void __iomem *core_mem;	/* MSM SDCC mapped address */
> 
