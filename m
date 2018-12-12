Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA711C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9BA20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtPQd7NG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9BA20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeLLKwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:52:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41690 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:52:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so15146916edi.8;
        Wed, 12 Dec 2018 02:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IzAnvxxHAXEAR0bdfpTkQaTIm7Ghs8YMA4IRbwqkJB4=;
        b=KtPQd7NGr4fZS+uRtag/QhKzOon5Y1t9R/mxRSiPJw3bOz+5N2xC8rRVgv+O4NPsZb
         J4xFZzCRXY2UQ1xITZ5ZynfkVNBBZHQtofMXXUPR/j7+8nwfbEQR1eeuJGGqR1guSvE1
         XaKfKr5b2J0dottPCzUvsofZ5VDHf28PWiclzPWux7JJhsbRfkB7gm3fG/uLajZ6zinA
         FeSXC4y2c0tehfarpc572Ce+Gqv3CvL59Z2yWFoMkftjg/9FGeWT5NRUjrsNf6TK+soi
         ogxWEqz6YimOWVn6HhZwwzLErjIe8dDGoeqSilVc2RS9MSKdx+ghyO3aeMtca2JWGyWp
         SEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IzAnvxxHAXEAR0bdfpTkQaTIm7Ghs8YMA4IRbwqkJB4=;
        b=ucSDpD5Cfwhm8nYSISO+vgF0WYskSmpvVsQ8w7+uQAe1eOCBR2cdnhw4ebHR5ceDK4
         /QCFQwrm6u8rHVWquIpfKrItZ8roIyEy8l/Kjs2HYpIUkDcksPhIdIzqH5RTOYdQ/Ye7
         4sn3Bi46ETPWSnUVljuMOXVCzb6is5UWXr4TclLMNhvE3BBs20t8a1uBhXzdBx+WyxlN
         UawC2Oq5xg7h50gOz3P8Qg3+j0LFl0fMaesiOAnkEnUZ2q3Aa0RpIjm6Za6JSSIXOsqu
         WTZnqMlCaAZvipnbejGuxgfhMcNiqv/4Jd1UhTaXNjMI55kNTBteJzap/0vHhuTg4f3Y
         9ScA==
X-Gm-Message-State: AA+aEWZObpgkkUGz2RKaskk9BcCIEPs6UsO1jVIunOVX4uKbcTYgFylA
        GLwKVb62Ywy6cs6g5ZwbGvwMBaWO
X-Google-Smtp-Source: AFSGD/Vu/Z/rFrT505Jxee1rVF+JnODVT4geNMHDvWKg8GS/m6Q/OdJiKauDlY98kjAMwhC1ZAnkFw==
X-Received: by 2002:a05:6402:3d1:: with SMTP id t17mr18935046edw.21.1544611926970;
        Wed, 12 Dec 2018 02:52:06 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s46sm4991814edd.9.2018.12.12.02.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:52:06 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:52:05 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: imx: Sort include files
Message-ID: <20181212105205.GB17654@ulmo>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 04:19:46PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Sort included header files alphabetically.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  drivers/pwm/pwm-imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ6FUACgkQ3SOs138+
s6FFsQ//btDu0pz+GTZtr4KqoQPIKacHrD7MbWlyLFERBtFikwDK13mZv5q9Sl2c
jZmFCNXtGC6aD43mTQjno+4UCRw9WOCacnKLGPu3wbF4hnD/sJ8hKT3HFASfcX+P
v4mINeTfY62Z9A0sLGcrVlJ10clRBBZiIhKmI2uVwtVHi22LCOLyXGNtgn/EPGv4
t6cXi8DS++kd7BGukRMM09Q3dHcCAV2Cp/7HaBfZBZYed7+p930+7V9cqvcgh11+
HzlUDmcQ7w1rybU32N61d631zepFuHeln2zAbf93M1xMItNiAu3mwXZNWS/tdufw
FlQcZA01eqVcwdDNcyfYMaUyp9O4F438Ym4Sp7pJ+1z1CX1lKDLhNVmRONM3u7+4
gZXoveMPIF1OlVudYIsGpef1hIgPmVzOznvMRTqChKs8T0ScgNXNX2OMGrMhRSDt
VEoQWQUOMWiRrZk75l9J8SiG7BdTImKxomLehS1zBPR/OVfJoJOPhljEMoOpW1Ar
q+zf+DoOM0sCM6Nzuv3iPHS6dXqc2FcP/Yl2m7p01wXDr8Fom9kI72aMOSCw998R
FPYbIiQQrM4EBQy45nvS4FGWNF7WmuGTcuMvQJm4r2o1STFMKkHzBd1wG51tFIsH
10RoHvNcLbkxLqx7q+8CE+MdNe8jH44csi8gx9WHaWDBEwOURFg=
=ux8v
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
