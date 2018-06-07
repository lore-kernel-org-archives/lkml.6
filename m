Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Myl1HUNgGVs5OgAAmS7hNA
	; Thu, 07 Jun 2018 16:42:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F2A44608BA; Thu,  7 Jun 2018 16:42:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 565F8601B4;
	Thu,  7 Jun 2018 16:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 565F8601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeFGQmb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:42:31 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:21456 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932714AbeFGQma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:42:30 -0400
Received: from tock (unknown [37.48.92.129])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 6C52619F5C9;
        Thu,  7 Jun 2018 18:42:01 +0200 (CEST)
Date: Thu, 7 Jun 2018 18:41:55 +0200
From: Alban <albeu@free.fr>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Aban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode
 for the cells list
Message-ID: <20180607184155.6da38a01@tock>
In-Reply-To: <d30656d6-f17e-6ed0-251f-2b59d02cd202@linaro.org>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-2-git-send-email-albeu@free.fr>
        <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
        <20180417165420.423a691b@avionic-0020>
        <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
        <20180417180040.04f53495@avionic-0020>
        <20180418134119.2e587621@avionic-0020>
        <9f7d2987-b33e-79b5-ae58-2985fd7334e4@linaro.org>
        <20180418143243.3c23493c@avionic-0020>
        <e34619a4-e9b6-9945-a1cc-a3680aac6819@linaro.org>
        <20180418153440.187ed16e@avionic-0020>
        <d30656d6-f17e-6ed0-251f-2b59d02cd202@linaro.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9Ob2lgq1f9qUa+6V9nvLT5a"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9Ob2lgq1f9qUa+6V9nvLT5a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 1 May 2018 17:49:03 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 18/04/18 14:34, Alban wrote:
> > On Wed, 18 Apr 2018 13:53:56 +0100
> > Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> >  =20
> >> On 18/04/18 13:32, Alban wrote: =20
> >>>> I was also suggesting you to use nvmem-cell subnode, but make it a
> >>>> proper nvmem provider device, rather than reusing its parent device.
> >>>>
> >>>> You would end up some thing like this in dt.
> >>>>
> >>>> flash@0 {
> >>>> 	#address-cells =3D <1>;
> >>>> 	#size-cells =3D <1>;
> >>>> 	compatible =3D "s25sl064a";
> >>>> 	reg =3D <0>;
> >>>>
> >>>> 	nvmem-cells {
> >>>> 		compatible =3D "mtd-nvmem";
> >>>> 		#address-cells =3D <1>;
> >>>> 		#size-cells =3D <1>;
> >>>>
> >>>> 		calibration: calib@404 {
> >>>> 			reg =3D <0x404 0x10>;
> >>>> 		};
> >>>> 	};
> >>>> }; =20
> >>> But the root cause is in the nvmem binding, this conflict could exist=
s =20
> >> No, the root cause is because of passing wrong device instance to nvmem
> >> core. And trying to workaround is the actual issue. =20
> >=20
> > The data is stored on the MTD, so the nvmem provider is the MTD device.
> > I don't think it is a good idea to have a virtual device in the DT to
> > accommodate the nvmem API.
> >  =20
> Yep, I agree! this is same issue if we make nvmem-cells a child of nvmem=
=20
> provider too.
>=20
> However, I would like to see this moving forward.
>=20
> I can think of one possible solution here, which is, adding=20
> "nvmem-mtd-cell" or "nvmem-cell" compatible string to each cell.

I would definitely use "nvmem-cell", from the binding point of view it
doesn't matter what the underlaying storage is.

> The problem you mentioned regarding #address-cells and #size-cells with=20
> provider need to be addressed in nvmem core.
>=20
> Currently nvmem core only support offsets of 32 bits, if you are=20
> expecting a 64 bit offsets then we should add that as a feature to nvmem=
=20
> core.
>=20
> nvmem core as it is today should work fine with 32 bit offsets for mtd=20
> cases.

That's not what I meant, 32 bit should be more that enough for now.
What I meant is that if a binding already has children nodes using
unit-address, then we would end up with two different uses of the same
"address space".

> what do you think?

AFAIU the only thing that we disagree on now is if the nodes
representing the cells should be direct children of the provider
or in a dedicated subnode. For the MTD case both solution would solve
the binding clash. I would really appreciate if the DT people could
chip in so that we can settle this and get the MTD support merged.

Alban

--Sig_/9Ob2lgq1f9qUa+6V9nvLT5a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbGWBUAAoJEHSUmkuduC28HyQP/37V7eIFgwwnql9bvJM/LoQ+
knLG6mpQ1AciuobA4k0xtid3zQk6M5EaU/fUMak72hvlLteUWEALn85ahNS1LDFN
T19+lm97gtNywFzkD4OF1tQheLPdfMD/0N2pV3E2JNp5heDwgKp8HroCtVCnQ73S
SaFZJNv2GmOHAeNkaHlyvVT+4P/HhQgL4nRQ0PL/7R4w36d4Jbn0Xo78GnE9whY0
YEZpc4LWQV7NxQFUZJvNjIoWN4CKp0Snb9XQbs3LEDidtwIo8eydt424ourL7X5U
csf3naDC5oNumYgV5rqTjbLKVsm663LY6LkdnaxtNZU44EdlQWIYhNzay/kKmkc3
hXND24daaamwT61nujRLkQwdWESKaHvfbxAmw9RpOueagA0nMuKynInDv3Dx5PIq
Ha8aQtdUP947HSARUDiwIrbdFJmdQsgUJfKsVAZX6FC8WBA2xPKtZ+9Vq8+HeiFI
PewOuBWnZ8DhsmY9NuO+CYRvQVX61qQBwbrVmRvSFSRdeJ4ubMdqasVr/u5jPz9e
8+CTAQKTRKSIloa5upcuI2oQG+PtzMzcVoykpmroq3kzhKfJ89gEKGdM+zREtSjE
chPWiMaiv4amq+B3Asd33YuGA0KIFVW807hQJQa09E/sAVHIOsKbxiqbmRKx3ObH
x1C64XnN3OSZYbx2qH1q
=c3AR
-----END PGP SIGNATURE-----

--Sig_/9Ob2lgq1f9qUa+6V9nvLT5a--
