Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C90C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4091F21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502002AbfBNQxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:53:20 -0500
Received: from sauhun.de ([88.99.104.3]:54094 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732639AbfBNQxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:53:19 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id 444002C2817;
        Thu, 14 Feb 2019 17:53:17 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:53:15 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        peda@axentia.se, digetx@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V19 5/7] i2c: tegra: Add DMA support
Message-ID: <20190214165314.dczoxwkayras5cdr@ninjato>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
 <1549998408-9137-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fvm2hgq32qt7p7oz"
Content-Disposition: inline
In-Reply-To: <1549998408-9137-5-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fvm2hgq32qt7p7oz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 11:06:46AM -0800, Sowjanya Komatineni wrote:
> This patch adds DMA support for Tegra I2C.
>=20
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
>=20
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
>=20
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
>=20
> Tegra210 and prior Tegra chips use APBDMA driver which is replaced
> with GPCDMA on Tegra186 and Tegra194.
> This patch uses has_apb_dma flag in hw_feature to differentiate
> DMA driver change between Tegra chipset.
>=20
> APBDMA driver is registered from module-init level and this patch
> also has a change to register I2C driver at module-init level
> rather than subsys-init to avoid deferring I2C probe till APBDMA
> driver is registered.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Not directly related to your code, but maybe someone is interested in
fixing this rightful checkpatch comment somewhen later:

WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code rath=
er than BUG() or BUG_ON()
#332: FILE: drivers/i2c/busses/i2c-tegra.c:791:
+				BUG();


--fvm2hgq32qt7p7oz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxlnPoACgkQFA3kzBSg
KbbNOA/9EoHlFIaSVQ4ZqkVUQZf6r88V+QclrcLuuiVPC9DoP0faWi8wUN4IDHES
tXjCRrAndBuqcb6wqOEv2b3cZPYTSg0iBDfSlENIpGjlUProkJ+HcQxAEh5lK1lh
HwSjlfPfzu28BNvyQeR69c3/6gM56lqVS07EIQg9JCM+ouGVnIQHa1NLg8gf2jJV
kTqO/MI+byye+ELjKHVHBpAf60zQ6hIfWLqBn9iuRgRGHQNx4Mks2ov17mAC85UN
Kv8YnL6Sf/Aj6NAg+em/cFL+ReXGMeWJxJY4ENJW5IeCgmCDR/0uEr8iroTLy/3p
OT2xLBEtF7f15ylTRBmfrdfrdnb3BoNmb7W3VBL9oQWmeJLPG2JFyMBR1GuDDJSg
Bb9EeIXAPTxCrLYPWAMnpMDaBi4P6ozx8VjYasJRukGoNgg8PA5VCrxbHOq8bigV
Bf4W8JTmyt1YT0Td9c0cWIE2qrwnTFHfyDPgIdQTkw68ArP0R8kOZjo8TH4sTQ+b
kq85iZtpPoMA+t+zo3H+3YWv8yvXgGpPfCOVdclFa40b+F/g0Ouxdq0QxW/W4loi
sFVHIMVe3NqlA2MB6u9DXRuwmeWvmHkVQepqKfFOdXPlqWR51wtZbf0IZVipXyoy
t9WEOVE6KzBNhmahJ5KxSn+qVsp3d1KCNdmWWS9gDn8XLrik4PU=
=t5RN
-----END PGP SIGNATURE-----

--fvm2hgq32qt7p7oz--
