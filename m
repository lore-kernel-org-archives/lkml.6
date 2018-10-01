Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C3BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7047B20652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7047B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeJAP2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:28:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49542 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeJAP2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:28:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 314BE20A2E; Mon,  1 Oct 2018 10:51:47 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id E4517206FF;
        Mon,  1 Oct 2018 10:51:36 +0200 (CEST)
Date:   Mon, 1 Oct 2018 10:51:36 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, andrew@lunn.ch, allan.nielsen@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Subject: Re: [PATCH net-next 2/5] net: phy: mscc: Add EEE init sequence
Message-ID: <20181001085136.qebnqu5kr3d5rgej@qschulz>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <64809c5f01f3c6407257553a286b82949cef1ac0.1536913944.git-series.quentin.schulz@bootlin.com>
 <1321f1a0-57af-a059-f78a-a699da94c064@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ifdy6dhibjymhbzy"
Content-Disposition: inline
In-Reply-To: <1321f1a0-57af-a059-f78a-a699da94c064@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ifdy6dhibjymhbzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Fri, Sep 14, 2018 at 07:21:09PM -0700, Florian Fainelli wrote:
>=20
>=20
> On 09/14/18 01:33, Quentin Schulz wrote:
> > From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> >=20
> > Microsemi PHYs (VSC 8530/31/40/41) need to update the Energy Efficient
> > Ethernet initialization sequence.
> > In order to avoid certain link state errors that could result in link
> > drops and packet loss, the physical coding sublayer (PCS) must be
> > updated with settings related to EEE in order to improve performance.
> >=20
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
>=20
> [snip]
>=20
> > +	vsc85xx_tr_write(phydev, 0x0f82, 0x0012b00a);
>=20
> Can you just make this an array of register + value pair? That would be

Sure, I'll.

> less error prone in case you need to update that sequence in the future.
>=20

I'm curious about the kind of errors you're worrying about or have
experienced. Do you have any particular example or thought in mind?

> With that:
>=20
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks,
Quentin

--ifdy6dhibjymhbzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux4BgACgkQhLiadT7g
8aPp/Q//bjyF7Sp993gi/7ckKC7n9QfwT3fhxQLjre3xNNP7HsKm87bKOQY5omGG
P5V5bkFWQs+S/iSssrP5gW287tFQ2LvOSZaYSeU8CnrpjyKK8iAiRKCZTFpuIrTE
K+zeAsGEYls/Gfnr3lsqfZTxdnhA4M4sMvqz6KiKUd8HwKEdxCxTvLox4q8Fq0vL
67nLMeZMCDLAUaLr0Ey7ix2GAs4rjiJrHVl8DHSs/TqFE0oLI/MGfLZWobr/K7hS
LFM7V1Rke9re4pGqHxGZ1QW9l7JeesQH3TU+hbFGrCyNYmYMCZCBKFVnizUW4CwI
NNMM5hjzFqXfLFu+z8543vLupU/qklgI3RQ0BFzPVjLJD07HmVnhkMzOXKo/g2zU
I9ZIqaRwv6xhpiyP5ro1683TLHb8gxZPWsK9pXmbT5m63AiUiX1p1eVtcq0yjb85
oyEl0JxtAmpNZPAaxYDJeCLMhLSdciUa6la0Ww6Jdn05dAmsJbCe/RKarYfZ0J0H
tQCebD3qkZtMUV+QU5vaOtmLcqE+K96u0Cd2EzWN+fY/eQkBn/FsU6fD6XMGxvSc
itN4/sV6ioBmvVlVCqCJ+rOAbGOOD9b0xfnYs51WGA+F1jXMBCcAZU6J7Cfy30No
sPGhQM38zGDUkwiHzvRwMqL3R1UZm0YlK9TMvjhHB+/XRlxZbLs=
=jphq
-----END PGP SIGNATURE-----

--ifdy6dhibjymhbzy--
