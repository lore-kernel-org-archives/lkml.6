Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75534C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3507C2150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3507C2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbeHBPWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:22:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35612 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387547AbeHBPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:22:37 -0400
Received: from mail-wm0-f71.google.com ([74.125.82.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1flDhK-0008I4-H6
        for linux-kernel@vger.kernel.org; Thu, 02 Aug 2018 13:31:22 +0000
Received: by mail-wm0-f71.google.com with SMTP id n22-v6so1713682wmc.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 06:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=meD7VFXm0yO5L7wWcaIjE/S7x9vqo/q3UYbw8aG1iG0=;
        b=l876ts0JFex2je2D81tI4LAwsgrUUNmfYYVyVIVvbGxq2U/msnucPTATElL0evc7Ut
         9M9WUYzBeLu7V7KmeAM68E3GBUN4SNZc3X0CsJDnox9sBff0z+TsxsSX+9U9QtU0ekhE
         bIbE+N0ng4g5La99c1TCtMoeBHDLRrLiobBerXEl+0H0XUR3z0mtbxxFtXe1nPm6UZEM
         h1Tu2BLBQhXfVGoe/JbGUa1ivXP1DIvpSe9DLt0ZUiMJ3wfIZ7VPrsDIYBI4XH3Dgv/3
         3vXKUdxb+XmTZap1H8GDqqAUY74If+anYGWv/22+sB46KPPP9UY0WhdhhCWS2O97nZqw
         f1Sg==
X-Gm-Message-State: AOUpUlFWKQPXElm8EQFQzK9ZnoyaV7mY5QjV/Zt9jReHhHHyoo5J97+c
        7XNXXtJqc40R1spNdppIak4q4nFKGwNbDzIVvyK+J6ZSKidG+KNH+8S+vdEIja0zLcHBxa94sLl
        NiEHceFbMlsXPj5qwX6raGUNwxhy+TU/bXrru+xumtA==
X-Received: by 2002:adf:8877:: with SMTP id e52-v6mr2185539wre.30.1533216682075;
        Thu, 02 Aug 2018 06:31:22 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpd9nlOeHG+DTwK4oiO5dnME+COmk/qBrAeDJYf1zjEWv86iZC24XzyAXg4ZCbI29hnzgZoRMw==
X-Received: by 2002:adf:8877:: with SMTP id e52-v6mr2185525wre.30.1533216681812;
        Thu, 02 Aug 2018 06:31:21 -0700 (PDT)
Received: from gmail.com (u-087-c004.eap.uni-tuebingen.de. [134.2.87.4])
        by smtp.gmail.com with ESMTPSA id b22-v6sm2653596wme.48.2018.08.02.06.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 06:31:21 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Thu, 2 Aug 2018 15:31:20 +0200
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk
Subject: Re: [RFC PATCH 0/4] file: export functions for binder module
Message-ID: <20180802133031.GA30612@gmail.com>
References: <20180730143710.14413-1-christian@brauner.io>
 <20180730163452.GE27761@infradead.org>
 <20180730201224.GA1081@mailbox.org>
 <20180730201947.GB12962@bombadil.infradead.org>
 <20180730202840.GA14693@mailbox.org>
 <20180730214108.GE30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20180730214108.GE30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 10:41:09PM +0100, Al Viro wrote:
> On Mon, Jul 30, 2018 at 10:28:40PM +0200, Christian Brauner wrote:
> > On Mon, Jul 30, 2018 at 01:19:47PM -0700, Matthew Wilcox wrote:
> > > On Mon, Jul 30, 2018 at 10:12:24PM +0200, Christian Brauner wrote:
> > > > > I don't expect this patch to be mergeable but rather to kick-off a
> > > > > discussion if we can either simply export them as they are or how=
 we can
> > > > > get supportable exports that allow access to struct files_struct.
> > > >=20
> > > > Maybe that wasn't obvious from the first message. Is there any way =
we
> > > > can come up with a way to have versions of these functions that you
> > > > would be fine with exporting?
> > > > The point is that otherwise we would have to either duplicate the c=
ode
> > > > or come up with something way more complex. If you have any pointer=
 that
> > > > would already help.
> > >=20
> > > He said in the first reply this should probably be using an anonfd.
> > > If you do that, I think all four of these exports go away.
> >=20
> > I try and see if that is possible.
> >=20
> > >=20
> > > And there was really no reason to post each of the four exports as
> > > separate patches.  That just makes review harder on everyone.
> >=20
> > Sorry about that. It usually depends on the preferences of each
> > maintainer how fine-grained such minor changes should be.
>=20
> The fundamental problem here (besides "who the hell thought that this Fin=
e Piece
> Of Software belongs anywhere other than in /dev/null?") is that messing w=
ith
> other's descriptor table is Fucking Wrong(tm).  It's not going to become
> a general-purpose interface.  That kludge is just that - a kludge caused =
by
> atrocious API design.
>=20
> Exports NAKed, and if brought again they'll get NAKed with extreme prejud=
ice

That's fair. When this discussion of turning them into modules was
started it was expected that this would never fly as is. The question
was whether there's any way for binder to touch struct_files of another
process directly at all. Now we know, there isn't. What I was hoping for
is that this would cause a redesign that avoids touching these helpers.
There's an effort from the Android folks now, which is good!

Thanks!
Christian

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAltjB6YACgkQjrBW1T7s
sS0TKRAAk9pHBArc7WIIxgcjZYOnNWp2bef8R3bY31tdoFj8FSjTwxMrc8y3816r
DFLv+JJXN8MNSF3f7O4us3Vcgwg3/OtkDpyhFfAJijk3wco3j01Czp8MCbUjBmlv
MS7t1MGwekjelpjIpZ/e2SbbD3OPXdCHUP+FCL8CTIPFPkzfr47LiL9EdGtfeVDb
cunRAeyLg/SFCRJAA6EeDvLjl4lZIqeWVw+MaJPG7lbbQ4KoXX0H7gVUgWLNj4eu
LjpU7J0MV97WOjuASDEyL4k+Gf6jD8ix0DlpqqaEW+eK9xJouryitZb71dV5Q1wJ
V0Z+WNE7/uls5x4GMC4C+wOK3T6L4VnIN/kZ8uljjfvax+d47xDGbBPokLLcwrF7
HFnD9RDLkiTwMrCp7OQR8x0Q3c+Ch6EhaEFCWfKiCnwqi5GFk8EX/Cd481xCs5+6
1IV471jkwMOEFsdQ1TCREpCiIwEkTnxCkokz9tEkG8F4F2zqal22B9KKYQkDL/Ht
MDm5xTg2XcnbFcnQwZuQmH2y4t1Ylk1g1plnK5/6D6g11VmNi66TrKE150C21fB2
fELDrkNhjVLBcU/b/Z3OU0Os8+id60wG+4NBk5hH9HQNtl1Jy5SBkCKpGQyjTmcc
fWAXOXmcIthocltP8h6do/T3qcdyyHWApyhp2xtlWRSmDYjR1Ek=
=rah/
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
