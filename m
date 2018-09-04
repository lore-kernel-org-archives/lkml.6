Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396C3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1B22077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1B22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeIDO2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:28:41 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38373 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeIDO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:28:41 -0400
X-Greylist: delayed 1820 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 10:28:40 EDT
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 848D024002B;
        Tue,  4 Sep 2018 10:04:07 +0000 (UTC)
Date:   Tue, 4 Sep 2018 12:04:00 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove sh_mobile_ceu_camera from arch/sh
Message-ID: <20180904100400.GA28160@w540>
References: <1527525431-22852-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180831122558.zv7537uyfw5pcnqj@valkosipuli.retiisi.org.uk>
 <20180903072234.GA4116@w540>
 <20180904093358.GK20333@w540>
 <20180904094319.om6qp5rc3k66ukrd@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20180904094319.om6qp5rc3k66ukrd@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Sakari,

On Tue, Sep 04, 2018 at 12:43:19PM +0300, Sakari Ailus wrote:
> On Tue, Sep 04, 2018 at 11:33:58AM +0200, jacopo mondi wrote:
> > Hi again Sakari,
> >    sorry, I'm confusing you
> >
> > On Mon, Sep 03, 2018 at 09:22:34AM +0200, jacopo mondi wrote:
> > > Hi Sakari,
> > >
> > > On Fri, Aug 31, 2018 at 03:25:58PM +0300, Sakari Ailus wrote:
> > > > Hi Jacopo,
> > > >
> > > > On Mon, May 28, 2018 at 06:37:06PM +0200, Jacopo Mondi wrote:
> > > > > Hello,
> > > > >     this series removes dependencies on the soc_camera based
> > > > > sh_mobile_ceu_camera driver from 3 board files in arch/sh and from one
> > > > > sensor driver used by one of those boards.
> > > > >
> > > > > Hans, this means there are no more user of the soc_camera framework that I know
> > > > > of in Linux, and I guess we can now plan of to remove that framework.
> > > >
> > > > What's the status of this set? I think it'd be nice to get it in; the CEU
> > > > driver is the last using SoC camera framework.
> > > >
> >
> > The series went in in the media tree in late June and I now see it in
> > v4.19-rc2.
>
> Oh; I missed this entirely. I thought it'd be merge later as there were
> comments. Anyway it's good it's in. :-)
>
> >
> > Sorry for the confusion.
> >
> > The other soc_camera series which is pending for approval is the one
> > removing dependencies on the framework from some SH defconfigs:
> > https://lkml.org/lkml/2018/7/4/323
>
> Given this series is in the current Linus's tree, that seems like a
> no-brainer now.

Why I don't see it? (just pulled v4.19-rc2).
The only patch that has been collected from that series is
"media: sh: migor: Remove stale soc_camera include"

I don't see the defconfig related ones though.

>
> >
> > Mauro was exitant to take this one through the media tree, and he's
> > probably right SH maintainers should at least ack the series. So far,
> > I haven't heard from them.
> >
> > I'll try to rebase it on latest version and re-send.
>
> If you have further changes, please make them in separate patches.
>
> --
> Sakari Ailus
> e-mail: sakari.ailus@iki.fi

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbjliQAAoJEHI0Bo8WoVY8GOEP/31Mg/WFqloSaLBUrZa/UcGA
19/Ewd+7Djfjgc0+r6gqFtHyvARY7lhKVK++5WcZT9GBX1jRXv0tfoCzm9KoY6Rh
MwhJnwYRTS5+hQfRVD7PAk2g89SptrTBbos2uwBjxtCLSErg8W3luS42KwsMjCfk
CEYf7fbIYKkoa4YaLH08yhI3rjbvLUJhb0xAweqXf0hRDwQVgMHn0hkBJTwJIBsT
WgeGa+xfKyfV7x0sY41mUea6R2IVl3zdHm61QPTgEyYMJdv9KnTt4qoe1JOAF5pK
2TykLPQ5L6r6LwBLPAdWtBJHHiqr744qcdEQyeQIerwtEmYJyASy4NSrDFzBD4Rr
qsRLUqNZqvgN5fBdT/BVBsiW57V1dE62AeT5QamZBrmujV/uoTWjzAy84Bv+5pSm
ieBVR0KVITWWwWTaS5LDihLg8JtTTJeyXNRQjL48P8eZipdqeakooLn3z0FCclGM
nU/DEm/qre4ZnPn4ajBOGDptJWJHOPWAQHbEH84hB/S2cRwHlKcf64yPy0B3oynw
aaLch46iYKMiaL1ES2VnmW+R92VC7F80Euc/z9zis2nKTypckZd1exztJslQN23+
B+rCB1z+wDnXdzZq6PWtEl0CHC4s8Z3WwA1S1A/lUGqHb9jUbsTNei+H+5rxMPxI
ybHs9khWWN7CIXX0Lx/A
=CrMl
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
