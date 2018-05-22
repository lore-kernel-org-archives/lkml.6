Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEVTp6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:45:58 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33178 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeEVTp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:45:56 -0400
X-Google-Smtp-Source: AB8JxZpyVkFiKKX7ZPVXkDexuFfjXdhnbG5dCBNuxyEDpuMC+LE8xlYJeqgjfaLaW87cN8mgf5/M6A==
Date: Tue, 22 May 2018 14:45:54 -0500
From: Rob Herring <robh@kernel.org>
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
Subject: Re: [PATCH V1 3/3] mmc: host: Register changes for sdcc V5
Message-ID: <20180522194554.GA21209@rob-hp-laptop>
References: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org>
 <1526552938-21292-4-git-send-email-vviswana@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526552938-21292-4-git-send-email-vviswana@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 03:58:58PM +0530, Vijay Viswanath wrote:
> From: Sayali Lokhande <sayalil@codeaurora.org>
> 
> For SDCC version 5.0.0 and higher, new compatible string
> "qcom,sdhci-msm-v5" is added.
> 
> Based on the msm variant, pick the relevant variant data and
> use it for register read/write to msm specific registers.
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |   5 +-

Please split binding patches.

>  drivers/mmc/host/sdhci-msm.c                       | 344 +++++++++++++--------
>  2 files changed, 222 insertions(+), 127 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index bfdcdc4..c2b7b2b 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -4,7 +4,10 @@ This file documents differences between the core properties in mmc.txt
>  and the properties used by the sdhci-msm driver.
>  
>  Required properties:
> -- compatible: Should contain "qcom,sdhci-msm-v4".
> +- compatible: Should contain "qcom,sdhci-msm-v4" or "qcom,sdhci-msm-v5".

Format with 1 per line.

> +		 For SDCC version 5.0.0, MCI registers are removed from SDCC
> +		 interface and some registers are moved to HC. New compatible
> +		 string is added to support this change - "qcom,sdhci-msm-v5".
>  - reg: Base address and length of the register in the following order:
>  	- Host controller register map (required)
>  	- SD Core register map (required)
