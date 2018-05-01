Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeEAVKb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeEAVK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:10:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC5D2368F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525164093-16645-2-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1525164093-16645-1-git-send-email-tdas@codeaurora.org>
 <1525164093-16645-2-git-send-email-tdas@codeaurora.org>
Message-ID: <152520902751.138124.3904360654314728163@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [v5 1/2] dt-bindings: clock: Introduce QCOM RPMh clock bindings
Date: Tue, 01 May 2018 14:10:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-05-01 01:41:32)
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
> new file mode 100644
> index 0000000..ecc1dbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
> @@ -0,0 +1,32 @@
> +Qualcomm Technologies, Inc. RPMh Clocks
> +-------------------------------------------------------
> +
> +Resource Power Manager Hardened (RPMh) manages shared resources on
> +some Qualcomm Technologies Inc. SoCs. It accepts clock requests from
> +other hardware subsystems via RSC to control clocks.
> +
> +Required properties :
> +- compatible : shall contain "qcom,sdm845-rpmh-clk"
> +
> +- #clock-cells : must contain 1
> +
> +Optional properties :
> +- assigned-clk-divs : property should contain a list of divs for each clock in
> +                       the clk-output-names property. In case divs are not
> +                       provided the clock rate would be same as parent rate.
> +- clk-output-names :  a list of strings of clock output signal for the divs to
> +                        be applied.
> +
> +Example :
> +
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +
> +       &apps_rsc {
> +               rpmhcc: clock-controller {
> +                       compatible = "qcom,sdm845-rpmh-clk";
> +                       #clock-cells = <1>;
> +                       assigned-clk-divs = <2 2 2>;

This property shouldn't need to exist. Instead, add a fixed div-2 clock
to the DTS file (I guess in the SoC file) to divide the crystal
frequency into the rate you want (19.2 MHz in this case).

> +                       clk-output-names = "bi_tcxo", "lnbb_clk2",
> +                                               "lnbb_clk3";

We don't need this either.
