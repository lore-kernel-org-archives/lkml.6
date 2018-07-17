Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D182AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CA720877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dj2shwCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CA720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbeGQIbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:31:51 -0400
Received: from ozlabs.org ([203.11.71.1]:53243 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbeGQIbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:31:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VCPn2n3Bz9s3Z;
        Tue, 17 Jul 2018 18:00:29 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531814429;
        bh=daZ54g91/iMPDT/zhVsecLzFHsZfT86im8xT1SGKW5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dj2shwCueH7NPQh7n7JILKDV66n2loMrBBgoucsbKi2eSiH3IiuO2JYG7rXMGgnDq
         IY4ac20hyIincSQxAyaG5nIHvb1R7Ck1L4oMMAFiMtRhVGbE45CVCvqpIwhzursERT
         3mr1tewWwKlvcHbJH/rkVb3q6ax/rxFvon5OAS4ZuZySJ8nTfsGcGiV6G2g6uks3x/
         pibpFfpaEoa6vA4V6JQ2Ucnkox6zImCn8GuCBTAd5bxHJ9kWG79+Pq8RKt8n/32G2o
         mAkqnlX444Qb8VrRt+24AYtcgTYOBAoBgSJuny8g09T2tZ3g+K4QTWQF0l3cmpTwal
         yK517Q38opyGg==
Date:   Tue, 17 Jul 2018 18:00:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Tejun Heo <tj@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-omap@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org,
        Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Samuel Morris <samorris@lexmark.com>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
Message-ID: <20180717180028.0ba098f6@canb.auug.org.au>
In-Reply-To: <20180717060808.GW99251@atomide.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
        <20180620102904.GC112168@atomide.com>
        <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
        <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
        <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
        <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
        <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
        <20180702093243.GO112168@atomide.com>
        <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
        <20180717060808.GW99251@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Hm7invgqnGXP7kvcNCVH6+o"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hm7invgqnGXP7kvcNCVH6+o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Mon, 16 Jul 2018 23:08:08 -0700 Tony Lindgren <tony@atomide.com> wrote:
>
> The following regression is still pending in next, see below.
>=20
> * Samuel Morris <samorris@lexmark.com> [180702 13:35]:
> > On Mon, Jul 2, 2018 at 5:32 AM, Tony Lindgren <tony@atomide.com> wrote:=
 =20
> > > Hi,
> > >
> > > * Roger Quadros <rogerq@ti.com> [180621 14:56]: =20
> > >> On 21/06/18 17:31, Samuel Morris wrote: =20
> > >> > On Thu, Jun 21, 2018 at 3:58 AM, Roger Quadros <rogerq@ti.com> wro=
te: =20
> > >> >> +Rafael
> > >> >>
> > >> >> On 20/06/18 18:30, Samuel Morris wrote: =20
> > >> >>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> w=
rote: =20
> > >> >>>> Tony,
> > >> >>>>
> > >> >>>> On 20/06/18 13:29, Tony Lindgren wrote: =20
> > >> >>>>> Hi,
> > >> >>>>>
> > >> >>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]: =
=20
> > >> >>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle b=
oard x15. =20
> > >> >>>>>
> > >> >>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: all=
ow disabling of
> > >> >>>>> hotplug to save power").
> > >> >>>>>
> > >> >>>>> Reverting the patch makes things work again. Any ideas what
> > >> >>>>> might be going wrong here? Things clearly idle but then there
> > >> >>>>> seems to be some register access with clocks disabled. =20
> > >
> > > So this issue is still happening as of next-20180702. Can you guys
> > > please revert the commit above while working on a better solution? =20
> >=20
> > That's fine with me. I'm not very familiar with the process here, does
> > this require anything on my end? And would that require the
> > accompanying patch to be reverted: "ata: ahci: rpm_put port on
> > port_stop to match rpm_get in port_start"? There shouldn't be any
> > problem leaving that one in, but I just want to know before submitting
> > my next patch set. =20
>=20
> Well usually the maintainer just reverts the regression causing
> patch in the related branch and that's it.
>=20
> Stephen, can you please revert in next until we hear back from
> Tejun?

OK, I have reverted that commit from today.  Please let me know when the
problem is fixed in the libata tree ...

--=20
Cheers,
Stephen Rothwell

--Sig_/Hm7invgqnGXP7kvcNCVH6+o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltNohwACgkQAVBC80lX
0GzfBQf9Hef9gp4izYBLjKnFS8pOE8SylX5vLn+IxcljOyakrzwV1SLupQVI3+ZL
bmL+xrbu5eY07Bt2xTjw/rkSfU38xxctWOFZiDXVGs1+N5n93LnTpDxbu567HyOK
3Kolafh0l6FcjSYUEuyENFeFqbMhPYRIFuCwwtjxPPcTzMH/BNinxfCAELvJO2E8
LZZ9kKiG0KWl4QkG7LdS8KYBsn9OmKQ8UGS7K7MHdxMKID+I8HVJdG52Cq+aVdgg
8ntbHhRQChOHQRSLdkOKP6a7Ng9fe5sff9yDwkeBuw59l51i1N5RRzrc1pkWOmlo
oVt5Y2BcaGIFor/0vKAj1Q3bJEJA/w==
=HbdJ
-----END PGP SIGNATURE-----

--Sig_/Hm7invgqnGXP7kvcNCVH6+o--
