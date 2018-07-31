Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588B208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588B208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeGaKVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:21:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44395 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbeGaKVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:21:45 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fkQEd-0005IH-VZ; Tue, 31 Jul 2018 10:42:27 +0200
Message-ID: <1533026547.3444.4.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add PDC reset binding for
 SDM845 SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Date:   Tue, 31 Jul 2018 10:42:27 +0200
In-Reply-To: <20180727152811.15258-1-sibis@codeaurora.org>
References: <20180727152811.15258-1-sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
> Add SDM845 PDC (Power Domain Controller) reset controller binding
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/reset/qcom,pdc-reset.txt         | 52 +++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> new file mode 100644
> index 000000000000..85e159962e08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> @@ -0,0 +1,52 @@
> +PDC Reset Controller
> +======================================
> +
> +This binding describes a reset-controller found on PDC-Global(Power Domain
> +Controller) block for Qualcomm Technologies Inc SDM845 SoCs.
> +
> +Required properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be:
> +		    "qcom,sdm845-pdc-global"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must specify the base address and size of the register
> +	            space.
> +
> +- #reset-cells:
> +	Usage: required
> +	Value type: <uint>
> +	Definition: must be 1; cell entry represents the reset index.
> +
> +Example:
> +
> +pdc_reset: reset-controller@b2e0000 {

Is this really just a reset controller?

The name makes it sound like a driver binding to this should also
provide pm_genpd and the binding should probably call this a power-
controller: Documentation/devicetree/bindings/power/power_domain.txt.

> +	compatible = "qcom,sdm845-pdc-global";
> +	reg = <0xb2e0000 0x20000>;

This looks like this is the register space of the complete PDC, not just
the reset register?

> +	#reset-cells = <1>;
> +};
> +
> +PDC reset clients
> +======================================
> +
> +Device nodes that need access to reset lines should
> +specify them as a reset phandle in their corresponding node as
> +specified in reset.txt.
> +
> +For list of all valid reset indicies see
> +<dt-bindings/reset/qcom,sdm845-pdc.h>
> +
> +Example:
> +
> +modem-pil@4080000 {
> +	...
> +
> +	resets = <&pdc_reset PDC_MODEM_SYNC_RESET>;
> +	reset-names = "pdc_restart";
> +
> +	...
> +};
> diff --git a/include/dt-bindings/reset/qcom,sdm845-pdc.h b/include/dt-bindings/reset/qcom,sdm845-pdc.h
> new file mode 100644
> index 000000000000..53c37f9c319a
> --- /dev/null
> +++ b/include/dt-bindings/reset/qcom,sdm845-pdc.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_PDC_SDM_845_H
> +#define _DT_BINDINGS_RESET_PDC_SDM_845_H
> +
> +#define PDC_APPS_SYNC_RESET	0
> +#define PDC_SP_SYNC_RESET	1
> +#define PDC_AUDIO_SYNC_RESET	2
> +#define PDC_SENSORS_SYNC_RESET	3
> +#define PDC_AOP_SYNC_RESET	4
> +#define PDC_DEBUG_SYNC_RESET	5
> +#define PDC_GPU_SYNC_RESET	6
> +#define PDC_DISPLAY_SYNC_RESET	7
> +#define PDC_COMPUTE_SYNC_RESET	8
> +#define PDC_MODEM_SYNC_RESET	9
> +
> +#endif

regards
Philipp
