Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755360AbeC0Q4f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:56:35 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42781 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeC0Q4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:56:31 -0400
X-Google-Smtp-Source: AIpwx4/mRZNCQuP7UmXLCWqH8Hwc4nPdZS8v6F4cpRwqkx5YDnoQQWwqoy9qQNdNdJ5NPQyp2dY8pg==
Date: Tue, 27 Mar 2018 09:56:41 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
Subject: Re: [PATCH v5 01/13] firmware: qcom: scm: Add ipq4019 soc compatible
Message-ID: <20180327165641.GG1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-2-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-2-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:

> Add the compatible for ipq4019.
> This does not need clocks to do scm calls.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
>  drivers/firmware/qcom_scm.c                             | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> index 7b40054..fcf6979 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> @@ -11,9 +11,10 @@ Required properties:
>   * "qcom,scm-msm8660" for MSM8660 platforms
>   * "qcom,scm-msm8690" for MSM8690 platforms
>   * "qcom,scm-msm8996" for MSM8996 platforms
> + * "qcom,scm-ipq4019" for IPQ4019 platforms
>   * "qcom,scm" for later processors (MSM8916, APQ8084, MSM8974, etc)
>  - clocks: One to three clocks may be required based on compatible.
> - * No clock required for "qcom,scm-msm8996"
> + * No clock required for "qcom,scm-msm8996", "qcom,scm-ipq4019"
>   * Only core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660", and "qcom,scm-msm8960"
>   * Core, iface, and bus clocks required for "qcom,scm"
>  - clock-names: Must contain "core" for the core clock, "iface" for the interface
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 5a7d6930..e778af7 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -603,6 +603,9 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
>  	{ .compatible = "qcom,scm-msm8996",
>  	  .data = NULL, /* no clocks */
>  	},
> +	{ .compatible = "qcom,scm-ipq4019",
> +	  .data = NULL, /* no clocks */
> +	},
>  	{ .compatible = "qcom,scm",
>  	  .data = (void *)(SCM_HAS_CORE_CLK
>  			   | SCM_HAS_IFACE_CLK
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
