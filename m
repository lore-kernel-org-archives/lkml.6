Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC993C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F872175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mxeyiX5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBGQIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:08:07 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18998 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:08:06 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5c57e90000>; Thu, 07 Feb 2019 08:08:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 08:08:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 07 Feb 2019 08:08:06 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb 2019 16:08:05
 +0000
Date:   Thu, 7 Feb 2019 17:08:02 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: Add Tegra Combined UART driver
Message-ID: <20190207160801.GA6991@ulmo>
References: <20190207143916.GA11121@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <20190207143916.GA11121@roeck-us.net>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549555689; bh=su9glXLC3gssdiFzlGOQbCpiArKY7VgGdiPm97E8q7A=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=mxeyiX5ebwCttCX0DFe+jygJYFPE28NQBOLugpOsCGGQQyGFfM47YHVQ2HqxQaWqo
         z+LvSH8Tyk/M15QADtaJHzvbq6/k8Olu0pGl0Y6AkBUnwm/GDMCdoHoofMEoSZJeUe
         1RMEaH2eCkgVCjOYQps2cUavVUEU1o0sjLmKypP8IdyH1YqkV1SNn5tfS43OZB3hId
         pv/b1acNuoI2I9pGuG3QkOYR7BR9GBWYocKq8zF7GJgSBgmNCcLC6g+rRYu7rL7DBi
         zuFDeE7VrbCaIrX4MFtHUSd63lWWLcMLSHgSJ9BXJRrXriPKEh8DT6/I7lYiC+xJfx
         dfLHiG8gvlcvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 06:39:16AM -0800, Guenter Roeck wrote:
> On Wed, Jan 23, 2019 at 11:28:19AM +0100, Thierry Reding wrote:
> > The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> > multiplexing multiple "virtual UARTs" into a single hardware serial
> > port. The TCU is the primary serial port on Tegra194 devices.
> >=20
> > Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> > are part of Tegra HSP blocks that are already controlled by the Tegra
> > HSP mailbox driver.
> >=20
> > Based on work by  Mikko Perttunen <mperttunen@nvidia.com>.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> In case 0day hasn't reported it:
>=20
> arm64:allmodconfig:
>=20
> ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!
>=20
> mbox_flush() isn't exported.

We only ever test TCU as built-in because it's used for the system
console, so I never actually tested this as a module. I sent a fix
for this earlier this week:

	https://lore.kernel.org/patchwork/patch/1038464/

Thanks,
Thierry

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxcV+EACgkQ3SOs138+
s6F2hhAAkE8/2g42itbQfle0OjIYXCHozySLdAF9vs4Q9tzrTUMtglKQ2oElyHT6
qHJGNiu1sv/m8TMMOmLZ6GC50JzaSglidx/VJUxNx1TZrrfp6kpW2bWE5p4Av7Mg
g68PERX3zbpCEcdfGCMqP182lmhsVke1PzLOP0aVCG46+0j6p64a2jQqRaHZq0j9
ZQ8GR4otV3xThEIQ4pDpkjNhDCwlWW84ysCxPl/p/ifpnZQHien5I0U3RmuYACI3
bpjAbS9B+bZrL5pjxSIC6cBqRCiLslod86rO3VD56BwRJs9mf+O2f6DpaKYTrhH3
+oISLh4P7T+n0jdAtetS1O7sHmccA6/ofe3E/dBHvtc/e0GVwQYYRd6Phf/Dsrlt
m3X5cW8K8RZy57hWgwgBMHR+c4H7QfhB90Ow2bCNUV/FU/a7/lX9VnqVeINvRh59
wXYIPqbl3xYnykqM4lfmVt2Fd6OIzQj0cXvXYcVuKeZICH6cW4ijPjMxLheasEil
0icIx9/K7Pisic4ste7fxqDfGeW0P/64Q0PdRFIKas+f3yb/jLd8r0VjS7PXutfV
HIRCnguJGO8qpAaAYLlSl8h1UMxF8lVDnEkoMvXaSMgwkKWpHb7oljGlysk3TFsd
wWDMjVxTlX3nRVeR3e08PoCCWkp01Snr9XXXUwQ+RMkpwM3nZNo=
=kZsL
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
