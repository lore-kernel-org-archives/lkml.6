Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C138BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E8E20834
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ChrurXIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E8E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbeHGFyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:54:50 -0400
Received: from ozlabs.org ([203.11.71.1]:44603 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbeHGFyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:54:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41l0hR2QWlz9rxx;
        Tue,  7 Aug 2018 13:42:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533613351;
        bh=NmTYf0ZVjso5WpEXO4qY/C9LFoRn0+4lCzVYtCXQheM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ChrurXIrATnhDclItE+gBiAB/wG+qdjqOhFbPNQLvZ+rTujlPrL126+SiEozCLXkP
         DHpne/rRm5dluRHk/sXNHrtcv6PxGpnf1N4qnW+snwmy9qPeQDKjqzKr230+0oDKiM
         bMqXtmR2uE700ybB0oC/y5p2mnvf1hFRdl69zCglUdgC2ef8oxxjewVwS5ECO6VshN
         nHwtIy3JCEK/VVSTCr86jCYUl4PySA6WM+svV+PKdP9yCIGt6j4yP7WZLxruHVbGZ1
         ACqUfoHxabiSlVEO6bCR5E/vunGCawIpwqa1acUq7XSKom8C37j2WHm9d6eG9ZUuf1
         qCghaGD4Jd0Xw==
Date:   Tue, 7 Aug 2018 13:42:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bob Tracy <rct@gherkin.frus.com>
Cc:     linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [BUG] 4.18-rcX iptables regression
Message-ID: <20180807134230.2b20d73e@canb.auug.org.au>
In-Reply-To: <20180807010049.GA1345@gherkin.frus.com>
References: <20180807010049.GA1345@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hxcJu+bhGcmBQfjaNVpzgwo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hxcJu+bhGcmBQfjaNVpzgwo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bob,

[Juts cc'ing the netfilter and netdev mailing lists]

On Mon, 6 Aug 2018 20:00:49 -0500 Bob Tracy <rct@gherkin.frus.com> wrote:
>
> With iptables v1.6.0 and kernel version 4.18-rc7, "iptables [-t table] -L"
> produces diagnostic output to the effect of not being able to find the ta=
ble.
> Kernel version 4.17.0 and earlier work fine.
>=20
> --Bob

--=20
Cheers,
Stephen Rothwell

--Sig_/hxcJu+bhGcmBQfjaNVpzgwo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltpFSYACgkQAVBC80lX
0GwRygf/b8r16ngF0z/iY6IABeqoqJXjN6AzRP5Cf+MsiCbm68mcXLVUJPnbsIql
afjk+/PKccdMdl8/qH1CvszH9CQUo1PdzS03/Qr6HkaHBV1dJSkllR+oI0OZ8ZpR
R00bbSiEVprTbcMjaNNhGGwLJZ9+ziSs42eqnBWilbzyISL+Q/Wm6Y4PUuNUAXZl
F6Z8g7aCf5MTrGAV2dpRhLAghi2IyNLqCHR890a+Lh+vKRumF/ljt+JDchaQS5P0
vIuMJlp8RBLK5xk29mcQvg4AiU6Hp+Jdvz29RUXTczO7mFpsG1tjiO26Hs/huRqo
JdTVz/gTgb5S/dMmffeXRG7xzWOudw==
=Iwza
-----END PGP SIGNATURE-----

--Sig_/hxcJu+bhGcmBQfjaNVpzgwo--
