Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E2C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34C221782
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 10:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34C221782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeHEMmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 08:42:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53765 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeHEMmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 08:42:05 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6903E80633; Sun,  5 Aug 2018 12:37:57 +0200 (CEST)
Date:   Sun, 5 Aug 2018 12:37:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sowmini Varadhan <sowmini.varadhan@oracle.com>, arnd@arndb.de,
        gthelen@google.com, jgg@mellanox.com
Cc:     santosh.shilimkar@oracle.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Subject: Re: [PATCH] RDS is not Radio Data System
Message-ID: <20180805103756.GA24849@amd>
References: <20180805065920.GA8968@amd>
 <20180805101945.GA4056@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20180805101945.GA4056@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-08-05 06:19:45, Sowmini Varadhan wrote:
> On (08/05/18 08:59), Pavel Machek wrote:
> > Getting prompt "The RDS Protocol" (RDS) is not too helpful, and it is
> > easily confused with Radio Data System (which we may want to support
> > in kernel, too).
> >=20
> > I wonder if option should be named NET_RDS, instead?
>=20
> RDS has been around for a while now (since 2.6). How will you
> rename proposal manage backward compatibility? Why can't you call
> your new option CONFIG_RADIO  or similar instead?
>=20
> Are we going to rename NFS* to NET_NFS* because someone decided
> to reuse the NFS acronym?=20

Was it?

Because this was first time kernel asked that question... when I was
testing -next. Is this related?

commit 533d1daea8d8a389b37207ad7b50c4e750969231
    IB: Revert "remove redundant INFINIBAND kconfig dependencies"

> > And this sounds like a good idea:
> > -	tristate "The RDS Protocol"
> > +	tristate "The Reliable Datagram Sockets (RDS) Protocol"
>=20
> surn that sounds fine.

Can you apply the patch, or do you want me to send it to davem?

Signed-off-by: Pavel Machek <pavel@ucw.cz>

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltm04QACgkQMOfwapXb+vLyjgCgu6DEn0uwoQLJwZE2qVLSeIOm
/HcAn02lG6cu7dLKHpCHLw9ByrqZ1pm8
=vV9F
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
