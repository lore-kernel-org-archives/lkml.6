Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 888ADC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34848208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kPi1HTuX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MOSO75o3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34848208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754619AbeFNGsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:48:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33122 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeFNGst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:48:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D28C606DB; Thu, 14 Jun 2018 06:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528958929;
        bh=dUAh1AGh/rJjhuHmjBc11b7zcyeFUnxhJ6/sgUPPUZ0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=kPi1HTuXFLMhGPlo7ldwFC4Sb1DYEXD3n33OM9jPz6EDomKeA2y/g8QGJlHYsrv+o
         by+6MQbqHfTbC/7LikZFhJbAiHbptNrEmikwGt+9fNFh7nYNbeKv+lAJNa9LLPbc2L
         Df02JESValzJvTN2xfXKbKTcjELjmGQWwDtmoDxw=
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com [209.85.220.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 542A760159;
        Thu, 14 Jun 2018 06:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528958928;
        bh=dUAh1AGh/rJjhuHmjBc11b7zcyeFUnxhJ6/sgUPPUZ0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MOSO75o3ru7lPZa12tJzQvv8fe4jpRjCAHk+XQfa/punssoRe86KB01l8vbBvkj5W
         8jF+7GQMuJ8GZRG0YqPrKE3pRfflihEMMFFSkurgxWeNYNEsDYEPb1eg7xdcvU6H4B
         ds8nnN9V0TL4jxPW1ez+CBkF4OBvwBUhR/52IH/g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 542A760159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f179.google.com with SMTP id y4-v6so3047360qka.5;
        Wed, 13 Jun 2018 23:48:48 -0700 (PDT)
X-Gm-Message-State: APt69E2PJaAZjbBxSlNftZ5g23XhysBSZAeiEEp7jPQ/JenUrHp1Ewve
        rGuTnSDRQEmb2dG9lxBWOMywinaED3R0hac3738=
X-Google-Smtp-Source: ADUXVKKOCbGT1IzwD04pOwxd/JxkjfRwx4XoNOBOrQt601/oZ3slD03fFNkDW9slRadO3y4sGQE/me7zj9NMOFswysw=
X-Received: by 2002:a37:7c45:: with SMTP id x66-v6mr1044214qkc.310.1528958927511;
 Wed, 13 Jun 2018 23:48:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 23:48:47
 -0700 (PDT)
In-Reply-To: <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org> <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 14 Jun 2018 12:18:47 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEnep3ogEkdfmaSOn_2w+09huae2NOwBF1o7-vn3iQMCA@mail.gmail.com>
Message-ID: <CAFp+6iEnep3ogEkdfmaSOn_2w+09huae2NOwBF1o7-vn3iQMCA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] thermal: tsens: Add support for SDM845
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Tue, Jun 12, 2018 at 4:24 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 uses the TSENS v2 IP block
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt |  1 +
>  drivers/thermal/qcom/Makefile                            |  2 +-
>  drivers/thermal/qcom/tsens-sdm845.c                      | 15 +++++++++++++++
>  drivers/thermal/qcom/tsens.c                             |  3 +++
>  drivers/thermal/qcom/tsens.h                             |  5 ++++-
>  5 files changed, 24 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/thermal/qcom/tsens-sdm845.c
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 292ed89..8652499 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -5,6 +5,7 @@ Required properties:
>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> + - "qcom,sdm845-tsens"  : For SDM845 Family of SoCs
>
>  - reg: Address range of the thermal registers
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 2cc2193..dc9f169 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_QCOM_TSENS)       += qcom_tsens.o
> -qcom_tsens-y                   += tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
> +qcom_tsens-y                   += tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o tsens-sdm845.o
> diff --git a/drivers/thermal/qcom/tsens-sdm845.c b/drivers/thermal/qcom/tsens-sdm845.c
> new file mode 100644
> index 0000000..a647265
> --- /dev/null
> +++ b/drivers/thermal/qcom/tsens-sdm845.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, Linaro Limited
> + */
> +
> +#include "tsens.h"
> +
> +static const struct tsens_ops ops_sdm845 = {
> +       .init           = init_common,
> +       .get_temp       = get_temp_tsens_v2,
> +};
> +
> +const struct tsens_data data_sdm845 = {

Just a minor nit. 'static' here?

> +       .ops            = &ops_sdm845,
> +};

[snip]

Thanks & Regards
Vivek


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
