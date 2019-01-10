Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21C1214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On1+lY/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfAJIQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:16:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43380 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfAJIQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:16:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so10249841wrs.10;
        Thu, 10 Jan 2019 00:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qM66r+xntB+5kvbjpiQ9/uer7mbNfi5prClgUIOCWc4=;
        b=On1+lY/dq8UJzS7CgnkUQ8Dmm5DPPDnJ/nTfEoEKr1VxzFqeDC4j+12Vj21ZzEM6KU
         Xx+b4XTqi8VeeJseoC6nbS6k4SiFHgm3pxC3r7Svz8Z5B1x1JLwaErH7pmvU7EmIRkDQ
         4M3vbwbrCHXu9tmCSWlDzEliEdoM9py+6Bou4L49F2NJJhpv1bLw/PP4whlBQSsHH/Wv
         E8i54tH8jdfOi8Cq0dw0CfbXrdhyHQHJ5hsU79sS6XS22USiuPrEYwmYaA6kC8a5Vp2g
         bg4GUUDT3/H0z4cQL0MX2iQFBbnOXRQtPY0T3efnUk6ia33+SIGk8/zsoEB9/n75XbXs
         qgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qM66r+xntB+5kvbjpiQ9/uer7mbNfi5prClgUIOCWc4=;
        b=nNU4CjL8abxWalDeBEu7QK3S+PdlpOCgqyepwhdAreNy/x6gERMngPqk1brVmD1PtM
         21VRNRv82SK1FBEKDRBhtfftr6eWSniZsqLhXc9eJIGvt3gXtim1nQdeZvVI15cpKrRt
         /jB/cm/hnqlK40fDLo++iJb6YeIp2ZaJoY2pdNJ3Ln8RsCkE/F0GLRxfdhZ1I0Zyw4go
         Npt/yt23hipPb9DM4To3DJK9FO+zWMYfQv34q5oyRWTsOPLuNrcUYPniEPZ4ih2xiCW/
         8Mas4PTCtvAkuRcAD/p7P/xX/CA4m/HT41rkbYUU2YqObiGNYqF3Rfq0tjuR/5JBj3zH
         x1HQ==
X-Gm-Message-State: AJcUukdaxPlnh0t9ZrXgkr5mf11rmBBDixpWxbo4mY+XafZ6cRlIwhru
        +Xj4i3Yf7XKAG3IW8+QTAxo=
X-Google-Smtp-Source: ALg8bN4X4GCNf9dbpCojbnhubVx5N3K/B+QdHhY6DcNoAQadMdqRTGK9U50QG9PD5X32MWMQRW9KpA==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr8493938wrp.92.1547108177682;
        Thu, 10 Jan 2019 00:16:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s66sm12569416wmf.34.2019.01.10.00.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 00:16:16 -0800 (PST)
Date:   Thu, 10 Jan 2019 09:16:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     jassisinghbrar@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] mailbox: tegra-hsp: mark PM functions as __maybe_unused
Message-ID: <20190110081615.GD5213@ulmo>
References: <20190108143713.15120-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <20190108143713.15120-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 03:37:13PM +0100, Anders Roxell wrote:
> Without CONFIG_PM_SLEEP, we get annoying warnings about unused
> functions:
>=20
> drivers/mailbox/tegra-hsp.c:782:12: warning: =E2=80=98tegra_hsp_resume=E2=
=80=99 defined but not used [-Wunused-function]
>  static int tegra_hsp_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~
>=20
> Mark them as __maybe_unused to shut up the warning and silently drop the
> functions without having to add ugly #ifdefs.
>=20
> Fixes: 9a63f0f40599 ("mailbox: tegra-hsp: Add suspend/resume support")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/mailbox/tegra-hsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw2/08ACgkQ3SOs138+
s6FA9g/7BZnwUwUOpe+vG8m8xTivmfFvce+BAah6q88UtWSGi5VrG1seAVibwTHO
SkMQQgyU8ji+QXgSzoPVexaluII6sYBLzDkIYM7+Jssilms391OflC0gPqIadkxY
jYQMXjDh9rEXo+42W+3lSLw2P5rYpgXEUKcBkCK8zjz6pDYt40X5ApnSsaG0Z3v+
ad3802dUF4x/EgDpqyKkA23LsvM+5PU6DDQ+cjwEt5fwb/BObQSdb3v36BU5gC8/
7l56xyBb8qtjsN7IfuGrFF2RTSr4QMMf0SLu7vaArJlIj9pgO/eKGbms3UulDtpz
23pSEXG/aAFSSvOA/ajcME+2MtYIBxo3FTRT5ED2la7oB+UWr06Tzk7c8J3e7uEG
q+dqzdOT1dmG6dPX+lq9GSlpgwq/jSMmobSswZgnpPu3UW0qvBI6I6pEm2jrzGSN
iDGKWsQAzaYSvwXVTRcQLnPidLDe0B24ExRR/mQkMPDJRrVOcEbJtNw0QiKLF5Cn
MdRfFsulghWaVIlJ2z3MxbNj5sXrKagXrzYtwviZrDX57w6tSIo7wBD3i7zEjBV7
LrwgOFwliyGAT5sd3WFOe5bEJucO/7ELAnaaIqJ65dwoqvTdnOvgOyYzvX6OwqaO
wiiwvk6sfUFVAOaTGAEvfdXmI/HmthDGGH9mwkBzz4ULNKgxrC0=
=NYWm
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
