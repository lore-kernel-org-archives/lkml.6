Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED84ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D4120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aGRhB3S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D4120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbeGWWGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:06:53 -0400
Received: from ozlabs.org ([203.11.71.1]:41145 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388076AbeGWWGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:06:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ZDVt079Wz9ryn;
        Tue, 24 Jul 2018 07:03:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532379830;
        bh=v0lSzvL619ztkDS/b1eZydeyPUerwJx5XhM+w5Q7HnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aGRhB3S3E6GDAG67BR+xomUx4LLUyoG73msRU0ggeX9IpnARvwNoRcfKiQnxgBhlh
         jHDtXmYHUCp7CQmd37y4Q1NKCptQIOONcfPIcHT6bbmIqsiM/MRBsxhbcEKRCPKe1a
         hBcO170iuS+5j7rZx7Sfx2norf/8GkqN2P6Dzzdm5l+DYYnbAwwFC8tbAX06WN/dSF
         Y+PIDa3IbHJbHrUNxLTUL+jre5aLqKRYmx0e7yHMjLxo83h9Y4AODkjUpec9naIvwx
         Vc206vd+zt02Z+WGrVhQBwBUr2mqJOBYEOGBWieda87poEZOd15QFTwiGot/M2KrSV
         TKGjCKKI4VqSA==
Date:   Tue, 24 Jul 2018 07:03:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 23
Message-ID: <20180724070342.36c5a2d9@canb.auug.org.au>
In-Reply-To: <877elmhvf9.fsf@concordia.ellerman.id.au>
References: <20180723200032.221a8f18@canb.auug.org.au>
        <877elmhvf9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.vKZNXdL2uNbeeSvD13OLGZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.vKZNXdL2uNbeeSvD13OLGZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, 24 Jul 2018 00:35:22 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Would you mind adding my "topic/hvc" branch to linux-next.
>=20
> We (ppc) are notionally the maintainers for that code but it's used by
> some other folks, so I'd like it to get some wider testing before I
> commit it.
>=20
> You should get:
>=20
>   9f65b81f36e3 ("tty: hvc: introduce the hv_ops.flush operation for hvc d=
rivers")

Added from today.

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

--Sig_/.vKZNXdL2uNbeeSvD13OLGZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltWQq4ACgkQAVBC80lX
0GyI7gf+P5pl3lh9oWieWUcUDvlW9IaG50WC3U9/+CzkfeD5t+2sbJKrHOUBphcd
WgJkCloTcYBzr4KQ7xeyGYPIjvguHadZnvbmjn3vU0gyaQ5p64IgvKBT5raBPI9y
agzuJusSiizIhi2/MU53v/LP5l/WcNfQFxW/Jq/0r0aAKiunxg3EGGfuzA2yVPgU
PzEC9T/MFlg9KWBPT4E68B97L8g5HutHoe02tjPxbpOOLF3ixEz3DSdPCWXdOJ49
dwCtHn/UHTSzE94P3wg7d2aynn53ruNJLXe7NLNn1WA/DII5ALQYdjuSWU3S+JxW
o6CJY9nyfJ0N1buaeOXrUmkkVkPOkg==
=xVNS
-----END PGP SIGNATURE-----

--Sig_/.vKZNXdL2uNbeeSvD13OLGZ--
