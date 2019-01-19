Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02B3C6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 07:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDED2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 07:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="XdADO6f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfASHM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 02:12:28 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:33618 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfASHM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 02:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hZ9ax6upapGp6T9kLNWDN/tg1u40CL01JpKtAPnNd9U=; b=XdADO6f7BaB+COAcuOFnUT5JI
        GEUboer4jHyaP/JlDUpUo2nf9cf+Xb3HipPtVOhPJzUCBlpHmBP5sEbC5FjHIjclJUZpScLjksQ2v
        t4au7BxEJgPwKdGa/Oy1Qntbxek8Ozk3P+P00Lpt7DZTu+75wjnDR84rAHgTOBcijcEXI=;
Received: from p5dc58a38.dip0.t-ipconnect.de ([93.197.138.56] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gkknh-0003Lb-1O; Sat, 19 Jan 2019 08:12:17 +0100
Date:   Sat, 19 Jan 2019 08:12:11 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     "J, KEERTHY" <j-keerthy@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, <paul@pwsan.com>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <t-kristo@ti.com>,
        <bcousson@baylibre.com>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [Letux-kernel] [PATCH v3 3/3] arm: omap_hwmod disable ick
 autoidling when a hwmod requires that
Message-ID: <20190119081211.73844b6a@aktux>
In-Reply-To: <c2c283c5-d1f7-8b65-a19b-0c4af80b722a@ti.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190116220429.9136-4-andreas@kemnade.info>
        <20190118154807.GV5544@atomide.com>
        <20190118181827.7163bee4@aktux>
        <20190118183630.GX5544@atomide.com>
        <20190118203832.3be7975e@aktux>
        <20190118204204.44db353f@aktux>
        <20190118194802.GZ5544@atomide.com>
        <c2c283c5-d1f7-8b65-a19b-0c4af80b722a@ti.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QOboxb.j5kj7pmjtWLwyAwN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QOboxb.j5kj7pmjtWLwyAwN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Jan 2019 12:09:48 +0530
"J, KEERTHY" <j-keerthy@ti.com> wrote:

> On 1/19/2019 1:18 AM, Tony Lindgren wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [190118 19:42]: =20
> >> On Fri, 18 Jan 2019 20:38:47 +0100
> >> Andreas Kemnade <andreas@kemnade.info> wrote:
> >> =20
> >>> Hi,
> >>>
> >>> On Fri, 18 Jan 2019 10:36:30 -0800
> >>> Tony Lindgren <tony@atomide.com> wrote:
> >>>
> >>> [...] =20
> >>>> til the next workaround.
> >>>>     =20
> >>>>> That flags also causes the iclk being enabled/disabled
> >>>>> manually. =20
> >>>>
> >>>> Yes but SWSUP_IDLE for the interface clock to me currently
> >>>> just means:
> >>>>
> >>>> "manually enable and disable ocp interface clock"
> >>>>     =20
> >>> well, if we want to manually disable it and not automatically,
> >>> we have to disable autoidle or it will be automatically disabled.
> >>>
> >>> Disabling it manually when it is already auto-disabled (by autoidle) =
is
> >>> just practically a no-op towards the clock.
> >>> =20
> >>>> and with your changes it becomes:
> >>>>
> >>>> "manually enable and disable ocp interface clock and block
> >>>>   autoidle while in use".
> >>>>
> >>>> So aren't we now changing the way things behave in general
> >>>> for SWSUP_IDLE?
> >>>>     =20
> >>> Yes, we are, so proper testing is needed. But If I read those comments
> >>> it was always intended this way but not fully implemented because it
> >>> appeared to be more work like needing a usecounter (which my patchset
> >>> also adds) for that autoidle flag.
> >>> =20
> >> and there are quite few hwmods marked by this flag.
> >> And then there are those clocks marked by this flags (on am33xx) which
> >> do not have that autoidle feature at all, so the risk is not too high.=
 =20
> >=20
> > Keerthy, can you please test this series on top of the
> > related clock patches with your am335x PM test cases? =20
>=20
> Can you point me to the clock series that needs to be tested
> along with this?
>=20

https://patchwork.kernel.org/project/linux-clk/list/?series=3D66691

Regards,
Andreas


--Sig_/QOboxb.j5kj7pmjtWLwyAwN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxCzcsACgkQfb1qx03i
kyRCyg/+MZv6UlN4QxGeLwJk5wnOiM/377SC6ANjD+Wzdmxoq7SctKitaPsqbKIy
/uHLgS52AzILAELttWdnldgJxeroELE1JyChE+hgb3zOcapGbKkzN5JYdc6cr6vP
RfG8GwTjDbO1BOdYKzKwDvwINmHpfr4j78/eiC0xjuI/F1tVk0KYWW7tjjmwbFQs
xSf9/6k/a0nMcTGmZtjBTdorN2qIKBNepeOSLgjj+/6j+WWA3WkiyLsqOyiDxCbU
TN+VUUDT0tPTFWzZlL3iNlv5bKGWVDBaoYyps4PYzvSlBzQHy9wVmW1KLT9VGIB1
7bRO3t15DB4eqUNI8JGxRnEto+MytVXB6qIWdhkE2lLBH7j7G3z7rV1kd/vmK+Sy
q3mgdOG13gtz2T4kKDD4Jf7Zy70pc3iyx9PgO2piptj5rJME2uYtmKRrWWJIDJ++
Y2BLPEPfVBQpUFnD56DUCdB/+Agx2db7Hmp9FPT5h/V9lWstADz+uFYgMijjBsyH
C8x2uLsXka6WkrFhq9uqB4aFYyW7tNZuXfuAQnLzK7QjXzKnr/IJStCKTz5hH9tR
tiUxiCMG81IcCtbgZOgScq1pUAsjsff+lr4xuQlr+wlBeBg1USCSNdrNylCbnHyH
ipN2p3zN/3rZWcaLPOnwkhhuPiSVnsTjOhfp6YQxj3WwQLvPPj4=
=iCUZ
-----END PGP SIGNATURE-----

--Sig_/QOboxb.j5kj7pmjtWLwyAwN--
