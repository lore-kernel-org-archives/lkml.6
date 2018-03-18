Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeCRWpE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:45:04 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36929 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeCRWo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:44:59 -0400
X-Google-Smtp-Source: AG47ELsGG5GRKt9Lroy0caRwdcguCNWT98yjoL2k14mV3TCgYLXD5myqKtJPEhdAbjgduOrrGhuUYw==
Date: Sun, 18 Mar 2018 15:44:59 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi S <sibis@codeaurora.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 1/7] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
Message-ID: <20180318224459.GC5626@tuxbook-pro>
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-2-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521019283-32212-2-git-send-email-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Mar 02:21 PDT 2018, Sibi S wrote:
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must specify the base address and size of the register
> +	            space.
> +
> +

Double empty lines.

> +- #reset-cells:
> +	Usage: required
> +	Value type: <uint>
> +	Definition: must be 1; cell entry represents the reset index.
> +
> +example:

Please capitalize the initial char.

> +
> +aoss_reset: qcom,reset-controller@b2e0100 {
> +	compatible = "qcom,sdm845-aoss-reset";
> +	reg = <0xc2b0000 0x20004>;

0x20004 does seem very even, please verify this size.

> +	#reset-cells = <1>;
> +};
> +
> +
> +Specifying reset lines connected to IP modules

"AOSS reset clients"

Although you could probably get a way with just referring to reset.txt
and the header file.

> +==============================================
> +
> +Device nodes that need access to reset lines should
> +specify them as a reset phandle in their corresponding node as
> +specified in reset.txt.
> +
> +For list of all valid reset indicies see
> +<dt-bindings/reset/qcom,sdm845-aoss.h>
> +
> +Example:
> +
> +modem-pil@4080000 {
> +	...
> +
> +	resets = <&aoss_reset AOSS_CC_MSS_RESTART>;
> +	reset-names = "mss_restart";
> +
> +	...
> +};
> diff --git a/include/dt-bindings/reset/qcom,sdm845-aoss.h b/include/dt-bindings/reset/qcom,sdm845-aoss.h
> new file mode 100644
> index 0000000..e9b38fc
> --- /dev/null
> +++ b/include/dt-bindings/reset/qcom,sdm845-aoss.h
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0

For tooling reasons header files should have their SPDX License tag
wrapped in /* */

> +/*
> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_AOSS_SDM_845_H
> +#define _DT_BINDINGS_RESET_AOSS_SDM_845_H
> +
> +#define AOSS_CC_MSS_RESTART	0
> +#define AOSS_CC_CAMSS_RESTART	1
> +#define AOSS_CC_VENUS_RESTART	2
> +#define AOSS_CC_GPU_RESTART	3
> +#define AOSS_CC_DISPSS_RESTART	4
> +#define AOSS_CC_WCSS_RESTART	5
> +#define AOSS_CC_LPASS_RESTART	6
> +
> +#endif

Apart from these nits this looks reasonable.

Regards,
Bjorn
