Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6DBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC9A2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQE+Gog2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC9A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJJNDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:03:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43066 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJNDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:03:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id p24-v6so2032046pff.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 22:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ce30p6IP0CNtU2k9Km56sWT812Iuu5DUxbwZv5Lylts=;
        b=IQE+Gog2plFwsLUhHwCnZKO+6tcsipozQR5YHJIbhhlGDkT9VN+xCpNRO8ug4FY/G1
         rQmum+12wNFV4VBinoEk2AJiRA5Bfz7wkE28+JQkCfboumYDtAXtwxVEV3k4EVhaDzHt
         wLvXBVxdJd8KZjuTTLU27LvDGDqqKxRs28xc79z6BNy2xMv2UnE592bj90EG8WAecl3J
         0wANbM8cwhA/fKMAdB8BajGxym+IEAl1JeMN6yCkWhwhQR94eizDymAWHZ3Vn1VtNrNd
         OO0/aN5OeaOjEkVk2GT5Gl4yxZBk5ngKUG1drAIKIKVinnpyGaoGp9u5mPie2cyWOyj1
         4pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ce30p6IP0CNtU2k9Km56sWT812Iuu5DUxbwZv5Lylts=;
        b=WVzwZtzxAoi5yhyvEKqZcGbMVO7y2W/TIRqdXNZ1c/MYS1rjB0HG3m2PBPfcBdzgHl
         ydwp04pz7Eiz5bXogUUMifXO5PFQrklCA2iJmVmetmulY6Ynb2+JyJ2VAmPXV/2cWFpD
         ZQKpO4sGuZ99lkLcIgm5WgHqv1hjsqmAPZe/aFoIi5FXkjwb4XD64c/075UFSYJnA7vR
         2zVDT9wKuthCMWrpB0iPDs/2GloPzls/LpjE3TIAAdco/oXsWyHkELWVTn1tVotFPi7w
         a4p5sL79sdbCPQNJkR3tpSpUF77f5HgJN9dOigHyq6Edz+iTsy2z+NTjTXQ7I7LA364F
         Qskg==
X-Gm-Message-State: ABuFfoj3IgUh2R4ereTKQ0yyiDYyPQPhHfd5eCGmdKfSOmTAxMjPpM7C
        p5FBfzmFGr45KoDNd6c9QKjPfg==
X-Google-Smtp-Source: ACcGV61x4Xc82BSvImZBuBjaqfBcJUXhUvij/YZDhmIw/9zs1heLOzesvdtw8HzDYOLc2b/PgXbgMw==
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr32756591pfq.227.1539150189680;
        Tue, 09 Oct 2018 22:43:09 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id u21-v6sm35949811pfa.176.2018.10.09.22.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 22:43:08 -0700 (PDT)
Date:   Tue, 9 Oct 2018 22:43:06 -0700
From:   Benson Leung <bleung@google.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: chromeos_tbmc - Remove unneeded const
Message-ID: <20181010054306.GA231593@decatoncale.mtv.corp.google.com>
References: <20181008222041.7713-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20181008222041.7713-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, Oct 08, 2018 at 03:20:41PM -0700, Nathan Chancellor wrote:
> Clang warns:
>=20
> drivers/platform/chrome/chromeos_tbmc.c:102:14: warning: duplicate
> 'const' declaration specifier [-Wduplicate-decl-specifier]
> static const SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
>              ^
> ./include/linux/pm.h:365:56: note: expanded from macro
> 'SIMPLE_DEV_PM_OPS'
> #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>                                                        ^
> 1 warning generated.
>=20
> SIMPLE_DEV_PM_OPS is already declared as const, this one is unnecessary
> so remove it.
>=20
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied for 4.20. Thank you.

Benson

> ---
>  drivers/platform/chrome/chromeos_tbmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/c=
hrome/chromeos_tbmc.c
> index 1e81f8144c0d..ce259ec9f990 100644
> --- a/drivers/platform/chrome/chromeos_tbmc.c
> +++ b/drivers/platform/chrome/chromeos_tbmc.c
> @@ -99,7 +99,7 @@ static const struct acpi_device_id chromeos_tbmc_acpi_d=
evice_ids[] =3D {
>  };
>  MODULE_DEVICE_TABLE(acpi, chromeos_tbmc_acpi_device_ids);
> =20
> -static const SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
> +static SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
>  		chromeos_tbmc_resume);
> =20
>  static struct acpi_driver chromeos_tbmc_driver =3D {
> --=20
> 2.19.0
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlu9kWkACgkQHwn1ewov
5ljQ1w//VHQx5XuQYO9p4QO7cu8gXQ0vHrfBw1IZgt1zmpgtvAmfj1tCrW9bKok6
j/SRkBybsKr0ld3LKrQpiySzNj57f6HfXdZKMJq8uGQ3n9K2U9hPnCzeydD5fmNk
VFk2oCsR0mQl+F871wlXs68jvD21NvaWXWWR/5gO2JuxrZMizmmna6tTviPVRhPD
IQhDnwF6RLcR6TZ7yxb9c+xUr5/GoeooZRl7Gzd7z6+DTZ15YWnkJQaF7LmedBi6
bCyn0696SRx9MTcvzW++Wjme9N5jtNJUcF/haeVAqdXwHrNFW9ppiBz0dgX4Gc2P
ZI8esipsBFaBv2SPDaCqg05mZ16YcwScDVQTnMQ9xUWc0Ya1juKvtfhDBdn5NwPg
wTJKui1BD+6qi+3Q563jprx1GMzaQv7m7p5G/8tqf7F6PzjZyWtLaXiJsdaiIGWm
QY4i0dYprg3EOpIy2RWB2Co/IsFfH3Mvkg0dtk8tbf4HbyzTxGIauy8VqI6DYMon
9827p80BI7J47Ci4DGw6Z2/QqStktk8vFzVREZkOyF+IxD94kA2T5XFxscgNM1jZ
8i4Po8vxVwiCMt2FrhkSdRgfVc9TBdKhAcjMiGLZKgih047wL/W39RziimGw+4Lh
yL2hfcZwaGMJEKMjtcX7DnwcdPfqu7snyMspVzrYazHkV0ChFYU=
=V6lN
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
