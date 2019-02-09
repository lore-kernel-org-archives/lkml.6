Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F7C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC4F20869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 08:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7/0kqei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBII3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 03:29:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35905 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfBII3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 03:29:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so57205pfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 00:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=94cfNQIHKpyI6F4k2rEWTk6YvzKz4UtBNyk2ZTQ99zc=;
        b=g7/0kqeiKIxEL+dyBK2pudUoAd2B9YuUi6Duh4JqR395pUlpXd1OCatIAo9UBROsUf
         bU0y/oIEL7zr9Tb8pRd/O4WYMdbb+7hGGYMGEVpG50lJYvUuyE3A0xTXaUlSfD7oiwGQ
         6S4wn69AP3xMxUBWZYnUplcx7AMs7TMCbmgB8J3dr1pEPuEYrocQQMAOXfMfnLY3qCWY
         D8Ue7bfjCMvXHByyO6+a4KXoh8uIxmlE5YVQd09DgdK2nEalDbqyCp2rhj5QWlZXyvEg
         UmFhzbu3Syo4XK47vkChT8H5GI5DqPb3LOv1q55q3iQKmmyMIxC3CtkkdNpbyHM0kNZ2
         1odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=94cfNQIHKpyI6F4k2rEWTk6YvzKz4UtBNyk2ZTQ99zc=;
        b=ogbuFJDv76z4D4sFkPFNWNjgYRy1Zx4iJuUFzydScAunHIN9N+dIB/qIXMstyCnvy/
         ykDgp4jipFY3dKNMRyMN/DTm8ig0mB9IGduBKcoyOcGBsmCQtbINmANG4jlgCW0eguw2
         40hsSMCxjnyO2fn78okHlhYnurfeZkvGbJZPoTWAenWSpThx3Nu4dUMrxZ5DD9ZNcY/5
         NcqqacTxBu+wGJDs/lpAiZnDjXcjTErCcu/Hgnim2h8zydCEbOE4vmiphDNrdDI74ert
         p2jOYZS/sYNWlGgUkKwwq2EsdR7MW17Ui1DjKENEZjkdZDVCy3GIvRLdO7Coi9CQeJWL
         A7Cw==
X-Gm-Message-State: AHQUAuZPkId/SIMJwsrtckS0mlKYhhopkdTprQxx/VXI2jMiDTg4MDtu
        4MNoHGroWzPvIlPHuvsbrp0=
X-Google-Smtp-Source: AHgI3Ibcrg9vVSi6wlmuewXUYicN6kfWpmSGJTEKPhYkRTvI1FmMgNfaPg99UMrlrbffcVbxUXnpdQ==
X-Received: by 2002:a63:c56:: with SMTP id 22mr9300464pgm.44.1549700991141;
        Sat, 09 Feb 2019 00:29:51 -0800 (PST)
Received: from ikegamiPC ([240b:10:2720:5510:7dbb:9ccc:f403:cae1])
        by smtp.gmail.com with ESMTPSA id h8sm4996328pgv.27.2019.02.09.00.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 00:29:50 -0800 (PST)
From:   "Tokunori Ikegami" <ikegami.t@gmail.com>
To:     "'Gustavo A. R. Silva'" <gustavo@embeddedor.com>,
        "'David Woodhouse'" <dwmw2@infradead.org>,
        "'Brian Norris'" <computersforpeace@gmail.com>,
        "'Boris Brezillon'" <bbrezillon@kernel.org>,
        "'Marek Vasut'" <marek.vasut@gmail.com>,
        "'Richard Weinberger'" <richard@nod.at>
Cc:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20190208180615.GA24601@embeddedor>
In-Reply-To: <20190208180615.GA24601@embeddedor>
Subject: RE: [PATCH] mtd: cfi_cmdset_0002: Mark expected switch fall-throughs
Date:   Sat, 9 Feb 2019 17:29:46 +0900
Message-ID: <000001d4c051$9f66deb0$de349c10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQLfvGHS4rj+Sm6xb7HCdJOPFYC+/aPBKgyA
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Tokunori Ikegami <ikegami.t@gmail.com>

> -----Original Message-----
> From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On =
Behalf
> Of Gustavo A. R. Silva
> Sent: Saturday, February 9, 2019 3:06 AM
> To: David Woodhouse; Brian Norris; Boris Brezillon; Marek Vasut; =
Richard
> Weinberger
> Cc: linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org; =
Gustavo
> A. R. Silva
> Subject: [PATCH] mtd: cfi_cmdset_0002: Mark expected switch =
fall-throughs
>=20
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>=20
> This patch fixes the following warnings:
>=20
> drivers/mtd/chips/cfi_cmdset_0002.c: In function =
=E2=80=98get_chip=E2=80=99:
> drivers/mtd/chips/cfi_cmdset_0002.c:870:6: warning: this statement may
> fall through [-Wimplicit-fallthrough=3D]
>    if (mode =3D=3D FL_READY && chip->oldstate =3D=3D FL_READY)
>       ^
> drivers/mtd/chips/cfi_cmdset_0002.c:873:2: note: here
>   default:
>   ^~~~~~~
> drivers/mtd/chips/cfi_cmdset_0002.c: In function =
=E2=80=98cfi_amdstd_sync=E2=80=99:
> drivers/mtd/chips/cfi_cmdset_0002.c:2745:16: warning: this statement =
may
> fall through [-Wimplicit-fallthrough=3D]
>     chip->state =3D FL_SYNCING;
>     ~~~~~~~~~~~~^~~~~~~~~~~~
> drivers/mtd/chips/cfi_cmdset_0002.c:2750:3: note: here
>    case FL_SYNCING:
>    ^~~~
>=20
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>=20
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mtd/chips/cfi_cmdset_0002.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
> b/drivers/mtd/chips/cfi_cmdset_0002.c
> index 72428b6bfc47..0b0a1874d3bf 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -869,6 +869,7 @@ static int get_chip(struct map_info *map, struct =
flchip
> *chip, unsigned long adr
>  		/* Only if there's no operation suspended... */
>  		if (mode =3D=3D FL_READY && chip->oldstate =3D=3D FL_READY)
>  			return 0;
> +		/* fall through */
>=20
>  	default:
>  	sleep:
> @@ -2747,6 +2748,7 @@ static void cfi_amdstd_sync (struct mtd_info =
*mtd)
>  			 * as the whole point is that nobody can do anything
>  			 * with the chip now anyway.
>  			 */
> +			/* fall through */
>  		case FL_SYNCING:
>  			mutex_unlock(&chip->mutex);
>  			break;
> --
> 2.20.1
>=20
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

