Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB6FC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129B520869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QzhF8Hzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129B520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeIEEWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:22:33 -0400
Received: from ozlabs.org ([203.11.71.1]:34671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725726AbeIEEWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:22:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 424kGb6xvZz9sB5;
        Wed,  5 Sep 2018 09:55:03 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536105304;
        bh=paC33mDaqUwqLzHxN5eZoRZoLMF24RGOnFhgH8oE9kY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QzhF8HzjdnBfV0b/d+GfSn8JWoNijOSRB+m1ODctVoX+elkKH5jfZxTTZ3QUs33AV
         RAqRlVYVcN8n6sYXXz9vszXp5Hxfb4a9jhBgq/O79wxJJE6D5Tdq+9Rd66mbUU5GMc
         ZAKRz6fY+kZLlCNKbQYZXeugdjRFOBGK/xAVv9uzcmZxyorlQDqrm+rPprXqoiqMd7
         xppfTfdstu/vQBKCs9ar6kxDDVW6edVLQJcGE7IqR5VRi9zFewn6J9ab+KAK6XbDEL
         HdZuX9GM1vHb7j74BdwQdoOOvOCSHx+dNEgQP2YDERHU+QnNO7awodr2FmxOHb/101
         wwbRTM7UzM9Jw==
Date:   Wed, 5 Sep 2018 09:55:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: error when fetching the bcm2835 tree
Message-ID: <20180905095503.5f6feba1@canb.auug.org.au>
In-Reply-To: <1892655944.623.1536091635278@email.1und1.de>
References: <20180828074200.440fb5ca@canb.auug.org.au>
        <87wos1gny5.fsf@anholt.net>
        <1892655944.623.1536091635278@email.1und1.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ywZIngKFPKOvy0bg_pVSFo="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ywZIngKFPKOvy0bg_pVSFo=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Tue, 4 Sep 2018 22:07:15 +0200 (CEST) Stefan Wahren <stefan.wahren@i2se.=
com> wrote:
>
> > Eric Anholt <eric@anholt.net> hat am 4. September 2018 um 19:41 geschri=
eben:
> >=20
> > Stephen Rothwell <sfr@canb.auug.org.au> writes:
> >  =20
> > > Fetching the bcm2835 tree (git://github.com/anholt/linux.git#for-next)
> > > produces this error:
> > >
> > > fatal: Couldn't find remote ref refs/heads/for-next =20
> >=20
> > I'd passed responsibility for the git tree off to Stefan while I'm
> > mostly-unavailable due to new baby.  Maybe Stefan had deleted the branch
> > for a bit? =20
>=20
> sorry for that. I deleted the branch and i manually setup the new one lat=
er.
>=20
> I hope, everything is fine now?

Yes, all good.

--=20
Cheers,
Stephen Rothwell

--Sig_/ywZIngKFPKOvy0bg_pVSFo=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluPG1cACgkQAVBC80lX
0GwCZAf/cDti0PMzT0f40Zo9Y3cJDurFkMfUf3ct7q10uRwbibnebZYVyyemqjI7
7fUKxDIgc7052j4qfFV2GiaR7w06YbLyFn7dIAEjJTsKs75YI5oxCC8qWcB/qoll
9OlfXcppwXwAIflnnWaAHyVJZjoOXDliLdO8CKTy7kZrRa/lISnUa9gB7TqrzGvm
mnjbq2X1QTT+plRL2vx+8vKObasG8TvdRsVFaHEmEss1wwPd30wmfYV9th90ehwd
B1CAHHAnjyZCweHc2+4DVn3DqSktOiXyZaY+uPCHYLgqVd0mOCIHjQR3aqY0HK7I
tHVkQuWfmjfodctkL6k3wTI2lRd4ig==
=hDzP
-----END PGP SIGNATURE-----

--Sig_/ywZIngKFPKOvy0bg_pVSFo=--
