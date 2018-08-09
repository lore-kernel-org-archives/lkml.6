Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AEEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752DA21E23
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyalIYB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752DA21E23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeHIQlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:41:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39759 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbeHIQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:41:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so456709wmq.4;
        Thu, 09 Aug 2018 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FSgl1cBHjo24JivBOZRLQX/i19bdlEZio/yvyhyKW3c=;
        b=OyalIYB/+W1kruVFmuinh4IgrqRdnhwyJ0nOmbitNtXqzfzppiv89Brfxbtx0wIntn
         UZciAC9OzF7jRq1CfhKaA8JpF/Igpb5pQ3tCdUnUw8iyAd5YgFVMhYEhlVVKDgPgsx7+
         eNgriNfFwkpUhS+2tkPGky/KiQzKb43dvJGkABFWLSHIRLvjtlfFqrmp3vWiwnDuXNNw
         E/Y7m/UKT8YvlhLGVAn5sU4TIQhYUzsIFrpvYuACs+fbCQBfhxBCdKniPDTL5pOPFywY
         SITcgjWt5SFUYnLwqEpdaDPrPVoMF+QRDyYGBMnFssrw2qYxXi54zuXDGA0jTUTr9qfX
         qe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FSgl1cBHjo24JivBOZRLQX/i19bdlEZio/yvyhyKW3c=;
        b=lX0LDGR4RsbqzflPT3DMyKAWQJX1VNr8MjddcHMEeiKP5S5R2+F0sytOyv9HYtk0M3
         90MfizBedFrxlK43XFp43BaVTO7R157cF7yoqC7ILMxZrD4Q5pOq3ilvYw3b7HnF7Cob
         x4d117jWugGw2ADE/MOJ5h3x+JF8LG3c76qDFjECvUlIFSh+s9eKL1sqMlyH4nP76Iry
         8sVJ+hfVzEjTFtYis1TUjUxCsqnmbrznDe2I70AbBzvUHAJ9vwWsqfvkS6oFG+TPEsk+
         daEX686Z5E56w6OUic+8FFhglp6PeL2pXShOp5Iw4GmMuotZqhhDytyjslPN0H8hMt8F
         5yxQ==
X-Gm-Message-State: AOUpUlHxrZI9qN02zkJp9TL9evv5VFJT8QK+LZ4k75o2bSZ62pWBmKuA
        L0cZS1lIQ9KREBZSDc3yi7TDnTnk
X-Google-Smtp-Source: AA+uWPyV83Sbu1E8ZN64K+LY8WMgzYEAA7UG9mDgDKllZG8c0uLW7eu7VOf4pHQ78uis1ZfMbl8fWQ==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr1859001wme.125.1533824152648;
        Thu, 09 Aug 2018 07:15:52 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id y203-v6sm8829024wmd.1.2018.08.09.07.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 07:15:51 -0700 (PDT)
Date:   Thu, 9 Aug 2018 16:15:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, Kyle Evans <kvans32@gmail.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpu: host1x: Ignore clients initialization failure
Message-ID: <20180809141550.GJ21639@ulmo>
References: <20180801150807.15926-1-digetx@gmail.com>
 <1672653.y032a1rHIh@dimapc>
 <20180809131035.GZ21639@ulmo>
 <3195467.1OBRMfmz8N@dimapc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WdPYQQQ4lIWZ4ZWi"
Content-Disposition: inline
In-Reply-To: <3195467.1OBRMfmz8N@dimapc>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WdPYQQQ4lIWZ4ZWi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 04:46:55PM +0300, Dmitry Osipenko wrote:
> On Thursday, 9 August 2018 16:10:35 MSK Thierry Reding wrote:
> > On Thu, Aug 09, 2018 at 03:53:03PM +0300, Dmitry Osipenko wrote:
> > > On Thursday, 9 August 2018 13:45:41 MSK Thierry Reding wrote:
> > > > On Fri, Aug 03, 2018 at 02:30:47PM +0300, Dmitry Osipenko wrote:
> > > > > On Friday, 3 August 2018 13:50:55 MSK Thierry Reding wrote:
> > > > > > On Wed, Aug 01, 2018 at 06:08:07PM +0300, Dmitry Osipenko wrote:
> > > > > > > From time to time new bugs are popping up, causing some host1x
> > > > > > > client
> > > > > > > to
> > > > > > > fail its initialization. Currently a single clients initializ=
ation
> > > > > > > failure
> > > > > > > causes whole host1x device registration to fail, as a result a
> > > > > > > single
> > > > > > > DRM
> > > > > > > sub-device initialization failure makes whole DRM initializat=
ion
> > > > > > > to
> > > > > > > fail.
> > > > > > > Let's ignore clients initialization failure, as a result disp=
lay
> > > > > > > panel
> > > > > > > lights up even if some DRM clients (say GR2D or VIC) fail to
> > > > > > > initialize.
> > > > > > >=20
> > > > > > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > > > > ---
> > > > > > >=20
> > > > > > >  drivers/gpu/host1x/bus.c | 18 +++++++-----------
> > > > > > >  1 file changed, 7 insertions(+), 11 deletions(-)
> > > > > >=20
> > > > > > This is actually done on purpose. I can't think of a case where=
 we
> > > > > > would
> > > > > > actively like to keep a half-broken DRM device operational. The
> > > > > > errors
> > > > > > that you're talking about should only happen during development,
> > > > >=20
> > > > > [only in a perfect world]
> > > >=20
> > > > gr2d and VIC are fairly deterministic. What are the errors you are
> > > > seeing that cause initialization failure?
> > >=20
> > > Right now there are no specific errors. There is only a known trouble=
 with
> > > the ARM_DMA_USE_IOMMU, but that causes to fail all of the clients.
> > >=20
> > > > Note that it is possible for
> > > > these devices to malfunction even if initialization succeeds. A fai=
lure
> > > > to initialize can only happen if there's something wrong in the dev=
ice
> > > > tree, firmware is missing (in case of VIC) or a regression was
> > > > introduced in some subsystem that causes a failure (maybe deferred =
probe
> > > > or something similar).
> > >=20
> > > A missing firmware is an actual good example. Though can't VIC driver=
 be
> > > changed to load firmware at the time of a its first use by userspace?=
 It
> > > should be very annoying that kernel driver forces you to churn with
> > > initramfs.
> > No, that's not really how firmware loading works. There's no technical
> > barrier to doing it, but it'd be strange. If a device needs firmware to
> > work, it'd be unusual to make it available before you know that it can
> > be used.
> >=20
> > What if the firmware can't be loaded at the time of the first use? How
> > do you report that back to userspace? -ENOENT because the firmware file
> > can't be found? How is userspace to know that this is a problem with
> > firmware loading rather than some other error having to do with the VIC
> > command stream being broken, for example?
>=20
> You'll have to check kernels log if there is some kernel-related failure =
in=20
> any case for the detailed information.

Well, it depends. It might also send you on a wild goose chase for a
while until you realize that it's just a simple failure to find the
firmware binaries.

> > Modifying the initramfs is only necessary if you have the module built-
> > in or the module in the initramfs. If the module is in a root
> > filesystem, simply put the firmware there as well and you should be
> > good. This is all very standard Linux behaviour, nothing new or exotic
> > there.
>=20
> Having display driver built-in usually more preferable, it's not fun if k=
ernel=20
> can't get to FS mount stage.

Yeah, in that case you can include the firmware in the initramfs and the
driver should be able to pick it up.

> > > > > > and the
> > > > > > device not showing up is a pretty good indicator that something=
 is
> > > > > > wrong
> > > > > > as opposed to everything booting normally and then getting some
> > > > > > cryptic
> > > > > > error at runtime because one of the clients didn't initialize.
> > > > >=20
> > > > > If machine doesn't have a serial port and it doesn't have ssh ser=
ver
> > > > > running or network doesn't come up, you'll end up with a complete=
ly
> > > > > dysfunctional piece of hardware. Hence there is no chance for you=
 to
> > > > > even
> > > > > check what is wrong. The argument about a cryptic error doesn't m=
ake
> > > > > much
> > > > > sense, you have to improve your runtime as well (and you'll get a
> > > > > error
> > > > > message in the kernels log).
> > > >=20
> > > > You make a good point here. I'm not aware of any devices we support=
 in
> > > > the kernel that don't have a serial console, but that doesn't mean =
the
> > > > kernel could be used on an "unsupported" device  that doesn't have =
one.
> > >=20
> > > AFAIK, enabling serial on AC100 require soldering iron.
> > >=20
> > > > > > From my perspective, all clients should always be operational in
> > > > > > whatever baseline version you use. If it isn't that's a bug that
> > > > > > should
> > > > > > be fixed. Ideally those bugs should get fixed before making it =
into
> > > > > > a
> > > > > > baseline version (mainline, linux-next, ...), so that this never
> > > > > > impacts
> > > > > > even developers, unless they break it themselves, in which case
> > > > > > refusing
> > > > > > to register the DRM device is a pretty good incentive to fix it.
> > > > >=20
> > > > > Sounds like you're assuming that only kernel developers are suppo=
sed
> > > > > to
> > > > > use
> > > > > Tegra, though at least (for now) for upstream it is kinda true. Of
> > > > > course
> > > > > that could be changed ;-)
> > > >=20
> > > > That's not at all what I'm saying. What I am saying is that we shou=
ld
> > > > make it difficult for developers to break the kernel in a way that =
would
> > > > put users into a position that is difficult to get themselves out o=
f. If
> > > > we refuse to register the complete DRM device in case some subdevice
> > > > fails to initialize we increase the chances of developers noticing =
and
> > > > fixing it.
> > > >=20
> > > > If all we do on failure is output an error message, it's very likel=
y to
> > > > go unnoticed. Developers are likely to check specifically the
> > > > functionality that they're working on and ignore failures that they=
 may
> > > > have caused in other parts of the code as a side-effect of their cu=
rrent
> > > > work.
> > >=20
> > > I can try to help with improving of your automated testing suite, if
> > > you'll
> > > make it accessible to the public.
> >=20
> > This has nothing to do with automated test suites. The problem with test
> > suites is that you can't force everyone to run them, so it's likely that
> > people would still miss it.
> >=20
> > The whole point of failing the whole thing is to force people to do the
> > right thing irrespective of any test suite or log or whatever. So if I
> > work on display and accidentally break VIC initialization, I'm now
> > forced to fix VIC initialization if I want to be able to test display.
> >=20
> > > > Perhaps a good middle ground would be to turn initialization failur=
es
> > > > into WARN_ON() to increase the chances of them getting notified and=
 then
> > > > continue on a best effort basis in the hopes of having enough
> > > > initialized to get a message to users.
> > >=20
> > > Good to me, I'll make v2.
> > >=20
> > > > Another alternative would be to
> > > > mark essential subdevices (such as the display controller) so that =
only
> > > > they will cause failure to register the whole DRM device.
> > >=20
> > > I don't think that making some subdevice more valuable than the other=
s is
> > > a
> > > feasible approach, how you are going to differentiate what of the two
> > > display controllers is more important than the other.
> >=20
> > I wasn't talking about one display controller vs. another, but rather
> > about "optional" subdevices. For example, I'd consider gr2d, gr3d and
> > VIC as optional in that they aren't needed to get something on the
> > screen. Anything display related would be considered required to make
> > sure people get at least a working display, even if all optional sub-
> > devices fail.
>=20
> Well, from a users perspective, likely that display panel is more importa=
nt=20
> than HDMI port. It doesn't sound good that display panel won't work becau=
se of=20
> an unrelated HDMI issue (and vice versa).

Yes. That's why I said *anything* display related needs to be considered
important so that we can increase the chances of getting any output at
all. Only the bits that are later used by userspace should be optional.
Anyway, this is somewhat irrelevant since we already agreed that a WARN
should be sufficient.

Thierry

--WdPYQQQ4lIWZ4ZWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsTJYACgkQ3SOs138+
s6EHHBAAlOJ4r2B226NhKfcQ6O0bo/kcLhWFbuBexcMU4N7syogTbIG1xptIcL3g
DxwnpiUiAA40g9DEWSMKuNSJiaZyBWuUmGtuNwWL8bzg9M2QgBHJ3DaKDI5vLh0w
XfW9xJN1XnEfLV7mtZW120ETTUN9gr9+hfGrt/OLXGi0uhpKyLZ+ZUvzqYDkgJ79
ziCUJhPdFLdBewK7apkmtPFgEevSkxL+OwOOsUzy9Caaljqt44/VS2kxo9Dbr+W9
fNEzgir8rei8HeDHDYOWKCgNF3GiZ37ba2ZtRU8iYX7xe2UBBRm+6TXr1sqyyZUe
4ovWCoiiEXpTdsx24//Hxqqafn/e/YGtdvZaf739lPRP9/keDO4Pue2Uxv295LPx
iUOLTODW23DgbOg34GQaxxI1lw1djMF7JjYWLIU02mXToF6CLHFyvv4kYWUIOsx4
I8Lo95+PCPT5I8L7uOcQY26MTRjSqB61UlaSl1nGV2+zk04hMspdC3SWLULiF9uG
z/63QyoSxsXPmW+NumpKCCIZfYaS3W+LrRyUjbaUnURNvIawYnwsWepn9GSKV1jK
cyc0l2eOQSax3wVEPl5g/lENGR2NsA9dQxilj+pq/pGs+Vp28jNawdY/8BoLf0kw
KQOZzAgD3OKTY8UEufIg/iRnXYnxrJx/aCFgEf4pFKf6G3pBkV8=
=0aHv
-----END PGP SIGNATURE-----

--WdPYQQQ4lIWZ4ZWi--
