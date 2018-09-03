Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D7C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70E520843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70E520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeICMui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:50:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52724 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeICMui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:50:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CB3CF215E6; Mon,  3 Sep 2018 10:31:32 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9CC5020711;
        Mon,  3 Sep 2018 10:31:32 +0200 (CEST)
Date:   Mon, 3 Sep 2018 10:31:31 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ide@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
Message-ID: <20180903083131.asgh6wp54e2fs62l@flea>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
 <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
 <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
 <20180831074024.w7yicj5y4imy57e2@flea>
 <39f89b9d-f5bf-7c4a-8e68-252bfc0b91a4@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bqnc4wmife4rizom"
Content-Disposition: inline
In-Reply-To: <39f89b9d-f5bf-7c4a-8e68-252bfc0b91a4@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqnc4wmife4rizom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 08:35:23AM -0600, Jens Axboe wrote:
> On 8/31/18 1:40 AM, Maxime Ripard wrote:
> > Hi Jens,
11;rgb:0000/2b2b/3636> >=20
> > On Thu, Aug 30, 2018 at 08:52:52PM -0600, Jens Axboe wrote:
> >> On 8/30/18 8:32 PM, Chen-Yu Tsai wrote:
> >>> Hi,
> >>>
> >>> On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 8/30/18 1:01 PM, Corentin Labbe wrote:
> >>>>> Hello
> >>>>>
> >>>>> This patchset add support for allwinner R40 AHCI controller.
> >>>>>
> >>>>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> >>>>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources ad=
ded
> >>>>> by this serie, so no regression should come with it.
> >>>>>
> >>>>> The last patch(ata: ahci_sunxi: remove PHY code) should not be merg=
ed,
> >>>>> but will be resent for inclustion when all patchs will have hit lin=
us
> >>>>> tree.
> >>>>
> >>>> Applied 1-12 with Hans's blessing, thanks Corentin.
> >>>
> >>> Please don't merge device tree ("dts") patches, i.e. patches 9-12. We=
 will
> >>> merge them through the sunxi / armsoc tree. Having them in separate t=
rees
> >>> introduces conflicts when we have other stuff going through our tree.
> >>
> >> OK, fair enough, I can drop those.
> >=20
> > And the DT bits actually have some issues that would need to change
> > the code significantly.
> >=20
> > Can you drop all of them please?
>=20
> OK, can do.

Thanks!

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--bqnc4wmife4rizom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluM8WIACgkQ0rTAlCFN
r3TKYRAAhFvCHyzVXOZC/BzDb2cLoagfdyqL6PmDJrLnIywHrqkfEAIDGc3L9MBs
V88pX2q/85lyW6GyadGpD+Tj+vTDcZlLi/ZZadPwFzLsgBhabY7mhsGHtp9+1GTN
0i4rvz+xm2blUv2fQpCa4xJ/JW/FHQdgC5NvNl0LaPjMFFp1EL7DrRy9GYBs3fNP
a1Y0hiiBVCQ5HzkiTjXLQv5bG8QLVJCnTzRU8pCE69hN+WuiXsrmAp1l7I3ovcLx
fpIwbCs+wFv87TiTGthRaFrwb6udwYgKeUi94jZJP4VSEs2cSaDtnDUwsaSLts5O
GfztSy9JADpKz59jtsjKjBHlEDUS34mmnzo5rg4/HOhj0mrTMP6eSmRc2FTU8z0O
XTeBrNzMBlXUC/nnBxUrCuggKLD5b2avB6bfwayv5p8ZxdE90gB8wKTcnWxZqYut
/irhff7nqc4WN1xvMuOGMTbidPqLX5FByXOJhE7BCXOrsUMwGtBCN9DJdFdjtXEy
F32514jBAuiX+JCzHEC5F9PlfOZmNS15wwwOPDUNZoIrGpzrs/0LSzwn/PQuO/jD
Fl0AbkPskhhOAtX5OO/Eb3Sj6MeJF3dihAMEAlOGaa64eXQyXzW5TVp1qH31E4f1
LeI5BFWSCTpB+x6f2LTQKATzHQUiuamSOPc9hPtUS9ojhhCDFS0=
=lSQ9
-----END PGP SIGNATURE-----

--bqnc4wmife4rizom--
