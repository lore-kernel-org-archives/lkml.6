Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63EDC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6D220834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdKG+B9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6D220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeLCQIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:08:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41655 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCQIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:08:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so11204629edi.8;
        Mon, 03 Dec 2018 08:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3HOgXG8Cr5YsERV2T5rvhw+4316QgprwNLvsEggZMvs=;
        b=RdKG+B9PB8ntar0iej8TXhgUNUvyRcfSbCHZ6zdaP1QzA2c1q9W3/pVdmCoiUpo0Lg
         VryQyxeuCFQJ05QuKRvw6Fosc9ABmbsRCrli6z5Crs9UumjoNwF6r3xNK2MYrFET0e0C
         PYjoJbygsiVs5lSqlGKwRdShcrMmKX9c+S26EDarv6W8sG3KBubSoBprs0QPzDksrSMA
         vgWk6MiFKXHaUiytyrDMAzU6yVrAZQ3lhPOdusArSEfc/jxs9xHpfHQbIhJSC5MzHbHK
         F+YyUcGFEwlPUfcFtwuRAnuX4t8+EV/HvOculES6yQRM3mKD2C6VPoTrRVCfngRI7VaZ
         bItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3HOgXG8Cr5YsERV2T5rvhw+4316QgprwNLvsEggZMvs=;
        b=Lp92n55k3vIb+2iMA7y+vNBii2HAFLl7MoPtl/OEZsW/EQ5+fVm3oND0cUDofqo7H+
         maIiqWPtrXXSb8pnAOcTSRLK5rGHMZ8Kd7P4R8DI6FQROzH3C/AhmqGnLd9gXhsBqdXX
         Ajj9a1inqBkQTcTLxiWpITyj9XN51mG/lPw09cUBGIiirDxaxbONHGtFX22i+UCy5Jr6
         Ve5eJqYgOKj7K9gYAsFH9L1m3duQdCm5WahQ/dP6Z/1O0AnR79/b1TszgpLyaA50fT/G
         QJDtPOmXs/+Hgaiu5zLhnCDswSbW/EolPSqfWPXIrQdMuC7JcBCY8VJm/8MtK8Y8exrO
         1kLw==
X-Gm-Message-State: AA+aEWbgY+yc4/J7ip/I4UtZccQGG3+O+OIqoXXtEnFsw8PtfVy3ogaZ
        BI5uIHrvLviufDyKbTF0FwY=
X-Google-Smtp-Source: AFSGD/UKbV42t8DqyXyt4zru21D+THZXiIYKtVxajtvdQxAWbreLtTYO+wpJmvKMlE8GPp/DcroC5A==
X-Received: by 2002:a17:906:2009:: with SMTP id 9-v6mr13782442ejo.2.1543853320074;
        Mon, 03 Dec 2018 08:08:40 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id k24-v6sm2202838eja.60.2018.12.03.08.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 08:08:39 -0800 (PST)
Date:   Mon, 3 Dec 2018 17:08:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/4] drm/panel: simple: Add AUO G101EVN010 panel
 support
Message-ID: <20181203160837.GA10037@ulmo>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
 <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 05:09:30PM +0200, Alex Gonzalez wrote:
> The change adds support for the AU Optronics G101EVN010 10.1" TFT LCD
> panel.
>=20
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  .../bindings/display/panel/auo,g101evn010          | 12 ++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++=
++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g=
101evn010

Two things to keep in mind for next time: please split up DT bindings
and driver changes into two separate patches (checkpatch.pl warns about
this) and keep entries in panel-simple sorted alphabetically.

I fixed the sorting myself and also added a .txt suffix to the DT
binding documentation for consistency with other files in that
directory.

Applied to drm-misc-next, thanks.

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwFVQEACgkQ3SOs138+
s6Gt/Q//fW3RY8o0MJeeWb5pyty3d3BVcUWDLS9phurF90m/1HbMIWE7/8d53bBV
DavgsKBPmhRlqy1Lu1O3940r+xS6WtlDXzFbt5Iiqd5DtwP+gftTzLND71wohAKc
Pc9lGjzdbeIndY8VcB/oBAEd62DD5BZsn6gMewARCpvT/VcLRCo5Ks/pkGl8QGbe
Ze3tzeAQwWMumzrdJLqbyBE72QA0/9/1ql8iqujmyFHZ5A1vlMozihUcnQ6cyyAt
p9MEJ/TVfKGu42sLc5OW+oPb9f3tLO+G/jVoZ9lLgfRyQH7nyucJPqZ1SPXmI9AR
OI9g34RCqnldcEjh2QPtCchpZBT9Ip55B/GJxZpFonZVjK1Fty9bpSQ5ZZLo03cT
OL1psLujcsLAb3TrkKfCt0fROv9xix0qo954o61E5LjmOx3o8OkKvsM68CuSvUVC
1CrjVZzacco5DeGO5z8NZ4SsmF2hRyzmGNvSAv19toqjXvvrZMasUmSrU+pdBYgW
aZipFthJkw/jlXnk1UTVvMfd/OHfrwDBiXuLvQSfMJ4aVpti2Kq/q8NF2eZw1OWU
cJngTfAVPVD1uHVjJSSDv93u/A43hvJMHcVD0gd0Rpu+AXePbHdfPje5Nmni+QZK
b4S2QNnwsTHZP5pvKP7ai1/OXv/Qjo2DSBQAFLR2Gi7gcRcVRXw=
=/9Nx
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
