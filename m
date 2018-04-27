Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757948AbeD0KYQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:24:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54105 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757811AbeD0KYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:24:14 -0400
Message-ID: <1524824650.17614.4.camel@pengutronix.de>
Subject: Re: [PATCH v4 1/5] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Date: Fri, 27 Apr 2018 12:24:10 +0200
In-Reply-To: <20180425150843.26657-2-sibis@codeaurora.org>
References: <20180425150843.26657-1-sibis@codeaurora.org>
         <20180425150843.26657-2-sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Wed, 2018-04-25 at 20:38 +0530, Sibi Sankar wrote:
> Add SDM845 AOSS (always on subsystem) reset controller binding
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/reset/qcom,aoss-reset.txt        | 52 +++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-aoss.h  | 17 ++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> new file mode 100644
> index 000000000000..e5201de9a314
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> @@ -0,0 +1,52 @@
> +Qualcomm AOSS Reset Controller
> +======================================
> +
> +This binding describes a reset-controller found on AOSS (always on subsystem)
> +for Qualcomm SDM845 SoCs.
> +
> +Required properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be:
> +		    "qcom,sdm845-aoss-reset"
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
> +aoss_reset: qcom,reset-controller@b2e0100 {

The node name should be "reset-controller", not "qcom,reset-controller"

> +	compatible = "qcom,sdm845-aoss-reset";
> +	reg = <0xc2b0000 0x21000>;

The address here should match the address part of the node name above.

Apart from those two nitpicks, the binding looks good to me.

regards
Philipp
