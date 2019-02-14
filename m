Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58796C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E959222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbfBNRCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:02:33 -0500
Received: from sauhun.de ([88.99.104.3]:54220 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfBNRCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:02:33 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id 5E4372C2817;
        Thu, 14 Feb 2019 18:02:31 +0100 (CET)
Date:   Thu, 14 Feb 2019 18:02:30 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rostedt@goodmis.org
Subject: Re: [PATCH v3] i2c: core-smbus: don't trace smbus_reply data on
 errors
Message-ID: <20190214170230.dvm4i2wxmgxij4bg@ninjato>
References: <20190213034057.244716-1-jsperbeck@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="phfr5v3ila4kfyxj"
Content-Disposition: inline
In-Reply-To: <20190213034057.244716-1-jsperbeck@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phfr5v3ila4kfyxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 07:40:57PM -0800, John Sperbeck wrote:
> If an smbus transfer fails, there's no guarantee that the output
> buffer was written.  So, avoid trying to show the output buffer when
> tracing after an error.  This was 'mostly harmless', but would trip
> up kasan checking if left-over cruft in byte 0 is a large length,
> causing us to read from unwritten memory.
>=20
> Signed-off-by: John Sperbeck <jsperbeck@google.com>

Applied to for-next, thanks!


--phfr5v3ila4kfyxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxlnyYACgkQFA3kzBSg
KbZaEw/+NZvurPqjr3PWQqctg8PTGEw4RgkftxoIXmazaed8cCYoj3XpqQ0EP8jZ
Ur+GbUtMaPpO7bUjSG2jmlMeKW8kxJXFy9HwtSlZYBMK6GH/Yy4UqqPEPK+FAQt9
sIPzrnRMeGb4yxQY7fH9E/O0xHoR35cszDdwkwfhF31dpIrZAuFwDumSP6LdHeTs
9QKK/R1+gCegEArc4n+mb0Xpla7FLV03VD8DlEnUY8vvhWQyprmr1UK6SZ1r+HvD
AHTrM34kgrSBXSD28GP5s+r9AvdUgMvMRmHol9Ph8Mt2sp9ndwMs+IRL3OEsHBAw
22eBPJI7UixhQHWw03dbJ5jsd9J3SmTvD6KWoF5jyTqW9sd01vknob8fdOkH5Ec6
jnXSG4ixes9ILqHO+B+MQfhOnHxgXPE4NJGbktzdKCOHvajKiIplSDhZsBgTvmL9
ELj4tuBcifBfYGbeZDO6hwSLacwULrcGqMv4iMRMyQRnHWFvvHjpZPqucHgRCbJP
DSxaINCgfcsS4W8Cmd1FhrmsaHgk1WbbN0MkfuqjEkGtuGH6ld+10ENZArnxZU6F
kOZtyYKuj5oKw/Ayx0LJbHcDPNTYMjLqypmPjOrxtMMwDzG+qGqX2gaS1bQy6QP8
O52fD4NVHNkcIAtA+ROjGeqeOHYM3nWWBu01F2VmmER/s+yAx3Q=
=uqJ3
-----END PGP SIGNATURE-----

--phfr5v3ila4kfyxj--
