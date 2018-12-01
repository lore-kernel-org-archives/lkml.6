Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3211FC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 21:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D476A2080A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 21:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4aSAr7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D476A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725758AbeLBIpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:45:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44886 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeLBIpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:45:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so4500785pls.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 13:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IsolrVLm3RP9VspVOW/jCNjbCFZ7pA1u4vUTE9arfTs=;
        b=k4aSAr7fN3Q4I6E6estBCgFMiIPtuhzHQdZ30cTcfcHMEakem8UBotFARzeYU2SLgA
         LpFR9ZDEUjllny7JjfJZOsEBXXEX7kS7sdrXVE/U7ZiikbDKOtMYwvpRBeT7C4XLnFEO
         SiWuzjjpa/47IZLWMKWci3srWuednJtwsdgprtX2LOZM1p0cZlkYfdILOu5Q2BGwDCkQ
         kPG8M/qGKfdBLyzocSsfVzmkqLltaH9MA1n72TTzr8Hd2n1kPjLv933nfHmUOn5t+BN2
         B6HhgnOqJMr4ITJpcBTZB8RwdPjxSdUBMWypMgcHR0z3o6M8pkRoDAY4tVPECy7qtdl4
         Jw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IsolrVLm3RP9VspVOW/jCNjbCFZ7pA1u4vUTE9arfTs=;
        b=i6MJQujdPnQStTR/TmQkwvqVU9IdvlAbrfBJx1R5OWGs4mjPMfwpw2CjUJKBB4uR9I
         I/4frDI4GSSzC7CET1cEiT/Tb/1mtCGgOrZQ3jeXxuPg+d37POYcWinFd1fwhfSs8KiQ
         G8sL8BMUGHsmWRuz9dWrSFWT4XDMBZpebfBaAwzNwjUF90gGnsVypTdvILOh3ckMhHsH
         cAlgbfwLKTtR0A6SZdYabOw/PovfsHMS9uJqcOhqI45Z+6W1PYo9IYGN4biVKWajPrw+
         BGo8S9f+lSj856LQ+tvkH1WrP2OeZkv/lP9h2e56jqa+VOB6u+UsZ933PIRnu3LdWosz
         MO+A==
X-Gm-Message-State: AA+aEWar7WHDEzJXqrOpVle6yO7r+D6rJRc5eyku8kBPN/0A2FLVoxXf
        EO4RjGnx4psVRttuAaPNRMk=
X-Google-Smtp-Source: AFSGD/VatVl5AQPHUJfXxN86BwKB9cLtiqhazOi138hBCNYiP9zbkzWrzJ0Y2JPFx16IQzz8r0ux2Q==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr10610274plb.115.1543699939581;
        Sat, 01 Dec 2018 13:32:19 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id c67sm13561182pfg.170.2018.12.01.13.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 13:32:18 -0800 (PST)
Date:   Sat, 1 Dec 2018 11:32:16 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] sched/fair: Fix assignment of boolean variables
Message-ID: <20181201213216.wmikdw3emxhc7m5r@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
References: <20181201090936.10175-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3qy7gq5q4ryywuu6"
Content-Disposition: inline
In-Reply-To: <20181201090936.10175-1-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3qy7gq5q4ryywuu6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2018 at 05:09:36PM +0800, Wen Yang wrote:
> Fix the following warnings reported by coccinelle:
> kernel//sched/fair.c:7958:3-12: WARNING: Assignment of bool to 0/1
>=20
> This also makes the code more readable.
>=20
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: linux-kernel@vger.kernel.org

Ack, earlier assignments in the function like:

	if (nr_running > 1)
		*overload =3D true;

use `=3D true`, so this change keeps things consistent.

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a2e8160968cb..f19aa66f9b15 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7955,7 +7955,7 @@ static inline void update_sg_lb_stats(struct lb_env=
 *env,
>  		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
>  		    sgs->group_misfit_task_load < rq->misfit_task_load) {
>  			sgs->group_misfit_task_load =3D rq->misfit_task_load;
> -			*overload =3D 1;
> +			*overload =3D true;
>  		}
>  	}
> =20
> --=20
> 2.19.1
>=20

--=20
Cheers,
Joey Pabalinas

--3qy7gq5q4ryywuu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwC/d8ACgkQ2rGdfm9D
tVLsDxAAomwGuyDsqVM69ubKTE2jhrOmh4g4B7O3/bSWYJqMd2is9S0HvzQL2Q8i
W5yl2bvtoCoWBYWdsBOofJMbj6it/WIZHbS8z4CtuWAVQJOQ/27tWwZbFjBKX/yo
7YR+7klVlFp0PyCtSurpEFBJCCPYIzTQsddi07eFlJ+EoB/NIPPSR20bwTfmWzTe
HQVO+5I0T5F3Kd6Qkp94X3tCgZ3c14RyfznTlHd0Pha3sfgU70hraGf6olgbzx4W
7kBVqXgVG7C5oPBvnKlDOsO6wmk6KbymaKy9uyny4lPTdi2uyItzFoxZMVUCez4w
opKn176HE+Le9fDbFe7EKqW4JLYFt8hmt9EMDUHOmUy9+OsUMFNbeQWVPLAw6Fct
wtxS8GeiuCPk5C3z+3UikSAjNzj1f0RRzjH9YdMBTKKnGCATxxYTFrib5iTIRTIt
2aqtzfmJg/qOlUW3//cFF6XmJ7oeIsass9h4bRcsbDL8L4ZoL2HMei1o/444CcRb
DhOP6V0SWw+drNhjV03cNq/7lG5RynG86SKekNxrTbwuXe1io5XSJ7p6D1TetXGV
OW4AfphuGHYe5xITsvEYSncg6GOD25gLBlD94JvlRyaKISrvz/5/4Drd2OW7m0BV
OZAti70SbXECFw1ehUPjyWkNgGNSr1WXk9cn4p3K1TEAhuWdKpo=
=3cdh
-----END PGP SIGNATURE-----

--3qy7gq5q4ryywuu6--
