Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D45C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C10020870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSWEN3Xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C10020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJJVGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:06:22 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:36696 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJJVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:06:22 -0400
Received: by mail-wm1-f47.google.com with SMTP id a8-v6so5801219wmf.1;
        Wed, 10 Oct 2018 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cRI3tf5wvOQekpXYB8n3+TpZrmkGzWG2Pqc4L91fjdI=;
        b=eSWEN3XwITfWXkf1wsYiXIJOcxWuEyg78kYzJJcOWJCq6tb6NCxUnxUFeqrWDmG3db
         /qyvXMChlwUUPO0pVDZA38aUyrxvnOmhL9C1Jjk5jgEagoRHopLF8aVWzmmX+i4cfPJ9
         TNgO11ZJk71Mv/y81WEch2OQoLVEUCCwvOXwPjsPKkY8dNn7KbTw+82fniIH3SERH0Th
         ZBxB9stGI5/xEHyfqvCW4jJrR2EKtGbio7Fsq5kwfDyNI4v8OiTCFSpHkcoS5FOezjEo
         sRPUDKP52Ks6ovlOc7HnQC05dLhI4F2G+tUkha1j3Rt1qAhRE22fmLmi0ziebu9XztTR
         hIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cRI3tf5wvOQekpXYB8n3+TpZrmkGzWG2Pqc4L91fjdI=;
        b=Mz3og6HpS58jiySs/AJOqVVZiGdldMc+zMkpgysPeNihUpSG7eOjKYK/sZWXZksPiG
         wFjveSG3r1Q3Wab9f73b+EbeEUiA/OBgXj+YWXr08EPOOBQkK5ixtmLfeODNsL0HYdOp
         LvpHgXo/+4wkUGFo3H68qYCOolqGQOH5NEFIqnahraQD6lAuE4w+wihPZm/HLieSJ4p1
         0Uuzgoimba/KjCtuX0C+NMDpuF2sX52exMJKFXewKtb9AfonrT8HVBbFMPih6ej5dq9J
         +mz0ALtcmdJNXP+GzqrblVInUM9kHv/AucnyWA8smMHuKRdk6wO3CWlv139HkNgO/Rkj
         S3Uw==
X-Gm-Message-State: ABuFfojA+BfX/GQeemnWGdOfsReNMmevEn8wfkhYszJ23WE1woEI0aqb
        vzjZth6xMckwyV3BiKTd84w=
X-Google-Smtp-Source: ACcGV609DOSwacilKxc3rArUjc10tLfZm6BkGchNc6IARoqAZMMi8X6/1fedznQ5OZirWZ7sUL/g1Q==
X-Received: by 2002:a1c:9cc9:: with SMTP id f192-v6mr1001719wme.135.1539179045483;
        Wed, 10 Oct 2018 06:44:05 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id r8-v6sm24989791wrm.14.2018.10.10.06.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 06:44:04 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:44:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Atish Patra <atish.patra@wdc.com>, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [RFC 2/4] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20181010134404.GC21134@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
 <20181010131128.GA29142@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20181010131128.GA29142@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 06:11:29AM -0700, Christoph Hellwig wrote:
[...]
> > +static struct platform_driver sifive_pwm_driver =3D {
> > +	.probe =3D sifive_pwm_probe,
> > +	.remove =3D sifive_pwm_remove,
> > +	.driver =3D {
> > +		.name =3D "pwm-sifivem",
> > +		.of_match_table =3D of_match_ptr(sifive_pwm_of_match),
> > +	},
> > +};
>=20
> What about using tabs to align this a little more nicely?
>=20
> static struct platform_driver sifive_pwm_driver =3D {
> 	.probe			=3D sifive_pwm_probe,
> 	.remove			=3D sifive_pwm_remove,
> 	.driver =3D {
> 		.name		=3D "pwm-sifivem",
> 		.of_match_table	=3D of_match_ptr(sifive_pwm_of_match),
> 	},
> };

I discourage people from doing that because down the road somebody might
add a field here that's longer than the alignment tabs and then either
it becomes ugly or they either have to realign everything to keep it
pretty. Single spaces around '=3D' don't have that problem if used
consistently.

Thierry

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu+AiMACgkQ3SOs138+
s6EREg//bWfq+MbsvCFozGTRY2bewO2oXHvxKIEXUcmof2E5bb4d8Nji84cB29oG
LPQMtazXtr1/3sgvO8z1qd07P97gSHtOmGv5T/pFkMvvDh2bIYzVsvS/qegEabz8
Tjr0qBOUZfvy2NrsR0okSsYJr/qTWFZ6NyTkLZkwPNTKLInj6LxM1jsu7sxcso0K
lmdJ6vlYXeHDAzihK503O9sj1qbuYODppXsXrrqvx5bNdQfKmRZod2rs3kh4CsMa
cQ5hFJI7Kju9j9ndSlhj9s4R85BP00KInQ19+sduOxT490UDX47Fi3CGglQyJDjO
OEyW66jFsBI7y/bnW8ngLFz86Db5/p5iwRx81mLtE4pfrEONY4vjm8bqsHIF3U9R
Gcr1JaF+x3U8SYchjJMrxJjz2cdrzKoVD9XG+cGbzlxNEeWWxuALNZDN8paJkN8q
0QDgxDyc4zdo8mrHgOdlRxY35raBaKZLpUXdm8jYZeUT7oMYRvA0tlAkufbWuKHn
GpK7ERekVaApyNbabJTmk8gYbWIRrcosEpgrNjOrlSgkS92KBfX0TwOxHOUuVaKs
zM0rriWqTYEar2SUxqOuBJEckNVkJI8mKGG5Ks0S3i/hswft8+FFW2FCqgw1iau4
zm5VgMLqmhT+tZ1xFga5rOMQW/zNcBXPOoNqxe8EFvMjJMATjfw=
=cs39
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
