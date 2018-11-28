Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FC4C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB1A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="biwk9QR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB1A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeK1LtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeK1LtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:49:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C7062082F;
        Wed, 28 Nov 2018 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543366178;
        bh=UaD0brctcEnL5zd+h4X7MSMe9H+tTxDEDtpXtltCwmI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=biwk9QR9FKOugd8LZ7gn661CfRCVF282oNjS+EaCZH43i6WqiLjkR3y9xjZGg+YBX
         JVh8fUWxu0nsR3tZCew1+spC0S4cCphFqLiryZXyqotViwcWMoANp7J+mpdVnghWPa
         EpIQO4sSbmRjWVAke+U8RXCa8H/sp9WVBixSRvV4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543120569-14444-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1543120569-14444-1-git-send-email-tdas@codeaurora.org>
 <1543120569-14444-2-git-send-email-tdas@codeaurora.org>
Message-ID: <154336617743.88331.11824624815680965054@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Introduce QCOM Graphics clock bindings
Date:   Tue, 27 Nov 2018 16:49:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-24 20:36:07)
> From: Amit Nischal <anischal@codeaurora.org>
> =

> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SDM845 SoCs.
> =

> Signed-off-by: Amit Nischal <anischal@codeaurora.org>

You could have added your sign off here, but I don't think this is
really different from the original posting that's on the list so it's
OK.

> ---
>  .../devicetree/bindings/clock/qcom,gpucc.txt       | 18 ++++++++++++++++
>  include/dt-bindings/clock/qcom,gpucc-sdm845.h      | 24 ++++++++++++++++=
++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.txt
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm845.h
> =

> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.txt b/Doc=
umentation/devicetree/bindings/clock/qcom,gpucc.txt
> new file mode 100644
> index 0000000..93752db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.txt
> @@ -0,0 +1,18 @@
> +Qualcomm Graphics Clock & Reset Controller Binding
> +--------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain "qcom,sdm845-gpucc".
> +- reg : shall contain base register location and length.
> +- #clock-cells : from common clock binding, shall contain 1.
> +- #reset-cells : from common reset binding, shall contain 1.
> +- #power-domain-cells : from generic power domain binding, shall contain=
 1.
> +
> +Example:
> +       gpucc: clock-controller@5090000 {
> +               compatible =3D "qcom,sdm845-gpucc";
> +               reg =3D <0x5090000 0x9000>;
> +               #clock-cells =3D <1>;
> +               #reset-cells =3D <1>;
> +               #power-domain-cells =3D <1>;

I would expect to see the xo clk here as a clocks and clock-names
property. I added it myself and applied to clk-next.

