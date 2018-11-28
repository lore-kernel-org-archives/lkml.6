Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784D8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACCD20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqaUb4x0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACCD20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeK2I3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:29:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2I3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:29:06 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C5F2081B;
        Wed, 28 Nov 2018 21:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543440366;
        bh=yD4N3J0UF0sfL20X14uAhRdbfXNgfcpQcTJD30uy2/A=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=KqaUb4x0qLR1EncS25j9VATu7n5ZFhoQnkruNTBydB0r4n1uBp8tuRP3GtLpXn7OB
         kBoRLfObUpVxoFuvQZrGHYaWLzKkFQJ2xehJqzORevhDyvnJDoqDM/J3tTJ7qG/4Fo
         +4dKei3r2FVoT2/yDWR19XZzAYkTrx57PGziDxaw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181128185743.75328-1-dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org
References: <20181128185743.75328-1-dianders@chromium.org>
Message-ID: <154344036587.88331.13059372833537829634@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom: Fix the xo parent in gpucc example
Date:   Wed, 28 Nov 2018 13:26:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-11-28 10:57:42)
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.txt b/Doc=
umentation/devicetree/bindings/clock/qcom,gpucc.txt
> index 9d0358cc08b4..4e5215ef1acd 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.txt
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.txt
> @@ -17,6 +17,6 @@ Example:
>                 #clock-cells =3D <1>;
>                 #reset-cells =3D <1>;
>                 #power-domain-cells =3D <1>;
> -               clocks =3D <&xo_board>;
> +               clocks =3D <&rpmhcc RPMH_CXO_CLK>;

I don't think it really matters, but ok whatever. Don't mind me
shuffling patches over here.

Applied to clk-next.
