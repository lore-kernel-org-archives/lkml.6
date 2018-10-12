Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F739C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E627D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E627D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeJLTvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:51:23 -0400
Received: from sauhun.de ([88.99.104.3]:47026 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbeJLTvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:51:23 -0400
Received: from localhost (p54B3365E.dip0.t-ipconnect.de [84.179.54.94])
        by pokefinder.org (Postfix) with ESMTPSA id 0EB8D2C3256;
        Fri, 12 Oct 2018 14:19:09 +0200 (CEST)
Date:   Fri, 12 Oct 2018 14:19:08 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sh-sci: Fix receive on SCIFA/SCIFB variants with
 DMA
Message-ID: <20181012121908.sbwsojs7vvhiztbb@ninjato>
References: <20181009174158.4476-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="buj6bqvqn5q3nvzd"
Content-Disposition: inline
In-Reply-To: <20181009174158.4476-1-geert+renesas@glider.be>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--buj6bqvqn5q3nvzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09, 2018 at 07:41:58PM +0200, Geert Uytterhoeven wrote:
> On SCIFA and SCIFB serial ports with DMA support (i.e. some ports on
> R-Car Gen2 and RZ/G1 SoCs), receive DMA operations are submitted before
> the DMA channel pointer is initialized.  Hence this fails, and the
> driver tries to fall back to PIO.  However, at this early phase in the
> initialization sequence, fallback to PIO does not work, leading to a
> serial port that cannot receive any data.
>=20
> Fix this by calling sci_submit_rx() after initialization of the DMA
> channel pointer.
>=20
> Reported-by: Jinzai Solution and RVC Test Teams via Yoshihiro Shimoda <yo=
shihiro.shimoda.uh@renesas.com>

Brainstorming: keep Shimoda-san's address as is and mention the test
teams in the commit message?

> Fixes: 2c4ee23530ffc022 ("serial: sh-sci: Postpone DMA release when falli=
ng back to PIO")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> ---
> Reported on r8a7790/lager using SCIFA1 on Debug Serial 1.

I hope to test this on Lager this weekend. I am quite sure it will work
now, but then we have this formally checked, too.

> Tested on r8a7791/koelsch using SCIFA3 on EXIO-B.

--buj6bqvqn5q3nvzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvAkTwACgkQFA3kzBSg
KbZkthAAmGR7rsU8Sk45tDzPeEFHpyvkT9eAe7NEJV/V8CzZDW3BxP2mUDSDO0Z9
CWWH0kYPnvirKaGeZtGxJcs3qK4dF/OVkCEWLUs4Z2nv0hNAYmfUt/gBxdQFuqWX
jutfgi4EZkVIXvhQtGFU3ahdumsB3LSYy8aNpa9GNpbg0ECSBXgdGTUtA5LZ5H+k
NvavVQgVPYaNtT3DXn3FZyZzpUlsxtOtpu4mypjjzWvDlb58F/4zh9E3bkW4cLA0
FjtFpxasFOl34PQVHDnEQmddHSv9GRgRqvaSSvfbmhf9chC1y4ECweXRVBUL1J01
kVUuPEUc0e6ms7OIn67HCsBTDfzN9Mw+bkL1VmX5bIfWkquwBCU+4jMS0Dx9+FZG
GudshCXl51V/6MpfxjsVzvS6Phw5sL3ClsiOWphrnCzMwO5Kok9ElPfGqzFFulGO
xe+/ys2b8eqiGBNwnYu6artjaPtJkC7XO/l+53OPfnLXqd+U9SfI8HpXJTmHIocf
yLE7gFp94BB2vVplrO3PwIRRCVPhz3rV8wBPavfDcU9lJKb74A+qnu/GQJCv8Hqp
T4KUqD4hKyBcEGTmU9YQiZJmaxBiNTbrpzT+MR8OnXjphzyoWWs2PMWiedaVIwES
75tnGSiNm9jIhESRavSMYXxu9euM/GaV11c/Nt3Qm5bOLWok8KY=
=VFOj
-----END PGP SIGNATURE-----

--buj6bqvqn5q3nvzd--
