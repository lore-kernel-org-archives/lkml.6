Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD83C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC922190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbfBOIre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:47:34 -0500
Received: from sauhun.de ([88.99.104.3]:60138 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbfBOIre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:47:34 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id 3D2F22E3551;
        Fri, 15 Feb 2019 09:47:32 +0100 (CET)
Date:   Fri, 15 Feb 2019 09:47:31 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Clear current buffer pointers and
 counts after a transfer
Message-ID: <20190215084731.gy7khiydgyzgfsjk@ninjato>
References: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zp4qokiwiqe3hwav"
Content-Disposition: inline
In-Reply-To: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zp4qokiwiqe3hwav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 27, 2018 at 04:42:25PM +0100, Paul Kocialkowski wrote:
> The driver's interrupt handler checks whether a message is currently
> being handled with the curr_msg pointer. When it is NULL, the interrupt
> is considered to be unexpected. Similarly, the i2c_start_transfer
> routine checks for the remaining number of messages to handle in
> num_msgs.
>=20
> However, these values are never cleared and always keep the message and
> number relevant to the latest transfer (which might be done already and
> the underlying message memory might have been freed).
>=20
> When an unexpected interrupt hits with the DONE bit set, the isr will
> then try to access the flags field of the curr_msg structure, leading
> to a fatal page fault.
>=20
> The msg_buf and msg_buf_remaining fields are also never cleared at the
> end of the transfer, which can lead to similar pitfalls.
>=20
> Fix these issues by introducing a cleanup function and always calling
> it after a transfer is finished.
>=20
> Fixes: e2474541032d ("i2c: bcm2835: Fix hang for writing messages larger =
than 16 bytes")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied to for-current, thanks!


--zp4qokiwiqe3hwav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmfKMACgkQFA3kzBSg
KbZtrxAAohPOgZx5no3ThwDEyYTFd9bMJTKd+4Vz+n1rXHl2K9Ib1/rNfkPq9fiq
7HteQbVVbxw+KOLBUUjGBv6oqF7Wf7D6Im6JDEJvMINRXXvkyKODS/x+4QkPLmzl
4h+r2BkzJpR9Bd5hmWYvot8dia8sUM0qJpEGxKoxezbarIwK6gGeXBZb5hDm94R+
Qb2robryMxM5URI15D8wPFPUhnOxFhv01fRb1bVgJgcF1k2iBIFWHDU+13YGqgPX
v2q6DjebSMv/riI5o/wxOuM9o77cvYA8O8OKyc2bdtLxVuoi9yHIvR0LtG/t4ylS
ZODqbfhu2hk4qlqGVYaq9kYxtH0W/eiE7nTUpM8aNvqLKOrK0HVM6kCm2Tt+TBJI
XpZGBUPdS9YHv5bWJEQvT2svoli0whFKa16glpK3lzl7f6e2xxG2rqfV4xiqaZSt
vW+x2XO07lvZgVYBi/PyfPD+WazQZaZdxk8kWuYwO6KN8if4h8ltoqrfbbhFGQGa
Bs/kFkddb5hzAXBPUdHGr+dEgKT9VrIEYRrdc1PtSeSrbOFeu+xJviH8zgnlar56
romtLgZ3AoxcColAq7JFrMa1ZiYI1torjIxfMFtoNRZZv/JxgDMPuaSwCBMywlxZ
joUf0GbmiGtLW+zMeTb0B6RNTVMimxXB/XqQ0rirCkv8o0N0oP8=
=JjNL
-----END PGP SIGNATURE-----

--zp4qokiwiqe3hwav--
