Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeBVLBM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:01:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbeBVLBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:01:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C58D46031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v3 24/25] ASoC: qcom: apq8096: Add db820c
 machine driver
To: srinivas.kandagatla@linaro.org, andy.gross@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org,
        spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <2d646729-9bb2-86e5-22f5-19aaf009c0cc@codeaurora.org>
Date: Thu, 22 Feb 2018 16:30:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2018 10:28 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to DB820c machine driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig   |   8 +++
>   sound/soc/qcom/apq8096.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 181 insertions(+)
>   create mode 100644 sound/soc/qcom/apq8096.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 8c2d65e0a28e..fa4b575c086c 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -77,3 +77,11 @@ config SND_SOC_QDSP6
>   	 This will enable sound soc platform specific
>   	 audio drivers. This includes q6asm, q6adm,
>   	 q6afe interfaces to DSP using apr.
> +
> +config SND_SOC_MSM8996
> +	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
> +	depends on QCOM_APR
> +	select SND_SOC_QDSP6V2
should be select SND_SOC_QDSP6, V2 is not defined
> +	default n
> +	help
> +	 To add support for SoC audio on MSM8996 and APQ8096 boards
>
