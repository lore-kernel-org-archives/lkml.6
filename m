Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE39C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08B121D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08B121D68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbeHISIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:08:22 -0400
Received: from sauhun.de ([88.99.104.3]:46852 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbeHISIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:08:21 -0400
Received: from localhost (p54B3374D.dip0.t-ipconnect.de [84.179.55.77])
        by pokefinder.org (Postfix) with ESMTPSA id 5BED772064A;
        Thu,  9 Aug 2018 17:42:52 +0200 (CEST)
Date:   Thu, 9 Aug 2018 17:42:52 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     George Cherian <george.cherian@cavium.com>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jglauber@cavium.com
Subject: Re: [PATCH v2] i2c: xlp9xx: Fix case where SSIF read transaction
 completes early
Message-ID: <20180809154251.twazp6scrs57sih5@ninjato>
References: <1533796608-26349-1-git-send-email-george.cherian@cavium.com>
 <20180809153959.y6su5kxnwilkdhlz@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ohgxcwhw75czpbt"
Content-Disposition: inline
In-Reply-To: <20180809153959.y6su5kxnwilkdhlz@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ohgxcwhw75czpbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 05:39:59PM +0200, Wolfram Sang wrote:
> On Wed, Aug 08, 2018 at 11:36:48PM -0700, George Cherian wrote:
> > During ipmi stress tests we see occasional failure of transactions
> > at the boot time. This happens in the case of a I2C_M_RECV_LEN
> > transactions, when the read transfer completes (with the initial
> > read length of 34) before the driver gets a chance to handle interrupts.
> >=20
> > The current driver code expects at least 2 interrupts for I2C_M_RECV_LEN
> > transactions. The length is updated during the first interrupt, and  the
> > buffer contents are only copied during subsequent interrupts. In case of
> > just one interrupt, we will complete the transaction without copying
> > out the bytes from RX fifo.
> >=20
> > Update the code to drain the RX fifo after the length update,
> > so that the transaction completes correctly in all cases.
> >=20
> > Signed-off-by: George Cherian <george.cherian@cavium.com>
>=20
> Applied to for-current, thanks!

=2E..and added stable.


--4ohgxcwhw75czpbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltsYPsACgkQFA3kzBSg
KbZR6A//TTUy+d5WR759qa9//DOQICFzd9mB+/vxG23omvs16xE13YTNjJHOH5z7
F/Wt504apHkYa2ziXWCzG8dSQwhYKJI8D3fKGj3KhIR6Fqr93k4ZpcoJlrq1Ck9o
Wo6Jv9wC+j6mOwCN85zKu+N7Q8RsRxve7DZwS+PUqMqMB96d5U52fN0FklhCeBVv
ZLNbiuE/G2YhyYY3DgjQOoGUueLriGQDyFbTfyyXAY30VsU38K86RFMkmiP4Cz20
TKdlJvcq7YEn4olZzFPS6G/ccR3hUJelnWA2GVux2pm+KXD5+Hz3yDGz/tQGbG9p
vy4dl3bgoZYnqBMWHZy0oYecPmDNsjwlDZCKPSXRTKHKIDopEsJ7k4lwvQTrBnsz
YMURB7v7tY1G3hCU8LQCnwXagG28Xh1CpnakxUB5Qv0IvUPe2QIDUxTKTEI+l2bR
SNYRR6DZyEmXYRCJcF0svPKB17v7Hr90M1hNmAY12Q0rjG+yTBCTlEC1UQgCBNbk
kz/jqNliVj4Vn3dFGp7UuY8ZVR9FYz3C0/rLtZeenSiyyCFijvpQoY6UtBOoK3Jd
15ickgVZqlrkOXnC85CzH8h1fdgnTCOyUBFUeEDGVt358xEY8GyLiDMPszwSRyws
pVxY2+6LwF/Sd+pYIy5It494dEAfcqpb1iXqw3ZIdC+7os2GYuY=
=msB/
-----END PGP SIGNATURE-----

--4ohgxcwhw75czpbt--
