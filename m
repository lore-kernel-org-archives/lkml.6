Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeDSRWz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:22:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36801 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbeDSRWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:22:53 -0400
X-Google-Smtp-Source: AIpwx48ovAXmbbOCWhJ7ILlJQCEILAvE9zIkJQ2A4p83B83qlteQ+y46o4DLHe68kc5V6ZL2LyPnIA==
Date: Thu, 19 Apr 2018 10:22:49 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi S <sibis@codeaurora.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 4/7] mailbox: Add support for Qualcomm SDM845 SoCs
Message-ID: <20180419172249.GY18510@minitux>
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-5-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521019283-32212-5-git-send-email-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Mar 02:21 PDT 2018, Sibi S wrote:

> Add the corresponding APCS offset for SDM845 SoC
> 
> Signed-off-by: Sibi S <sibis@codeaurora.org>

Full name please.

> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 57bde0d..62d704d 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -125,6 +125,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>  static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = (void *)8 },
>  	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = (void *)16 },
> +	{ .compatible = "qcom,sdm845-apcs-hmss-global", .data = (void *)12 },

The block seems to be called "apss shared", so make the compatible
"qcom,sdm845-apss-shared".

Please resubmit this patch separate from the others in the series, as
they can be merged independently of the rest of the series.


PS. For updates like this you can generally submit the dt and code
together.

Regards,
Bjorn
