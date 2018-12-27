Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC60214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/Iq3RXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbeL0L5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:57:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34909 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbeL0L5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:57:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so12553225lfc.2;
        Thu, 27 Dec 2018 03:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0u+t53wp3ovowzonqM8HJAMfjd+IqOrSRFovgYZHdmM=;
        b=p/Iq3RXeki+vvId89NEwssocj8L1S1kuWidCLyH0WkwN7fqzXot9XNJzpsFpfqRWi7
         Uo7aiPgHaIjgpLcRI9/i6bry20oDUW7/03e95gYVZZpYI1dUJRODzwi4X+Muhqi7+FXn
         A6xASCZ/Lbx7iq0Big0C7uwCwRtnEtv/qXO9yi8deDscu+Jov9HTgYsfdHG/d+Y4fSN5
         5gpaIjizaHbSH9w+Gme8C5pm9QErV4yjdNcsZyPFOrzvd3lXkFFOkZzXUTmrjyNjZoiV
         +Rdo7l271QG+a/fDMpVcp5i9h+1sVrqErO3kMCe4M28Mi+gdqpAYVZgcw/UBtvsGDPhD
         tjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0u+t53wp3ovowzonqM8HJAMfjd+IqOrSRFovgYZHdmM=;
        b=Ypk/Laswo2jhMU7o6uAHg91SaeM6YKCr0AgxNR+Qsdbp0vJbmRuvUti9T4aEs/fKmn
         vc/XFiTf07G2ZEuzATayK1CB05/SaCU7pCZe40CCuiDNqLvifRrO1UZnFkrRjeHmtqOz
         vTSJ0fpGme2J6XBBKzno4SDfurKP4RdXDFE6W1nkakgHKq0879HVbpMumy1Cetkj+Uk2
         2oRQdeLFRCVWCMOQ1p5yV59IC/B92S34i+r8PRU2WQvvRpHVNFlorS1FLFN7TLeot8r5
         gpSYGMgwEr5qjNQSCDOrkIuj6CwaIRrAOVEHwIokwqQNmbSpZfv4w4BK/rhbLOyj7Ptj
         gR/g==
X-Gm-Message-State: AA+aEWaMSJPnhE7f6Gj9CpEkx1qlwzJ3TOXfzxENq6+zYsX+hWw/8qZr
        k4M1Y/92OCU4Ox0m8l5plIA=
X-Google-Smtp-Source: AFSGD/XRKParsNAMKywnx/zABcWlwVKK4mUA7fT8fxwv1yeHGc39XBCGdas93ZOPhD7cX4EcP/rtKg==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr11302168lfe.154.1545911858376;
        Thu, 27 Dec 2018 03:57:38 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:9009:87a3:91bb:333a])
        by smtp.gmail.com with ESMTPSA id o5-v6sm7916444ljh.75.2018.12.27.03.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 03:57:37 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Inki Dae <inki.dae@samsung.com>, airlied@linux.ie,
        jy0922.shim@samsung.com, Seung Woo Kim <sw0312.kim@samsung.com>,
        kyungmin.park@samsung.com, kgene@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: gpu: samsung-rotator: Document s5pv210 support
Date:   Thu, 27 Dec 2018 12:57:35 +0100
Message-ID: <4331572.iOIAVLAcOa@acerlaptop>
In-Reply-To: <CAJKOXPfHHNUzQZu62btspC+6SwgoGPdAzusfSixXM7U9u3QP7A@mail.gmail.com>
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com> <20181219155704.15264-3-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPfHHNUzQZu62btspC+6SwgoGPdAzusfSixXM7U9u3QP7A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia =C5=9Broda, 19 grudnia 2018 17:22:51 CET Krzysztof Kozlowski pisze:
> On Wed, 19 Dec 2018 at 17:04, Pawe=C5=82 Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> >
> > This commit documents new compatible for s5pv210 soc,
> > which will be also supported by this driver.
> >
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/gpu/samsung-rotator.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt =
b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
> > index 82cd1ed0be93..78658dec6941 100644
> > --- a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
> > +++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
> > @@ -5,6 +5,7 @@ Required properties:
> >         (a) "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
> >         (b) "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/4=
412
> >         (c) "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
> > +       (d) "samsung,s5pv210-rotator" for Rotator IP in S5PV210
>=20
> How about putting it at beginning as the oldest chipset? This would
> require reordering the list so maybe let's remove the a/b/c list
> enumerations? They are kind of useless.
Ok, i'll send v2 of patchset with this change.
>=20
> Best regards,
> Krzysztof




