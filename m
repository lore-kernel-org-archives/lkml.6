Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83ABC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC94B20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC94B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJOBry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:47:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38132 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbeJOBry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:47:54 -0400
Received: from 188.29.164.50.threembb.co.uk ([188.29.164.50] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBkmB-0005xp-Hw; Sun, 14 Oct 2018 19:06:03 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBkm4-0005dA-Ok; Sun, 14 Oct 2018 19:05:56 +0100
Message-ID: <482a6bce7a01778168a169af4e5db4c080d44278.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 232/366] tracing: Deletion of an unnecessary check
 before iput()
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     akpm@linux-foundation.org,
        Markus Elfring <elfring@users.sourceforge.net>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 14 Oct 2018 19:05:56 +0100
In-Reply-To: <9b4c97ade076d0ea6b4c2adde7535a5b48f0c5bc.camel@perches.com>
References: <lsq.1539530741.752314819@decadent.org.uk>
         <9b4c97ade076d0ea6b4c2adde7535a5b48f0c5bc.camel@perches.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-aSQM/syPiZ1eg6Ltnaw1"
User-Agent: Evolution 3.30.0-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 188.29.164.50
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aSQM/syPiZ1eg6Ltnaw1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-10-14 at 10:24 -0700, Joe Perches wrote:
> On Sun, 2018-10-14 at 16:25 +0100, Ben Hutchings wrote:
> > 3.16.60-rc1 review patch.  If anyone has any objections, please let me =
know.
>=20
> I believe that no stable or backport kernel needs to
> apply patches like this unless it's needed for other
> real patches to be applied more easily.

This is only included so I could apply commit 0c92c7a3c5d4 "tracing:
Fix bad use of igrab in trace_uprobe.c" with fewer changes.

Ben.

> > ------------------
> >=20
> > From: Markus Elfring <elfring@users.sourceforge.net>
> >=20
> > commit 16a8ef2751801346f1f76a18685b2beb63cd170f upstream.
> >=20
> > The iput() function tests whether its argument is NULL and then
> > returns immediately. Thus the test around the call is not needed.
> >=20
> > This issue was detected by using the Coccinelle software.
> >=20
> > Link: http://lkml.kernel.org/r/5468F875.7080907@users.sourceforge.net
> >=20
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  kernel/trace/trace_uprobe.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -552,8 +552,7 @@ error:
> >  	return ret;
> > =20
> >  fail_address_parse:
> > -	if (inode)
> > -		iput(inode);
> > +	iput(inode);
> > =20
> >  	pr_info("Failed to parse address or file.\n");
> > =20
> >=20
--=20
Ben Hutchings
I haven't lost my mind; it's backed up on tape somewhere.


--=-aSQM/syPiZ1eg6Ltnaw1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvDhYQACgkQ57/I7JWG
EQnhhw/+IaAKLRxtQzLv3YEak9I1Tpaip8F4ARuwJjK52r3OCbztSiuEQdRJf+p5
2RfhyTs0CsQHkSDLg0RBGH+1xdsIqAOwbxx3YlMBUyhOssyjE24tuSD6AvT3ORa3
6m57jHExMzXW6jDP9LldDhxxSx+uHx46PzmqEmIqjWl2++zE0m7HA3zvQjZreBf7
2kk8VsauU5rLERwyH9zyA0jmnIa8obA/oCci3W+LlvfTSgFIlW9cXfHqE62KHxZg
NCQgGInQqUjMJ9juoE/c6h64PKkPWa0AUjfuMjAIJ4VRkD6D/7rI9Amli1Y2vYwa
qYOFmaEE2IxrjM9A+AFn4btJ9URrgqiLld5M0z4WLlCUiLf/mfBvOz3rZQoTCuKh
mBgyPBm0HXS9PidgnHbGQTqAKqtFCvLozkicGw7AXGZQmvp1/0fSVu6v9Bb+8sy4
rX/U/4FxMQYROQlJbdcs4hIYCzYonWttPRiBmCA0Jq6UFAttmdaxC9y5qP8rCvGO
9X0XDXsZbkJNAkH5ScFwprLt7Zrn7SEnjfB0gMxbPaF0z3ZA0xLhRz4Zv3mvQm7h
utavG5bFYWaeZZSiXfHb5xucW6yK1FYFKUXGOPEJvS3BbGqMxTxXG/VdhsbC+z0y
c8cVDguKYO5IwLW680ldRl6ClLHgMC8au2Z5xDqPNAQfMEVOOFs=
=zetv
-----END PGP SIGNATURE-----

--=-aSQM/syPiZ1eg6Ltnaw1--
