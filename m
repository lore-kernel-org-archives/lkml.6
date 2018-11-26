Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3823AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA01B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lZQJ4QTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA01B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeKZVT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:19:27 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15113 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeKZVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:19:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfbca2a0000>; Mon, 26 Nov 2018 02:25:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 26 Nov 2018 02:25:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 26 Nov 2018 02:25:45 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 26 Nov 2018 10:25:44
 +0000
Date:   Mon, 26 Nov 2018 11:25:42 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20181126102541.GC10878@ulmo>
References: <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
 <20181126093625.GA10878@ulmo>
 <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
MIME-Version: 1.0
In-Reply-To: <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543227946; bh=KM6nDDAZoH50q81Sbl24Iwo9CmiGsOgSZst6krGj2Y4=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=lZQJ4QTjKKoAhpYW8Phanv3okVwfvJx6DPFNTkUZtEJrF5uiliDhXpa+zs1a3w2T8
         8ZYIw8VvdbSMSh5teAtHGmJ0rodz+Gs2f2G0DlbKdwxlt9NZfdFRvb3MubHZ5ZDc3x
         +KXvnWWJ2xwlJCzte2gEKqziT4CpHHDVWrDeKENsGCIXFXdneK1l1gXFc3wI2y0cuS
         4dkDcsMvWLHdF8hMJFV8QITun/JSTdbYzl+cffRFP0kqKBz/5iGtt43Rkc95tpyrrp
         u9XH08g1wXnFyuZ/WF6mICBHStboU1SM+spSVP6Ja7Z8B5oPaM5vYqHf+PKIYkkHKs
         dbsWizG826hcw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 11:49:54AM +0200, Peter Ujfalusi wrote:
> Thierry,
>=20
> On 11/26/18 11:36 AM, Thierry Reding wrote:
> > On Fri, Nov 23, 2018 at 08:48:27AM -0800, Tony Lindgren wrote:
> >> * Jon Hunter <jonathanh@nvidia.com> [181120 11:14]:
> >>> On 19/11/2018 17:14, Tony Lindgren wrote:
> >>>> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> >>>> Tegra114 PMIC interrupt") states that tegra114 inverts the
> >>>> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
> >>>
> >>> Yes Tegra can invert the polarity of the PMIC interrupt.
> >>
> >> So is there some IP on Tegra called "Tegra PMC" that is
> >> inverting the interrupt? Or is the "Tegra PMC" that commit
> >> 7e9d474954f4 mentions just the palmas configuration for
> >> inverting the interrupt?
> >=20
> > Yes, there's indeed an IP called PMC (Power-Management Controller) on
> > Tegra. It has a special input that is usually wired up to the PMIC
> > interrupt and a bit in the control register that configures the polarity
> > of that interrupt. If the PMIC generates a low-active interrupt we
> > usually set that bit to make sure it is properly sampled by the PMC.
> >=20
> > The symptoms of this being incorrectly configured is usually an
> > interrupt storm on the PMIC interrupt, which I think typically results
> > in the system not booting at all, or taking a very long time to boot
> > because of that storm.
> >=20
> >> The problem I'm having is With omap5 where I can only get the
> >> PMIC interrupts working with IRQ_TYPE_LEVEL_HIGH if
> >> PALMAS_POLARITY_CTRL_INT_POLARITY is not set unlike for
> >> Tegra.
> >=20
> > Does somebody have access to the Palmas documentation? That should
> > pretty clearly state what the default polarity is and what it changes to
> > if you set the interrupt polarity bit.
>=20
> The register map documentation I have states the following:
> bit7 INT_POLARITY Select the polarity of the INT output line
> 0: Interrupt line (INT) is low when interrupt is pending (default) RW
> 1: Interrupt line (INT) is high when interrupt is pending
>=20
> By default the Palmas irq is active low.

That would confirm that the driver code is correct. My understanding is
that the PMC on Tegra expects a low-active IRQ from the PMIC, so we need
to invert the interrupt again in the PMC.

> > From what you're saying it sounds like either the logic is the wrong way
> > around in the Palmas MFD driver (and we correct it by switching it back
> > to the correct polarity in the PMC) or that you'd need to find some way
> > of inverting in on OMAP5.

=46rom the above it sounds like there would need to be some mechanism in
OMAP5 to invert the PMIC interrupt, similarly to how it is done in the
PMC on Tegra.

Thierry

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv7yiIACgkQ3SOs138+
s6Gzug/+JNM3GWVVAq4tUhcK81m2KTuysWyjWF4VVKDgpi6U9esstKZaTTTZde8N
dOmkgjZeKGlzOHyuqrM4ax2GD8BMN4v/eXgXifQ8ybTDYs3UU2V7elcJ7Mqm49oJ
fIVDmOedsR0p5oemtMIhs9Grt6bVPoqtKMa2AbzKBawp2kmJ4kmTnCcbDs1ZLoWd
dO1yHVY2npdOIIycsfL4NqtVm/b/EFEsnDMVjnau7FsZbbVCNG3gxUM0fZ9yb8+G
H9UeQOA2NqcX3u0PhCVnpWZxtrgtWRU/WUpnEIg+JM+M4kZMP0Ac1zF0I2moA8bY
AmFzDceqPWUINjTGgXw7eUNAFrnZAGw1oP5ebxFE+jcu1b6OhGmqN+SpdG4cmNBx
p19KGI8bwkA+mBNxP4bMKn8KHRq5zJMI/pYRR2b9/PAXx3JOZKIW8FZ3uBVuKSzX
ggOAFRZ+AH7vGtFednADnktNduOxYWJZfCcElGF/WkSBHn26HkUN9l99klreCfMD
mEw8wzRl2pZJ0qTAEqSHnYHwQzF3S2FTvQqOmtJwKyB3kifOLY2yFYyd0TJkGYHd
EemjDsxw/0e6FS9lWDava3dfMOvet/pHUUkGoN+dHfAmdWghEXv8hlSwbCSng/Rs
igmmOuLdkJG8Qu/qTQHdSh4Nx0W+zivwoelbheJvqxAgu4FleVM=
=uTXL
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
