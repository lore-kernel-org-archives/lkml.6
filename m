Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FF8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6642086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6642086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbeK0WgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:36:01 -0500
Received: from sauhun.de ([88.99.104.3]:57088 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeK0WgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:36:01 -0500
Received: from localhost (p54B33299.dip0.t-ipconnect.de [84.179.50.153])
        by pokefinder.org (Postfix) with ESMTPSA id 7AC2D2E3542;
        Tue, 27 Nov 2018 12:38:22 +0100 (CET)
Date:   Tue, 27 Nov 2018 12:38:22 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/5] i2c:ocores: improvements
Message-ID: <20181127113821.GB1107@kunai>
References: <20181029145051.31984-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20181029145051.31984-1-federico.vaga@cern.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This patch set provides improvements to the i2c-ocore driver.
>=20
> [V1 -> V2]
> - replaced usleep_range() with udelay() so that the polling version can be
>   used in atomic context.
> - added dedicated patch for minor style issues
> - fixed delay computation
> - use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is alw=
ays
>   necessary and a trylock would generate an extra interrupt for nothing
> - make the driver ready for an eventual master_xfer_irqless()

Peter, do you have a time slot to review this?


--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlv9LK0ACgkQFA3kzBSg
KbZpVg//Ys16rW3F1UCl9U1nMvkuhOP/F+yTVZJUgObOPYYh2kbw/V2M1RysAEW/
gcYbHiC9Q7S+MDvn9457S5PkVmJwdEQZ0lbSKHdibFvJh6TxCNNpze7KzO+IAfVf
KUh81g8NOjNQRPfsZEFMOlgOzFXOazfV1HHoj74JQD9rnHYBnZf6FNCq4gVJaOT6
HcYsGPtLk35r1l4H3XKqBrkIXi0c1eTLXKOSd4mSbxbKvM1GKhiIKOfaXt5Kbqjq
CO3PMaGl1PIYBNMWF1xvI2VOKRVv+sVwF4qOOidV7UySeRB/nYvlVLWOyWoLMlD8
jtq4UY33tJ+gWOfo7cDYJaleHca3TMemoSsE4tPM+E/vrDRf8Erhscmd3soxbAwt
RnM43/J1BTIJltlY4l7dvIMxTN8DvQBwqgV6Klmfvt0PMTd87oH62zmOR9ati3fX
mZAVkyBlFKqtfcwkKl3hSW7FRzKX5vsA2fIJOLIVgfnSL29bx6LKLNhgN03UYCww
hlfijx9iYVbwZ7qw/B8sOiDm10X8tlIeY4ixZun27caRltWxXT4/FVSd66wOP4OS
9DTi0A9yCDavEa87a7n9uoQiBowTwRMQMW5sUnB2d8j8WVYtL+HZp7vQzGeGcASo
IcrF+R0l92d/lSMVexIz1Ge0ksip/jYQnCdSblCgptDDZ27towU=
=EItn
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
