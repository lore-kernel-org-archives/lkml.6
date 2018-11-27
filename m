Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975F1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AD820664
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C6RRNQzi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ABTNcz6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AD820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeK0O2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:28:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbeK0O2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:28:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1AAAF607EB; Tue, 27 Nov 2018 03:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543289506;
        bh=Ub8P+rpiORyQVGCVvQAmPrRzvcRXqXv/cD+tc2JWCVs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C6RRNQzirzOtSHSMLA+iiZWBg2UX8l8Or7odxesv/MO7T+v4GFrgAqjC0bavAnOiX
         rTx1H/Pc9S2qRCJ2aOejtJmwS8KKhP9Q7Dkq96ViW5Nkqwqze0VlV96Uusb3zKJrjC
         1sC+8gCuTtq+At8JpNNAkWsk4GatRyj10LhvKA2Y=
Received: from [10.79.128.28] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7B0F60351;
        Tue, 27 Nov 2018 03:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543289505;
        bh=Ub8P+rpiORyQVGCVvQAmPrRzvcRXqXv/cD+tc2JWCVs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ABTNcz6hergajbd59Pr7Nwps/U+A8wTR5KDBsN1GcWMez+EuHuw255Y5OguNAOeUy
         QSX5y6W2Zo/VEfCJ3PqTHPVWraXyjwGk0PSynpiAfIAv8Po0gOeJ0ChSxomF5ZWEDB
         1zif4gPxzlLF7zQwEsuOI/MwiozS9ITzkqG1yt9A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7B0F60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 3/3] soc: qcom: Add AOSS QMP genpd provider
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181112080557.22698-1-bjorn.andersson@linaro.org>
 <20181112080557.22698-4-bjorn.andersson@linaro.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <dfd0096c-d1f1-da0e-7c4c-3da916d521dc@codeaurora.org>
Date:   Tue, 27 Nov 2018 09:01:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181112080557.22698-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 11/12/2018 1:35 PM, Bjorn Andersson wrote:
> The AOSS QMP genpd provider implements control over power-related
> resources related to low-power state associated with the remoteprocs in
> the system as well as control over a set of clocks related to debug
> hardware in the SoC.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/soc/qcom/Kconfig       |   8 ++
>   drivers/soc/qcom/Makefile      |   1 +
>   drivers/soc/qcom/aoss-qmp-pd.c | 135 +++++++++++++++++++++++++++++++++
>   3 files changed, 144 insertions(+)
>   create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index ba08fc00d7f5..e1eda3d59748 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -10,6 +10,14 @@ config QCOM_AOSS_QMP
>   	  micro-controller in the AOSS, using QMP, to control certain resource
>   	  that are not exposed through RPMh.
>   
> +config QCOM_AOSS_QMP_PD
> +	tristate "Qualcomm AOSS Messaging Power Domain driver"
> +	depends on QCOM_AOSS_QMP
> +	help
> +	  This driver provides the means of controlling the AOSSs handling of
> +	  low-power state for resources related to the remoteproc subsystems as
> +	  well as controlling the debug clocks.
> +
>   config QCOM_COMMAND_DB
>   	bool "Qualcomm Command DB"
>   	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index d0d7fdc94d9a..ebfa414a5b77 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   CFLAGS_rpmh-rsc.o := -I$(src)
>   obj-$(CONFIG_QCOM_AOSS_QMP) +=	aoss-qmp.o
> +obj-$(CONFIG_QCOM_AOSS_QMP_PD) += aoss-qmp-pd.o
>   obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>   obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
> diff --git a/drivers/soc/qcom/aoss-qmp-pd.c b/drivers/soc/qcom/aoss-qmp-pd.c
> new file mode 100644
> index 000000000000..467d0db4abfa
> --- /dev/null
> +++ b/drivers/soc/qcom/aoss-qmp-pd.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, Linaro Ltd
> + */
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/soc/qcom/aoss-qmp.h>
> +
> +#include <dt-bindings/power/qcom-aoss-qmp.h>
> +
> +struct qmp_pd {
> +	struct qmp *qmp;
> +
> +	struct generic_pm_domain pd;
> +
> +	const char *name;
> +};
> +
> +#define to_qmp_pd_resource(res) container_of(res, struct qmp_pd, pd)
> +
> +struct qmp_pd_resource {
> +	const char *name;
> +	int (*on)(struct generic_pm_domain *domain);
> +	int (*off)(struct generic_pm_domain *domain);
> +};
> +
> +static int qmp_pd_clock_toggle(struct qmp_pd *res, bool enable)
> +{
> +	char buf[96];
> +	size_t n;
> +
> +	n = snprintf(buf, sizeof(buf), "{class: clock, res: %s, val: %d}",
> +		     res->name, !!enable);
> +	return qmp_send(res->qmp, buf, n);
> +}
> +

I was trying to get QDSS working with these patches and found one issue
in qmp_send of qmp_pd_clock_toggle.

The third return value should be sizeof(buf) instead of n because n just
returns len as 33 and the below check in qmp send will always fail and
trigger WARN_ON's.

          if (WARN_ON(len % sizeof(u32))) {
                  dev_err(qmp->dev, "message not 32-bit aligned\n");
                  return -EINVAL;
          }

Also I observed that multiple "ucore will not ack channel" messages with
len being returned n instead of buf size.

One more thing is do we really require *WARN_ON and dev_err* both 
because it just spams the kernel logs, I think dev_err message is clear
enough to be able to understand the error condition.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
