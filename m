Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3233BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753882088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b45Ur+Da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753882088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeGYKqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:46:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40948 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbeGYKqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:46:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so4478772wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 02:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=36RjgOBnGNEydIychZtcnhWI++JndIUpMgaJC8EaB6k=;
        b=b45Ur+DaJxEvQyIg1rFizZrJLkOZ8HaoRLlLspMnlBnwNXXKzVouiIdUdcyRoqzmRJ
         V4HyjSxBQM+NUyNQWC6aG7yOY0TS+BB1utNs+BpY6ntNgcMgMDf2cCwueo0BO5r1DC24
         ThOuulZr4ZIVEh3Ru/0a7OCtG9KL/8bZUHEjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36RjgOBnGNEydIychZtcnhWI++JndIUpMgaJC8EaB6k=;
        b=N9LiLBgs4dGfCNmz+MqW1QC7MAVEsX3z1861OxNGTmOFjUAbC6KhOHVqVATAGunnJJ
         lG8KjfDtcYOykagGnm8kEaqbv4c0b4IJJHsar3ntfWmh/uXlTnFFkAb+5YFvJX5UCtCs
         F9HjR41lLBB6jtsmqOlXcKHYmEbvbs8ZDCQY80hxNM9pfyhq3+ubJl/PIZtvb7JZI+zd
         bC/fgUkrZI0f/mKZ0MS8klNsQR8JMQmsC1fhk4T8hcaMwb8bsNhpUFs1RV6ZH3S1FLcz
         AJS2YpcObs0cyWGlb7wcpQoD7dCpNWcGbhCJbMC4nMRqCUI/Z+GGI5BgJc6qBChXXiyh
         ytvA==
X-Gm-Message-State: AOUpUlEN09o9MIzxzkM/NJsQ9pJpHnMb8I/TvwUVxdiU7scn0XBccgvJ
        gRVXP1iZEw5XV2IxKr7ONheTHw==
X-Google-Smtp-Source: AAOMgpeJtqalyD9hGL86ViaCSxywCARMNWJHOLxa2icNPpYEZQQqpD0jgNxpv2BhDQALhcK34Z0sWg==
X-Received: by 2002:a1c:a813:: with SMTP id r19-v6mr4033521wme.100.1532511330368;
        Wed, 25 Jul 2018 02:35:30 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id h2-v6sm3999815wmf.28.2018.07.25.02.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 02:35:29 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] venus: firmware: add routine to reset ARM9
To:     Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
References: <1530731212-30474-1-git-send-email-vgarodia@codeaurora.org>
 <1530731212-30474-2-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <8635f09f-a464-2ec6-a29d-9c2fc7601a36@linaro.org>
Date:   Wed, 25 Jul 2018 12:35:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1530731212-30474-2-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 07/04/2018 10:06 PM, Vikash Garodia wrote:
> Add routine to reset the ARM9 and brings it out of reset. Also
> abstract the Venus CPU state handling with a new function. This
> is in preparation to add PIL functionality in venus driver.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.h         |  1 +
>  drivers/media/platform/qcom/venus/firmware.c     | 36 ++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/firmware.h     |  1 +
>  drivers/media/platform/qcom/venus/hfi_venus.c    | 13 +++------
>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  5 ++++
>  5 files changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 2f02365..eb5ee66 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -129,6 +129,7 @@ struct venus_core {
>  	struct device *dev;
>  	struct device *dev_dec;
>  	struct device *dev_enc;
> +	bool no_tz;
>  	struct mutex lock;
>  	struct list_head instances;
>  	atomic_t insts_count;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 521d4b3..3968553d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -22,11 +22,47 @@
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  
> +#include "core.h"
>  #include "firmware.h"
> +#include "hfi_venus_io.h"
>  
>  #define VENUS_PAS_ID			9
>  #define VENUS_FW_MEM_SIZE		(6 * SZ_1M)
>  
> +static void venus_reset_cpu(struct venus_core *core)
> +{
> +	void __iomem *base = core->base;
> +
> +	writel(0, base + WRAPPER_FW_START_ADDR);
> +	writel(VENUS_FW_MEM_SIZE, base + WRAPPER_FW_END_ADDR);
> +	writel(0, base + WRAPPER_CPA_START_ADDR);
> +	writel(VENUS_FW_MEM_SIZE, base + WRAPPER_CPA_END_ADDR);
> +	writel(0x0, base + WRAPPER_CPU_CGC_DIS);
> +	writel(0x0, base + WRAPPER_CPU_CLOCK_CONFIG);
> +
> +	/* Make sure all register writes are committed. */
> +	mb();
> +
> +	/* Bring ARM9 out of reset */
> +	writel_relaxed(0, base + WRAPPER_A9SS_SW_RESET);

replace writel_relaxed with writel and drop above mb. The writel has wmb
just before writing so I think using writel here is better choice.

> +}
> +
> +int venus_set_hw_state(struct venus_core *core, bool resume)

s/resume/suspend as it is done in the function prototype in firmware.h.

> +{
> +	void __iomem *base = core->base;
> +
> +	if (!core->no_tz)
> +		return qcom_scm_set_remote_state(resume, 0);
> +
> +	if (resume)
> +		venus_reset_cpu(core);
> +	else
> +		writel(1, base + WRAPPER_A9SS_SW_RESET);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(venus_set_hw_state);
> +
>  int venus_boot(struct device *dev, const char *fwname)
>  {
>  	const struct firmware *mdt;
> diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
> index 428efb5..ff2e70e 100644
> --- a/drivers/media/platform/qcom/venus/firmware.h
> +++ b/drivers/media/platform/qcom/venus/firmware.h
> @@ -18,5 +18,6 @@
>  
>  int venus_boot(struct device *dev, const char *fwname);
>  int venus_shutdown(struct device *dev);
> +int venus_set_hw_state(struct venus_core *core, bool suspend);

could you make two inline functions here, call them
venus_set_hw_state_suspend() and venus_set_hw_state_resume() which just
call venus_set_hw_state with the right state.

>  
>  #endif
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 9366dae..5b56925 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -19,7 +19,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> -#include <linux/qcom_scm.h>
>  #include <linux/slab.h>
>  
>  #include "core.h"
> @@ -27,6 +26,7 @@
>  #include "hfi_msgs.h"
>  #include "hfi_venus.h"
>  #include "hfi_venus_io.h"
> +#include "firmware.h"
>  
>  #define HFI_MASK_QHDR_TX_TYPE		0xff000000
>  #define HFI_MASK_QHDR_RX_TYPE		0x00ff0000
> @@ -55,11 +55,6 @@
>  #define IFACEQ_VAR_LARGE_PKT_SIZE	512
>  #define IFACEQ_VAR_HUGE_PKT_SIZE	(1024 * 12)
>  
> -enum tzbsp_video_state {
> -	TZBSP_VIDEO_STATE_SUSPEND = 0,
> -	TZBSP_VIDEO_STATE_RESUME
> -};
> -
>  struct hfi_queue_table_header {
>  	u32 version;
>  	u32 size;
> @@ -575,7 +570,7 @@ static int venus_power_off(struct venus_hfi_device *hdev)
>  	if (!hdev->power_enabled)
>  		return 0;
>  
> -	ret = qcom_scm_set_remote_state(TZBSP_VIDEO_STATE_SUSPEND, 0);
> +	ret = venus_set_hw_state(hdev->core, false);

... and use venus_set_hw_state_suspend()

>  	if (ret)
>  		return ret;
>  
> @@ -595,7 +590,7 @@ static int venus_power_on(struct venus_hfi_device *hdev)
>  	if (hdev->power_enabled)
>  		return 0;
>  
> -	ret = qcom_scm_set_remote_state(TZBSP_VIDEO_STATE_RESUME, 0);
> +	ret = venus_set_hw_state(hdev->core, true);

... and use venus_set_hw_state_resume()

>  	if (ret)
>  		goto err;
>  
> @@ -608,7 +603,7 @@ static int venus_power_on(struct venus_hfi_device *hdev)
>  	return 0;
>  
>  err_suspend:
> -	qcom_scm_set_remote_state(TZBSP_VIDEO_STATE_SUSPEND, 0);
> +	venus_set_hw_state(hdev->core, false);
>  err:
>  	hdev->power_enabled = false;
>  	return ret;
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h b/drivers/media/platform/qcom/venus/hfi_venus_io.h
> index def0926..0a4210f 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus_io.h
> +++ b/drivers/media/platform/qcom/venus/hfi_venus_io.h
> @@ -112,6 +112,11 @@
>  #define WRAPPER_CPU_STATUS			(WRAPPER_BASE + 0x2014)
>  #define WRAPPER_CPU_STATUS_WFI			BIT(0)
>  #define WRAPPER_SW_RESET			(WRAPPER_BASE + 0x3000)
> +#define WRAPPER_CPA_START_ADDR	(WRAPPER_BASE + 0x1020)
> +#define WRAPPER_CPA_END_ADDR		(WRAPPER_BASE + 0x1024)
> +#define WRAPPER_FW_START_ADDR	(WRAPPER_BASE + 0x1028)
> +#define WRAPPER_FW_END_ADDR			(WRAPPER_BASE + 0x102C)
> +#define WRAPPER_A9SS_SW_RESET	(WRAPPER_BASE + 0x3000)

something is wrong with tabs/indentation could you check? seems only
WRAPPER_FW_END_ADDR is fine.

>  
>  /* Venus 4xx */
>  #define WRAPPER_VCODEC0_MMCC_POWER_STATUS	(WRAPPER_BASE + 0x90)
> 

-- 
regards,
Stan
