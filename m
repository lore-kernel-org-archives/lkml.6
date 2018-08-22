Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2F0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57D1208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JVqdEEiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57D1208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHWC5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 22:57:42 -0400
Received: from ozlabs.org ([203.11.71.1]:51461 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbeHWC5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 22:57:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41wkLZ3FBKz9s3x;
        Thu, 23 Aug 2018 09:30:46 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534980646;
        bh=Xv/7eNuZHtdEARWXcL1Fh2sqS5LZvA/C0zugBplwaog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JVqdEEivEx5B6EUUD4cWbpV5G4ZdM7imEcoTKpt2mLySl1FGcupASuigYkKzReL0x
         DV6dreOITKc8G2+vtpscfI1uzjkw+hPrwUud3RCICFuDRp5m+8VICHXg0JTFPMdKtN
         XOZmkns2tje8D53XVsBEALhZz3EzS4TeED1lx+fWszMwRkzt2U7W0E0xGUETkLOZIg
         sUcV1qSY0OlURop/lfvKvVytVUkI8MAx550PqX+W1CiZ29S6YzetBncQQlx49q8pU4
         bcjTQp+bbzgE/ykqJT/ugVmKW/JKAYDiykIsDeDTnVdY76UxdxzlCPsvSDw/iEoK9M
         cOSCFFoDjEPsA==
Date:   Thu, 23 Aug 2018 09:30:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <ksummit-discuss@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: at91 git tree in linux-next
Message-ID: <20180823093045.00e751b0@canb.auug.org.au>
In-Reply-To: <f15a82c8-5960-34ea-e7fc-dffdfdd369c6@microchip.com>
References: <551A9FAC.2010203@atmel.com>
        <f15a82c8-5960-34ea-e7fc-dffdfdd369c6@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+4dgMPmFUSSpu5TCHLDNxTj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+4dgMPmFUSSpu5TCHLDNxTj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 22 Aug 2018 14:47:56 +0200 Nicolas Ferre <nicolas.ferre@microchip.c=
om> wrote:
>
> Alexandre Ludovic and myself are the group of maintainers for Microchip=20
> ARM SoCs. The current tree that we have in linux-next is mine [1] and we=
=20
> are moving to a common group kernel.org tree.
>=20
> So, can you please add our new tree to linux-next:
> at91 git=20
> git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git#at91-next
>=20
> instead of:
> git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git#at91-=
next
>=20
> In addition to that, we also have now a "fixes" branch. Can you please=20
> add it to your "fixes" tree?
>=20
> at91 git=20
> git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git#at91-fixes
>=20
> Thanks for your help, best regards,
>    Nicolas
>=20
>=20
> [1]=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
Next/Trees#n84

All done.  I added Alexandre and Ludovic as contacts for both trees as
well.

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

--Sig_/+4dgMPmFUSSpu5TCHLDNxTj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt98iUACgkQAVBC80lX
0Gzclgf/ZvkzzO6cm36C2M5s2hjrrv28qwEj6AhizdZIvCe63OJigfEXWyXw83TZ
KJ/SylLSFMaFKJ/cdNUKqR4/We06IfXcPccBIrwqL4PocDZuwoayOB9SPNXr9oSf
Ho+x7yZSM8E1UavKYTxc4RKtFiytW1oFYsZ+mhXo04zptStncgShapIrwG5PMyUC
wrdGqe8IoKtRUQ/KVJiiUZpFhXlhK6S649qskHU7138hOFccm7EIeqcjY/VJ5JIM
pHwg9c/fO8TYzpE7soIIdvX4/QaW5QsmQ0gDrTnBrhDQlYiNzpb1GUIzVGWlu3SK
yKKtzaomCQgtanMskfRyD58sE6Qkiw==
=SJ80
-----END PGP SIGNATURE-----

--Sig_/+4dgMPmFUSSpu5TCHLDNxTj--
