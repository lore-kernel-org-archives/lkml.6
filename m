Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933145AbeEWNvk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:51:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932900AbeEWNvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:51:37 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vireshk@kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 1/8] soc: qcom: Separate kryo l2 accessors from PMU
 driver
To: Ilia Lin <ilialin@codeaurora.org>, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org, will.deacon@arm.com
References: <1527079981-11179-1-git-send-email-ilialin@codeaurora.org>
 <1527079981-11179-2-git-send-email-ilialin@codeaurora.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <1cd8b060-9dec-6dce-cb57-4a43bf441f12@arm.com>
Date: Wed, 23 May 2018 14:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527079981-11179-2-git-send-email-ilialin@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/05/18 13:52, Ilia Lin wrote:
> The driver provides kernel level API for other drivers
> to access the MSM8996 L2 cache registers.
> Separating the L2 access code from the PMU driver and
> making it public to allow other drivers use it.
> The accesses must be separated with a single spinlock,
> maintained in this driver.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  drivers/perf/Kconfig                 |  1 +
>  drivers/perf/qcom_l2_pmu.c           | 90 ++++++++++--------------------------
>  drivers/soc/qcom/Kconfig             |  3 ++
>  drivers/soc/qcom/Makefile            |  1 +
>  drivers/soc/qcom/kryo-l2-accessors.c | 56 ++++++++++++++++++++++
>  include/soc/qcom/kryo-l2-accessors.h | 12 +++++
>  6 files changed, 97 insertions(+), 66 deletions(-)
>  create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
>  create mode 100644 include/soc/qcom/kryo-l2-accessors.h
> 

[..
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 7093fe7..0567dff 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -39,6 +39,9 @@ config QCOM_GSBI
>            functions for connecting the underlying serial UART, SPI, and I2C
>            devices to the output pins.
>  
> +config QCOM_KRYO_L2_ACCESSORS
> +       bool
> +

I think kbuild bot complained about this and you haven't addressed it.
This can be enabled on ARM and build breaks due to missing sysreg.h
IIRC. Look at the kbuild report and fix it.

-- 
Regards,
Sudeep
