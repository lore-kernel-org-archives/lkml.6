Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1367C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D4D2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="TjYsNLBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbfAaQlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:41:49 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:43582 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388489AbfAaQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C3amELg1Ujiw7elcsQ+TuZ1AZWH0mBbM9WqhTmkZo6Q=; b=TjYsNLBLB/oGj32yqL7L59/Xq
        fD0//02sfr+A5Ej3KV1T1jr6IrTDZYZHUWkwF6kMrYdRX7j2T/bGiTzlE03bMkqWCX5qyA27mis4P
        eWRKjGJvFcGJyCTCiM3XrXmOvGM8jZo4vip+j3nNW/3mMZiCLe73Hf0IZv615eabda/Rg=;
Received: from [77.247.85.71] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpFPD-00009K-5T; Thu, 31 Jan 2019 17:41:41 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpFOv-0001kK-36; Thu, 31 Jan 2019 17:41:17 +0100
Date:   Thu, 31 Jan 2019 17:41:03 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v2] arm: dts: gta04: add gps support
Message-ID: <20190131174015.544a00f3@kemnade.info>
In-Reply-To: <20190130090434.GM3691@localhost>
References: <20190129073843.14979-1-andreas@kemnade.info>
        <20190130090434.GM3691@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vgmloT8=KlyDOyf+POR3ria"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vgmloT8=KlyDOyf+POR3ria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jan 2019 10:04:34 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Tue, Jan 29, 2019 at 08:38:43AM +0100, Andreas Kemnade wrote:
> > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > which one is mounted so use the compatibility entry for w2sg0004
> > for all which will work for both.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> > - some s/gps/gnss/
> > - not added vcc-supply because the regulator is not modelled
> >   in dts at all =20
>=20
> I strongly suggest not sending revised patches before people have a
> chance to comment on your previous version and resolve any issues that
> may have been raised.

for technical check there was already some small team review ahead,
so I expect only formality issues and not something complicated and
was not mentally prepared for more discussion.

At that point I had the impression that I am not allowed to have
such driverless things into dtb, so I had the impression that I have
to follow two conflicting rules at the same time.
That leads to the impression that I worked a long way into a dead end
which made me quite angry so I was not as contructive as I should be.

Regards,
Andreas

--Sig_/vgmloT8=KlyDOyf+POR3ria
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxTJR8ACgkQl4jFM1s/
ye/4WxAApY3EPVu2dFHryhqT6YYsMDk+N6f2ERAo9HcBNIbOPGiz6FshPM7OygZU
cpK/MUzxU/9Arar1F5zn31BfmQhsFlAEfyk5YLTq1k6qkCwkKcOQfeQT5eOvTh5w
qJLJKGlQVX3nUz6gbANxUsRS9zhPrfbYjuI/lkEesOANXl95wBgTxouQb1TSK3Qz
csKxCMXYAe2xEfaUcaC/bTPMSuxBCdra3O8o4m1rbMwc4cOihSUcuisKSkhv3402
IBK3S4ctKd5UCaxmaEum90rjGkQ6l56EjJVrKC2L9IyrqA5pv9aet7ei4fS59NHg
ciF9gjtw3eeqVM52byHQv5pv+enQE+y74wVuOr1BTUVHe3Uon8Io7JLWJ0aaSe3w
ob3L66BYsqaR/Ub4J/TM4PGDXwTHNhpCGx2XayyDuGqPqiMWL40A8NEWSYQAfem8
BUKT18OrjmUZjKu5vdqm3nzMqL/7L5Cm0jUGl1FWBPajNZbTBaSRSQxhjDzJTSuu
B1vwirWlPelzFwtpy1cfcyVt5z8LVInQU3518EJJRwDohDuTkpKCjsO9SVT13FRw
8t3/jAk9paA2SIOPZtRJvhHw0pUDsvMqoRQr3qqcamp3GAC/2MpzgDWDjjMN/7US
3M0i/neoH3f1gP8uIppD7ScNlwLgTOHtz0w5bhPV3rvZF2ZGr+0=
=2Hfv
-----END PGP SIGNATURE-----

--Sig_/vgmloT8=KlyDOyf+POR3ria--
