Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88456C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B91219A3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WeGcIs1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B91219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeHFBg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 21:36:57 -0400
Received: from ozlabs.org ([203.11.71.1]:57439 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbeHFBg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 21:36:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kH88493zz9s0n;
        Mon,  6 Aug 2018 09:30:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533511833;
        bh=aH5sklbpyNQs1yKxpU9GfRfUFEPmA8Vlg1xIZOWSo98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WeGcIs1GU23gwjitMnzBI8uFadeHlSL5GCy2xM3fpqN5Kk7EhMm/Fk8Uql3lRZF3v
         4ezpoFqYZuDceyrm+kitMRzMT0LaLQCIL1xJ3NdxPfe+PYztKHtJ3JucDQqx88ArNW
         33TlMUgwsOiOMlVQid9jHklYy+920PwmHfUWx/JZ50LYHwEeyILUk6VDnWFijf2gBe
         X3KAT/GMq+EmOemtQ/S8CVK1yNByo5jaJyZfN8SsMHBGLCc6p/MLJln0fyFeG5aEQq
         V6GzOJ+IFf3bEMgKV/gOIbKxUeJvwThCOZ3AA+Hwk2X/Mmz89BLIzbVBJgpTiY+tB1
         +s21zs22ddKYw==
Date:   Mon, 6 Aug 2018 09:30:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Samuel Morris <samorris@lexmark.com>, Tejun Heo <tj@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-omap@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org,
        Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
Message-ID: <20180806093015.6099ef5c@canb.auug.org.au>
In-Reply-To: <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
        <20180620102904.GC112168@atomide.com>
        <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
        <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
        <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
        <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
        <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
        <20180702093243.GO112168@atomide.com>
        <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0YK+L5KAgQs0umX0hv0jfjt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0YK+L5KAgQs0umX0hv0jfjt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Mon, 2 Jul 2018 09:31:56 -0400 Samuel Morris <samorris@lexmark.com> wrot=
e:
>
> On Mon, Jul 2, 2018 at 5:32 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > * Roger Quadros <rogerq@ti.com> [180621 14:56]: =20
> >> On 21/06/18 17:31, Samuel Morris wrote: =20
> >> > On Thu, Jun 21, 2018 at 3:58 AM, Roger Quadros <rogerq@ti.com> wrote=
: =20
> >> >> +Rafael
> >> >>
> >> >> On 20/06/18 18:30, Samuel Morris wrote: =20
> >> >>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wro=
te: =20
> >> >>>> Tony,
> >> >>>>
> >> >>>> On 20/06/18 13:29, Tony Lindgren wrote: =20
> >> >>>>> Hi,
> >> >>>>>
> >> >>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]: =20
> >> >>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle boa=
rd x15. =20
> >> >>>>>
> >> >>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow=
 disabling of
> >> >>>>> hotplug to save power").
> >> >>>>>
> >> >>>>> Reverting the patch makes things work again. Any ideas what
> >> >>>>> might be going wrong here? Things clearly idle but then there
> >> >>>>> seems to be some register access with clocks disabled. =20
> >
> > So this issue is still happening as of next-20180702. Can you guys
> > please revert the commit above while working on a better solution? =20
>=20
> That's fine with me. I'm not very familiar with the process here, does
> this require anything on my end? And would that require the
> accompanying patch to be reverted: "ata: ahci: rpm_put port on
> port_stop to match rpm_get in port_start"? There shouldn't be any
> problem leaving that one in, but I just want to know before submitting
> my next patch set.

I am still reverting that commit from linux-next myself.  Has this
issue been fixed some other way, or is it still ongoing?

--=20
Cheers,
Stephen Rothwell

--Sig_/0YK+L5KAgQs0umX0hv0jfjt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltniIcACgkQAVBC80lX
0Gy+uwgAjx18AusCZRh5RpDhTpXN2yvL7JAiPuWJVdZAb/EYFEAB/EP+oaNaKSla
xnFifSNuzIY//X39E3Rim6NMUdWSA9F6CqRGQMhOgFKtXQPzCytDuhVCQ7YYirYw
V5jYFmZLH0ZCgnP2fLX792gjBdIFUi/MYyLv8LVf2nM29dDX0+WqKqfIZn8BopEU
M5HYs5p2aD90gtyQtzWuz1y3zRyLYsBgY4HFdj+4ZAnuCfBFMFmBWCfHuZgqjSd+
ClFk7KI6Pf0hICdxn9yFF7mwgg6d2u/bebaqFhAr8re0RXiBZLEgs32opSpyeUig
0vyso/SsPqx1XvhU/j+6sWyceMeUdQ==
=37UH
-----END PGP SIGNATURE-----

--Sig_/0YK+L5KAgQs0umX0hv0jfjt--
