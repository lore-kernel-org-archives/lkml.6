Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35CAC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A7820643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="OHmSmIqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfBISyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:54:05 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40540 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfBISyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0eU1k6dX8J0XmRThAkqgj7y8wKku6XnImH23mgoaowU=; b=OHmSmIqLhaj7FAhSftbeHTf7u
        zDzRphDm/wTnspAFcatAYM6hPLxRwKCPGlTXtaK55nSyCP2aexvr+TyNK/S+r2LMyOYNu/i3/8MF4
        dRTgOUD6HImQLOZmMk7MB1pW7/RCcBGFkoqOM8LZBsw21oJYnaY/T1cX42kkKwgAXzzIQ=;
Received: from pd9e2f9b9.dip0.t-ipconnect.de ([217.226.249.185] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gsXlA-00068z-L6; Sat, 09 Feb 2019 19:53:52 +0100
Date:   Sat, 9 Feb 2019 19:53:39 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 0/3] mach-omap2: handle autoidle denial
Message-ID: <20190209195105.74bb9085@aktux>
In-Reply-To: <20190121195803.GH5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190121195803.GH5544@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/65=PCPS8TYCcaoYbPhBie0B"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/65=PCPS8TYCcaoYbPhBie0B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Jan 2019 11:58:03 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190116 14:04]:
> > On the gta04 with a dm3730 omap_hdq does not work properly when the
> > device enters lower power states. Idling uart1 and 2 is enough
> > to show up that problem, if there are no other things enabled.
> > Further research reveals that hdq iclk must not be turned off during
> > transfers, also according to the TRM. That fact is also correctly descr=
ibed
> > in the flags but the code to handle that is incomplete.
> >=20
> > To handle multiple users of a single ick, autoidle is disabled
> > when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
> >=20
> > Changes v3:
> > - replace CLK_IS_BASIC
> >=20
> > Changes v2:
> > - uses spinlocks instead of mutexes
> > - invert counter logic
> > - check whether clock type is basic =20
>=20
> For this series it's best to merge it all via the
> clock tree along with the related clock patches:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>
>=20
hmm, this is stalled. Have I missed any new objections?

Regards,
Andreas

--Sig_/65=PCPS8TYCcaoYbPhBie0B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxfIbMACgkQfb1qx03i
kyTzzA/+OHsIwacb/G1qQhvkuTCOcU9XvIV82zhtLWKSzN/JCUJCTcYHaRzC1sHq
6SkA7Tyc9fDeXrpgZFhI62C0eIuIYjkZ/894LxJkkKrJvEepezJbpU7FWaHohJSe
vqWUUnjvh5ElSt+/4cjk2xukWiET0P2PwRvkZPLMEeFNr2n1z7zBqsbjG3tfuHln
IgstegDhHVUj/m1h8wI76V9cbAOavlH9pU5eG5qd5fa+fg1QYUlYlKRUkohWYczJ
mF7P1GXpEFoFTr+QNIcOTSWXXPrbt4iKfDfNn16oRCpApFs8RCYZw7zpB1T7PEEu
uOApIJm8sntuSmA8+JLEwNcDZOD8ZbJu8f/3Le6nH47qe20ViiecptQmcxYFR4CJ
AE96FYpVk0BPZNu52r4IUsdTv/l//tH5okj06VmkwB59ovICpGFAICMwlIOl6Wn6
eOV+F2c/C+07aRTbQ2sYaHOuwxn1xOKaWg5+NfbIL3BYT1VgdHF4woWfapzhsO6w
2rNwMH6e65/X00oNirC2e3ykP8FAcQZQKRXWPGBOT0ypjdbYfsBGk7Ojs6HIFk0W
h8/uAOJbnGlMTLO+eN+4+3Wfdsmbc9K1Knl3tQHg8T8gXgaehpyuNvAj+iaFFXXr
tpiokpKPJUC/ZQ1+bAzZHraVRqJ3EhK+tvbbp0bMm6aV6TKnyWc=
=uXmU
-----END PGP SIGNATURE-----

--Sig_/65=PCPS8TYCcaoYbPhBie0B--
