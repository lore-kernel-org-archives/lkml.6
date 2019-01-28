Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71869C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B20520857
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW3BJnV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfA1QAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:00:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45160 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfA1QAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so18598239wrr.12;
        Mon, 28 Jan 2019 08:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rAf5KtiLxB+Y8yeddfolVuZO/p4Rej1EROwoeD/HCh4=;
        b=WW3BJnV2TgZkYA7Mks7exD3nnMDX21lD9e0moEQJ0rTGE0ejhICthxrjfvGbf1bFwn
         GCX4yvyczRsCz/PCafWqcLuodsrJ5bErJzoTYJMP18Yc4xw3lnU5j32ASh9rdNsQT/BP
         YB6L6lK2DQ72feI3bHLx1Vor6dBJpMumU+IKC2DVe/ftAl48z1wva9j05QWIQTV1AERZ
         zUPFn8WuoXzZQ/hkCs7/QQuEzHYi2FAjjW3zieQLj0lSV3038hkgt/8B+cHEZvLVEfqb
         2n/TmTZyajLKF5ZH+D4Gf4MLNx7Hpb2rHNoETQkcLkPr40eS4NEaRZ/0sBbYsgxVZATA
         zquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rAf5KtiLxB+Y8yeddfolVuZO/p4Rej1EROwoeD/HCh4=;
        b=oknuuX0SGbUilcCOqbqoBPI0Njpyrg2QhLe2VBKzAsChIBDIprE+2Wk5mxhvPVWtqD
         uclIBytEiDf/5KblorItoMgGzcIwrDjDOo5NEnW7kCgOHWMklwSPZZ5kEi1fm8JxnBVx
         gfiOQX6Kuuh/aV5+Co3FZQppzIkY28gvywCMFZXH9rAHYV4l9tRk8X+zX9a4+UU8wzOL
         +jp2Y8ZI4+mlmyjlmBNfeIHnvcaVYIhkPRxz7tdOmBs4OX1eamm3NMN/2gfNrY7j0AFt
         kL8nmt1UGfbqRZOVrodsTz1QkQ+gzXMrxcMZsxI0y8ybXwk8BbZVOFgUcn6ZY09XZ+9d
         YDLA==
X-Gm-Message-State: AJcUukeYnTR1aint0Go3jpFcCpX1M8tL4iF2nl4MwjVZMf05WQvM2JgO
        yhYB9BCboExjLzxTvvw55Wb9WQN57FQ=
X-Google-Smtp-Source: ALg8bN5pWnMJYEHDDziducx0SUj6LBoU4btuuFyq0iC9SAkRJPub3QntuNyHUtWJNFfYq0n26gY3VQ==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr21687810wrw.310.1548691209769;
        Mon, 28 Jan 2019 08:00:09 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b12sm88642813wrt.17.2019.01.28.08.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:00:08 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:00:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH v3 4/8] dt-bindings: Add vendor prefix for LeMaker
Message-ID: <20190128160007.GD26200@ulmo>
References: <20181107181843.27628-1-contact@paulk.fr>
 <20181107181843.27628-5-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <20181107181843.27628-5-contact@paulk.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 07:18:39PM +0100, Paul Kocialkowski wrote:
> This introduces a new device-tree binding vendor prefix for Shenzhen
> LeMaker Technology Co., Ltd.
>=20
> This vendor was already in use but it was not documented until now.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> Reviewed-by: Rob Hering <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied to drm-misc-next, thanks.

Thierry

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPJwcACgkQ3SOs138+
s6FAihAAg3SFG5bkiqSyuBFogMyx2ezKdKZLxO4g3NAM6DhO3MKV/iyCCpbcxeaT
L0YP13yjuhvOc3JdiX9H3OInqH4pUV2ybUPZ3RoVVgB/LTWxth+m61vg4S95kLbW
801yEJqXxqHLSNX3jzZby9n6wKC5ojCDBTa0nggFlKKL/XIkFNAWIuf9S78cUPoG
si4+xZf6tIftd8F3YYQLsTlfA/dTqTwJ4oBYOoH+W9DhgamxRV+DwwNfRpHy4JbJ
cVs9tce+OhdZL9W/l8aisfq2TQtbctfEbFg+NjQq3z4y2HRk2jz5mWbtkhHDn198
5Kew52EKWfxIydnJURrPtzGjF0gn27uHZaKAxhYNW8qTRnuQjzAJSey6sopsi15h
nElhgiLK4yW86w5CO0sxtM+4Rn7FUHfgZP2ek8Uff496goaKvdJJqaD953HPDy9V
FGLUKkekd28xLRrkuAKGwS5oXdLisCsckQZU3Wq/7NrxziudZvE8UxqoGrriYmZd
//QZM5BWnc1T5+9bpfGXD6XsB5mY16wCy0VZulE4tLcBsltNDCt8ywHuJFvm+Scn
Ujih/S4DGcALpvfmGABk5nKb9n9uLP+C54N5opmvCrKbRX+2ZfY4fvppkIed+fQ6
dRfzEEQEvKVi2zROggB+McIp9Z+UtXLsjGapHbPgRYJpZ5fTmxM=
=U+8k
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
