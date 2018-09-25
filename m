Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62786C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1730F20838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KkmOWrbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1730F20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeIYJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:53:20 -0400
Received: from ozlabs.org ([203.11.71.1]:33187 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbeIYJxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:53:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 42K6Tx1bSkz9s9N; Tue, 25 Sep 2018 13:47:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1537847269;
        bh=ROZYdAp3aOY/k8QSJaaQkfyEfaRUTUIwDlyjRjCubeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkmOWrbpaZeu+BrScYOZXMd9S9NdkK2y/vjqDqFjQ79jqMtmVWyzsShELL+bOuTd+
         pKLkrMfgBUJ7uLrR/8JdtmONtFgzKVXhlvi6JoaIZL0OQ9+JujxvCScZJQJRNpsWpx
         Ugz80YBD6kxh5GwF5Oo+XUiOWGfFdQUeQ4gFQj2s=
Date:   Tue, 25 Sep 2018 13:47:43 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Alan Tull <atull@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Portable DT Connectors with regard to FPGAs
Message-ID: <20180925034743.GD30868@umbus.fritz.box>
References: <CANk1AXQY14NHHoDUKNShvDQCFP-bw7ndU=W9a5G8C1d-p4tDUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BI7KTAps+wX7oIMI"
Content-Disposition: inline
In-Reply-To: <CANk1AXQY14NHHoDUKNShvDQCFP-bw7ndU=W9a5G8C1d-p4tDUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BI7KTAps+wX7oIMI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:32:44PM -0500, Alan Tull wrote:
> My interest here was in having some discussion on whether connectors
> are a good match for handling FPGAs.
>=20
> The relevant use model is where a user applies a DT overlay targeting
> an FPGA region after the kernel has booted.  That overlay initiates
> FPGA programming and then adds nodes for the new FPGA hardware. This
> is discussed more completely in the FPGA manager DT binding document
> [1].  The main deal here is that I'd like to be able to add nodes
> in/below a FPGA region node to support devices in the FPGA (and be
> able also to remove them if we are going to reconfigure the FPGA.)
>=20
> Previous discussions about DT connectors focused on the types of
> things likely to be on a physical connector. GPIO and SPI got named as
> good examples for discussion while MMIO specifically was dismissed
> [2].  That's problematic for embedded FPGAs for example since the FPGA
> is on a mmio bus and hardware that is programmed into the FPGA lives
> on that mmio bus similar to any embedded peripherals.  So there's a
> question - are mmio busses intended to be left un-connectorizable?

I don't see any particular reason that a connector couldn't be used
for mmio devices.  I think you'd want to treat the connection point as
a bridge on the mmio bus - that can have a 'ranges' property mapping
the connected device into the parent bus's address space (as an
identity mapping or otherwise).

>=20
> Alan
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/devicetree/bindings/fpga/fpga-region.txt
>=20
> [2] https://lkml.org/lkml/2016/7/20/560
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BI7KTAps+wX7oIMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlupr8oACgkQbDjKyiDZ
s5K7MhAAvzTQruD8Eug/NpcLk36W4uVPasCdGxhjWNmHE0+hjEAX9OET2QK1y4OL
NAlDCJAiOYr9L6ljqUSP64jtJ8RKab2LhiYzS/NXFiG8f8keCiitmJXRmCQ4DoqU
7+NEKk9GpMfmtflmUcAOqAxShwiCRdfazsP3uPHGb54zMCTioci8b7vetKydmSEu
hKh1aYjD5reKcb/JfVYUPQ4k38hHCrQtzcU0VECST2nkvJOCnfvmMQn5Qa+k2aow
UjMPHZnkFu1WBJRrermwQs7WWpN4Lp1pVBuM/0fThUwF12AFydr2TevWHHgOgFvC
iIMFbjHIV0bbzgV+bLQ2SPhJ8YB8p+H1uBnplBCLZUFUPE7/tbEK/91wcQr4F543
e/LlWlblgJHmdlV6zgqp4ZOZ/g4JuYQsscvc5B4sajheQHJ5cLG0HSj+tKZEzRdY
D7P6461froQSTBjldXGY1uP5O2GFvtebdKPYepDJN/XAHHyHpJuxlMgjZsWhEZSi
3kNLTWpuHjUAhc2tsjmCCZObj5fp3+R1KnMdbbMzUSYiQD4atN5b1e0Sc78Lt9vB
51mI4xpq/2Wkt7RojTIYN3Z1X5EVSDaZxcDz5NVrjQCOS1dnM1i6m3BgExL4UQGj
idcGkHtfQH/OGrD+hk0Y3VhlzMptP5AAQrYPdRudUbnesIrjzCw=
=MnJW
-----END PGP SIGNATURE-----

--BI7KTAps+wX7oIMI--
