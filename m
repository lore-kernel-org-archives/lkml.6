Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC284C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DAA208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f8sQ+jFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DAA208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbeGaCRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:17:20 -0400
Received: from ozlabs.org ([203.11.71.1]:38159 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732039AbeGaCRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:17:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fcyl4kSBz9s1x;
        Tue, 31 Jul 2018 10:39:43 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532997585;
        bh=ERexqFq6BAdOd6UzpCDW2sMMSWCvmIj+v4K6JAoN7Lc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f8sQ+jFWnHUfzWmlb307x1/jGd5oD4zWJlWx3bRlh3UTr0bUJLRHm8szsaTsEx6x+
         Lzdn3QDXS3IUxruCp3aHb7QreXZiG2i6+zTrURSN9V3FTlCi3wHezPiHfPcY8QSknD
         DiTlz4sCHhzxEH1G3z9hIXD3WfQVJ+BrKbShvF1QN/I/eH0nCQyPBznCUPv9FOOSiW
         cJnNzmYqOgseXENdZr69I4pzs6q4w5xjy9vNN5kA29jisFGQwcttbQKsRuv5XOAsyG
         KXb+UjrQjtokreBeh2xZBLHYGA/r0EECqLqwIRyhXiLT6inECtKywLSDS9r4FRFcAS
         7b6qJuLWLuvIg==
Date:   Tue, 31 Jul 2018 10:39:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: linux-next: build warning after merge of the pm tree
Message-ID: <20180731103923.47c7c294@canb.auug.org.au>
In-Reply-To: <20180730072445.kt2yxxifx4i7y3fr@paasikivi.fi.intel.com>
References: <20180730120053.62732d27@canb.auug.org.au>
        <20180730072445.kt2yxxifx4i7y3fr@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cIUv3ou4LxH=jOVXGf4L2o0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cIUv3ou4LxH=jOVXGf4L2o0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 30 Jul 2018 10:24:45 +0300 Sakari Ailus <sakari.ailus@linux.intel.c=
om> wrote:
>
> On Mon, Jul 30, 2018 at 12:00:53PM +1000, Stephen Rothwell wrote:
> >=20
> > After merging the pm tree, today's linux-next build (x86_64 allmodconfi=
g)
> > produced this warning:
> >=20
> > drivers/media/i2c/mt9v111.c: In function 'mt9v111_set_format':
> > drivers/media/i2c/mt9v111.c:887:15: warning: 'idx' may be used uninitia=
lized in this function [-Wmaybe-uninitialized]
> >   unsigned int idx;
> >                ^~~
> >=20
> > Introduced by commit
> >=20
> >   aab7ed1c3927 ("media: i2c: Add driver for Aptina MT9V111")
> >=20
> > Looks like a false positive, but not something that gcc can easily see.=
 =20
>=20
> This must be coming from a new driver merged to media tree recently. Than=
ks
> for reporting this.

Yeah, sorry, process failure.  This should have been reported against
the v4l-dvb tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/cIUv3ou4LxH=jOVXGf4L2o0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltfr7sACgkQAVBC80lX
0GzvLgf/bhtKo4+1OmwV+KOKis2Z4fwwj0KbkV5/cEn1mQnDN+5RBwAZjPjIV75Y
/SWpPRh/B9riwAjZ3geVRkky7mf/x7yoBxVafM9tdAV1+DjPO645rYQZ1jmGYxbG
qEN/p1NXyE7bkw9CLLPtt6pfr8ImMNj0ugtODNZpgkfbXG7uk/60z06HIXu36Vdv
vE4nKWmRi8YdJFHWn+6sjshRVG4aiYAjRgWubGxwuRuHBcvh1xEI2C/ud0kg7ZVm
MV1STUnfjDtUFT/NlrCZT+dinQ5TSy9xIese/GXnvoMAVglSPlCe1+i3T63CHVbH
nhVxoHWGLZb9lZ+lz5PW0uPT6w+WYQ==
=po4R
-----END PGP SIGNATURE-----

--Sig_/cIUv3ou4LxH=jOVXGf4L2o0--
