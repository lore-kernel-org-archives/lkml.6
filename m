Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FD2C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CA02081C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544133321;
	bh=58o7wj7mBWhPeIdyXdGX6xBxzVrsyTDPdXl18Bzxd+I=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=P5vtabfCmcJRe1auHtQBH+sFmivDDewLBaZTS7ze8hZTnPQorhJ/b6Ug1qAOgPSHH
	 z9xCm12Zd1D2sMaT/PEqdH3TQ9UwGKE9oYhex9YtuU2ZSiPsQWQ61geTqf1yDLKLtN
	 lTRp9e3ZHOrWWCMAenYjKwamX8Ave0Z966KnOGdc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CA02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLFVzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbeLFVzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:55:18 -0500
Received: from localhost (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E012081C;
        Thu,  6 Dec 2018 21:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544133317;
        bh=58o7wj7mBWhPeIdyXdGX6xBxzVrsyTDPdXl18Bzxd+I=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=nU+loz+iD+acKlaHlzZsOvQ3FsI24j2XyUKAhFSDKwWHNGo3s9Dn6LJCnTQeglyob
         Qt1EXKJQB8QOTT8wD4rWIp8Rdev9+Zyn2wFVOdWwOnbp+FaTz9FOB2dzxIWzdX56qL
         dkbrg0B+0L4VrrIMBHMKs6ifyHXNMeq5rPORf/uw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jeffrey Hugo <jhugo@codeaurora.org>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1544130666-32252-1-git-send-email-jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <1544130666-32252-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154413331679.88331.15909045605070653326@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: smd: Add support for MSM8998 rpm clocks
Date:   Thu, 06 Dec 2018 13:55:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-06 13:11:06)
> Add rpm smd clocks, PMIC and bus clocks which are required on MSM8998
> for clients to vote on.
> =

> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,rpmcc.txt       |  1 +
>  drivers/clk/qcom/clk-smd-rpm.c                     | 62 ++++++++++++++++=
++++++
>  include/dt-bindings/clock/qcom,rpmcc.h             |  6 +++
>  3 files changed, 69 insertions(+)
> =

> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Doc=
umentation/devicetree/bindings/clock/qcom,rpmcc.txt
> index 87b4949..16c4293 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
> @@ -17,6 +17,7 @@ Required properties :
>                         "qcom,rpmcc-apq8064", "qcom,rpmcc"
>                         "qcom,rpmcc-msm8996", "qcom,rpmcc"
>                         "qcom,rpmcc-qcs404", "qcom,rpmcc"
> +                       "qcom,rpmcc-msm8998", "qcom,rpmcc"

Can you keep this sorted on the first compatible?

>  =

>  - #clock-cells : shall contain 1
>  =


Rob may prefer this file is split from the driver part into a different
patch.

> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rp=
m.c
> index d3aadae..269304e 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -655,11 +655,73 @@ static int clk_smd_rpm_enable_scaling(struct qcom_s=
md_rpm *rpm)
>         .num_clks =3D ARRAY_SIZE(qcs404_clks),
>  };
>  =

> +/* msm8998 */
> +DEFINE_CLK_SMD_RPM(msm8998, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, =
1);
> +DEFINE_CLK_SMD_RPM(msm8998, cnoc_clk, cnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, =
2);
> +DEFINE_CLK_SMD_RPM(msm8998, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, div_clk1, div_clk1_a, 0xb);
> +DEFINE_CLK_SMD_RPM(msm8998, ipa_clk, ipa_a_clk, QCOM_SMD_RPM_IPA_CLK, 0);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk1, bb_clk1_a, 1);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk2, bb_clk2_a, 2);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, bb_clk3_pin, bb_clk3_a_pin=
, 3);
> +DEFINE_CLK_SMD_RPM(msm8998, mmssnoc_axi_rpm_clk, mmssnoc_axi_rpm_a_clk,
> +                  QCOM_SMD_RPM_MMAXI_CLK, 0);
> +DEFINE_CLK_SMD_RPM(msm8998, aggre1_noc_clk, aggre1_noc_a_clk,
> +                  QCOM_SMD_RPM_AGGR_CLK, 1);
> +DEFINE_CLK_SMD_RPM(msm8998, aggre2_noc_clk, aggre2_noc_a_clk,
> +                  QCOM_SMD_RPM_AGGR_CLK, 2);
> +DEFINE_CLK_SMD_RPM_QDSS(msm8998, qdss_clk, qdss_a_clk,
> +                       QCOM_SMD_RPM_MISC_CLK, 1);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk1, rf_clk1_a, 4);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk2_pin, rf_clk2_a_pin=
, 5);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin=
, 6);
> +static struct clk_smd_rpm *msm8998_clks[] =3D {
> +       [RPM_SMD_SNOC_CLK] =3D &msm8998_snoc_clk,
> +       [RPM_SMD_SNOC_A_CLK] =3D &msm8998_snoc_a_clk,
> +       [RPM_SMD_CNOC_CLK] =3D &msm8998_cnoc_clk,
> +       [RPM_SMD_CNOC_A_CLK] =3D &msm8998_cnoc_a_clk,
> +       [RPM_SMD_CE1_CLK] =3D &msm8998_ce1_clk,
> +       [RPM_SMD_CE1_A_CLK] =3D &msm8998_ce1_a_clk,
> +       [RPM_SMD_DIV_CLK1] =3D &msm8998_div_clk1,
> +       [RPM_SMD_DIV_A_CLK1] =3D &msm8998_div_clk1_a,
> +       [RPM_SMD_IPA_CLK] =3D &msm8998_ipa_clk,
> +       [RPM_SMD_IPA_A_CLK] =3D &msm8998_ipa_a_clk,
> +       [RPM_SMD_BB_CLK1] =3D &msm8998_bb_clk1,
> +       [RPM_SMD_BB_CLK1_A] =3D &msm8998_bb_clk1_a,
> +       [RPM_SMD_BB_CLK2] =3D &msm8998_bb_clk2,
> +       [RPM_SMD_BB_CLK2_A] =3D &msm8998_bb_clk2_a,
> +       [RPM_SMD_BB_CLK3_PIN] =3D &msm8998_bb_clk3_pin,
> +       [RPM_SMD_BB_CLK3_A_PIN] =3D &msm8998_bb_clk3_a_pin,
> +       [RPM_SMD_MMAXI_CLK] =3D &msm8998_mmssnoc_axi_rpm_clk,
> +       [RPM_SMD_MMAXI_A_CLK] =3D &msm8998_mmssnoc_axi_rpm_a_clk,
> +       [RPM_SMD_AGGR1_NOC_CLK] =3D &msm8998_aggre1_noc_clk,
> +       [RPM_SMD_AGGR1_NOC_A_CLK] =3D &msm8998_aggre1_noc_a_clk,
> +       [RPM_SMD_AGGR2_NOC_CLK] =3D &msm8998_aggre2_noc_clk,
> +       [RPM_SMD_AGGR2_NOC_A_CLK] =3D &msm8998_aggre2_noc_a_clk,
> +       [RPM_SMD_QDSS_CLK] =3D &msm8998_qdss_clk,
> +       [RPM_SMD_QDSS_A_CLK] =3D &msm8998_qdss_a_clk,
> +       [RPM_SMD_RF_CLK1] =3D &msm8998_rf_clk1,
> +       [RPM_SMD_RF_CLK1_A] =3D &msm8998_rf_clk1_a,
> +       [RPM_SMD_RF_CLK2_PIN] =3D &msm8998_rf_clk2_pin,
> +       [RPM_SMD_RF_CLK2_A_PIN] =3D &msm8998_rf_clk2_a_pin,
> +       [RPM_SMD_RF_CLK3] =3D &msm8998_rf_clk3,
> +       [RPM_SMD_RF_CLK3_A] =3D &msm8998_rf_clk3_a,
> +       [RPM_SMD_RF_CLK3_PIN] =3D &msm8998_rf_clk3_pin,
> +       [RPM_SMD_RF_CLK3_A_PIN] =3D &msm8998_rf_clk3_a_pin,
> +};
> +
> +static const struct rpm_smd_clk_desc rpm_clk_msm8998 =3D {
> +       .clks =3D msm8998_clks,
> +       .num_clks =3D ARRAY_SIZE(msm8998_clks),
> +};
> +
>  static const struct of_device_id rpm_smd_clk_match_table[] =3D {
>         { .compatible =3D "qcom,rpmcc-msm8916", .data =3D &rpm_clk_msm891=
6 },
>         { .compatible =3D "qcom,rpmcc-msm8974", .data =3D &rpm_clk_msm897=
4 },
>         { .compatible =3D "qcom,rpmcc-msm8996", .data =3D &rpm_clk_msm899=
6 },
>         { .compatible =3D "qcom,rpmcc-qcs404",  .data =3D &rpm_clk_qcs404=
  },
> +       { .compatible =3D "qcom,rpmcc-msm8998", .data =3D &rpm_clk_msm899=
8 },

And this sorted too.

>         { }
>  };
>  MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);
