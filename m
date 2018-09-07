Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A8DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710652075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="XkczJYvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710652075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIGWSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:18:13 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:44674 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeIGWSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c7TxYZ63c4qq6s0x3cSkaJES7fzhCWB32Jffi7RcnEc=; b=XkczJYvPUn3DaVjhB8QGmQGE8
        km+UdouUd4vsXaKQxgmS72K+Tb4ygvQFv/ndkU9bLCI+lxvUQQQOUHyRFjI4rhl0AG0bJXUxG+mMt
        MhMcPYMDoVLxUJeUu/EEjDIIDVKaijX62b6CA1hAEr19TPqlMrnQt8zOeDB5u5nD6ruuc=;
Received: from p5dcc3012.dip0.t-ipconnect.de ([93.204.48.18] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fyKfu-0004UG-Em; Fri, 07 Sep 2018 19:36:06 +0200
Date:   Fri, 7 Sep 2018 19:35:57 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression in next with filesystem context concept
Message-ID: <20180907193522.1a98d410@aktux>
In-Reply-To: <20180907161023.GF5662@atomide.com>
References: <20180906164358.GI5659@atomide.com>
        <9053.1536310046@warthog.procyon.org.uk>
        <20180907161023.GF5662@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JwFDSM5zShD/p=h26a5lGM7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JwFDSM5zShD/p=h26a5lGM7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 7 Sep 2018 09:10:23 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * David Howells <dhowells@redhat.com> [180907 08:51]:
> > Tony Lindgren <tony@atomide.com> wrote:
> >  =20
> > > Looks like next-20180906 now has a regression where mounting
> > > root won't work with commit fd0002870b45 ("vfs: Implement a
> > > filesystem superblock creation/configuration context"). =20
> >=20
> > Am I right in thinking you're not using any of the LSMs? =20
>=20
> Assuming LSM as in Documentation/lsm.txt, right not using any.
>=20
> BTW, I don't think this issue shows up with ramdisk either,
> so that's probably why for example kernelci.org does not
> show errors.
>=20

I have also similar experience with my automated tests (automated
alarming does not work yet ;-)), I am still in the beginning.
I do there a ramdisk boot to create an overlay mount with the fresh
modules on top of an ordinary rootfs. initramfs mount is
ok, but the microsd card fails.

Testing from a ramdisk I get:
/ # ls -l /dev/mmcblk0p2=20
brw-------    1 0        0         179,   2 Jan  1  1970 /dev/mmcblk0p2
/ # mount /dev/mmcblk0p2 /mnt/
[  682.819061] Filesystem requires source device
[  682.825103] Filesystem requires source device
[  682.830810] Filesystem requires source device
[  682.836303] Filesystem requires source device
[  682.843078] Filesystem requires source device
[  682.847991] Filesystem requires source device
[  682.853149] Filesystem requires source device
mount: mounting /dev/mmcblk0p2 on /mnt/ failed: No such file or directory

64GB microsd at omap_hsmmc correcly recognized.=20
Last known successful boot: next-20180830

so you are not alone with such problems.
will investigate further

Regards,
Andreas

--Sig_/JwFDSM5zShD/p=h26a5lGM7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAluStv0ACgkQfb1qx03i
kySW4xAAhKea/3ncoKAloypGwknJoJjnLjX2eeUxdMhY6iQ9RQwJpRvv9Dp5soIt
v+g2uSt4jHnGZ7coADGAk2VDJDqZ09/kmxOUJRTo8Ndqn2X2fAz/SMJ9mJYv6gp/
5FvBh7RBeDifNZh2FBfN+08w869NcGCZ7hQeTnv1LregpAfVdGzn5rZuGbwflMLK
ErFiyxatzzRlDvG1PBxuqmbu4xYf15OWDdCiEPMgfdjDUgv5wNEMO0t7RHYfW3Po
HlMlmDY4soCAIYdhJEPc1WQANafFdjauKPhfTNpmgiiKLmnuSa0Slgv+Lh12S/nA
T3e/JH3ikFmlB25RaHrHWKlAT04Hp9SGiJ3f2eFX9voOtHZEdd9p6KSkDVEc2DaO
JZhrg44xOrXvdzKe6u8KOfkSSqXKt6QMbCCuwPLxSEUWBzUHQXlO1Cs/+2X3aWf2
XocgxtzaMajzIrwC4HNRosY3prejyvg6mcP9mPQZjW6+NOTOKktWJrIb9lw1eWND
EEz01x0oQJjzJz1dLfG0veH4p/nt6FYdrFeyoSwJd4oPXmUP8qkvENshjbS4Fx+3
hN8BF2WhL9+XLjKMFolNIiVumNrP1WuLZZcknRZfd15VBAp05Htd6kUdHHC9areT
6Gi786e0bnEpgG/Od/CsohMXjYVaao6tCLzzwyyLAtqoD3nEfuU=
=nwXd
-----END PGP SIGNATURE-----

--Sig_/JwFDSM5zShD/p=h26a5lGM7--
