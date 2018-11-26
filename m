Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B05EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF3E2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN+SDJGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF3E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeKZUlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:41:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43713 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZUlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:41:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so6304817pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPIAW/W8cJjElbXks5QEk8dS+4CKPSiRaVxp8q/fLxg=;
        b=lN+SDJGH+Ztfo94aXsH5kjYgjBOB5GSh1zJMx1Q5UvVpLorsLnWbRnhbd2c6RmNONA
         BiOo/M+r6oPTvjnALJ6vwQ6DkFcTNbBNQzzHyGikwbQyDXtPstUVGt6phGlwh7FX3tiF
         gZtCUfSPLuIzlN9IVSCtWBj9jzAIR1kIwJ/XeuBznvySQN0S5mJZ3Y11rPCG7qWPFrCr
         dtNRHoydaPKO8MrzKgvoXPewRHqBWEtq309aljOzQdcToJ2cTnpJKPzXwcoR9t7Sctiq
         xDL0obQpf/rmbrzoNJH2950322BXeUhHE+5e/2lz9TyqESgUNhibisnun58TsQkomY32
         rQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JPIAW/W8cJjElbXks5QEk8dS+4CKPSiRaVxp8q/fLxg=;
        b=gRXeALrufqdLN4vGjxCXJGkuLYNCrkcPJBo+9A8aikf93F27JrjqUh9g0jm2rxp4yn
         PlnG004/BSZUGpUi9gvWwHb3nDpdiABr6jThbyaqqzoRYv9UTLczRFkXm07GdG5/OX5E
         3VEkrFrcyuR71e0t5nR2fv4FCg30CIY6NQ2Db+2lZjgf5ES6f+Z3gm4xaMNZ8uHX4nU+
         8sRf8WX6dBHBvkYLTwip+ITMA0U+YBPiVB01TriG92QJFZbb1gnrrgK7HdnVD2KQ5FXW
         S8J7gXezaH6p0TWPn4xXXHjISCbVVPb8UhYjYq4pzuPLbKhBk1a2lGY1f/GCGmpgekYr
         Okjw==
X-Gm-Message-State: AA+aEWaNb2UxdoJdk3CobMfjNFiFUf2K3e6cqUdUulAHHQ2BQ8uloq8d
        9OfHSr+CCLLx5qbM3MKrwVM=
X-Google-Smtp-Source: AFSGD/WwpZOCxe+bio++v7ltRsS+VTDoNLV5WxEsLcDDYm1K+L4h9IPS7quC3wMqLh6nmjaR8u/Nog==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr23883286pgs.448.1543225660977;
        Mon, 26 Nov 2018 01:47:40 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id v190sm15531933pfv.26.2018.11.26.01.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 01:47:40 -0800 (PST)
Date:   Sun, 25 Nov 2018 23:47:37 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v2 5/7] zram: support idle/huge page writeback
Message-ID: <20181126094737.sfudpeoigra2vir7@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <20181126082813.81977-1-minchan@kernel.org>
 <20181126082813.81977-6-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c5mdpm6lxzx5f4kq"
Content-Disposition: inline
In-Reply-To: <20181126082813.81977-6-minchan@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c5mdpm6lxzx5f4kq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 05:28:11PM +0900, Minchan Kim wrote:
> +	strlcpy(mode_buf, buf, sizeof(mode_buf));
> +	/* ignore trailing newline */
> +	sz =3D strlen(mode_buf);

One possible idea would be to use strscpy() instead and directly assign
the return value to sz, avoiding an extra strlen() call (though you would
have to check if `sz =3D=3D -E2BIG` and do `sz =3D sizeof(mode_buf) - 1` in=
 that
case).

> +	if (!strcmp(mode_buf, "idle"))
> +		mode =3D IDLE_WRITEBACK;
> +	if (!strcmp(mode_buf, "huge"))
> +		mode =3D HUGE_WRITEBACK;

Maybe using `else if (!strcmp(mode_buf, "huge"))` would be slightly
better here, avoiding a second strcmp() if mode_buf has already
matched "idle".

> +		if ((mode & IDLE_WRITEBACK &&
> +			  !zram_test_flag(zram, index, ZRAM_IDLE)) &&
> +		    (mode & HUGE_WRITEBACK &&
> +			  !zram_test_flag(zram, index, ZRAM_HUGE)))
> +			goto next;

Wouldn't writing this as `mode & (IDLE_WRITEBACK | HUGE_WRITEBACK)`
be a bit easier to read as well as slightly more compact?

> +	ret =3D len;
> +	 __free_page(page);
> +release_init_lock:
> +	up_read(&zram->init_lock);
> +	return ret;

Hm, I noticed that this function either returns an error or just the passed
in len on success, and I'm left wondering if there might be other useful
information which could be passed back to the caller instead. I can't
immediately think of any such information, though, so it's possible I'm
just daydreaming :)

--=20
Cheers,
Joey Pabalinas

--c5mdpm6lxzx5f4kq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv7wTgACgkQ2rGdfm9D
tVL31BAAztN6cmovy/+sjVssa8XfRFNqmOOBHbmQvoJYUMxHPh17ZPtzsZlOtRgp
J2neB19lBhauatC2mJoi21Re+/kttdUGgpIus3PMgBzc6dIHkqkkcT1QeEc6wCej
AkL0gIu9pw5qDks/ZIeMGYrIVIrxwXQvhQTBeZ/Wsg+SHqTP78sVixLXPTRChXiu
CQE3ZlrJh8NVImsQofeexokn0OmX1N5yieZw4Fhf2KYFTbnp/4YR+qFrinJKkhoh
ccwXxmtgeg+SdUuBVIYIsCSdsTcMYI1yqoibTJ9tP4Ohu9IDPC5pDFpevW2mua0/
4l1UarsMFmDwr/gjqKxe7r5otj8S+iKMOgB7KKNNY3GlcN3e8gCW4Ss5q3re5Q/N
n03oplrdqrkcHIHQgM8FvbaI8Pa8JHF2cmILbryfiZ1SEnofv1key1+17SM6WFeR
bDLVtypq9Jt/Shw7SYK57C7wUMuVazEh/J7Ld+/NHqwo/BqWdd4CJ08wq+6AZ+cJ
M2LWwlBbXPQ0nWfQGtPOAXAHRhMKQR0ie7p8d89M+0OO736vX9KQYJ7oQ7IazB9X
uqBkKNo0MiXHQzfOKLS1PSJFsdj2tHMzk0/LmUEyLLnCS77M4dowLh0RukQe2jni
y5naS0ykf4wokXc0YhyonGWPrpCIBVulzczhhVFijL+MTPtJSVM=
=n7eU
-----END PGP SIGNATURE-----

--c5mdpm6lxzx5f4kq--
