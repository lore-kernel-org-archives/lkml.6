Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC2EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054BF20664
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkHfYuET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054BF20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeK0Nt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:49:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35982 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeK0Ntz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:49:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so2379278plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bSf78nB3aOegWkw1ToEmGbCEE7T2ioCy3PArTYbX0DY=;
        b=SkHfYuET+wrX/1ju/+/G1SnWefsZs8m6WrKJTBNZMJZBzel8Wk5kCQoKHhFESViRAw
         wxjqGwBtZTUv5czbM7xw2++JsrLDiR+S0izZg/WbWYOwyM6it16yAV05WNlCXoErrr3l
         zoYQjuuVndF96xlc+EaK7VLM5CqnxsRGDxzBxkDFykTRUoauYJZaGOxqb8fIvcPpeOah
         9QNAJC3+idKAZZzdN3xmo4SRmCqw4nsU4eEAbuzbVERPfRNJS+nlKS/5j+8VVvyII3If
         LBmOAqhiq4kW159ckCe5UEq5pjIPGzOXvHs5gEYyDg8xwL5MZ3NSrUu2Q+iU4r06DFKD
         334w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bSf78nB3aOegWkw1ToEmGbCEE7T2ioCy3PArTYbX0DY=;
        b=rIOUHI4QZhuymEKLc1TYWleiHzSgRdBryzrOaHe3T7TxiUc2Ac2K63xQzEAQWnoKVN
         F3Pokspf7K68B3SD+FjNvhdzygx/VtTVyHZHlGlfEAK2INDmf+/CrEEaAIeh4L8czaB2
         XgZ2bbNx0TBfiSLcEkx+3mVW2Es+zIU4V84j5cbcHuoF9r5TY4ELPGzs67wm7bF7vOMD
         qG/3E9s6dwlTq1aOGocwxzt594g4vCE06WUtcNoko0hsMbJcQ40P/4AOzB/bqcFBWeIi
         URBCsRVNMENw8xiUVzXDaWa5c1cBnOd2XpzV8AfpB08iYdx/Kl5O4FmNGCfowjMquAOz
         jaoA==
X-Gm-Message-State: AA+aEWZEckUA7PR8vhgc3mEC40N28mAoGNNqLgCmupnba8xm2bPQLtzk
        5jFB+mlqghLWfih0pad/kLg=
X-Google-Smtp-Source: AFSGD/VsHZhLpU/kPX9ZfYZZjwDiqTZS6JactuHqdr9indc6UK/mVsLGx5ICfRkfKJt6nVwPZ7Jy3g==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr30010206pln.324.1543287215241;
        Mon, 26 Nov 2018 18:53:35 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id z7sm3787393pga.6.2018.11.26.18.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:53:34 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:53:32 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 5/7] zram: support idle/huge page writeback
Message-ID: <20181127025332.23wlp4zai6e7mrip@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <20181126082813.81977-1-minchan@kernel.org>
 <20181126082813.81977-6-minchan@kernel.org>
 <20181126094737.sfudpeoigra2vir7@gmail.com>
 <20181127021327.GD237537@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uww5br4pqkvqqwfq"
Content-Disposition: inline
In-Reply-To: <20181127021327.GD237537@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uww5br4pqkvqqwfq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 11:13:27AM +0900, Minchan Kim wrote:
> On Sun, Nov 25, 2018 at 11:47:37PM -1000, Joey Pabalinas wrote:
> > On Mon, Nov 26, 2018 at 05:28:11PM +0900, Minchan Kim wrote:
> > > +	strlcpy(mode_buf, buf, sizeof(mode_buf));
> > > +	/* ignore trailing newline */
> > > +	sz =3D strlen(mode_buf);
> >=20
> > One possible idea would be to use strscpy() instead and directly assign
> > the return value to sz, avoiding an extra strlen() call (though you wou=
ld
> > have to check if `sz =3D=3D -E2BIG` and do `sz =3D sizeof(mode_buf) - 1=
` in that
> > case).
>=20
> Thanks for the suggstion.
> If I limit destination buffer smaller, I couldn't meet -E2BIG?

-E2BIG return from strscpy() just means the string was longer than would
fit in the length passed as the third argument. This means only
`sizeof(mode_buf) - 1` bytes were copied into the dest, with the last
byte being the \0 terminator.

You can find the function source in lib/string.c.

> > > +	ret =3D len;
> > > +	 __free_page(page);
> > > +release_init_lock:
> > > +	up_read(&zram->init_lock);
> > > +	return ret;
> >=20
> > Hm, I noticed that this function either returns an error or just the pa=
ssed
> > in len on success, and I'm left wondering if there might be other useful
> > information which could be passed back to the caller instead. I can't
> > immediately think of any such information, though, so it's possible I'm
> > just daydreaming :)
>=20
> It is write syscall semantic of sysfs so not sure it's doable to pass
> other value to user.

Well, with the write system call you can have partial writes, in which
case it would return the (short) number of bytes written. But in this
function, even if there was some sort of partial write possible, this
function still only every returns len or error.

Neither of these are that important though, so Ack from me with or
without these two suggestions.

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

--=20
Cheers,
Joey Pabalinas

--uww5br4pqkvqqwfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv8sasACgkQ2rGdfm9D
tVKQwxAAl57Z+TFCh/x3f1sz0/UKSIYwTb3uqnyl7jv2FHK+ZVPeGwggSK2yeAFY
uRIizMH23LKGMTeMSeJ1mE8F+GUvy0HeizzGR475phJH3qPgvzXk3qj3m1UK3aBS
3uEZogQcg5vjKsbICEFhb30vvhpPplM/YIFvzzzW2oRxe5vz5/bHGZ20wA2uHSCS
WXAu8SmMxjB/n3+tPHLdTeHCO7Y2rYCt+c8MSlAGo2j0iz/9OH0u4kX5WRqy0A6m
qo8oI2WoyjauwJgqL+tnqs3Q15AQySd4FU8YQ1Ro9mldyUDydNYncCv1QNuqdv6u
1jzyPSLyelOEl7eMMPiESI+1ZdptgH3wRitPmDHv9+CIs3srsmJH8NJlXkI8FO+y
zZuuJeyF9k5YbNLt2FMSGG/v2OcuGSaNIr1NnL7H6p2X7+c5Bnwgl2rH4smvJmDK
tB537x4GvDy3kEo3x7ZNXFMwFkbFhwXJcu6IViglHe14+u9oKpALF8n6Kwa9iW2s
k5LkU0CzbvrghyL8BvZiiszxjHpGV8dBmHKOd6dtCju8O/aCNKX6jtDSdxSMwMoL
k6pH1NcqpFHRjVl9HxpymdLhId+7QAlrPiFnyy7mHNoduzV7X/H97u5R01/YVVPU
vwNlrrWNRzZAJsEA/7q8zAHGNlAG+Up2HWDHJQijRB4H1/a2M9g=
=EgsN
-----END PGP SIGNATURE-----

--uww5br4pqkvqqwfq--
