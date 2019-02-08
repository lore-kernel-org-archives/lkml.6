Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E6DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C6C21908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBHVsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:48:52 -0500
Received: from sauhun.de ([88.99.104.3]:59954 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfBHVsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:48:52 -0500
Received: from localhost (p54B331AB.dip0.t-ipconnect.de [84.179.49.171])
        by pokefinder.org (Postfix) with ESMTPSA id 3DB5B2C282F;
        Fri,  8 Feb 2019 22:48:50 +0100 (CET)
Date:   Fri, 8 Feb 2019 22:48:49 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
Message-ID: <20190208214849.GH12451@kunai>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline
In-Reply-To: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 11:39:58AM -0800, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so
> cases can be happened that this master tries sending data through
> the master_xfer function but slave data from a peer master is still
> being processed or slave xfer is started by a peer immediately
> after it queues a master command. To support multi-master use cases
> properly, this H/W provides arbitration in physical level and it
> provides priority based command handling too to avoid conflicts in
> multi-master environment, means that if a master and a slave events
> happen at the same time, H/W will handle a higher priority event
> first and a pending event will be handled when bus comes back to
> the idle state.
>=20
> To support this H/W feature properly, this patch adds the 'pending'
> state of master and its handling code so that the pending master
> xfer can be continued after slave operation properly.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Hmmm, the #ifdeffery quite increases with this patch. Maybe it is easier
to select I2C_SLAVE in Kconfig? I'll let you decide.

My code checkers found this:

    CPPCHECK
drivers/i2c/busses/i2c-aspeed.c:694:10: warning: Variable 'ret' is assigned=
 a value that is never used. [unreadVariable]


--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxd+T0ACgkQFA3kzBSg
KbYPvg/8CQ+tXkRGz8HmQGO9FCYbOYEFSlIz26yIOPrldRkZGuG+Kb+Fp+ges97e
hx0VXsi7KmaQZwQl3GI9sttzjbINY11XCpERgpEdPumbQD/q2aEeyl1n7HlJ3la+
Dpl5mzTO4Hma/PACdNoYY2PTYBrDz7GfrfiT5seRGr18Uc6LGlNMKGJnbPYrT5J8
ZZthhAmN0EB2HCSQ0KF4OGZX6QUV1TjX2mka0qvP/TzL0RwhVE/xhLXNGf6TUcBp
M7P7Was7AzUFETJdpELqSbL79tQH/2/1b2dGcG0ZRIXfo8DC4zekSlG5tprkA678
uh8INIeg1nPxjj2S4aoOvR28XuUnOhWD/idAWu2ZwzcPj1ntZy0NZqQAbJ3+FZAu
D9v7G8KZRbtMf6CGyBhZ2sVikTDwUkfErafXImXI0OesiBpB2c3m3ETS25bhiiHc
yOMKWLauSuyYf4sKqTcHobJtd1MV4kSn37opY/ugvknEEsqAJT6Z2uGNF5/LXgDO
ckyWHgFVkIZsDPkgeg+sCJZo+cLzaOMnPdUtNm0t+K7T4DaUL+tZxo+n3Hm8Qwvq
zgdgFxQCtk2Cq8flR9F9TD/AkCxFllMEUzDSavqm7ndxscaONWLvEddf6qxFrZT6
K8fymQrltfxpKmGc8r7LRnlhI728qamrLx/MKr/w96ByuPsdUgA=
=6dhw
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
