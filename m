Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC63C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBF520820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Czei7OQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfBDSfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:35:46 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:54658 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfBDSfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NGO7Ic5XZkItH3LF0+bIv+Wx3vHk3m8cWCn1TQooGOg=; b=Czei7OQVfTM4QpPuefeIDbCL4
        W/sEL8v3ap8UPFvwMWHiQ33x1SBJzx/rS6UvNBYNmoJs0u6Y4k+FzqZv7J/dyspLLW5LYvgCj1zRd
        Kn6YlXupfo3EdWKVo0aZJYS6RNvI0sGMnDC8iZlE58ELNLbk1pC4uzu0922hY686GizCM=;
Received: from p200300ccfbce42007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbce:4200:7ee9:d3ff:fe1f:a246] helo=eeepc.fritz.box)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gqj3Y-0004E9-II; Mon, 04 Feb 2019 19:33:20 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gqj3W-0007Ts-VX; Mon, 04 Feb 2019 19:33:19 +0100
Date:   Mon, 4 Feb 2019 19:33:11 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux@armlinux.org.uk, khilman@kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Message-ID: <20190204193311.102a60e6@kemnade.info>
In-Reply-To: <20190204155604.GH5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
        <20190204155604.GH5720@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cZTCPF4_0JCD8_K5dVyf4=+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cZTCPF4_0JCD8_K5dVyf4=+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Feb 2019 07:56:04 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190202 06:01]:
> > Enabling off mode was only reachable deeply hidden
> > in the debugfs. As powersaving is an important feature,
> > move the option out of its shady place. =20
>=20
> How about let's enable always if we have the twl4030
> configured to allow it? You can just check if the dts has
> "ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
> properties set.
>=20
> In order to enable deeper idle states, the user space still
> needs to idle the UARTs and possibly other hardware blocking
> idle. So we should be safe there.
>=20
Let us not mix up runtime pm and system pm. The uarts need
to be idled for runtime suspend, but they are off/ret for
system suspend without userspace intervention, so allowing off mode
will have an influence even without uart runtime suspend,
and also probably for other powerdomains (non-core/per).
So we still need to be sure to handle at least some erratas and
context save/restore correctly.

Your Idea seems to be in pseudocode
if (powersaving_wanted)
	enable_off_mode()

I had something in mind like
if (system_is_trusted_to_handle_offmode()
	enable_off_mode()

Regards,
Andreas

--Sig_/cZTCPF4_0JCD8_K5dVyf4=+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxYhWcACgkQl4jFM1s/
ye+kpxAAtyNv7KqReXE73tqndnZZKlspBriMnP2PreLqcpI8myQPpBCb+aCtP+AS
q1HAXiiMZVF41tdQ8cDXpEQPi537pGz7bmLxh+QLdAMrh6gVweUtBPX3dLIdn8+B
lC+3awFj4B9d4jNCveHh8OeAb7mDYZN9XZDzSBaJztcXGNsY9P4sr57Ird4NzoFc
A2zGUSofbgVKN2JPZT7FaSnv8sgd4khFwAV5FbIVK1R5gFWyj8ZCsnpdVSHYQIEd
yUM9qTtYshGLs/0W19h6SFxlLk+2qCiLKdslXUytkpdcHZ/0zL6rJtHSIhlua+Gc
UH6DoPhRO5Qo9Y63fy60lyRFm5cMeAosghDfzhvEBt58doLJVPwi06coRY/Tdmxn
gK8/YSMTt+S1Sj3FvDODxsOACg1MxzdBwcG/sGQDBzV/8iyiiyA28WWcHFcNiQJ7
wzPPk8FMHRP2oipVIj7gQVz2Q+HvD+stuJhS8SPIiNKmNeZSdF0qh1s7kCrOfK+6
RQUNl2goH2+8ldkWhCdcswfGQyhpr00cdhxoxrKSaat/roLpbyTalGx/cm9lgoPH
UkXzWKVTaqdjrN7/VxWjzamgjy4VMnq99BuF91UaOz0a63KPO6ob6cW+jVdtJ/I9
m/TeKon7/F+zxpuDxk5QWyZlA7YTFhzhCCMGXybBl9nX7m+bovA=
=sAHi
-----END PGP SIGNATURE-----

--Sig_/cZTCPF4_0JCD8_K5dVyf4=+--
