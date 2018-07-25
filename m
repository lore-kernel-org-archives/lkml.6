Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E863C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9CA20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9CA20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeGYSNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:13:13 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:59840 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbeGYSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:13:13 -0400
X-Greylist: delayed 1964 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jul 2018 14:13:11 EDT
Received: from pd9e2f8df.dip0.t-ipconnect.de ([217.226.248.223] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fiMdl-00023p-RN; Wed, 25 Jul 2018 18:27:54 +0200
Date:   Wed, 25 Jul 2018 18:27:45 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org
Subject: Re: [Letux-kernel] [PATCH 09/32] ARM: dts: omap3-gta04: make NAND
 partitions compatible with recent U-Boot
Message-ID: <20180725182745.6e436abc@aktux>
In-Reply-To: <20180725083305.GB8303@lenoch>
References: <cover.1532501910.git.hns@goldelico.com>
        <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com>
        <20180725080735.GA7467@lenoch>
        <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
        <20180725083305.GB8303@lenoch>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EvVVwApYBji=RIuQBH6+p31"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EvVVwApYBji=RIuQBH6+p31
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Jul 2018 10:33:05 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> On Wed, Jul 25, 2018 at 10:18:28AM +0200, H. Nikolaus Schaller wrote:
> >  =20
> > > Am 25.07.2018 um 10:07 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > >=20
> > > On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller wrote:=
 =20
> > >> Vendor defined U-Boot has changed the partition scheme a while ago:
> > >>=20
> > >> * kernel partition 6MB
> > >> * file system partition uses the remainder up to end of the NAND
> > >> * increased size of the environment partition (to get an OneNAND com=
patible base address)
> > >> * shrink the U-Boot partition
> > >>=20
> > >> Let's be compatible (e.g. Debian kernel built from upstream). =20
> > >=20
> > > That, in fact, is breaking compatibility. =20
> >=20
> > With what? Nobody is using the old u-boot partition scheme any more
> > (it is >5 years old).
> >  =20
> > > So once you are touching this
> > > what about relying on partitioning provided by bootloader just to pre=
vent
> > > something like this happening again? =20
> >=20
> > Well, we define what compatible means here (since we are the vendor).
> > And people complain with us. We simply recommend them to upgrade the
> > boot-loader. =20
>=20
> Fair enough. Suggestion was to remove partitioning scheme from DTB alltog=
ether
> and let U-Boot provide one. But you being vendor you decide, of course :)
> (I'd use only two partitions: MLO and UBI, latter one with BCH8, and store
> everything in UBI volumes. That's a bit more flexible approach)
>=20
hmm, so using mtdparts kernel commandline parameter? Somehow it sounds
to be sane to not have partition tables in kernel. What only is needed
is to have a nice transition scheme for systems in the wild, can
commandline mtdparts overwrite dtb? So dtb is a fallback?
But I think all that is a future improvement?

Regards,
Andreas

--Sig_/EvVVwApYBji=RIuQBH6+p31
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAltYpQEACgkQfb1qx03i
kyS/cBAAiJDfHrQ1C/NH2CyAl4MhuKBmq0Y5OF9pA7skcJ2o9CFkNEIwVsh0Uhpb
+5XaAB5JfiFp5Ec/fF8dbRrr9SN8+n9N4DynnHyxC4GtwR7ENFkojSLtYxYq+iCe
UtvJBwdztUOlS5ZU14DcHWVrG4eGXcVAiNU65Fy5NTnrxQMvDSuM7gz9jPWCnhft
n/Dy1UZERTnbC15yakXwHY/IGmqTHv/6edVt2SEtsVi2+fFnafwdpZDccAHOxbdb
Ukpt1xnUZj7NoNdKsLlXyWHNmAJ3jGWr4JM8CVl+ljV2jetKv97zNFcH1yN+DHQe
zD4DMvmG5O9+Op+MX+c0Op32tAslHLS2gDPZ3jS2vkIKMJD6Wy3DAu5NU1BYjqfp
APqO96G+1TYejdIiZTD8q/PAPSCp3/pJvJcnJaMHsXY2nFZpTgLKELQ2gB7on3le
u8bU3hzQIZS0Jgr3nEI8DVcq6qBLpTfj34KNzq5PwPhFr9oHQ+bBa2y3OD0vsLnL
PXJOkXW5DacLuVpnztAdLmY4r+uE9qizAk2TFFN3ytWdipuh4vVqK3JTsl/yUqf4
qHrpXnrL5L+MYW59q6VxhbIdUrWMfjXd8k+gZ6+hGmFf9waWyHf3tGzxpn/1Yby9
sFCv2S/XaSvAMauNxidH9iENvjfne7UQJdBwmPjx+YBwVw1mZxM=
=Y4Fy
-----END PGP SIGNATURE-----

--Sig_/EvVVwApYBji=RIuQBH6+p31--
