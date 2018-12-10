Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AEDC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E576620831
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hl3y9zCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E576620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeLJAsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:48:53 -0500
Received: from ozlabs.org ([203.11.71.1]:55953 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeLJAsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:48:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CkwK0ksNz9s55;
        Mon, 10 Dec 2018 11:48:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544402929;
        bh=Mcdj/tYBGFciyIyjDZYAypgwYvegFDGbx3PHWnQin3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hl3y9zCjWw9h1urBP+qYnZvUMc4CDe206RqFp6DNOp8ya8Jt48xl4gpH6DaeWGbLd
         KK1tXXWIrml39QjpiOQWsZdo5k4hZ97MSKz4YT38An75EnautJ2CF0LCTFOonCu6Da
         h/WmlG/ZPrVfS1k1KgWPr7TDonCAsCPXJgefwFIw+SvospHbtl0hVL4PplKCZV7nL5
         7QAQfxz5Uwuz2Uh4tEMc1MYJt5UeJqauTxDizT9OhMTlyS+ND8tV7iBklnmWtqI9tb
         lXNEujSTVLa1J0ZjUu6hE97nvtBY+ZKDvKOuOZeO2hmN9aDheFyr/+NwRYFnz4/kwv
         wJDrGF1YJ9zyg==
Date:   Mon, 10 Dec 2018 11:48:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     sd@queasysnail.net, andrew@lunn.ch, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
Message-ID: <20181210114848.3f726482@canb.auug.org.au>
In-Reply-To: <20181209.163152.1641648923109797638.davem@davemloft.net>
References: <011f5be3-4bc1-2e64-0ddf-b43b8dbc4dcd@gmail.com>
        <20181209214907.GC21186@lunn.ch>
        <20181209232722.GA4425@bistromath.localdomain>
        <20181209.163152.1641648923109797638.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bB1V6PnovWIlxnY4IgzmlMz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bB1V6PnovWIlxnY4IgzmlMz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sun, 09 Dec 2018 16:31:52 -0800 (PST) David Miller <davem@davemloft.net>=
 wrote:
>
> From: Sabrina Dubroca <sd@queasysnail.net>
> Date: Mon, 10 Dec 2018 00:27:22 +0100
>=20
> > Maybe Stephen's script to detect those missing sign-offs could be run
> > as a commit/apply hook by David? This happens regularly, sometimes
> > dropping more than just a sign-off. =20
>=20
> Yeah, that would probably be a good idea, maybe something even on the
> git.kernel.org side that won't let me push if I'm sending commits that
> have this problem.

That is fine as a last resort, but it is probably less disruptive to
find these things before you try to push i.e. as part of the "apply the
patch" otherwise you could end up having to rebase a whole lot of later
commits.

Anyway, here's my current version of my script.  It just takes a commit
range (anything you can pass to "git log").  You may want to drop the
gitk invocation at the end.

--------------------------------------------------------------------
#!/bin/bash

if [ "$#" -lt 1 ]; then
	printf "Usage: %s <commit range>\n", "$0" 1>&2
	exit 1
fi

commits=3D$(git rev-list --no-merges "$@")
if [ -z "$commits" ]; then
	printf "No commits\n"
	exit 0
fi

author_missing=3D
committer_missing=3D

print_commits()
{
	local t=3D"$1"

	shift

	s=3D
	is=3D'is'
	its=3D'its'
	[ "$#" -gt 1 ] && {
		s=3D's'
		is=3D'are'
		its=3D'their'
	}
	printf "Commit%s\n\n" "$s"
	git log --no-walk --pretty=3D'format:  %h ("%s")' "$@"
	printf "\n%s missing a Signed-off-by from %s %s%s.\n" "$is" "$its" "$t" "$=
s"
	printf "\n"
}

for c in $commits; do
	ae=3D$(git log -1 --format=3D'<%ae>%n<%aE>%n %an %n %aN ' "$c" | sort -u)
	ce=3D$(git log -1 --format=3D'<%ce>%n<%cE>%n %cn %n %cN ' "$c" | sort -u)
	msg=3D$(git log -1 --format=3D'%b' "$c")
	sob=3D$(echo "$msg" | sed -En 's/^\s*Signed-off-by:?\s*/ /ip')

	am=3Dfalse
	cm=3Dfalse
	grep -i -F -q "$ae" <<<"$sob" ||
		am=3Dtrue
	grep -i -F -q "$ce" <<<"$sob" ||
		cm=3Dtrue
	"$am" && author_missing+=3D" $c"
	"$cm" && committer_missing+=3D" $c"
done

if [ "$author_missing" ]; then
	print_commits "author" $author_missing
fi
if [ "$committer_missing" ]; then
	print_commits "committer" $committer_missing
fi

exec gitk "$@"
--------------------------------------------------------------------

--=20
Cheers,
Stephen Rothwell

--Sig_/bB1V6PnovWIlxnY4IgzmlMz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwNt/AACgkQAVBC80lX
0GxHFwf/QChML+9/26RJSk5MYZiCdZ2C0Rj0Lq95hdPgnSw6OnVPFbOIjhrZpYwo
rpkbbrju7ZgSMvmgl0BV+nJoUDmgkHfIu6HP6zwtZUhFt9BDWifDNOnHN2MYg2Q2
kVPUnfKv8r2+o7cyZZw3NwcS4PN5a0VW8ygEOFOEvxe3pu8m0tLlIBDcf2DjnixZ
8Muucn91s/5SioTtV4zpaYh6PCDeOrs1o2HWM4vL6u3N80h9lOwG6zfsDyryW+C2
LGhVUq9WDKvIZ+rUq7ykJJ/W8GpSu7F+lWZavruqcIdVYV4taAY5E3N/V4eB4QbA
UEp/J0Xtigx3jbpMaq+VVCeH2eA3ag==
=Idhg
-----END PGP SIGNATURE-----

--Sig_/bB1V6PnovWIlxnY4IgzmlMz--
