Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF62C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0402075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0402075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeIFXRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:17:38 -0400
Received: from sauhun.de ([88.99.104.3]:48188 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbeIFXRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:17:38 -0400
Received: from localhost (i577A6E95.versanet.de [87.122.110.149])
        by pokefinder.org (Postfix) with ESMTPSA id DB9462C058F;
        Thu,  6 Sep 2018 20:40:51 +0200 (CEST)
Date:   Thu, 6 Sep 2018 20:40:49 +0200
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
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
Message-ID: <20180906184049.GF8607@kunai>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 03:57:31PM -0700, Jae Hyun Yoo wrote:
> In most of cases, interrupt bits are set one by one but there are
> also a lot of other cases that Aspeed I2C IP sends multiple
> interrupt bits with combining master and slave events using a
> single interrupt call. It happens much more in multi-master
> environment than single-master. For an example, when master is
> waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
> SLAVE_MATCH and RX_DONE interrupts could come along with the
> NORMAL_STOP in case of an another master immediately sends data
> just after acquiring the bus. In this case, the NORMAL_STOP
> interrupt should be handled by master_irq and the SLAVE_MATCH and
> RX_DONE interrupts should be handled by slave_irq. This commit
> modifies irq hadling logic to handle the master/slave combined
> events properly.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!


--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluRdK0ACgkQFA3kzBSg
Kbbwxw//fnipr7fL2hTZUv5YPPPStXA0l+i/78PzHVW1YNbeHJih2fAM3UfbNllY
0dS+h8z1/b8u+BLOBsuBuYsWT4rNnecA8i7vW0KIZQ/0bjV+BjrK4L8Wu6XQf3bc
OYHpp8iNBilvGKnWvEXPDOi/x3WYGjVToEGGTWDRU+4VAfORbwijUG7bw6YQKBPr
9bA+7dSFgFXPDj2HgvapOo/foHcGdLeT9X4ydh4jHr3mbx1OsE2HrLQKR5UGAuoq
2aWmXQSpZNWwsf1OwOY2O5t0YZWzZS0rsqoJt1cS0qNtGeBG3Pm76joPm4S6yFMD
Xv4cM49BMZYFMuLIj391jz4vPM0AyqJEyCaYrz0V+V7vwgXskTAmHGS63skduLIj
ytiB+ogvIDTIem3e5/Yl3WMQP32ViWaVGRDJj+tUU3zFuzrIkFvOTwDmaH6eN8oG
86nyhmkjli8V/XJ4z6sWxd8QJNj4rUAuaetmQw65lIN47tviXcRpb3ZVhiOxLKSR
TI1IpRGJQ5j79KIYthxYS9pwIRqUYcv1dqdKUb75N9q1YHyaE4KDZUOGSpxwwDZu
Tlh3JIGTm4Uqg/CBlLJiPosZ06lvWi6ymhvMnNi1hFbq3H/iSksiD7P12zC3TZzz
LLsMUkE7jKR2Na2hA13nNlHfZZ/aISfsCtjZ/FHk6VIZZZs2ltg=
=4NGx
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
