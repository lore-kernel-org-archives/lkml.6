Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE20C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252F62146F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKfRdGjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252F62146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeK1USz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:18:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36049 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeK1USy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:18:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so21474706edb.3;
        Wed, 28 Nov 2018 01:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F6OwLcCXU54f2u/KCw68kuJ8Lq4mhWShCbV6z9yfCRY=;
        b=tKfRdGjZ6rkKHqongZpgoArv9uQQsRICH51Vx0OVW0E5Vg4uFq+AsPvpJFQSSovSlU
         zDZRwmBkE1WHeVwK2StBBbFtVGEkH6eBYWbTJ8ANocujaFjqUpCB//JSCyQmA/8EVH10
         CiOqqrO3Yq+DlDT/pgJtt4SWolJK+FhNZsIq6ELp+8Br9LqxBV2yUZjx9Ijw6IyykiVc
         0W0HxBYTSgJmZUw44nmgcZjkiuSOSaBXGTsKkzD8yovSaNvLfXWo1CKicKDCspaFbMO8
         QnovlytOFOy/ddFZz0Dp2+YO5J54UoSoXnPMi2qzBQljZS2i/+JMbs0392b6DJTXuAT8
         rT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6OwLcCXU54f2u/KCw68kuJ8Lq4mhWShCbV6z9yfCRY=;
        b=sfTRi/hFsdgOLxOLcRrd0GOcli0YDMVCLd/omKE92MdOStsAapuANfsernwEKncQNW
         i+ZRsn22kNFqqNUvKeDx01dY9MVeMmcLSVjsezFSIvq60Xr6hbvYHVHiu5U7O2R1oLo2
         6dzv1tFOfnmtJ/MXhGQ6WTe37ROYKwR1WocMWkO5/czmP7NT8f2qOzVq96H7URpnMaAU
         +YJvDiztuSDWKFg7FSyG40trY/uMhkkZucZIGz0iAxYvVLOOZWXqBy5ODEqklG2dAlNK
         z3B+tbMUoALbh8id9DutSIHRsVxMqMcZ6975um5eLxeLj8F6n+HJLwXCU5Pv3TzB/JZg
         C9+w==
X-Gm-Message-State: AGRZ1gI2GrcTXG4MbsGwPaB68Bl48OD1FlHpzejrZzikCQ63nEJ3as3K
        de8om0a3JC2caO6kPkSW7GI=
X-Google-Smtp-Source: AJdET5d14sqlRfUBl/0dN7ZbSvQB9DGpaNRDqq5YzmTaBrz/fYslM2cmbA/mKSBX8wfwQWcCTwIyvw==
X-Received: by 2002:a17:906:3389:: with SMTP id v9-v6mr25740981eja.201.1543396676796;
        Wed, 28 Nov 2018 01:17:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s12sm1676806edb.43.2018.11.28.01.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:17:56 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:17:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v1 1/3] clk: tegra: get rid of duplicate defines
Message-ID: <20181128091755.GD17419@ulmo>
References: <20181101015230.27310-1-marcel@ziswiler.com>
 <20181101015230.27310-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <20181101015230.27310-2-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2018 at 02:52:28AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Get rid of 3 duplicate defines.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> ---
>=20
>  drivers/clk/tegra/clk-tegra-periph.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+XUMACgkQ3SOs138+
s6HLtBAAwLL2s5Q37THgafBMibsJL0fTIZxHyL4TAMQ6AinFQxL4sNVpf2I+S7oL
G79WnmDGcrYXDsE0AdYXY5IJD9SoS4VE73KrCbnsxzsnmk2MouzWaELrSlFbKDvi
cN1Fs7Gl98T7hhkLTyZAmwAlM2aI5T0xrGXTxJXGQG5uOYmC1y0fyNik+o7mMiei
bEhQACtsOzuV01LfR44aXJ2ScQGrD8NM26TzeB+lCkiEr4PtHpbe7vM1Hya1t73p
+rCCtWi4fJze9d9oW8ZnWFFEoRosbLEi6om1PojMtWx5kL329sYwHcYUOBQB14jW
GjTEX9hvUvFXi9/LsdNFHrP5EJECwkGrLZLXCfbYXG3uoD+TR0Gok7o4ct22dBUE
1hFUW73o3tk4jH+Qc3hCXeDKzvKPWQW07ClFP58yELz8uH1TWIcdRgJwB9fIc7qw
JlXJFHQfVuPlb2AnIXsasTzhZ0FCIBE/2plr9MOBWJU+KVo2fcYr9Sw8UAvM7tq9
Y4k16hbIkTu5/WsFpYPyj5hMEXOz60EMFVzeQvTcsmYnkMlm5anUKLlFmnT+GyEw
jrnlOEc/tJePcZOO5LgbBptVlisZcpB9l81nW59QdsZEiR+k8VUCHsYr1cXMVJFj
VLX0cuRsxEcSFma1joGD8e0mfriSB9rWXJ82MvBAkavysSvm3yM=
=plpM
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
