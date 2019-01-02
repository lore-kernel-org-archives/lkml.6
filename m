Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D18C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0754F20856
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfABWpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:45:17 -0500
Received: from sauhun.de ([88.99.104.3]:49120 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfABWpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:45:16 -0500
Received: from localhost (p54B3353A.dip0.t-ipconnect.de [84.179.53.58])
        by pokefinder.org (Postfix) with ESMTPSA id 9E6EE2DE754;
        Wed,  2 Jan 2019 23:45:13 +0100 (CET)
Date:   Wed, 2 Jan 2019 23:45:13 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V2] i2c: tegra: Fix Maximum transfer size
Message-ID: <20190102224512.GA2750@kunai>
References: <1546468519-2128-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1546468519-2128-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 02, 2019 at 02:35:19PM -0800, Sowjanya Komatineni wrote:
> Tegra194 supports maximum 64K Bytes transfer per packet.

Linux I2C doesn't support more than 64K of transfers as well...

> +	.max_read_len = 65535,
> +	.max_write_len = 65535,

... so you can simply drop these lines.


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwtPvQACgkQFA3kzBSg
KbYyhg//Tk0HSGMGXUeNh1I6iOG6YdKa6Nc2860yRcRCTv3zWSyjLh5M5XdHZYfn
wcyC0g0sa8NqNicyYi0/U/mGc6hnPdclAdXQOtDWpSp5bLzSjFCy1h1W4GvP5nz8
1opiKPIn2j6NWftnVGfM1+DJD0HWhk1zLPm7FwOizQ7Des4Y6s8fzPG7MnnhCKYx
moMevM6TgryERm5qAtdePLVX0N12JPBdHrIgRbFPmlVIZB7Y8K5R6sBlTPIHx30e
GOwmBwvh7x25qoejOZNVeuzafLiRiR4e1kOqdXSVA1L+91FAakdWb5YEINgCPEAt
Q1e38EmSVNHp7KiIiTUsTU3pxEBdY4bc7qp9+UryHAaoWnapC9HvVJ7dJD+5G3F+
3gXJcv7odrsEO92C1FyN0JDevFvxNdTQR4gPzbCdlKA6inYjY5VhyLXGdgACkaXr
9kO4u4A7ikPmheO7Dr5Qe5bDLmng5Qfd5dkUfA0hZRcfVEZpvKdr5ujd30Mp9CKI
3Rd0jgO5sdgSUzxmHey0VGQUpqZoB0h3d6lDdBPPK9+okaRXiZ1W2icFr/w/TZ5D
RVbgwl4XP47uC+kkAGI3Jhi7ZtmtkrNWlpHKI5bAX4EA9cMlEZkvUkBf9eqSN1FQ
zpY9Bgxz6cXTabWUyUWVrvggkIEfMB7wYBSBie9yV3QbGBhnWYQ=
=axrp
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
