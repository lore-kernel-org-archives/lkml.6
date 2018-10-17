Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913AECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0096B21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGlAHmny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0096B21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJQXfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbeJQXfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:35:42 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E3732150F;
        Wed, 17 Oct 2018 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539790766;
        bh=fbMRY1yP5Ng3nsdoUh09s5sgvUUzw43IsYM/3Dpu+g0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=jGlAHmnykwhvYA8XJGIq1pNRmslWjzLinPUNq/22POBSo3frLtyAxg7tmBNtkoDNI
         +t0KfqskosiZjSBn5wTiRKSC2u+B2yPy2dIok+hkDp3jvGjrm4W+fZ9XXGSdv1BLiH
         lbL/k6VWHF1N4dB56NGjHLbAe92cl3aeMxAYpEBA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     ilia.lin@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180614215358.11264-3-ilia.lin@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilialin@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-3-ilia.lin@gmail.com>
Message-ID: <153979076609.5275.11289929616133786271@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v13 2/8] clk: qcom: Make clk_alpha_pll_configure available to
 modules
Date:   Wed, 17 Oct 2018 08:39:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting ilia.lin@gmail.com (2018-06-14 14:53:49)
> From: Rajendra Nayak <rnayak@codeaurora.org>
> =

> Allow clk_alpha_pll_configure to be called from loadable
> kernel modules.
> =

> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Oh I think this one came via another patch series. Either way, keep
resending this along with everything else to make kbuild happy.

>  drivers/clk/qcom/clk-alpha-pll.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alph=
a-pll.c
> index 3c49a60072f1..a43f80ac94a4 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -228,6 +228,7 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pl=
l, struct regmap *regmap,
>         if (pll->flags & SUPPORTS_FSM_MODE)
>                 qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
>  }
> +EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
>  =

>  static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
>  {
> -- =

> 2.11.0
> =

> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
