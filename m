Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBDCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0044D2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEgbUOhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0044D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJPTFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:05:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51365 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeJPTFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:05:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so21862099wmf.1;
        Tue, 16 Oct 2018 04:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r3tD0LO9vV/ZgcFNvRrT46ealkzLcxX8l+1AqpHzcEw=;
        b=rEgbUOhY3+528q0FJyLctXate8AGG2uGIQ+ExQByeziwsbzVZF0rCqHZO1BMvdfr1A
         1FSrQU91z3ohzK0SncV9JVitT1bKupA838ZxUkCCRTJ0kgEwuWiJTZVwaADKcKL42D7m
         REiVbxK+fXNPnNvKoV+8b6jEsLr6Ms7aPTrIIUcIIXGk/+eaj1Af+pbkrGl8+joaTb+a
         Si6xMPaXVBgb9fBw27++uBfJDH7ykdmeNH3ekqW+3d386X3v4W754ItR4XCuJrnfjL1Z
         ekfwfUr08fm8c5UmtOcMk3LT2YsD3p817L2MprJ37PDtDOBmokik0c8oo22/U26S+p/t
         kY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r3tD0LO9vV/ZgcFNvRrT46ealkzLcxX8l+1AqpHzcEw=;
        b=gVyp5b+scuTInoTB//xKJq1E3LeQnqaMQfzv6Cc+A6vTU/s6vK8S4skxSN9D13nWGd
         ltRTIL/nAy95cPDjPilSil8a4fD/JQG74eqVWXQw+AiRHdQgchwWeBvNkOtzdgliFF3p
         oHU39DQ/HMyC2GiAe54fiOBHWIRg2q92dFwmv6DtCeD4zrb0l0OlB4rS940TY9GQvEAd
         xHNUG8CSraWRhihU66ieQ59NF3pf/SLEeBg7coSwTfkfasw9ReMCF3WgoBx5M6yP8UWi
         LIIAVB0AwfMyTaP5sLOHoq8IhFQtycQ/Wyy6emjWGowVMsbLslBoDvusZlM8Xg2jbKOO
         hvSA==
X-Gm-Message-State: ABuFfogxWyC7LahwbYOQGEgM7WRR2iXoGTzsRID2gLyS5Y6n/hGF6rLh
        IrO352upO0WQGBf2kPVJKbpmScHf
X-Google-Smtp-Source: ACcGV62L5rWJE99gG24ddCyO+Z3lmaSX9EzBkIdhFIszbSe+ICH8MGips6HS5clicfVvqb25sHIymg==
X-Received: by 2002:a1c:7e57:: with SMTP id z84-v6mr17559771wmc.43.1539688543241;
        Tue, 16 Oct 2018 04:15:43 -0700 (PDT)
Received: from localhost (pD9E5106D.dip0.t-ipconnect.de. [217.229.16.109])
        by smtp.gmail.com with ESMTPSA id l125-v6sm44310810wmb.1.2018.10.16.04.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 04:15:42 -0700 (PDT)
Date:   Tue, 16 Oct 2018 13:15:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
Message-ID: <20181016111541.GE8852@ulmo>
References: <20181016060402.18756-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
In-Reply-To: <20181016060402.18756-1-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 11:34:00AM +0530, Vignesh R wrote:
> Couple of patches to enable pwm-tiecap driver to be used with TI's new
> AM654 platforms.
>=20
> Vignesh R (2):
>   dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
>   pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
>=20
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>  drivers/pwm/Kconfig                                  | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvFyF0ACgkQ3SOs138+
s6FGaw//csiUGEqfwZ8tliCNgbz5WYxINJb+RjG/Chxlb0md2/9EuQkgVzAC4pNe
mEMRD+h46h74M+21M4pb87zPjklMQPyBMkopY1h+S2mf4sGRtibFwBntK9/vX5Jq
0NN1gAFUrv8ckHYfCvR6uMJ6Gu72RpX9KkJjNVnZtJF18tCIR03+jvKLZCbHe7F5
aK/VTHy8zzLMx70po1iIcubTnxOxRi8MfVIVW52gsj6ffG7KHouTN19DJGUvkicy
7VDUR9OMNl/4BgtlkGxzcM9Jmc27iUUS9xUZEk5OCheGuFfQCnKnxKDapuseb1u/
hPoabCvx/3OPjo5Dmhy7rc0KPRHeybRFKbIavPvzQ+UNqK6E0suRgGEu5bB43/Wi
t3PyY5bbEI6toEt02ONgCDGT2apINvPvscN42CqyQzVXD+/lfB0ayLKex5v60ARC
q0wwonzglROvLjrVeaOfcz5zs2RsfI65nQSwgoz1yb1PeTEocZ2h4vrZnIwVAUn5
mKScjezE2uBtKhnnLNaFO332CeGMmaMpBhCa3Ak0QT3yqNIspQCYjlYFRWHV+Mz5
1CmdTFCbRxf0/egNDYWXjQxkD07/uRclZt7g37iuRx7N8+VZd5pi44Me7SGD7k95
8Nu0EKFApi8HgP5Rw+Y6FneH6ZeowlEuMaCJo3Bgrq5ozbrpSQg=
=vO/S
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
