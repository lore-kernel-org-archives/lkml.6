Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829C1222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550066755;
	bh=7GmzglS2u/JkI574oyrQ1SMa8YsPu1Z/11NkARXHqkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zczGZgn1dc+RSSuBPlLnb1aecTz0JWS4/+63bXHyMqUzVQt4XTSZ2tEoGNumVqW6E
	 UyWuO8GU45ikxhWH45RQ/yWo57IgFCgrFa9pW2b14GW499f5o1IEUFxvKj0fTmxqmr
	 kAaX56hevv6fYqeSVmqV3wJw88V5PlCeaguitpj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391558AbfBMOFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfBMOFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:05:54 -0500
Received: from localhost (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CFA52075D;
        Wed, 13 Feb 2019 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550066753;
        bh=7GmzglS2u/JkI574oyrQ1SMa8YsPu1Z/11NkARXHqkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kerXPDxXvHzyPq5xUayKtAP5YHBFgiYx8ZcB9MMUIGzh21LpFeppOHdGfwGqL9SU3
         PdpNuRaQ9omE49/jaHhIrRtxzY0Msqko5wleCzpAk5lbECk2NbEvRo2630IVClhCON
         SOvcHpKT6ouAM21XgXPrZE4xZLv2V/Dak/LAIDnU=
Date:   Wed, 13 Feb 2019 15:05:42 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mtd: lpddr_cmds: Mark expected switch fall-through
Message-ID: <20190213150542.552adeb1@kernel.org>
In-Reply-To: <20190212153131.GA5746@embeddedor>
References: <20190212153131.GA5746@embeddedor>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 09:31:31 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>=20
> This patch fixes the following warning:
>=20
> drivers/mtd/lpddr/lpddr_cmds.c: In function =E2=80=98chip_ready=E2=80=99:
> drivers/mtd/lpddr/lpddr_cmds.c:319:6: warning: this statement may fall th=
rough [-Wimplicit-fallthrough=3D]
>    if (mode =3D=3D FL_READY && chip->oldstate =3D=3D FL_READY)
>       ^
> drivers/mtd/lpddr/lpddr_cmds.c:322:2: note: here
>   default:
>   ^~~~~~~
>=20
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>=20
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>=20

You sent me that one twice, is that expected? Is this a new version,
and in that case, what has changed?

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mtd/lpddr/lpddr_cmds.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmd=
s.c
> index b13557fe52bd..76a4c73e100e 100644
> --- a/drivers/mtd/lpddr/lpddr_cmds.c
> +++ b/drivers/mtd/lpddr/lpddr_cmds.c
> @@ -318,6 +318,7 @@ static int chip_ready(struct map_info *map, struct fl=
chip *chip, int mode)
>  		/* Only if there's no operation suspended... */
>  		if (mode =3D=3D FL_READY && chip->oldstate =3D=3D FL_READY)
>  			return 0;
> +		/* fall through */
> =20
>  	default:
>  sleep:

