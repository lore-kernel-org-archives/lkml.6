Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6964BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F336206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOvQJ7Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F336206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJBR5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbeJBR5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:57:10 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7512206B2;
        Tue,  2 Oct 2018 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538478864;
        bh=h59U8tc1PbnHw7ZjAW66npZWOicrsq97Qd0G7hnX/ds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lOvQJ7Xd/KjzU65aYuyeSYxfyiSdbtcyS6plNZ5bOJlj4F8GI8J/kmE0nd0wOnpef
         9/lYAftjrN+Ds8mP/04nXCGyn8vRiY3DNpRk5fAcO+PcUjQ9/huiCqvijIEUK7Sdvd
         ldCYXdYQaaqOWqsCjE8pL2qWBj57mwh7hL1JN4q8=
Received: by mail-wr1-f44.google.com with SMTP id a13-v6so1732404wrt.5;
        Tue, 02 Oct 2018 04:14:23 -0700 (PDT)
X-Gm-Message-State: ABuFfojI319i5UpZvMoutTbzvrrdAlEnc6thghesVPKcyBnO3AYWOI0S
        d6qDetegZDNGKWuPzB7a6dHDo2N0NZDYYMCP+Cw=
X-Google-Smtp-Source: ACcGV60Dazo2lDxPrZI5J4901H4sYi9OHuFb2edr0heUnL1xNcMNa3JYek6DGcoTWtjrh9r7jpEpGu8iiNLw7TGIVBc=
X-Received: by 2002:a5d:6a8d:: with SMTP id s13-v6mr9614331wru.44.1538478862138;
 Tue, 02 Oct 2018 04:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181002075700epcas2p1e1650ae02c1d6b1bfb946b146d4ce223@epcas2p1.samsung.com>
 <CAL_JsqLoZfU+DMxHJg7ZqD06dgcsxiDbYYW99x8H4C0sOwdiiw@mail.gmail.com> <20181002075633.25658-1-l.stelmach@samsung.com>
In-Reply-To: <20181002075633.25658-1-l.stelmach@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 2 Oct 2018 13:14:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdrtCGa_doOk_fQDC6d9=ZDY460X-0qmWjaGyJpxeB+Ug@mail.gmail.com>
Message-ID: <CAJKOXPdrtCGa_doOk_fQDC6d9=ZDY460X-0qmWjaGyJpxeB+Ug@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: hwrng: Add Samsung Exynos 5250+ True RNG bindings
To:     l.stelmach@samsung.com
Cc:     robh+dt@kernel.org, joe@perches.com, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018 at 09:57, =C5=81ukasz Stelmach <l.stelmach@samsung.com> =
wrote:
>
> Add binding documentation for the True Random Number Generator
> found on Samsung Exynos 5250+ SoCs.
>
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
>  .../bindings/rng/samsung,exynos5250-trng.txt    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos5=
250-trng.txt

Mine and Rob's tags disappeared already once (v2->v3) and...  now
again (from v3 to here). Just amend the commit in your local repo and
add them permanently.
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> diff --git a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trn=
g.txt b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
> new file mode 100644
> index 000000000000..5a613a4ec780
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
> @@ -0,0 +1,17 @@
> +Exynos True Random Number Generator
> +
> +Required properties:
> +
> +- compatible  : Should be "samsung,exynos5250-trng".
> +- reg         : Specifies base physical address and size of the register=
s map.
> +- clocks      : Phandle to clock-controller plus clock-specifier pair.
> +- clock-names : "secss" as a clock name.
> +
> +Example:
> +
> +       rng@10830600 {
> +               compatible =3D "samsung,exynos5250-trng";
> +               reg =3D <0x10830600 0x100>;
> +               clocks =3D <&clock CLK_SSS>;
> +               clock-names =3D "secss";
> +       };
> --
> 2.19.0
>
