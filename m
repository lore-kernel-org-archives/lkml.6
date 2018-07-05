Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D44EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C222411F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fqSmkgys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C222411F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeGEEha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 00:37:30 -0400
Received: from ozlabs.org ([203.11.71.1]:40153 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeGEEh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 00:37:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41LlT26pL1z9s1b;
        Thu,  5 Jul 2018 14:37:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530765447;
        bh=0L4bDrvyf4MwyvI7eALm1kt0mSBn1iT+7roS6hkaUa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fqSmkgysDwm9i02qYIvB6x8jvzk09sj9O8k8sJwhnqRJzwMN300KHDXQHc3zr3ZCt
         0S4ilU2exiiq6WUtYOpPfPuekEsQdU1w6xG3ozDf93UNVyalo+H4Ph0L0PNtgj7LLj
         8P/duVTmduxxd5u4XlwXwEQdQLtPXrBlMekTLQKqbJW71CktMq2KoVASgABYK5rMxN
         NG5dtT6F97sC9W2yraoYyptM+3TTGNt3QSaiQy7vZdVkSe42CcrwmCu6kI6gm1YxcR
         ovUjDbgzgbZPUcqynvJ/YPk7bVVaoSw3VnJ4SYHcCPvV9A6C9BqPV7r1FPT1vwQBlE
         ZI3/JkbsmgMiQ==
Date:   Thu, 5 Jul 2018 14:37:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: XArray -next inclusion request
Message-ID: <20180705143726.3ec5e77a@canb.auug.org.au>
In-Reply-To: <20180704225431.GA16309@bombadil.infradead.org>
References: <20180617021521.GA18455@bombadil.infradead.org>
        <20180617134104.68c24ffc@canb.auug.org.au>
        <20180704225431.GA16309@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2u+J8f_.TkC=Al/t6PlP1PA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2u+J8f_.TkC=Al/t6PlP1PA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Wed, 4 Jul 2018 15:54:31 -0700 Matthew Wilcox <willy@infradead.org> wrot=
e:
>
> I have some additional patches for the IDA that I'd like to
> send to Linus as a separate pull request.  Unfortunately, they conflict w=
ith
> the XArray patches, so I've done them as a separate branch in the same tr=
ee:
>=20
> git://git.infradead.org/users/willy/linux-dax.git ida
>=20
> Would you prefer to add them as a separate branch to linux-next (to be
> pulled after xarray), or would you prefer to replace the xarray pull
> with the ida pull?  Either way, you'll get the same commits as the ida
> branch is based off the xarray branch.

I have added that as a new tree from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/2u+J8f_.TkC=Al/t6PlP1PA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls9oIYACgkQAVBC80lX
0GyA6Qf9E96YAJqveWQemXWqUNd++DgTtmwPWP5y/5w4Oh95tM5IT2iVjLnvqKLE
F3a8NX4jpqWezgdOJAb5r9IPbosGRabgGNLvluET82kVfcs2KIsK4ITsAmuqmjt0
5Hf1zynH/GOXXhGqOfkbfr3xyQqFTETyOYv67Jy4l6NCWNO8HP0lNb9qfbUZcOH2
y4ARndfMobDYXpGOlGHPIiHz6TzOH+epEI5Vtl1kW91TvqfM0FMyuIsMQptZE+es
DyaQ7VTmhTP55tZE/RAwX5rNgrfXMYE1jUTZqs9lw7v3OnVZzxbDIVnVXvCL+gxl
4sY69QdBR2EVykYmD9KVeAMbC4IqUA==
=XVdQ
-----END PGP SIGNATURE-----

--Sig_/2u+J8f_.TkC=Al/t6PlP1PA--
