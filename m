Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B232BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A0D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIgZ/dQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A0D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeGJLFR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:05:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33469 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeGJLFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:05:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so5231912wrp.0;
        Tue, 10 Jul 2018 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iL+p69KaXjX3g/UtF0Nnt+u5lUzh73fXZamwx+/GLOQ=;
        b=MIgZ/dQ5rghpIl1GaR0zY4gO+3D6HVxBmiWU4ELoScCkWVdwgvVsCF2re+DQanjTrc
         hNBXa221PWpvnpcMQjFqNBBH7rgYH/h5bVC7Dq6wxrg4jYqRaBdFSyR+X1mYs9OMwQQO
         zfj9+X3mZOiPQL42y8rEfp4ndmRTN9hZyotcoVOdZUQg1f1AHn2Bup/PwGxDdAf2Dxi0
         pog8DM3w5t0nW37ht+6Kx0noqQ4m9/9fIsgzVwWMX7Eg5N12z/RpDWERTLkNSGWCdWvD
         tk8ocY2RMQOjY+rRtYCARBNrdg/Atc222GuBBzAEZuLh1UULKilMYCvEFMcq6706TR40
         DYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iL+p69KaXjX3g/UtF0Nnt+u5lUzh73fXZamwx+/GLOQ=;
        b=DIyiZN1k4p1thObj6Ie3rvlZ1ONeaIEN0sU6F6JLnN/K08c6mPteONV7TppJmMhQSE
         FszEhj3Eu005lK0CwD+SrJ+HU8h+nFmhB2bJMzX/3L/N+/lD9Ti39h2LOqpEHPNGCREz
         2rYkk/hDDNi+nQrPZopZK/Ke7F18hl6k/4tSohUFSNPuFKoTMPEmAdQN7j/6lnLdrwOZ
         X/Nuu4WpQVas6OcHSSIK1V5cFp/OKxy3kVV1hY90741A4zLwOyNyS5vn1YvumuvE2EVE
         N27rpIkm2FS5aBKieg5/F9fosZrbVWeISz1Jjm0WTX/P/ydXVtY/Mg5lV44KVHhTzjoV
         UuTg==
X-Gm-Message-State: AOUpUlGpUsyW9cjkZQCaoKsL2prJBaXVsxI8Q5xHWIpSow30XjFdVG3e
        EXmE+8DGEF+NkCwhjhma4kw=
X-Google-Smtp-Source: AAOMgpdPcSM58DjvudCch1MZvsO61QTajJJlM0Ugw7vuLtRcijkehDnM1YHPpDnACdjlakfzndf5SA==
X-Received: by 2002:a5d:494c:: with SMTP id r12-v6mr9576621wrs.66.1531220714376;
        Tue, 10 Jul 2018 04:05:14 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id u6-v6sm15819964wmu.5.2018.07.10.04.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 04:05:13 -0700 (PDT)
Date:   Tue, 10 Jul 2018 13:05:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        nickey.yang@rock-chips.com
Subject: Re: [PATCH v2 2/3] dt-bindings: Add KINGDISPLAY KD097D04 panel
 bindings
Message-ID: <20180710110512.GP1504@ulmo>
References: <20180702103229.3952-1-heiko@sntech.de>
 <20180702103229.3952-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wg9FEZT+WCTrEXgJ"
Content-Disposition: inline
In-Reply-To: <20180702103229.3952-3-heiko@sntech.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wg9FEZT+WCTrEXgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 12:32:28PM +0200, Heiko Stuebner wrote:
> From: Nickey Yang <nickey.yang@rock-chips.com>
>=20
> The KINGDISPLAY KD097D04 is a 9.7" panel with a 1536x2048
> resolution and connected to DSI using 8 lanes.
>=20
> Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../display/panel/kingdisplay,kd097d04.txt    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/kingd=
isplay,kd097d04.txt

Applied, thanks.

Thierry

--wg9FEZT+WCTrEXgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEkugACgkQ3SOs138+
s6FLCw/+IW5ycgyk9TiWVBIurrQDhG2/XUgcfQmtRmO0gEvvGKNPLuT4A1bCX3S+
lJp/uRWCyi6utFVYBpr0H9k2kKV+lVq4WSI26cE/A5haCJa/nknjBXfzz6o7nADR
w0/tMxvkJ0/Toj0urFCZUhMx8cpTveOWUVMMXINHKL6wSBGq7+4SlDoJ+hsUx4C9
xm7cDjUex1Y0eCIsksPO7I8YuoFleqEAOlYmp1nbCazKh/pqIcfOJiDaeWcKNAJ2
Xx0tmIPxq+2+8OzgZd08m570iSdn1BffcCkO6OqAddx0b+1vmnmSC4jxDPgaQxEP
ie1rxlSd1IaGP3wS//xmT9xiCd+dF1EJQ8AAv7zis+qQHCBICtKD3Mpb9B53/36v
r4CUN/OYsR3s7GgMWX8KFoYjFrD0zsS4hz+uAH1d85pLX/hFjyAlpz30b9KbaEVM
5DlruZZuLGSewW2XAM7xeuPHXPzdlNlErSnPCu92qywmIJekM6g0Q8nueVnf0egh
hMLBgTbdhO8SD83vL6xdl+uEN93hwID/G1Tr0ZzlKAp0GU2cHPlsYbkyU8Pr4aFU
Fi3fGBxxhljE2VlJiSACnioSNmR2BANBGx96SEE3CX7mHATOnZyVBj9FDFxfWjit
y1Ook6PrD3qsLM/kiILorkw0+djSUgWSJ+6ptd3tT95/qbgCZDw=
=WVH9
-----END PGP SIGNATURE-----

--wg9FEZT+WCTrEXgJ--
