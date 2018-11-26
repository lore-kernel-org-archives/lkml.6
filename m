Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B32AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C9C2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q/qC4P5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C9C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeKZUaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:30:03 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11412 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeKZUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:30:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfbbea60000>; Mon, 26 Nov 2018 01:36:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 26 Nov 2018 01:36:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 26 Nov 2018 01:36:29 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 26 Nov 2018 09:36:29
 +0000
Date:   Mon, 26 Nov 2018 10:36:26 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Jon Hunter <jonathanh@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20181126093625.GA10878@ulmo>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181123164827.GE53235@atomide.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543224998; bh=3xGj9A1zHJi5d2tKna9Zqj2QwPI6uuNv5SS7rsZRxY8=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=Q/qC4P5QmfgsJ0L9qrgvJJCt34uKtaKnh4rEcg/IwjIYX4ERm1Gu+sTlGeormQzmV
         nO0fXCLUvJOM751U/ilUtISjqAPZZunx+ZwArunHei3mIbT9L8Fz6L22VPqjKpNGCL
         4ZRmFNlmkefDXIFgF89WVRoubdSJpmVEla7UIJCl7kMuMe4ujxR1ImY+XJAQ674FKe
         rviYyOC52NxIouaSz9lerWNbGpOZSuF1MbJVDOjRmDfOpIea+dwVgg12H/lq1WWz6u
         uE9HliyiS4keMt1I1WK886YHMdWb48Y820GDU6aKvi9oDBB0fZzp9z1ZJT/K27eqY5
         m3vV0UH6Lv1wQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 08:48:27AM -0800, Tony Lindgren wrote:
> * Jon Hunter <jonathanh@nvidia.com> [181120 11:14]:
> > On 19/11/2018 17:14, Tony Lindgren wrote:
> > > Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> > > Tegra114 PMIC interrupt") states that tegra114 inverts the
> > > polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
> >=20
> > Yes Tegra can invert the polarity of the PMIC interrupt.
>=20
> So is there some IP on Tegra called "Tegra PMC" that is
> inverting the interrupt? Or is the "Tegra PMC" that commit
> 7e9d474954f4 mentions just the palmas configuration for
> inverting the interrupt?

Yes, there's indeed an IP called PMC (Power-Management Controller) on
Tegra. It has a special input that is usually wired up to the PMIC
interrupt and a bit in the control register that configures the polarity
of that interrupt. If the PMIC generates a low-active interrupt we
usually set that bit to make sure it is properly sampled by the PMC.

The symptoms of this being incorrectly configured is usually an
interrupt storm on the PMIC interrupt, which I think typically results
in the system not booting at all, or taking a very long time to boot
because of that storm.

> The problem I'm having is With omap5 where I can only get the
> PMIC interrupts working with IRQ_TYPE_LEVEL_HIGH if
> PALMAS_POLARITY_CTRL_INT_POLARITY is not set unlike for
> Tegra.

Does somebody have access to the Palmas documentation? That should
pretty clearly state what the default polarity is and what it changes to
if you set the interrupt polarity bit.

=46rom what you're saying it sounds like either the logic is the wrong way
around in the Palmas MFD driver (and we correct it by switching it back
to the correct polarity in the PMC) or that you'd need to find some way
of inverting in on OMAP5.

Thierry

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv7vpcACgkQ3SOs138+
s6GBZBAAvMehEa8A+LGTqIFmDqN1oCIrXPtzxBKNQOXr1R1eR5VS2YCRcZQ0CW4e
UEf+mDgJ+4/i3uEWcidyv6ILuFdy/RQoWvOVOAjeTGQiMkofC8PvetxMo693NXmD
7np9OHR5KUtU87+PkKojUM3SxzJ1ADlm28YMqF3SCqOEMvphXSxoOA3YIPpUttn6
dftMt88yxmXJM58KksnMjZZ2eM/EqBSvlGshJS+uWXQP8isK1KIQgOxx3SRqfIKP
mBhhmhDNq54vqoaEpKcsPjuoqwbBKmAkSj6jahlQ7TGB6bjIMweshZgxWL+Zu4Gd
UPehtHm4yWKqlHYa8kquTgahn3/z8pKr1fpdvvlCrqwXBOxQIOpUMZXqiqWoOipg
urDxeVvM7y0Lic+8QfKOzg0eLysCyDJmkum3rE1ubcvVG6ql1vuWxRr8yr9geTC6
/k3Mb4gU55oWAlB7RUgrvkwOFoAiEwdWnI6aJGtJhiblimW+KV6pvJheAlzQ/BZv
fwaq/vYLf+wkew17Y8oxt6b5RQTGz9Hr6Vpjr5rmaiFHB/6cCR0GWVyQFz83QO2p
SetWlOnIr1QcJ5ieBbuFaY0ip3GagavB+28RDfcRVXF2lMfFQ4q9luf84B4h3Ffi
BjGzfsZpEAlCRoL/o9AN/J441UaEryo2KF7dLDswY1Q1Eh9NEW8=
=sb3s
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
