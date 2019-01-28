Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5DDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC33B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0f2APmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfA1RZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:25:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39954 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbfA1QBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so18647090wrt.7;
        Mon, 28 Jan 2019 08:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IIAGtlBAYxChq9LE8Xgl+stdWp4U/DLgt3p9mfM8A4w=;
        b=J0f2APmLKasT0G5NAvM1SyYOaBOB4/DG8gZPHtmDlyriIOJjgbysxSSlkqcg2Lygls
         AZ+buUDStjIzFJMZhm6dRo4vutqq7ry/6GrVYzVyBxZT6LGJHUzTkzaeNC0DhDHvgTzR
         zx9s1txptMhs+sekTGy8suK0wekuh3VWfp5UTdrInMx6arCtJtu/gPgbiSTkRaoApIvc
         lJik1G6KB6ed+0o2qShbmCqGwX/Zh3SPVYcHkD1XrZGKWA07FUSzgAz0TOFPeT5Aav9y
         o/6EfC1+x47BQZOj1OBsfIfU2h6KC0pxGMidf2C2Nom2fvlafPAFiaodeJavNu3lW8j8
         /I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIAGtlBAYxChq9LE8Xgl+stdWp4U/DLgt3p9mfM8A4w=;
        b=qEpwnQu74nfNjPwwnyn5sd5TYyG8zNLQtQtOldo8KgRit/lwKO9WHnMG2vgPnmtE0T
         UouAb4/pXG63NlWUqC6jgImbsiyqXXkDLqLhMGt5okz6+YYCORLhPMID0thVs5GdoRwD
         PtEMdr36E/yy0u1N/UIpa1GGb8mEl+wM8laMotKG7nQlfoU5vmQs4mVknTrRDpEq93G3
         84tyJmLMIQ1bTpdw8/+0OvJCoB4MdNr6bnZ+bpqgvFf5HO3Vhp6NhKkSswG3MzkxppqN
         NTLqmhkgxT7eF1p5x++Mw6ltLmVxSk+NZsSUyJ9tYyYj6ySCDwVHhQIDXdu3Voc0ONQ3
         Yjxg==
X-Gm-Message-State: AJcUukc3tuKiC2zL7LqiibA0+Ox09U6ElmN7Z4oV0aN36YiUBoFWwECF
        UCojF9fFyBrrFLNhxzmoIoU=
X-Google-Smtp-Source: ALg8bN5DObWtwRbYQu1aRttWOkLwMW+gxLycNqWov7WPxgIHDrq6DevYTE8AKl8fC9tuC4rWKMjapQ==
X-Received: by 2002:adf:db51:: with SMTP id f17mr21126321wrj.90.1548691269782;
        Mon, 28 Jan 2019 08:01:09 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s1sm168731525wro.9.2019.01.28.08.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:01:09 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:01:08 +0100
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
Subject: Re: [PATCH v3 6/8] drm/panel: simple: Add support for the LeMaker
 BL035-RGB-002 3.5" LCD
Message-ID: <20190128160108.GF26200@ulmo>
References: <20181107181843.27628-1-contact@paulk.fr>
 <20181107181843.27628-7-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <20181107181843.27628-7-contact@paulk.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 07:18:41PM +0100, Paul Kocialkowski wrote:
> This adds support for the 3.5" LCD panel from LeMaker, sold for use with
> BananaPi boards. It comes with a 24-bit RGB888 parallel interface and
> requires an active-low DE signal
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Applied to drm-misc-next, thanks.

Thierry

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPJ0QACgkQ3SOs138+
s6G5CQ//dIsEbrfTLsm7zGTb7L5zbM+zjfqGl43qCtTF8Y0EWBHIgW5fDctrzXlO
pddXxyZiQVGDu4dJv1UXJjLVfSOIVRQW0K1XjnR7d0Gq4o8juSkdO8czCphmZbUM
fDf3F37dIXE0w4ehW4OClzVnoC1EBGSHCLBiVg+gC/viu5mBpN+8WMLM0nq+mwA2
7Yl9yiD6CTa9E8EqM9NbmJN1QoXM8RFIESs9xgRI7Yj4Fu7lTltumYGbu6xNEO2M
qmSlUrJtMWNLHj+XSuxdo8bbZzZIL4Q9sj6oeEDwYUmPuVurzhfZuG3AhwM7t4XD
ropeE/C7ihGTmLIHfuDd8W6nC87kCkk32lGsIQGyQmWEoByDzNhcLccq3pk6hCxb
yIOjhnz/68LtIzxrGVNCbBWBkDXqrYdt74Qo9YJV9+3meKTZyNnggHHWwi5NL1p3
lZDWcqhvvGl27ZB++VvNNGrrxcqyNdWkdlaNV/xwMI0tSvpiq4u1spjf/xjMa+L2
9jdpCBo4LKhGA1IG/70dnH0PwKKEWJVWYFjLUiWODW07Kwelrc77FO8Pdmc9N/PZ
ow3moJNaWFqMDHdaorSWGOLF/Y4HWOK8+3ppxCYQARtn+hCVs9w4EzyrAhuW0Clz
dlUhtndKOchqsoMoosmGoWiPrfNIvA3hgQ5WWCFvfzu9AsAGA5E=
=Ujym
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
