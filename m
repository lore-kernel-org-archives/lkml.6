Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4ABC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D8E208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/i1CoFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D8E208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeGIFiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbeGIFiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:38:09 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6BC9208DB;
        Mon,  9 Jul 2018 05:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531114689;
        bh=I34QFg9fwWua2vJOHX3JRqyKiMWlWPR5PW4WW5TTx/E=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=k/i1CoFQyhIVpnJCDbkHGC6igXs+ZQY884bKCQtcU27W+Rewfi/7CtuMy4sOOIogJ
         H9lhfXkIcUO9YqpUvONkpn0mSu3EYDotxh9ib0/k+0AWVyvKjIDN6DwZCXrFmJ0CA6
         K4cBPp4RniqvQIRkfQJpiivoXTsme1j8Qs4ivSP4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528285308-25477-4-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-4-git-send-email-anischal@codeaurora.org>
Message-ID: <153111468812.143105.11066074667783322403@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/4] dt-bindings: clock: Introduce QCOM Graphics clock bindings
Date:   Sun, 08 Jul 2018 22:38:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-06-06 04:41:47)
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.txt b/Doc=
umentation/devicetree/bindings/clock/qcom,gpucc.txt
> new file mode 100644
> index 0000000..e311219
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
> +       gpucc: clock-controller@@5090000 {

Drop the double '@'

> +               compatible =3D "qcom,sdm845-gpucc";
> +               reg =3D <0x5090000 0x9000>;
> +               #clock-cells =3D <1>;
> +               #reset-cells =3D <1>;
> +               #power-domain-cells =3D <1>;
> +       };
