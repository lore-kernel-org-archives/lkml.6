Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645B8C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3707F20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3707F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeJBOxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:53:36 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:45210 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeJBOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:53:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42PX1035Ryz1qvpF;
        Tue,  2 Oct 2018 10:11:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42PX102Hmnz1qqkd;
        Tue,  2 Oct 2018 10:11:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id VgmUbbEoiUci; Tue,  2 Oct 2018 10:11:31 +0200 (CEST)
X-Auth-Info: Shdn0CKIJZlZEYxlZzWEBWjGLBabueXlwO50ELbcVvM=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  2 Oct 2018 10:11:31 +0200 (CEST)
Date:   Tue, 2 Oct 2018 10:11:20 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spidev: Enable the Liebherr's BK4 board to work with
 spidev driver
Message-ID: <20181002101120.0f92f296@jawa>
In-Reply-To: <20181001142219.GB19099@sirena.org.uk>
References: <20180927223152.24990-1-lukma@denx.de>
        <47e37a54-6df6-47c0-b38b-ad35e9bd4ce4@cesnet.cz>
        <20181001142219.GB19099@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_u9a=FNUjzZxxdVoNt_xTQk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_u9a=FNUjzZxxdVoNt_xTQk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> On Mon, Oct 01, 2018 at 04:20:32PM +0200, Jan Kundr=C3=A1t wrote:
>=20
> > Hi Lukasz,
> > I tried submitting a similar patch for another devicem but got no
> > reaction [1]. In the meanwhile, there has been another proposal [2]
> > which moves =20
>=20
> As documented in SubmittingPatches please send patches to the=20
> maintainers for the code you would like to change.=20

I'm using the ./scripts/get_maintainer.py script to obtain list of
relevant people.

Moreover, you may want to look for gitk -- <patch to your modified
file> and add developers, who did some remarkable work in that file.

Also git-blame helps.

And another issue - maitainers are very often very busy (as
maintaining/reviewing is not their main occupation).
We would like to have a prompt response/review, but it is acceptable to
wait week or two for reply....=20


Please also document in the ./Documentation/devicetree the introduced
compatible -> there are some examples (ge,ahca) in the misc directory.

> The normal kernel
> workflow is that people apply patches from their inboxes, if they
> aren't copied they are likely to not see the patch at all and it is
> much more difficult to apply patches.




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/_u9a=FNUjzZxxdVoNt_xTQk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAluzKCkACgkQAR8vZIA0
zr3AiwgAqda1Vt18KLTmjRn0zSmAmL8YKr/YvwZukHlAbjTFMGtqSBEcZogkVFfw
Vyu+shvI441kvcCMPFQpEZZlEBVUuSvHA64UgKKfs6mOlL8Kj2T1HPRfExTn0dnm
wGFyOSgP7JNW3a2h6/dmebO+Cl+Z15XXAcvEezK+WN16NPNmH3DX7ylprCpEi3WO
zhX0sP/f5vl2BFE99HhbPRXAcECMNEuAD89kKZHSl+Hnx9FlQhEMzwLvkoKgSdyB
JPyAfFcJbMzloZWnqQxTW8/A0U+uCmU7OtlIgo7nVNXNjCIyc+KjHHHrU27irxb6
q6y0EemSXHv/mV0Apk6p0m3TR97CEw==
=lchy
-----END PGP SIGNATURE-----

--Sig_/_u9a=FNUjzZxxdVoNt_xTQk--
