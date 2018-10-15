Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F5CC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8FA2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8FA2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeJOTRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:17:19 -0400
Received: from sauhun.de ([88.99.104.3]:46258 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbeJOTRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:17:19 -0400
Received: from localhost (p54B33719.dip0.t-ipconnect.de [84.179.55.25])
        by pokefinder.org (Postfix) with ESMTPSA id 19FBB2CF683;
        Mon, 15 Oct 2018 13:32:26 +0200 (CEST)
Date:   Mon, 15 Oct 2018 13:32:25 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag
Message-ID: <20181015113225.br7rwxtqjhxwbhli@ninjato>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
 <1539143492-32605-3-git-send-email-yamada.masahiro@socionext.com>
 <20181014222812.GC3260@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dl5tgo7rbzvmdf5e"
Content-Disposition: inline
In-Reply-To: <20181014222812.GC3260@kunai>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dl5tgo7rbzvmdf5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 12:28:12AM +0200, Wolfram Sang wrote:
> On Wed, Oct 10, 2018 at 12:51:32PM +0900, Masahiro Yamada wrote:
> > TMIO_MMC_HAVE_HIGH_REG is confusing due to its counter-intuitive name.
> >=20
> > All the TMIO MMC variants (TMIO MMC, Renesas SDHI, UniPhier SD) actually
> > have high registers. It is just that each of them implements its own
> > registers there. The original IP from Panasonic only defines registers
> > 0x00-0xff in the bus_shift=3D1 review. The register area above them is
> > platform-dependent.
> >=20
> > In fact, TMIO_MMC_HAVE_HIGH_REG is set only by tmio-mmc.c and used to
> > test the accessibility of CTL_SDIO_REGS. Because it is specific to
> > the TMIO MFD variant, the right thing to do is to move such registers
> > to tmio_mmc.c and delete the TMIO_MMC_HAVE_HIGH_REG flag.
> >=20
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested on R-Car H3 ES1.0 and ES2.0, M3N, and H2. No regressions. I
pulled the SD card out during transfer to ensure the reset function will
surely be called.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--dl5tgo7rbzvmdf5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvEeskACgkQFA3kzBSg
KbYNXQ//ZhXUdVmZQvLF5cLDWRZ8xgRFls/JJUJ3iJWftreITLNpmGgiE43K48nD
h4iFmPvQD7Ik1Dixlm06I2i3SrJx6bu+jB1MbTexwmZ1NtpAYSp0chpul800avjc
Okts+tHHLGRol/au7Dg+wocCa+RjYdKOOvDy5PFqBkOscKtNn/+v5U3oUMjsjW/u
WqkTT103RhV95T6ZLlzQ/5AwbN12FYfOMl4PJYaJ4k/Z5EpNXXUMm5a81AROSKmK
G1THCDUGjG4WotQxGEPmtRdjjl897M8thmpGBYtj7j0CmXKy0bxx11nHTnhKMPXa
nbkiPuuVrJtamFpm10J9LRAShUSZVDPbOxW7//mxfXRqPJr3K4d9sgRNu6uI4yI1
rSC/mjgKxuhGyM4UyUP7wbDrzLKxu9M6lY1L5Rnx8rkriW5+UhThwMeUX5H6Ub/P
6uSEdCqTkwIgB/1Skqdra94cxryS3tqyz1WuWkudt6jSArN375qztxPgdNW1K1NM
EQLNfNDxoj3P9egYiu1MgZeRUWJk/4YIhmDXOzq/KH3gqiH+TzZl/HZpPgaLgtGH
szeMu0sEtlSiK0ZsfMBVKRcjoS/1L6U/qdmpi6zMjMQ0OkiA8GKahTSnO7CQs24n
6axnce5/+100NcuPimJFfvyG1juRqPgH+Kvzq14k5Q2lWsuTRIM=
=Ouyk
-----END PGP SIGNATURE-----

--dl5tgo7rbzvmdf5e--
