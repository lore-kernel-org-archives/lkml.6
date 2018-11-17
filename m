Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F9FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C542080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C542080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeKRHvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 02:51:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:51578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbeKRHvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 02:51:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3803AD0A;
        Sat, 17 Nov 2018 21:33:12 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Date:   Sun, 18 Nov 2018 08:33:03 +1100
Cc:     devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v6 1/3] staging: mt7621-mmc: Remove #if 0 blocks in sd.c
In-Reply-To: <d24db4fd34fc2347ba0512aaae04b937b942ac0e.1538670306.git.nishadkamdar@gmail.com>
References: <cover.1538670306.git.nishadkamdar@gmail.com> <d24db4fd34fc2347ba0512aaae04b937b942ac0e.1538670306.git.nishadkamdar@gmail.com>
Message-ID: <87sgzzcru8.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04 2018, Nishad Kamdar wrote:

> This patch removes #if 0 code blocks and usages of
> functions defined in the #if 0 blocks in sd.c.
>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Hi Nishad,
 thanks for this patch (and others) and apologies for not
 reviewing/testing it earlier.
 Unfortunately there is a problem - see below.
=20
>=20=20
> -#if 0 /* --- by chhung */
> -/* For E2 only */
> -static u8 clk_src_bit[4] =3D {
> -	0, 3, 5, 7
> -};
> -
>  static void msdc_select_clksrc(struct msdc_host *host, unsigned char clk=
src)
>  {
>  	u32 val;

Above you removed the first few lines of a "#if 0" block, but not all of
it.  Previously the function msdc_select_clksrc() was not compiled at
all.  Now it is, and that causes an error - MSDC_CLKSRC_REG is not
defined.

Would you be able to send a follow-patch patch which removes this
function and the "#endif /* end of --- */" at the end?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvwiQ8ACgkQOeye3VZi
gbkkhhAAvlqAYwnHB+Gap8yhZTj9NN7d8hgmVH9R3G1CcBtRIXMTVnO5wpc1YTF1
vN5S8Ga0uL7t3Aa17I/nITgzbvhlqV4elEb5vwmh0DzOscYjcLPN2pQc+Qgr0B4/
XywSZ83FQr2M8z0AD1MOzXmf5n1SRgcJVpYlJnReEt0S2cqotmWhTdQHNmgqDVk+
SyVHEtPC26/+1zfxVKfOumTbgz557OfkuYtLgDEgSHSGm0EaAYL425+Jkve85Xf2
WUeumLUtw0CsnT1pgpp7d5lP3neq/b/v7C9VLH4zqhtPIrRgaxchnSClTOQZo6GJ
gz+J8d3JEbf4b6hXvZLLGYJPZpqPYh9BFy0nNlys1u+4SEX3oXLNEcs1y5RmxZ7B
OzkGOxmVJyygYUsx7Q1OMJaXWqk6HsZU1xOwfNekrzFJPafo3j6h5pesPgAa1tZb
gh4t2ZBIrJMKtVtkXqDzrxPpRbT5S5znk4rRkoNDK/L7udbzpllQMdrXun/Mfb9Q
eTRnLWdIooJnjeWydsRG9CQBQnRCUZDnoLg2GoV4OckSria4krA/48JUNsxuCUyy
hantbitz7wG2Wth3/naouVJBoHLsQH5wyClWVBptkBQY2L3zXERNgmYXeZtgIeRQ
wzpkR9dSkRF2yCVHlHT4HM2DXzSphyivJZCD58FmvCqEx1t3AEY=
=8boA
-----END PGP SIGNATURE-----
--=-=-=--
