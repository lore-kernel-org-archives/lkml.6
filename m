Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDEXUa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeDEXU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:20:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AAD21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1522304274-18989-3-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1522304274-18989-1-git-send-email-tdas@codeaurora.org>
 <1522304274-18989-3-git-send-email-tdas@codeaurora.org>
Message-ID: <152297042791.143116.12493897848354753009@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] dt-bindings: clock: Introduce QCOM RPMh clock bindings
Date: Thu, 05 Apr 2018 16:20:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-03-28 23:17:53)
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmh.txt b/Documentation/devicetree/bindings/clock/qcom,rpmh.txt
> new file mode 100644
> index 0000000..8222c88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmh.txt

Can the file name be qcom,rpmh-clk?

> @@ -0,0 +1,22 @@
> +Qualcomm Technologies, Inc. RPMh Clocks
> +-------------------------------------------------------
> +
> +Resource Power Manager Hardened (RPMh) manages shared resources on
> +some Qualcomm Technologies Inc. SoCs. It accepts clock requests from
> +other hardware subsystems via RSC to control clocks.
> +
> +Required properties :
> +- compatible : shall contain "qcom,rpmh-clk-sdm845"
> +
> +- #clock-cells : must contain 1
> +
> +Example :
> +
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +
> +       &apps_rsc {

> +               clock_rpmh: qcom,rpmhclk {

Should say clock-controller for node name.

> +               compatible = "qcom,rpmh-clk-sdm845";
> +               #clock-cells = <1>;

Is this tabbed out correctly?

> +               };
> +       };
