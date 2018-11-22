Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC23CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF6320685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZBC+d6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF6320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405771AbeKWBxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:53:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35007 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeKWBxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:53:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so8002750edx.2;
        Thu, 22 Nov 2018 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jHz7DcSu13eqYZujy8RCSOiwrR4fLp27d6XMDqSrB4=;
        b=qZBC+d6kB/pi35FZ34VEDqr3RXb0oMXUhqQJq2uv6Y0ZQldi9DlHaAYTbvLPAtvMVq
         KDOo2P/dw/tolAdVgq7KVVDbCaMihDHCmGpIxD8F5LoxVavtV0a44JQxwujmdWd51NCV
         j0J21Bu0e6Ftr6xeAG1om/5xG5WXMX2objD9e5GbceekhIxyzO36HiQJXZONhGbM5QHS
         z+dHMXZ3fz9dzcQihaMR1YfJI1bd1mHo9EXspsjehMO5/f4Vcb3rcm2Q6kKf0QjPkQb4
         gwHJs24MNktsK8zMap0QdEhSRzYirZQLo4zuYmXD9QmOAISRD1xBnsPplaYxxuIXiq2g
         sQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jHz7DcSu13eqYZujy8RCSOiwrR4fLp27d6XMDqSrB4=;
        b=ATjGjkObR6lvUAptQ3ScvMaZHSAnVMX8lOwr8tWc4SIoO7oy7VzZBtKaUyTo0MpqX0
         8FOrX+gPBfRCESLzIkppv7hpIcsbEYDCGGnDqS3px9tDlDvtL+8+puwG5huMBXmSuLx8
         FVvRwUQE2mvj24GjeCLi5ImexvPs0q3pRohqDZNp4XG17ZISP/U1LiU8uJfZq2Dx6Cku
         Mnhi8R/DPmgjcThxvRkVymGoKJ9KbA0LdlbYinxOUlH+GTfDyC3VFMmlkhNhWiXWajZw
         IKIjCjj7koVPoIhlo9wuCT9DD/OfWTao+TSYsj3xnjt/hg7OC3qslIqjety/M8fnxwg4
         4BPg==
X-Gm-Message-State: AA+aEWbfDcB/fvdOtDa4Wqyjjytq2L2WQ2QaWRbLmFGWM32RCxK0u1zJ
        wiJjy1vLrGV5K5wKdNoY7ZM=
X-Google-Smtp-Source: AFSGD/XTXWAW2JKkg23lkKMcF5eMmycD46atfu+xPkv7nTPecSvt0pxucrUE2flJqRIsnFMyWZR1EQ==
X-Received: by 2002:a50:a741:: with SMTP id h59mr9268401edc.106.1542899606569;
        Thu, 22 Nov 2018 07:13:26 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id v14sm1967081edq.74.2018.11.22.07.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 07:13:25 -0800 (PST)
Date:   Thu, 22 Nov 2018 16:13:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     jonathanh@nvidia.com, avienamo@nvidia.com, mperttunen@nvidia.com,
        andy.gross@linaro.org, robh@kernel.org,
        vivek.gautam@codeaurora.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: pmc: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181122151324.GB24661@ulmo>
References: <20181122131207.24791-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20181122131207.24791-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 08:12:07AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/soc/tegra/pmc.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Applied, thanks.

Thierry

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv2x5QACgkQ3SOs138+
s6GkzQ//RaryhEBFGRe9jmHJiJ8je0gbceK1g5Xx5OEGU3X04hhnsTUalDoAhc1H
7UeffL49eTwl+69nETWmt2bkQpngtAurDm1IA9kg6NlKCpzOPTXbe+Jk6BMAAqv/
GlMvMFMpABcv7CB1JQpfI84ifucFOYrDKWBhDzJYToCxG1AKzwxvH7qgMXsT9DZE
tvoEvoLRu6EFES0G6sz8vlz5JNJp1JPPs+iT29lkhxoMVKra4hVSCnbQ+xqf+L3+
OkKV6vijIyZpcWntwwh03ZdB+C9xtgOdCccYL2KoiJDq/c1Pj1B+zOhpmwPQG2ey
YFvFdwqPJV43uhbPxwcrp70ykKxMgyUT0idYndZKKjVpTNm/LnxQu1tAtgTRlPTK
xdp610kB1KD8CO14q9iinP2vjK5G0jTrT9Errki0sDgsMaQZXNfIFdUWEms2LMuV
fCyRDgxpwI9u4MEWJb+hUahfHYQxWSznBZTSORMOpu7joWhH1cOKoetV7xri26TM
YZ0xL0bn/XUfsIuBFn9R04YSLknUc0yys+Ogh7/QGlm8PO8vfWXwzTlUHjVgrg6H
h9xunlRJyf2WUaLuK/YoPs/WUh5U/ELF6gWtbJUSyCU3vI+xTF+6yKmoL60XW9pW
5l/ZKVpb3MVUxHTVgZ803lBeeBZAJ0YPn+IH1aQDfDNTr1Z3+mo=
=Gp6n
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
