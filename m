Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7F2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9070217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWG8Fjvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbeLPTVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:21:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34140 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730593AbeLPTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:21:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so5072994plz.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 11:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k3XWQrE42hJkEFHW0TiIDUIrQKT1AhR0Pn3bScuhEM4=;
        b=EWG8FjvkAZpzifi73exWw/VGWOoqJCqfrhMfxeq5XY2nBdI5pWbRwqRDt4Ztoku6Cd
         GJUvt96hMb22fTp+/UkR6AiXPEt7If0f7b/uwX/fPJ3WFLIIpZ3ZYUkM+AZ6PLZk9IWU
         5RZYCk9kCojEGMbMZ+V52xzlwRbnn/ReCAixOUvjE8jbRdJWTSPK5S95eYKyynQ0jhsz
         H+HWnXPUmIysfYcYp/Ww98aL0GO0iOco/peU1w12NaH4XgiXMDLiA4ZwbRarKQ9Lz0R4
         omkV21II7jIKTnu8nTIgXvAcBh1EFMBPah42Zge0W+KKPVTCyVBw1KercggzjA+ntv8S
         fDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=k3XWQrE42hJkEFHW0TiIDUIrQKT1AhR0Pn3bScuhEM4=;
        b=V6NVEOL2vLhxoidlhxtRHDVxuJ6L5ODcPvmXNF4Oki7fCk9TIiW7p0o7r8Qoq7wFpo
         ZPE2JImRqo2XVODLSNv0hTNsTphzpLhk4ka5WV/9g1Ya1+Sv/qIfHezNeyam+w7EO4je
         7xwWAxZTZsxKVx5x8S1rimJ5LR+vorPQM7BEL+iXO5XtfDk3w2FpYWzsj7m9waXrvVRs
         HyHosq/0MDH6Ea2mQmbvnAs1eBYIfn9YU2sW4SmMGwrRSccL6aMq7M5G4m1cwQK1bQ3/
         zgBniJcCje8JqdJcT+QtOWWz3Ih4irN8FCgppSPOQs3Xvr373rRhVQ3nESLxJmuXSPge
         ncWQ==
X-Gm-Message-State: AA+aEWb/x10IhyiggRhZ8u/pJb7SA5nCkdjogBQ5lQhfxv71d5NMip3R
        REYQnkJXrY9sw40OrZUV9iM=
X-Google-Smtp-Source: AFSGD/VyTsrmXPkjIMNcMnqSFnFRJUQKsbUNh24KigyQ0oMWAK/tub8eqGJLRH/3bySmdiEsu5RRnQ==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr9907179plb.223.1544988099469;
        Sun, 16 Dec 2018 11:21:39 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id p24sm14332667pfk.155.2018.12.16.11.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 11:21:38 -0800 (PST)
Date:   Sun, 16 Dec 2018 09:21:35 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] LKML Archive in Maildir Format
Message-ID: <20181216192135.hc7gykmwkfgil2j5@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
 <c7865616af2eab80f5e5a4cf756ba430f2293499.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kxus5dkjokdnkipq"
Content-Disposition: inline
In-Reply-To: <c7865616af2eab80f5e5a4cf756ba430f2293499.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kxus5dkjokdnkipq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 16, 2018 at 11:17:34AM -0800, Joe Perches wrote:
> On Sun, 2018-12-16 at 09:06 -1000, Joey Pabalinas wrote:
> > I spent a lot of time trying to find an LKML archive in Maildir format
> > that I could use for local searches with nutmuch or something, but all
> > the links I was able to find were all dead.
>=20
> You might instead use
>=20
> https://www.kernel.org/lore.html
> https://git.kernel.org/pub/scm/public-inbox/vger.kernel.org/git.git/

That was my first attempt, but the ducumentation for the public-inbox
format is sort of terrible, and after a few hours trying to convert it
to Maildir I just gave up.

I ended up just slowly scraping lkml.org for a couple weeks so I
wouldn't disrupt anything and it worked fairly well. Just looking for
advice on where to host this now so others might be able to use it.

--=20
Cheers,
Joey Pabalinas

--kxus5dkjokdnkipq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwWpb4ACgkQ2rGdfm9D
tVJgDBAAirxgxkupU7ahJC/8uJVR8EytLxMbpkijI8LND8Z8/kAqZYbajzpdADdO
4J4a6B7xGROe+LLhCmNAdtc6p5Spst3chUyHvGuidozovHeDa89ChX83gALuRpDU
lSTXkIYleQhhbjhUqkJHcyh6i3l3nc+jAuca9KVttwstGNLPzLyFuaf0SYwFaN7O
qw07nKTEqjovjyAAow/3nL6xk0T4cmn9Ma8HVSC3fGMLagH12+fuZVRe7jDtDLeY
ocZXSZo/t1ZyvX55xs+WKY851mZ8WQPEO7Ow8XbhzzBy+Qu1NmfpmtWCq/NS5qBz
s2av0f4u3P3MezNvlt6owdrEhjMzLjd7JaOvuV154eaOCxxUL9XS/u7OFEG7xYjm
UyvwMLNU37gclO6YqJSGuQJ8vgkstKmWVJjFqL1mpvNNJdYd1b3T1h5yqSy6dnsh
w4HLopKB8xDux4vxboJ2aw2XwVP8qRjlhmWgu8jBT3cqyrrLNoy3lqiHPIzOuB0o
qWPYz973lFtkioyAG+g+yRT3nQU0km9UNZEPBUXFcfXpfxV12G22xP0+2fxO624g
GwImmy8k2FmpEgvS1FS5sQJpSBXQd9IDO48Qum42VqiaX5nJ6ssYcs0iIaLH22s+
gcBnvpjTLKn3JjBsAzG65cXEHJbDEooBiRyyeOLwomFx5pZ4rVc=
=Cc7q
-----END PGP SIGNATURE-----

--kxus5dkjokdnkipq--
