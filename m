Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970060AbeEXM1k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:27:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965933AbeEXM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:27:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FB2960213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
Subject: Re: [PATCH V1 1/3] mmc: sdhci-msm: Define new Register address map
To: Evan Green <evgreen@chromium.org>
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>,
        sayalil@codeaurora.org
References: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org>
 <1526552938-21292-2-git-send-email-vviswana@codeaurora.org>
 <CAE=gft7uoUSDmfrpzEQ_AGKPD3E25X6xwPiTkgsJwZn-zHaYuQ@mail.gmail.com>
From: Vijay Viswanath <vviswana@codeaurora.org>
Message-ID: <d84dd4ca-f921-d9e9-c1bf-d9354f308e2b@codeaurora.org>
Date: Thu, 24 May 2018 17:57:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft7uoUSDmfrpzEQ_AGKPD3E25X6xwPiTkgsJwZn-zHaYuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2018 11:39 PM, Evan Green wrote:
> Hi Vijay,
> On Thu, May 17, 2018 at 3:30 AM Vijay Viswanath <vviswana@codeaurora.org>
> wrote:
> 
>> From: Sayali Lokhande <sayalil@codeaurora.org>
> 
>> For SDCC version 5.0.0, MCI registers are removed from SDCC
>> interface and some registers are moved to HC.
>> Define a new data structure where we can statically define
>> the address offsets for the registers in different SDCC versions.
> 
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> ---
>>    drivers/mmc/host/sdhci-msm.c | 89
> ++++++++++++++++++++++++++++++++++++++++++++
>>    1 file changed, 89 insertions(+)
> 
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index bb11916..2524455 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -137,6 +137,95 @@
>>    /* Timeout value to avoid infinite waiting for pwr_irq */
>>    #define MSM_PWR_IRQ_TIMEOUT_MS 5000
> 
>> +struct sdhci_msm_offset {
>> +       u32 core_hc_mode;
>> +       u32 core_mci_data_cnt;
>> +       u32 core_mci_status;
>> +       u32 core_mci_fifo_cnt;
>> +       u32 core_mci_version;
>> +       u32 core_generics;
>> +       u32 core_testbus_config;
>> +       u32 core_testbus_sel2_bit;
>> +       u32 core_testbus_ena;
>> +       u32 core_testbus_sel2;
>> +       u32 core_pwrctl_status;
>> +       u32 core_pwrctl_mask;
>> +       u32 core_pwrctl_clear;
>> +       u32 core_pwrctl_ctl;
>> +       u32 core_sdcc_debug_reg;
>> +       u32 core_dll_config;
>> +       u32 core_dll_status;
>> +       u32 core_vendor_spec;
>> +       u32 core_vendor_spec_adma_err_addr0;
>> +       u32 core_vendor_spec_adma_err_addr1;
>> +       u32 core_vendor_spec_func2;
>> +       u32 core_vendor_spec_capabilities0;
>> +       u32 core_ddr_200_cfg;
>> +       u32 core_vendor_spec3;
>> +       u32 core_dll_config_2;
>> +       u32 core_ddr_config;
>> +       u32 core_ddr_config_2;
>> +};
>> +
>> +static const struct sdhci_msm_offset sdhci_msm_v5_offset = {
>> +       .core_mci_data_cnt = 0x35c,
>> +       .core_mci_status = 0x324,
>> +       .core_mci_fifo_cnt = 0x308,
>> +       .core_mci_version = 0x318,
>> +       .core_generics = 0x320,
>> +       .core_testbus_config = 0x32c,
>> +       .core_testbus_sel2_bit = 3,
>> +       .core_testbus_ena = (1 << 31),
>> +       .core_testbus_sel2 = (1 << 3),
>> +       .core_pwrctl_status = 0x240,
>> +       .core_pwrctl_mask = 0x244,
>> +       .core_pwrctl_clear = 0x248,
>> +       .core_pwrctl_ctl = 0x24c,
>> +       .core_sdcc_debug_reg = 0x358,
>> +       .core_dll_config = 0x200,
>> +       .core_dll_status = 0x208,
>> +       .core_vendor_spec = 0x20c,
>> +       .core_vendor_spec_adma_err_addr0 = 0x214,
>> +       .core_vendor_spec_adma_err_addr1 = 0x218,
>> +       .core_vendor_spec_func2 = 0x210,
>> +       .core_vendor_spec_capabilities0 = 0x21c,
>> +       .core_ddr_200_cfg = 0x224,
>> +       .core_vendor_spec3 = 0x250,
>> +       .core_dll_config_2 = 0x254,
>> +       .core_ddr_config = 0x258,
>> +       .core_ddr_config_2 = 0x25c,
>> +};
>> +
>> +static const struct sdhci_msm_offset sdhci_msm_mci_offset = {
>> +       .core_hc_mode = 0x78,
>> +       .core_mci_data_cnt = 0x30,
>> +       .core_mci_status = 0x34,
>> +       .core_mci_fifo_cnt = 0x44,
>> +       .core_mci_version = 0x050,
>> +       .core_generics = 0x70,
>> +       .core_testbus_config = 0x0CC,
>> +       .core_testbus_sel2_bit = 4,
>> +       .core_testbus_ena = (1 << 3),
>> +       .core_testbus_sel2 = (1 << 4),
>> +       .core_pwrctl_status = 0xDC,
>> +       .core_pwrctl_mask = 0xE0,
>> +       .core_pwrctl_clear = 0xE4,
>> +       .core_pwrctl_ctl = 0xE8,
>> +       .core_sdcc_debug_reg = 0x124,
>> +       .core_dll_config = 0x100,
>> +       .core_dll_status = 0x108,
>> +       .core_vendor_spec = 0x10C,
>> +       .core_vendor_spec_adma_err_addr0 = 0x114,
>> +       .core_vendor_spec_adma_err_addr1 = 0x118,
>> +       .core_vendor_spec_func2 = 0x110,
>> +       .core_vendor_spec_capabilities0 = 0x11C,
>> +       .core_ddr_200_cfg = 0x184,
>> +       .core_vendor_spec3 = 0x1B0,
>> +       .core_dll_config_2 = 0x1B4,
>> +       .core_ddr_config = 0x1B8,
>> +       .core_ddr_config_2 = 0x1BC,
>> +};
>> +
> 
> I notice a lot of these are never used in the subsequent patches of this
> series. I guess more register definitions are always better than fewer,
> it's just a shame that they take up space now. Did you just add everything
> that was different between v4 and v5, or how did you come up with this set?
> 
> Also, I think lowercase hex letters are preferred.
> 
> I verified that the v5 register offsets look good, at least for the
> registers I have documentation for.
> 
Yeah, felt it better to include all registers even they are not used 
currently.

Will change to use  lowercase hex letters

> -Evan
> 
