Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B8C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0042720881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0042720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeGIWUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:20:48 -0400
Received: from sauhun.de ([88.99.104.3]:37208 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754406AbeGIWUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:20:46 -0400
Received: from localhost (p54B337BD.dip0.t-ipconnect.de [84.179.55.189])
        by pokefinder.org (Postfix) with ESMTPSA id 66E1C56A485;
        Tue, 10 Jul 2018 00:20:44 +0200 (CEST)
Date:   Tue, 10 Jul 2018 00:20:43 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: tegra: Fix NACK error handling
Message-ID: <20180709222043.5x627xxpf337uzeq@ninjato>
References: <1530608143-9222-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xo4b6y6k67pplbq"
Content-Disposition: inline
In-Reply-To: <1530608143-9222-1-git-send-email-jonathanh@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xo4b6y6k67pplbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 09:55:43AM +0100, Jon Hunter wrote:
> On Tegra30 Cardhu the PCA9546 I2C mux is not ACK'ing I2C commands on
> resume from suspend (which is caused by the reset signal for the I2C
> mux not being configured correctl). However, this NACK is causing the
> Tegra30 to hang on resuming from suspend which is not expected as we
> detect NACKs and handle them. The hang observed appears to occur when
> resetting the I2C controller to recover from the NACK.
>=20
> Commit 77821b4678f9 ("i2c: tegra: proper handling of error cases") added
> additional error handling for some error cases including NACK, however,
> it appears that this change conflicts with an early fix by commit
> f70893d08338 ("i2c: tegra: Add delay before resetting the controller
> after NACK"). After commit 77821b4678f9 was made we now disable 'packet
> mode' before the delay from commit f70893d08338 happens. Testing shows
> that moving the delay to before disabling 'packet mode' fixes the hang
> observed on Tegra30. The delay was added to give the I2C controller
> chance to send a stop condition and so it makes sense to move this to
> before we disable packet mode. Please note that packet mode is always
> enabled for Tegra.
>=20
> Fixes: 77821b4678f9 ("i2c: tegra: proper handling of error cases")
>=20
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Applied to for-current, thanks!


--2xo4b6y6k67pplbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltD37gACgkQFA3kzBSg
KbbcMhAArzo9LdUX56To43qMeyV6CEgGkqMHimspA76H325QhBdYLTTNU7JmD+u+
zvEF17a/PqbVX7a1SxKUdwdpQ/v5TieLuXya1iWw8rbFF93bSpZPkUCm2ceFn59G
RO3KHoUEx6mgG6FE2m9/2kkqsj+4prTZr2n979hvEFFxy6NsHE4zLzRIhoNlHo2d
glrGjKPOtdIm9O4HwMSA48S8C2O1dnj+MNXgPyA4t/uqfA6LBTVvg92L++/2Rfof
7Usm973Yd4B/XqHH9QzWlics+QnfRdOyWWkAeeo8ujnzBiOYJAamM/mFv0vBi07O
BaZicPaEmW5JWES8gQj9wJkD0wrldEnlJBmR1PR3F7bkeZqU3fnZbj2S9v6TXM/1
Wfm7jB6gHvTZZt62QDkwNNah1VmCdgXwe5cBQJNlDjmjNEpmURLoMtBC0tU22paY
QLt65BRX/IPGNMriXp3uJbkgkTUcbi8tNG4PZUR1ZgYPzktcsgAVnb9kqPIi/chw
wg5SzAevRz82c6x8fXdONoJsfxUURfD8/pFrQZiuNA2RKF2foSo7foj2x4VHpNT8
wqU7/aWdYo6cTk3d/+2kHtUt3trNUNsLPHfigUnLJ79UrEwelBfZpiixgkv4GOYk
H31Nr9G0zoqwGqllP8qnb38fpqv8K8jgL0nNmIYOZQe6ksiCCp8=
=FktC
-----END PGP SIGNATURE-----

--2xo4b6y6k67pplbq--
