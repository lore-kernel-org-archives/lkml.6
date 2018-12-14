Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE4DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C103F20643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVznxn6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbeLNNgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:36:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35227 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNNgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:36:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so5472476wrb.2;
        Fri, 14 Dec 2018 05:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pC1BwrKhI6S1WVsqkTH4TSPTqrje5huAZF08J04RsMc=;
        b=UVznxn6oQw4zl8PzxCZAktAa8Ssrcjbk8CcjPLqWmHfefYTmHoiQ8QgPMOkgaUPLzT
         D0TwJ4pejYx9cfOCGqQlD5pR2Ipw8u4s/p0/SVAkdYiZzf3rhLI8P/JDSIH5Khrigu5+
         cUTIW6ZaJAUijh1wxpt9kq8cxhnFKUsWFxVkewlLEBSk6vXIFpUp+JyBUmXl4Ss7E/vt
         2xAbLKj7k5Mx/2dCTDSGwEt2BCrX8EPP2wzmau1Ymd8Wm9t5hfh/lZu0eKzIkcaEmct/
         U46ewAvmengS/4oiuLUXUTogB3e2INqRO8iVOxtQlUbsJ+2y2m9thIMIinoYkuJDAHfM
         LyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pC1BwrKhI6S1WVsqkTH4TSPTqrje5huAZF08J04RsMc=;
        b=gva4Fk9GwE1Ur5sxwGrimusiQN+XOiuUS+2rlaCWyg1aIONorwYxSD95fJlZygnl+m
         pMTP32yn1JLTBlfXOOKlky9K6LoOafcvNbB36a4Wyen3PgCX4jQ1gWW7xgQ2MbciV6Tq
         DVZOUzd39GMs8Az4CWGkAAUf0kxGSMXsnWGSprf8AMzyOve2SgRweZnZomudqCwfT99Z
         Xrz5kfiTwpbVtYnG7u1zJU1yJvyrlbdVET6MafqSOynxvaew3vuWw4/nyDgm9KuZnegJ
         cgRA/nS2dClO+tPU9pdTc1Xj322GthKy4ym6v5cBdblEUC7zgADGl6vzSPtI67Yt/rSW
         JQjA==
X-Gm-Message-State: AA+aEWadxKzVo8WA6J/aHRM9+ThhYdvSej971Cw9xIda4AZEmUaeLHXB
        ADNDAilIgUsD4uRL5+xuRNs=
X-Google-Smtp-Source: AFSGD/XI09JurqmxrCnthuZl+9ZYUPFDgnkLF7ZB2RianE5K0xPF+Ef/9D5aK4tt8oOEfQEjrc0N/Q==
X-Received: by 2002:adf:e608:: with SMTP id p8mr2674964wrm.166.1544794598565;
        Fri, 14 Dec 2018 05:36:38 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t18sm3451645wmt.35.2018.12.14.05.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 05:36:37 -0800 (PST)
Date:   Fri, 14 Dec 2018 14:36:36 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] gpio: tegra186: Rename flow variable to type
Message-ID: <20181214133636.GA23379@ulmo>
References: <20181129170312.23625-1-thierry.reding@gmail.com>
 <20181129170312.23625-4-thierry.reding@gmail.com>
 <CACRpkdbuRJ+UAoZkZNtWNzrF2+_0h-ibkTaDXWcPe70yJCx+5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <CACRpkdbuRJ+UAoZkZNtWNzrF2+_0h-ibkTaDXWcPe70yJCx+5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 02:34:43PM +0100, Linus Walleij wrote:
> On Thu, Nov 29, 2018 at 6:03 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
>=20
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The IRQ core code refers to the interrupt type by that name, whereas the
> > term flow is almost never used. Some GPIO controllers use the term
> > flow_type, but it is most consistent to just go with the IRQ core
> > terminology.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Patch applied.
>=20
> No need to wait for genirq or other changes to apply this.

The genirq patch was acked by both Thomas and Marc. Were you waiting for
anything else on the rest of this series?

Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwTseEACgkQ3SOs138+
s6F0RRAAkBNay38yWFL3Omkl0uK0DU9odZW3Zn2R+bLQd3M1aAl891/gRC9SUOeR
UGaPR/4s/vmsTj+wQRZbCI/h+Q9B3MWND73H7Myz7Eoa5MbByge0jt8xfTD+7Eii
8ZzbS3vMq7WvDW4fXr4Zoo27p+Ll5fr3QDpCiT+3A6+XhAbnTws1/+eu8Y4WUSJl
bD7w2jZ3BZe+ATLeDsz5RowBIYACxms92jrNke2VF2/nnUx270ezYojje1BnDPHx
R7S9RTkSPKQbOSvwGaFXA35gu48SWjj6xFMFXTCZaabSby9FEx04Ro4j2luTZY1h
m/3zajkLpxG+/VAbxOyXZrLOm9OSh3C049HIgYRtjLbE2Qsp9rMZnOunfI0wHilB
hMkZv3Rti3ooofOVeAQBtyFLKjaYlQtd9o/wU8y1T/nxeFf0imcUZsCGNw+KB8kG
lTrfGz2ML24xA62fiV+CP/goA7WNFH9MfXEEutxLK2WTZwX6wXsoMk3gY+PiahZY
OMNXS1RI6G+/oSn+BT4a9C+bTQxC5rKROVN5XLHsj18030ZF/ugutEHy/y1m/LD5
7v9inda5sdLlDeuckW0pighzujO3DDusebkN4rcHb1WGEnTzz+lrC7gU6zrTHTSJ
tdvwZBQkMvTxzWzRhrg7Va0UhRM8+/EwxHc+t+VI+o/Zoh2FNM8=
=8+uw
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
