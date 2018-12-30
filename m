Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4A8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 07:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C789E213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 07:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6e6wZjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeL3HkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 02:40:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40783 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeL3HkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 02:40:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so12149489pfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 23:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ukStHd0tFqfEerlfyzda3Ho13QpxWQkZIKRB2bTzf30=;
        b=T6e6wZjxJmHIxDBO3MrAxMeFY01sBb51+cp4/NEOcc6tmwdgizIOMob7y/0nL9SKF4
         MIL3Vh0fwXO3O5CQIkGT46a5MmpA5zZ8tIrB2zgZ11XQacoW3BBEKpH4BX0wT4j27Tnr
         j1MSA0EVoyaWGH6mkm6JztSWpAXWB1WesEJZpGe1f14j5WF5tBFPjSUcj1wAAzlMFuz6
         BOrTZBmM1F8uNJ2yI48E9SSPQ8lFHXLQBYLNu/5GfhaimTEIu5jRBz1dDb/gt1CcbYPs
         HlQ2//CQ6q6FquD4L2595QfbPHrGqDlBtwuqz/WBC/w9nPBr6nyT9KH3Iy3O0Ofu4lHG
         NB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ukStHd0tFqfEerlfyzda3Ho13QpxWQkZIKRB2bTzf30=;
        b=myZdrCFR45w0IIF8LXjuuMM5wWezf7KY+FC0kCZu2XRGEj2sxnsR/WosAp6d8sN01S
         W+/PTEHyyHL25aOUWtXlvnrrSx1v1lnNrhtfjR7rBYpXqcYsMs/SEFnGabtmIJVnXVGV
         R/5mMFUV8KcA/7HR98Q1qHDg4cJlDY8YH7bP6hY/qyn7+RVCMJvJ4JUtmpOr2sDC+EDw
         dMajyyQyWve8z6boT6AZH8mwcvzvA5RbBVBwsRVNoQOOI9QWjccSvrXjpbzO9tfKchyI
         oOnErEpwZ7bOW1WDkTRrK5gaemJYZjicGDwoJuyoZjNhf22ZcY59KlAaOG2tVqx9Xu3d
         G7fA==
X-Gm-Message-State: AJcUukfG0B1TWWMPvRoI21y/k6ncizd8qq8eoVc8mUb8o0NGTdlXrdmn
        5S4R7DcIhrHO4jdm5oK8Ugw=
X-Google-Smtp-Source: ALg8bN7fCpm1S+KECCSmvKxRmxFFpoC798Udr97P46gls4ddTWOCimt6IchkB8Wse4LbtNIUFiDQHg==
X-Received: by 2002:a63:170c:: with SMTP id x12mr3722087pgl.364.1546155623145;
        Sat, 29 Dec 2018 23:40:23 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id e24sm62587362pfi.153.2018.12.29.23.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Dec 2018 23:40:22 -0800 (PST)
Date:   Sat, 29 Dec 2018 21:40:20 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rcutorture/nolibc: add a bit of documentation to
 explain how to use nolibc
Message-ID: <20181230074020.nirv2jzf6lh7s5lf@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Willy Tarreau <w@1wt.eu>, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20181229180218.15798-1-w@1wt.eu>
 <20181229180218.15798-4-w@1wt.eu>
 <20181229223324.slqx3qjrmzg5g2w2@gmail.com>
 <20181230070846.GA17139@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jcoswsvne2v4qsmc"
Content-Disposition: inline
In-Reply-To: <20181230070846.GA17139@1wt.eu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jcoswsvne2v4qsmc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 30, 2018 at 08:08:46AM +0100, Willy Tarreau wrote:
> Definitely! Same, I won't emit a patch just for this, Paul already queued=
 it.

Yeah, not that big a deal :)

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

--=20
Cheers,
Joey Pabalinas

--jcoswsvne2v4qsmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwodmMACgkQ2rGdfm9D
tVLV0Q/8DS1KBVyZ4yFEqh3yz3F1lFqd8yvhJYsurySB4okyj1JfPxDs/w8tlbLc
xJ+N8YvovXpHcRibZqYjMHNbufGPo44GU7B35KhwETZ7Yi639hiQKsqJjRcukv4d
m78NX8URt9OSf0Pqo3M4JaDLLsVA4gXA/JECnwB06Fth984QKJqvLkfeHSapELJO
q7TzGO+tq62NpiU/pOAaYkA6Zi44sJlkc2DjfV2C3ckWG5UMCPwi8+nMX+X07xqC
DgXywME94uAYHwMbqF1Gk5s/IPlDja27owX9ZWhYoGxy2Yh3IJjOn/Eu5qvxuuU4
QTPR7JCMziWXJKva/KaFEEIyu/f/V/cVDvEtXYaa2zGJSSXAGsECjmScN9OdArCD
CALQwIoxKyPMopfduhdUF1maNNBxT87ayATt15opzbq+R3wclp1VUQ9g6pE7+vC5
v/RbIeVVO2ttngQOEv1tPzTZN2gq7GgZh44n9Nn18eS8xKgTIH6DQonEHtwqhwYc
CSPEa2Ol86qUYnW0+1FR35vLGBy/61aNcMKjBtfpCs3D60b27sDMiaOyurmpE22I
+PCyE3nnkU81DI3ikWlVEJ4scyUqfSRvVEn0rst5W3tzzB+jd2QzaGrrtWxN7Nol
HLLoSEYkpsJI9mZ8fQhT353fmFbyC9oVpMiXOD1X4D4Y7lHr02k=
=9eHy
-----END PGP SIGNATURE-----

--jcoswsvne2v4qsmc--
