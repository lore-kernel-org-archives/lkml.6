Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D88C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D5F241C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gx3b9gLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D5F241C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeGECmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:42:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbeGECmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2R2p8w3tHi/CuVUkRJw8A4e0D8PWViqATYvFRZYaKh4=; b=Gx3b9gLzXg6omXIGQeguzajuN
        gGTt1ZfSvWIZ7ntugWXi4gMUV/54Xh5JjJwPDBoHjY8r9VLgIk3DekfYuUvwzj0izmCxnQytypjBw
        HloJFBXb02UK2Yl3mCKITVYOVr09s6c8xDhFWmn40XOdLRaSN/0UFlaZ81bMWcXe+feBDS7ZkADO8
        jKJdspW2j8m3wQj3Whe9kC5nI+WtkDTVuTTsCIiXJ+IJm0ge/FnWfJQI1P97NdNz+3IlQm/jYNP8m
        EJD7AUXBlRP2m3+8VvUR9asyjSfH9JcbCt0x339T4a0yqZwtNi35iyrF0AiSeAqQ664YC0rVDi2gP
        +raA1KC3A==;
Received: from 179.176.112.175.dynamic.adsl.gvt.net.br ([179.176.112.175] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fauEL-0003SQ-3T; Thu, 05 Jul 2018 02:42:49 +0000
Date:   Wed, 4 Jul 2018 23:42:44 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
Cc:     <linux-media@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] media: dvb-frontends: add Socionext SC1501A ISDB-S/T
 demodulator driver
Message-ID: <20180704234244.32d20f6b@coco.lan>
In-Reply-To: <000401d41403$b33db490$19b91db0$@socionext.com>
References: <20180621031748.21703-1-suzuki.katsuhiro@socionext.com>
        <20180704135657.3fd607cb@coco.lan>
        <000401d41403$b33db490$19b91db0$@socionext.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 5 Jul 2018 10:58:42 +0900
"Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com> escreveu:

> Hi Mauro,
>=20
> > -----Original Message-----
> > From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > Sent: Thursday, July 5, 2018 1:58 AM
> > To: Suzuki, Katsuhiro/=E9=88=B4=E6=9C=A8 =E5=8B=9D=E5=8D=9A <suzuki.kat=
suhiro@socionext.com>
> > Cc: linux-media@vger.kernel.org; Masami Hiramatsu =20
> <masami.hiramatsu@linaro.org>;
> > Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infrade=
ad.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] media: dvb-frontends: add Socionext SC1501A ISD=
B-S/T
> > demodulator driver
> >=20
> > Hi Katsuhiro-san,
> >=20
> > Em Thu, 21 Jun 2018 12:17:48 +0900
> > Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com> escreveu:
> >  =20
> > > This patch adds a frontend driver for the Socionext SC1501A series
> > > and Socionext MN88443x ISDB-S/T demodulators. =20
> >=20
> > Sorry for taking so long to review it. We're missing a sub-maintainer
> > for DVB, with would otherwise speed up reviews of DVB patches. =20
>=20
> No problem, thank you for reviewing! I appreciate it.
>=20
>=20
> > >
> > > The maximum and minimum frequency of Socionext SC1501A comes from
> > > ISDB-S and ISDB-T so frequency range is the following:
> > >   - ISDB-S (BS/CS110 IF frequency in kHz, Local freq 10.678GHz)
> > >     - Min: BS-1: 1032000 =3D> 1032.23MHz
> > >     - Max: ND24: 2701000 =3D> 2070.25MHz
> > >   - ISDB-T (in Hz)
> > >     - Min: ch13: 470000000 =3D> 470.357857MHz
> > >     - Max: ch62: 770000000 =3D> 769.927857MHz =20
> >=20
> > There is actually an error on that part of the driver. Right now,
> > the DVB core expects Satellite frequencies (DVB-S, ISDB-S, ...)
> > in kHz. For all other delivery systems, it is in Hz.
> >=20
> > It is this way due to historic reasons. While it won't be hard to
> > change the core, that would require to touch all Satellite drivers.
> >=20
> > As there are very few frontend drivers that accept both Satellite
> > and Terrestrial standards, what we do, instead, is to setup
> > two frontends. See, for example, drivers/media/dvb-frontends/helene.c.
> >  =20
>=20
> Thank you for describing it. I understand our device is rare case, and=20
> the reason why Helene has Terrestrial and Satellite structures.
>=20
> I'm using MN884434 device that has 2 cores. I want to setup DVB adapter=20
> devices (/dev/dvb/adapter0/*) for our frontend system as the following:
>=20
>   - adapter0: for core 0, ISDB-T, ISDB-S
>   - adapter1: for core 1, ISDB-T, ISDB-S

Yeah, that is what it was supposed to work, if the core was ready for it.

> But it seems one DVB adapter device support only ISDB-T or only ISDB-S=20
> if I divide structures. So I define the adapters as the following:
>=20
>   - adapter0: for core 0, ISDB-T
>   - adapter1: for core 0, ISDB-S
>   - adapter2: for core 1, ISDB-T
>   - adapter3: for core 1, ISDB-S
>=20
> Is this correct?

That's the way the current driver with uses helene does.

>=20
>=20
> > ... =20
> > > +static const struct dvb_frontend_ops sc1501a_ops =3D {
> > > +	.delsys =3D { SYS_ISDBS, SYS_ISDBT },
> > > +	.info =3D {
> > > +		.name          =3D "Socionext SC1501A",
> > > +		.frequency_min =3D 1032000,
> > > +		.frequency_max =3D 770000000,
> > > +		.caps =3D FE_CAN_INVERSION_AUTO | FE_CAN_FEC_AUTO |
> > > +			FE_CAN_QAM_AUTO | FE_CAN_TRANSMISSION_MODE_AUTO |
> > > +			FE_CAN_GUARD_INTERVAL_AUTO | FE_CAN_HIERARCHY_AUTO,
> > > +	},
> > > +
> > > +	.sleep                   =3D sc1501a_sleep,
> > > +	.set_frontend            =3D sc1501a_set_frontend,
> > > +	.get_tune_settings       =3D sc1501a_get_tune_settings,
> > > +	.read_status             =3D sc1501a_read_status,
> > > +}; =20
> >=20
> > In other words, you'll need to declare two structs here, one for ISDB-T
> > and another one for ISDB-S.
> >  =20
>=20
> OK, I'm going to divide this structure for Terrestrial and Satellite. And
> add attach functions same as Helene driver.
>=20
> I'll send v4 patch.

I ended by writing two patches that should be solving the issues
inside the core. With them[1], it will work the way you want.

There is a catch: you'll need to convert Helene to have a single
entry and be sure that the driver that currently uses it (netup_unidvb)
will keep working. I guess I have one such hardware here for testing.

[1] after tested/reviewed - I didn't test them yet. Feel free to test.

So, please look at the two patches I sent today to the mailing list.

(not sure why, they're taking a long time to arrive there - perhaps
vger has some issues).

I added them on this tree:
	https://git.linuxtv.org/mchehab/experimental.git/log/?h=3Ddvb_freq_hz

it is the last two patches there:
	- https://git.linuxtv.org/mchehab/experimental.git/commit/?h=3Ddvb_freq_hz=
&id=3Db3d63a8f038d136b26692bc3a14554960e767f4a
	- https://git.linuxtv.org/mchehab/experimental.git/commit/?h=3Ddvb_freq_hz=
&id=3D2a369e8faf3b277baff4026371f298e95c84fbb2

I'm not sure if all applications will do the right thing, though, as
it will depend  if they query the capabilities before or after switching
to a different delivery system. If it get caps before and store them
in Hz, apps will work, but tests are required.

>=20
>=20
> > Yeah, I know that this sucks. If you are in the mood of touching the
> > DVB core, I'm willing to consider a patch that would fix this, provided
> > that it won't break backward compatibility with other drivers (or would
> > convert the other satellite drivers to use the new way).
> >=20
> > Thanks,
> > Mauro =20
>=20
> Hmm, I don't know the details of DVB core, I try to investigate it.
>=20
>=20
> Regards,
> --
> Katsuhiro Suzuki
>=20
>=20
>=20



Thanks,
Mauro
