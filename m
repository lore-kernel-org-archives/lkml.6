Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720C8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B75E20818
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WRCA8n8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBGI4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:56:40 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14533 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfBGI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:56:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5bf2a60000>; Thu, 07 Feb 2019 00:56:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 00:56:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Feb 2019 00:56:38 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb 2019 08:56:37
 +0000
Date:   Thu, 7 Feb 2019 09:56:35 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Timo Alho <talho@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: tegra: Refactor BPMP driver
Message-ID: <20190207085634.GC8741@ulmo>
References: <20190206221711.GA21703@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <20190206221711.GA21703@roeck-us.net>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549529766; bh=lt8i385N5xjPw1bdISWWwucorrPM8A8Y2P3Tq77IeXk=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=WRCA8n8p/ALpCgINH9Yj1a9lgx/Eq6ZRLj/lt5hwG/6BSS5i/TZSu225hJy9snmnP
         x815CYuMRqGxFhxiCgKojneUhVmL+MZF+EL10Twpeeedq74p2TDY+yTSV++pBpsFVP
         MvJPOgdOVqFdpX7LHvcRIpc5B9A/ujZlp8can6zqjZgRIABQ4IiI9IYo+xRHeXXtdL
         u3lGgAPXgAH2QlqYtAjyjAzaBTsEwCH0Tr3TAKSo2uuHchYsrzUnS8mlapEqdl6Ug9
         jf9WqpuRVHsWOg9vRI/xJR9biU5x2+b7R/joSnUTT4+90c9i+Psx27mHU+aFLIwGet
         VpgaoKIFegOlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 02:17:11PM -0800, Guenter Roeck wrote:
> On Thu, Jan 24, 2019 at 07:03:53PM +0200, Timo Alho wrote:
> > Split BPMP driver into common and chip specific parts to facilitate
> > adding support for previous and future Tegra chips that are using BPMP
> > as co-processor.
> >=20
> > Signed-off-by: Timo Alho <talho@nvidia.com>
> > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> arm:allmodconfig in linux-next:
>=20
> drivers/firmware/tegra/bpmp.o:(.rodata+0x280): undefined reference to `te=
gra210_bpmp_ops'
> drivers/firmware/tegra/bpmp.o:(.rodata+0x2ac): undefined reference to `te=
gra186_bpmp_ops'

Hi Guenter,

this should be fixed by the below patch. Running build tests now.

Thierry
--- >8 ---
diff --git a/drivers/firmware/tegra/bpmp-private.h b/drivers/firmware/tegra=
/bpmp-private.h
index 07c3d46abb87..cc343f4ebafb 100644
--- a/drivers/firmware/tegra/bpmp-private.h
+++ b/drivers/firmware/tegra/bpmp-private.h
@@ -23,7 +23,11 @@ struct tegra_bpmp_ops {
 	int (*resume)(struct tegra_bpmp *bpmp);
 };
=20
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
 extern const struct tegra_bpmp_ops tegra186_bpmp_ops;
+#endif
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
 extern const struct tegra_bpmp_ops tegra210_bpmp_ops;
+#endif
=20
 #endif
diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 8e3f79959d48..6498c848c82c 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -813,6 +813,7 @@ static int __maybe_unused tegra_bpmp_resume(struct devi=
ce *dev)
=20
 static SIMPLE_DEV_PM_OPS(tegra_bpmp_pm_ops, NULL, tegra_bpmp_resume);
=20
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
 static const struct tegra_bpmp_soc tegra186_soc =3D {
 	.channels =3D {
 		.cpu_tx =3D {
@@ -832,7 +833,9 @@ static const struct tegra_bpmp_soc tegra186_soc =3D {
 	.ops =3D &tegra186_bpmp_ops,
 	.num_resets =3D 193,
 };
+#endif
=20
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
 static const struct tegra_bpmp_soc tegra210_soc =3D {
 	.channels =3D {
 		.cpu_tx =3D {
@@ -853,10 +856,15 @@ static const struct tegra_bpmp_soc tegra210_soc =3D {
 	},
 	.ops =3D &tegra210_bpmp_ops,
 };
+#endif
=20
 static const struct of_device_id tegra_bpmp_match[] =3D {
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
 	{ .compatible =3D "nvidia,tegra186-bpmp", .data =3D &tegra186_soc },
+#endif
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
 	{ .compatible =3D "nvidia,tegra210-bpmp", .data =3D &tegra210_soc },
+#endif
 	{ }
 };
=20

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxb8sIACgkQ3SOs138+
s6EDgA//V+zfQTeTEaLxmv8OuK0/W8+oaQ/gcK43P3WDbud1NLka65b8cfd+qVoF
mp71mm3FabYKPeeTEtYfkQM3IItFBQqsqTGgo9Q0MPQi2isDYvIAvWFhrRdqxuwj
IzUL4go+FSjMrTQ6mkZuoY5XzgDrs+Vi9eR70tES7dnD00GcU1ygXZpXfTT1zwCD
9EkqQ6oKe1opb3Nkr3I3u6zPzfgrImTAvVKMAn6Oum7wkesDO7YOxW3DLXnyZhyA
rpkrxxDjjric5EjCrm2Wj29/bEq4Nts00ezbCLfdaama0LVJS93wkPyZFtn2IIWE
NfzCqLPSMmU7WyTrQhptocOGTIHjuDJMHzGZqTy9Ijn7Jws0+lbJT4uK7Qb7GO9G
T1z8DAchVNIePoeyhx421tSRfMty839joW2p2lkQRcK/ASlakoatXU+KzLG8RZ8K
PIjlRtDDyIQJ69gRJ8B+Ql2t98opjKLCRayVFs2Wx3j4NrxVnkNme/jXmZMXLsEL
pD42hFL/G4mh1ArQYk03D8tu4NI0OAE9jUcN+y+eZhqr3XQ7QfbYmkk3u07cda0Q
U/3JkFVsAqIFlnU4aZOab8NaPdVlKZPVvP7l3dy+sOfDrdRA0LuG/pymmeN339U/
A2s89Li/rzGH02i1d1lTk/3qZQfW1Gcpi4sZWsdFrMK90688MNc=
=aBrE
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
