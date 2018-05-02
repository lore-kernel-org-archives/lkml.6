Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeEBPK4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeEBPKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:10:54 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525258277-3478-2-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1525258277-3478-1-git-send-email-tdas@codeaurora.org>
 <1525258277-3478-2-git-send-email-tdas@codeaurora.org>
Message-ID: <152527385298.138124.8046800128520264876@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: clock: Introduce QCOM RPMh clock bindings
Date: Wed, 02 May 2018 08:10:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42FB0w1025665

Quoting Taniya Das (2018-05-02 03:51:16)
> Add RPMh clock device bindings for Qualcomm Technology Inc's SoCs. These
> devices would be used for communicating resource state requests to control
> the clocks managed by RPMh.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

When you change things you shouldn't keep around reviewed-by tags if it
significantly changes..

> +Example :
> +
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +
> +       &apps_rsc {
> +               rpmhcc: clock-controller {
> +                       compatible = "qcom,sdm845-rpmh-clk";
> +                       #clock-cells = <1>;
> +                       assigned-clocks = <&clock_rpmh RPMH_CXO_CLK>,
> +                                       <&clock_rpmh RPMH_CXO_CLK_A>,
> +                                       <&clock_rpmh RPMH_LN_BB_CLK2>,
> +                                       <&clock_rpmh RPMH_LN_BB_CLK2_A>,
> +                                       <&clock_rpmh RPMH_LN_BB_CLK3>,
> +                                       <&clock_rpmh RPMH_LN_BB_CLK3_A>;
> +                       assigned-clock-parents = <&xo_board_div>,
> +                                               <&xo_board_div>,
> +                                               <&xo_board_div>,
> +                                               <&xo_board_div>,
> +                                               <&xo_board_div>,
> +                                               <&xo_board_div>,

There's only one parent, so assigned-clock-parents doesn't really make
sense. If anything, we would have 'clocks = ' here and specify the xo
board clk and the div 2 clk that live in DT. But I already merged this
binding, two patchsets ago. Please look in clk-next.

> +               };
> +#define RPMH_RF_CLK2                           8
> +#define RPMH_RF_CLK2_A                         9
> +#define RPMH_RF_CLK3                           10
> +#define RPMH_RF_CLK3_A                         11
> +

Ok. I dropped CLK4* from the previous patch you sent and dropped Amit's
signed-off-by.
