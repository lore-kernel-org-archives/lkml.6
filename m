Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A3AC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085F21D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0085F21D68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbeHISF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:05:29 -0400
Received: from sauhun.de ([88.99.104.3]:46830 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732063AbeHISF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:05:28 -0400
Received: from localhost (p54B3374D.dip0.t-ipconnect.de [84.179.55.77])
        by pokefinder.org (Postfix) with ESMTPSA id EC57172062F;
        Thu,  9 Aug 2018 17:39:59 +0200 (CEST)
Date:   Thu, 9 Aug 2018 17:39:59 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     George Cherian <george.cherian@cavium.com>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jglauber@cavium.com
Subject: Re: [PATCH v2] i2c: xlp9xx: Fix case where SSIF read transaction
 completes early
Message-ID: <20180809153959.y6su5kxnwilkdhlz@ninjato>
References: <1533796608-26349-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="442bub4pf5phc3fj"
Content-Disposition: inline
In-Reply-To: <1533796608-26349-1-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--442bub4pf5phc3fj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2018 at 11:36:48PM -0700, George Cherian wrote:
> During ipmi stress tests we see occasional failure of transactions
> at the boot time. This happens in the case of a I2C_M_RECV_LEN
> transactions, when the read transfer completes (with the initial
> read length of 34) before the driver gets a chance to handle interrupts.
>=20
> The current driver code expects at least 2 interrupts for I2C_M_RECV_LEN
> transactions. The length is updated during the first interrupt, and  the
> buffer contents are only copied during subsequent interrupts. In case of
> just one interrupt, we will complete the transaction without copying
> out the bytes from RX fifo.
>=20
> Update the code to drain the RX fifo after the length update,
> so that the transaction completes correctly in all cases.
>=20
> Signed-off-by: George Cherian <george.cherian@cavium.com>

Applied to for-current, thanks!


--442bub4pf5phc3fj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltsYEsACgkQFA3kzBSg
KbanCA/+Jam9ZhdgVQYLYpQ8vsiumEOKeHVyXTvURWBjU75HtBAJmlakVIc+B/O0
/xuqSor2PuB0qO1cfrxj7zHAF5aIUqpdoRpuUIPzEWSi6UGpJFsBB4rnenr/Mn3s
K55739eLgK5qDMt2uR4aiHUavoMnEzH25oYSax2oEbyoYL2hb7y9dQN5fsC+f8j0
HR59rPfzhyO7+k8BitGiPfJinXTdALW/utSWpgTwQtZbmBvDp52hk/hOekAfWLbT
o6h0nNXzB3EXTxyaY7/HP6PRGq0IWrBLXQkji91MFGwqnEpY6rYojHkkW09mItRJ
F5+ibOya78zc70V6j4hsBbC5ji0P4MmU9wpP7hE60iKTPyc+clXKfr+4Y+1LP4lC
RD2fAjBlTcsql0uOADKkxcuRapUP6/sCVWxt+XeYa3HO6awtxgRIrrkhGwAzOyC9
jTgr1BKz/dIVzpTMbp36Izodh2uEhskqmhU4fBD07phg+Tc6OMuOr3nZLwuK7sAM
C8sTYLlw7XKJSaB9Wy5JPneaFEdTp5jtDp8RdKMLrE+JB7O6pZ1jYEygOdMab2cC
omPJ+6CRy03hDUpcfAlCON2v06xz1ZaLEROn6BNFg9t6DTlzuU0kq7ws8uPiyg9+
P51YM4olAoEnVt4WtB0heWLRWTdRn3sDtcSp/SxF929pBgYTmhk=
=2E0D
-----END PGP SIGNATURE-----

--442bub4pf5phc3fj--
