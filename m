Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AC52146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIY2d1Ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AC52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeK3SNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:13:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeK3SNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:13:32 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303562082F;
        Fri, 30 Nov 2018 07:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543561514;
        bh=9dB7A+ZX47mdyOd0vscJY6P7AM/Ds7M0n2fItHQqiCU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=MIY2d1Ou9oAomo8gfF5X/FMeowjrSP044Xc+QT7cPBur4+hqW65IDaFhsH5Vdu1Zt
         IDQiCLrgmmYoQfSJMGyDKJS1d3Sdi2TClyb+HopGEgeI/zqHkzJ9ITPPmIepHQkp+v
         ryLcM4hqtWb1JhhFZhlQN9KBX6coKu2iHTYKFcFQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130065259.26497-2-bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
 <20181130065259.26497-2-bjorn.andersson@linaro.org>
Message-ID: <154356151361.88331.1298482384404357982@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] clk: qcom: gcc-msm8998: Mark hmss_dvm and lpass_at critical
Date:   Thu, 29 Nov 2018 23:05:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-11-29 22:52:57)
> Keep the two clocks enabled, so that the platform passes
> clk_disable_unused().
> =

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/gcc-msm8998.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm899=
8.c
> index 9f0ae403d5f5..d89f8e7c2a59 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -1972,6 +1972,7 @@ static struct clk_branch gcc_hmss_dvm_bus_clk =3D {
>                 .enable_mask =3D BIT(0),
>                 .hw.init =3D &(struct clk_init_data){
>                         .name =3D "gcc_hmss_dvm_bus_clk",
> +                       .flags =3D CLK_IS_CRITICAL,

Please add a comment about why they're critical. This is a temporary
solution?

>                         .ops =3D &clk_branch2_ops,
>                 },
>         },
