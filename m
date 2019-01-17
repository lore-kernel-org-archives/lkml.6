Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930C4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5373920855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="jfDyW9da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfAQRjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:39:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46627 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfAQRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:39:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so5141497pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=l4hACMh2EsCMIYaCvDv+pg+dMndHUnMc4GgG4D0IVAo=;
        b=jfDyW9dayW6h2uNRehu406qs/1qLLk3h1CDccPHLEZy08hXFFCL6vJXqd3dXePMy/5
         dspfQmXPAeggIXDV4FmzKuoNiQmnJm76JKOTg8jgVffqke4c19skGJY0lv6n2ZETk6mL
         zGB8IVL0N4sD1JcpPDAegf5L8Trk+pz+N0Fu/QuUTOvWH4Wwb2oudFjj+FnmKm1tUyyz
         wtr3ynAH/ArgQtz8BYE76D2mkpt+b866jEExAMtmXAIs4j6EGVycFt4hq+cJiJeSF9Eo
         baNlqkG61z6k8e3jRy4NpeyHRrybdNiYN9ZoSNBpUMVUBP4k0xA2uiD+0Ffd50yPPGnJ
         JJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=l4hACMh2EsCMIYaCvDv+pg+dMndHUnMc4GgG4D0IVAo=;
        b=ZZGBgEVEc9Hj6I4H7pO19uXueFRbUwgb2il9jnu6iPRPB0jaxC57GIvvNOGcyuoU8h
         GGz0PZdKXS+xBrWhY9AdjpI3yuKQOPwxpp12jac6mU78ASfle+PNLTP2PGxAdI/rO7l0
         0P90BwRvH7Ae7cs01xQ4t1OAe3HaN0n0AzADiMihWkhvgd5rSGwYGi3ojGpdrHCj2CmJ
         uEnLfKTL5AKB/LDmf9nzSCNxo+TJgQuaqeKFQtJ8rXNIzZRpL1NoksGcgyZhXdX9z3Cx
         5BdMOUQKZWItxKg1Ry+klv6hjPojWmyCcTvSqaB1SwMGu2j9wE/wRbytTeaNMKXrgGd/
         2lrg==
X-Gm-Message-State: AJcUukcOIPpMgjW5brhe/XhuUZxcEh4NAj+DjtnfkUIG49nxgFViB9AT
        esDmVqLN6vc9gZXzJORg9WMUMg==
X-Google-Smtp-Source: ALg8bN5VGIg7P51diMgZlVZzI6CET6xnawj802EOQ/beQ9xiYIV4FTz851Iz6Zp+sNVaV07bqevNVQ==
X-Received: by 2002:a62:3603:: with SMTP id d3mr16333308pfa.146.1547746756760;
        Thu, 17 Jan 2019 09:39:16 -0800 (PST)
Received: from [172.20.10.10] ([24.114.37.93])
        by smtp.gmail.com with ESMTPSA id v184sm3327596pfb.182.2019.01.17.09.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 09:39:15 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <965D4A30-6A3A-4A13-8C4C-3D75BF9B4BF1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E35A060D-0284-4083-ABFD-E0BA10F4B0E9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: annotate implicit fall throughs
Date:   Thu, 17 Jan 2019 10:38:56 -0700
In-Reply-To: <20190114203945.20233-1-malat@debian.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
References: <20190114203945.20233-1-malat@debian.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_E35A060D-0284-4083-ABFD-E0BA10F4B0E9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jan 14, 2019, at 1:39 PM, Mathieu Malaterre <malat@debian.org> =
wrote:
>=20
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=3D1). Fix them up.
>=20
> This commit remove the following warnings:
>=20
>  fs/ext4/hash.c:233:15: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>  fs/ext4/hash.c:246:15: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>=20
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/hash.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
> index e22dcfab308b..46b24da33a28 100644
> --- a/fs/ext4/hash.c
> +++ b/fs/ext4/hash.c
> @@ -231,6 +231,7 @@ int ext4fs_dirhash(const char *name, int len, =
struct dx_hash_info *hinfo)
> 		break;
> 	case DX_HASH_HALF_MD4_UNSIGNED:
> 		str2hashbuf =3D str2hashbuf_unsigned;
> +		/* fall through */
> 	case DX_HASH_HALF_MD4:
> 		p =3D name;
> 		while (len > 0) {
> @@ -244,6 +245,7 @@ int ext4fs_dirhash(const char *name, int len, =
struct dx_hash_info *hinfo)
> 		break;
> 	case DX_HASH_TEA_UNSIGNED:
> 		str2hashbuf =3D str2hashbuf_unsigned;
> +		/* fall through */
> 	case DX_HASH_TEA:
> 		p =3D name;
> 		while (len > 0) {
> --
> 2.19.2
>=20


Cheers, Andreas






--Apple-Mail=_E35A060D-0284-4083-ABFD-E0BA10F4B0E9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlxAvcEACgkQcqXauRfM
H+AGhQ/+LnOrJ9kpc86G+XPgBkXotiBcyTomHDxl82+FpT5vrR9vppCcAzHzhSh6
dYBy0pr4ygNpLbZaf1bJk3CmjXC/7QeV2WuSfxDnqdOG4snPdUFsRVqe75giCAHT
4zofdwqeoZqZ7o95DJ1jqJ/CajfoCcCo86uxDmqSI1YBFKol96dD0eeB8y7p1SOG
Ya7ui+Zb/Iyep2a13je2uz/ECNeNQl9ohLZFF/JopRAYezSGkkUTAI66vh1XtLNn
EDoZEZFeSX14D2sWayPtNGZmB/cQDPg+kXruuwX6Yh4oShZI1d92/D3a8JCGQ0H5
6JgMYChoPbnd+SyUuXJZ8G/6kdZiGH11yndbLAHkqG7ynIomwkt/dtkGlBAUZqt/
EKSOmL7fkRnbpBTgU3e/UbnDRXEDWI5k3KjMkts6kRJGTNRuuMpMXyEaFob6EAaa
35zSYDAtTKGFgzxx+SiJRJxa+38cHRBMl022NXwvSojCGHZml1uCw2vLYyJiE3Lx
iF3+GB3Z+/k2naQkf8zk/nMLPey+jAYXgjB9yqZEn7WNQRv6mUgK8EzR4yWvGQsU
yxmWcFu6z2WEUCVkvCuPqWri0kpTMnkkYGzf8f3Nk8qUySNb5GM/IDGCq4EioJJW
TM18WyDOsVQbgzI3GyU2SOu6Wk2kKlgbKQGn0TuvcJojbgQPJx8=
=jAzx
-----END PGP SIGNATURE-----

--Apple-Mail=_E35A060D-0284-4083-ABFD-E0BA10F4B0E9--
