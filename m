Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2DAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0802086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF42yYvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0802086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933169AbeGIPIj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:08:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43138 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeGIPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:08:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so11374678wrv.10;
        Mon, 09 Jul 2018 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=df28M+HIgThzbaDmCKA7uDtEyxYdJLywpO0rTm1drIM=;
        b=ZF42yYvCknXtRzokwASEdrQ7RKI6uRkr/XcaKIRgtsjCaSYU9tcArFkpyqEWAkUENP
         Tehc9lgk/6iSgwcgSnlNh68Y96/l8HjnLCpAgplB/KmGc9858LXTOJvEwoGif7qJQAJP
         ws62sPOGR07vmB67bjcwf+snMIHcO8kK1GQkhde9Pv8kddgQRzRbqGNgW9YBDWgP+R+8
         TGct1ze1LKxyL6Tf1REGH6qLzSR2royrg8fWo2OUsBJiQofDS0ojb3vkchXvonWai2Da
         JOWkTjzqtfgYtfQiad5XvFGIqHb1Ipkc6GcAK4Fl3o4lGJgjSI5hxTQVrjMZXhNhtI6i
         VJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=df28M+HIgThzbaDmCKA7uDtEyxYdJLywpO0rTm1drIM=;
        b=kcZzIU6kPR9BG6xWea35xkPfEXYs0QE3sB4Ag2SLav7xZQcc82jmfX7afD9Wg9wTnW
         iZUK32we3QDmedrQP2TcVDKbEFQ+HwcVwPozuz6cvZY81KJZebBKXwDlqbeQa32LVVmZ
         VnvTjKxYu1wDQwvHs4RVPJKC4f6MqjzSjSXJ2ZqaZcZsbAE+EGZ3V89+AzWvYMVy3sLD
         IK/e5CjCG2YsS3xZGg+53SzwM3bZpS0yhKj0MtVBw/zg92MSV/XdKwPne282Y4gh7oHQ
         8gVfbtvXmKB4s8nKY+Km03FF/y2EGHib4ZPrgMpYEHbaqdLvpQbE2MFZaEYTg9h71EA2
         ORPw==
X-Gm-Message-State: APt69E2LENs8V4bhqUjJGO6onT4nsNikJq87VNWb5PhC/MArkbbiGtQc
        vjgMYj+rAriYPLn1b3TcbnCPyA==
X-Google-Smtp-Source: AAOMgpeaF8kti/puzLsXgzbAwBMIPl/hCq8ebUHuq43U97O9x0G5l11sHOJfE/vDpgSkeNUJsjfZOw==
X-Received: by 2002:adf:984e:: with SMTP id v72-v6mr14457862wrb.180.1531148916100;
        Mon, 09 Jul 2018 08:08:36 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id z9-v6sm28405605wre.49.2018.07.09.08.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:08:34 -0700 (PDT)
Date:   Mon, 9 Jul 2018 17:08:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org, linux-can@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH] apalis_t30: fix can2
Message-ID: <20180709150834.GC18353@ulmo>
References: <20180703150340.29580-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <20180703150340.29580-1-marcel@ziswiler.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 05:03:39PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> CAN2 currently fails on probe as follows:
>=20
> mcp251x spi1.1: Probe failed, err=3D19
>=20
> Fix this by enabling input on pin mux of resp. SPI4 pins.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> ---
>=20
>  arch/arm/boot/dts/tegra30-apalis.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.19/arm/dt, thanks.

Thierry

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDem8ACgkQ3SOs138+
s6FatA//Q3UsiK6S5OcpY2UDUoYQ8QzjfrGpvdIuFNXKQc1SOqme3oCTDaWwgRrU
j3B+9NXTG1NMrm7/sB/1J6CwEM4B0Hz3d08AF88D9G/xNElzBtH8N23VMthRRprZ
8a5wZ2gnQ7a6K6/X2apx3XRXExmQeDFyQqe/WCW0w+0ieVz1lrcxsn+QtFmc7URJ
1MvFxGUyIsChXVJyXOUeAAvLypQxopkOvonMMg0Nbamav/blFZ0VzcKGLduQUptH
Bxd7qPNAQ6cImWPMrsuWEMUK8Y+EjG8Lhc89eVQ3DNFfb0xUMWigp2eXa5Wzhh+h
+53ITy4uSwVqh9MqEWcC8t02dBiHpBIi5V0odYMT3vLgaL9paQ6m9q/gcJa9Lswr
sLAyxVqtqDOfrjxl0prV7cYIlZoOffUhTKPIEB72GNcXUGORPzf6obtoRUblyEL6
Cs7mi3GX38XqnxJZzF43wuY8pRh/9ehhTYc2BrtZUW8frc5zy/527ZdK1xa6QZLS
PsfYDI9CbPfzGSwdQUFNj+uAQR5P6nh4sNZbnd1YzHAqcprCHLNbrhZKyQywpBpm
zxtlw2fSZMCTyBHLlnigGnGCea9Xz0OVc16gLpXXPA6atNiMXsViLKTcTgQ3RzSu
ilIDzgh1yYE16QgP/OpD2PR88uSNoWBqV4jv16hcYxO0CeBtus4=
=v0+e
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
