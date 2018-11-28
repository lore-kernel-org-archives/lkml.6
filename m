Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFC62081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGQCwY3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFC62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeK2Isl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:48:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43486 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2Isl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:48:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so10073037pgk.10;
        Wed, 28 Nov 2018 13:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zD/bt3+7CSFjxM5teGshWIr0EfBmxHt6ZzWJtGmDThY=;
        b=YGQCwY3IE9sk3cTCqblmKkahWf6B9n+r4RcpoNmQvEquQuUKEvMfIZCqatZNhjtFjn
         4r1D3HFAdy1HojTqHCdSCSBFWTBANj5jxKhDl3DudloX940rkApNctCKSko+0sNBN9tz
         E1PiVRq/cbVHZz/XWiQ7dKK1oT1zh0KaM5b7L/cbEfEpAKzj+ym4aJbrW7mQisAHKk0T
         gJ+6LuxlQriPE8YEtGVriPz0nyj3e0jRNvc2dtZmi/9Mr8N9mppTa1FEBCEaz57sBq7O
         V8Zt42mL9aOk8bEHjT9+uSSYDclCvBTil6TK99frjeNnywPtH3GGiojFJWUiRxq3Yhh7
         xD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zD/bt3+7CSFjxM5teGshWIr0EfBmxHt6ZzWJtGmDThY=;
        b=jWlLDZWYR/cjy/IdNW/6KIQ/9AOEOq/q45TbiysAc1BtAwrSEittHEBKwEwT7wWgwL
         3NV18NwfpVZtbaPFAH+OahMGTNSTMMh//KUryx+yh6ttnyvP5BqhFKmQfIATcqhoXZ7+
         4gXK51lUW3r4aNvKO41Ic9A23ESwUzJm+ffFiHaZlLRzMq5ewYW9ONhA6NcJzPdpKgBQ
         LnRHUnaYAeZJndfC/jED/8zgPiqjZFhbNE8jJHB5ssihT6KNZ+onUQAKMHOt1vBxMcZT
         0JYLenRTFSvsf2fjXFf/wnj2n3I7tncWyp7jGxMGRSCdZbPKKSP4TRZtd22Ae9GjIDC6
         Zngg==
X-Gm-Message-State: AA+aEWYjVkowITx7JBbgFHaavBOABPUWUlrw/WD1+qlM/Zj1J3QOrNRg
        zZIxePbBuYAuAduPMyuFGso=
X-Google-Smtp-Source: AFSGD/WGpcWLgJwL32KXqpdsbHhfLk2YfsCn/e7bko6N/rl33r6V6KrW4MzNU3c1BqfXJKZrnW//AA==
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr34862330pgd.446.1543441538533;
        Wed, 28 Nov 2018 13:45:38 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id m9sm8522154pgd.32.2018.11.28.13.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 13:45:37 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:45:34 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181128214534.xxqoyy7mi5dw54kj@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Christian Brauner <christian@brauner.io>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6lftnd4otlm67ut"
Content-Disposition: inline
In-Reply-To: <20181119103241.5229-3-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6lftnd4otlm67ut
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 11:32:39AM +0100, Christian Brauner wrote:
> +	if (info) {
> +		ret =3D __copy_siginfo_from_user(sig, &kinfo, info);
> +		if (unlikely(ret))
> +			goto err;

What's the reason you don't propagate up the errors from __copy_siginfo_fro=
m_user()?
Granted, I admit that -E2BIG is kind of weird to return, but -EFAULT seems =
like a
fairly sane error.

Or is there some reason it's more useful to just return -EINVAL for all of =
the
failure cases here?

--=20
Cheers,
Joey Pabalinas

--z6lftnd4otlm67ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv/DH0ACgkQ2rGdfm9D
tVJCLRAAx/hb15R5NTBk/RrIx/ZB+Ftn5+bixm6/+Ihy7Q3aJGoxmWlwS0nBkWaB
lHMsrBtxihHOo4za4ttgCawNnrdL1pooh04owHU+3YEVIJOZ5tdQLVvSVGtIPi4Z
Hclg6orB1w5f/RGCYLKARyrMnNpNstNb8zvdLswfKu8g4Wl44uBj603IaO3h47Or
rbsTWfBpuF2s8iS7KlFMKMjboYkOI8Gv9wsv79CcvFhGmTR+hTnT4xqvUk/hULbI
shCz/jfsNf0mu3FoAW/ac9tl/xswoT+Yr1L26KOeQGyB7D3Pme0f89JXwgBELAVD
LXnzvBzDxzm0Ly2Va57SVcqfn7lCxifLpG2FwHWohedG7CIbba0A+bUk/ZvN6AAI
3r7aVxUSEsRBRKXSKvv0uCI59GaetcZK3Cc4cmc+bbQNdKMBLSHxuAzKFhsjo5HV
2hXFnKZDEBApNRFcHZZdiZzczgd4VNabY5AA73iHqgiai43wHew8VfjiqyHKRwoa
6q7LEiA/MbxLMH84p4V5QbmjvFh/TxVX813YoHr0ZKmm+iRHSswPkYnRUF/KPalc
DW8JtP8gm0dX3GiIpKthB9VzTa/opcQEjVeUFWu8o2tD4yT/bMB8Xfqg/Rbt9ioJ
zfdX/lhZxVXFqM81qWlBeYAGMZKO3+ui+1jFjal5OLwHWnUwNAM=
=1lIC
-----END PGP SIGNATURE-----

--z6lftnd4otlm67ut--
