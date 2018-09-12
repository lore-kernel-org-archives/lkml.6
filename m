Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E97BC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9CE2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmJKaLu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9CE2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeILPBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeILPBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:01:40 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 695592088E;
        Wed, 12 Sep 2018 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536746272;
        bh=jE2yHRWlz1cdeBgjo9yAlNaiKxQbJKl/LkF40tXqlqo=;
        h=Date:From:To:Cc:Subject:From;
        b=NmJKaLu1mz8M6KPW90DzsO+V/ljagz2RA8TDu70wMNEk6RrrDXGafCXhEfX+HkCor
         dutUp8cRFGucWAeQ+KXKgkjwmHII0AAIlzPmWeIyz0tb0G81Uy8UODfxehFxZUgnmK
         xDQRO8NzQil+ZMXIlS0ZNv4HfQ/H75p2WTBu2JKE=
Date:   Wed, 12 Sep 2018 15:27:42 +0530
From:   Vinod <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: soundwire fixes for v4.19
Message-ID: <20180912095622.GJ2766@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Please pull to receive soundwire fixes for 4.19, these include stream
state and lock fix on release.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-4.19-fixes

for you to fetch changes up to 8d6ccf5cebbc7ed1dee9986e36853a78dfb64084:

  soundwire: Fix acquiring bus lock twice during master release (2018-08-27=
 09:49:48 +0530)

----------------------------------------------------------------
soundwire fixes for 4.19

 - fixes in bus for
	- bus lock on master release
	- incorrect exit after stream configuration
	- duplicate stream state assignment

----------------------------------------------------------------
Sanyog Kale (1):
      soundwire: Fix acquiring bus lock twice during master release

Shreyas NC (2):
      soundwire: Fix duplicate stream state assignment
      soundwire: Fix incorrect exit after configuring stream

 drivers/soundwire/stream.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--=20
~Vinod

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbmOMWAAoJEHwUBw8lI4NHHZgQAIT2f7rKEl5UGBocbeI/Nvvj
82OIoiNe5p48yBvKxUPJqnvDygbsiRaP95DInOq2HpjM3kS4Gf3w3SblcPmPLa76
fAEnm7VZRY4+XJfVLQ1cHdeyDAfiVbkV8V7MvoUPxqW4rBxtQnNFFNMGYnxexh/1
XwUiMlJQt8kVbnvY22+oN6Ey6cdvvsZbphH8X7Da7KnkyBpa9bOUKSTqKN/Xgc5J
Un7PiOHWIL/q7zDtZC1gJte9m2LrPe5FCVlxndn+hs+nc2kDAZ7MYc9Hdrudh7+U
f1vV+OeA+UzRFezPlMMJazGtvGWXw1UlfxAeSIMCoigXfvzCLioZlI25m4adxAxE
+ojDgY93zzjs7sbLS94zSsyHfSPNmUGMclq3/bDdcELlxQ6TaVchl/bPdjpv0WPP
OGu52EWkA8w23uF6YiIVHHNKKsiF7Ee8TBS0wDnN9zhVCAqi2yehdv7xVVPWXhkR
LPZlqx99sX7Hw+Bl9HLTxSpDmrf+W8W8KGp0SahJof9d9Px7+/MKLCrQ+d9sKQWL
HTvjEa+BUCUt3GbCcGjoQSji+Zuxoc/j/Em2hUBOSFejGl5BGVO95Vl5v+YG0gKK
1xjH3XZ9/KTEHAMPNhe/LfG/jKRrZBhnZpfzdopqL5/cdsjhRDs8Cr05z/YEslws
I49b1WbMAv3vnrN7qMv7
=Cm4Y
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
