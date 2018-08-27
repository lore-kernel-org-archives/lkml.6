Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7767EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29845208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUkW2DqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29845208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeH1BDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbeH1BDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:03:09 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D5D208B4;
        Mon, 27 Aug 2018 21:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535404487;
        bh=O8SIq+vYuWM6EDnfHnDLqVY03bsuhRzZuVw4qPIGZKY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tUkW2DqEuW5oxTqtZkg+MTGPYCkJrkLDPYH8Ikw7O46ac81y0y7n1qoHv0UeD52Za
         pZU41B7ZO0m+l+x+wRWWFpL4iWWmFLR7iJr9vy9aA12U7HD8upX8oPiIaseGInwVZj
         agVv9VUPLl0IsOtZL7zfhoGxooklYneWq3gbYDv0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1533298874-22863-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1533298874-22863-1-git-send-email-tdas@codeaurora.org>
 <1533298874-22863-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153540448713.129321.8622050618939041593@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Mon, 27 Aug 2018 14:14:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-08-03 05:21:13)
> Add device tree bindings for Low Power Audio subsystem clock controller f=
or
> Qualcomm Technology Inc's SDM845 SoCs.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt         |  2 ++
>  .../devicetree/bindings/clock/qcom,lpasscc.txt     | 33 ++++++++++++++++=
++++++
>  include/dt-bindings/clock/qcom,gcc-sdm845.h        |  2 ++
>  include/dt-bindings/clock/qcom,lpass-sdm845.h      | 16 +++++++++++
>  4 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.=
txt
>  create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
> =

> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Docum=
entation/devicetree/bindings/clock/qcom,gcc.txt
> index 664ea1f..e452abc 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> @@ -32,6 +32,8 @@ be part of GCC and hence the TSENS properties can also =
be
>  part of the GCC/clock-controller node.
>  For more details on the TSENS properties please refer
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +- qcom,lpass-protected : Indicate GCC to be able to access the
> +                       lpass gcc clock branches.

This doesn't parse well for me. Maybe something like:

'Indicate that the LPASS clock branches within GCC are unusable due to
firmware access control restrictions'?

> =

>  Example:
>         clock-controller@900000 {
> diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/D=
ocumentation/devicetree/bindings/clock/qcom,lpasscc.txt
> new file mode 100644
> index 0000000..062e413
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
> @@ -0,0 +1,33 @@
> +Qualcomm LPASS Clock Controller Binding
> +-----------------------------------------------
> +
> +Required properties :
> +- compatible           : shall contain "qcom,sdm845-lpasscc"
> +- #clock-cells         : from common clock binding, shall contain 1.
> +- reg                  : shall contain base register address and size,
> +                         in the order
> +                       Index-0 maps to LPASS_CC register region
> +                       Index-1 maps to LPASS_QDSP6SS register region
> +- qcom,lpass-protected : Boolean property to indicate to GCC clock contr=
oller
> +                        for the lpass GCC clocks.

Why is this here?

> +
> +Optional properties :
> +- reg-names    : register names of LPASS domain
> +                "lpass_cc", "lpass_qdsp6ss".
> +
> +Example:
> +
> +The below node has to be defined in the cases where the LPASS peripheral=
 loader
> +would bring the subsystem out of reset.
> +
> +       lpasscc: clock-controller {
> +               compatible =3D "qcom,sdm845-lpasscc";
> +               reg =3D <0x17014000 0x1f004>, <0x17300000 0x200>;
> +               reg-names =3D "lpass_cc", "lpass_qdsp6ss";
> +               #clock-cells =3D <1>;
> +       };
> +
> +       gcc: clock-controller@100000 {
> +               compatible =3D "qcom,gcc-sdm845";
> +               qcom,lpass-protected;
> +       };
