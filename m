Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A7FC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDBF206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0XBKdhIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDBF206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeJBVHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:07:15 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B323206B2;
        Tue,  2 Oct 2018 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538490216;
        bh=T5oXuWlWI9g8ZoXmiq/871JqmR91wxlWvHPwMgX8v18=;
        h=Date:From:To:Cc:Subject:From;
        b=0XBKdhIM51JmZeiqr0FXo0gpKthiI1HRlrxBWCN4CMw3ZD9M0FpGhGA5uDNLjsuUt
         4Y5dhecAnGpSLIK6pRK7GMlG9xocK8GlwvOIU3oUZYVHL7RU3JC2yuP9q9CXc5SLax
         Xxx7P1Lb/oF3L/+s66YOdivBuqsc28IlIaqwri5U=
Date:   Tue, 2 Oct 2018 19:53:27 +0530
From:   Vinod <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [GIT PULL] SoundWire updates for 4.20-rc1
Message-ID: <20181002142327.GA19792@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

Here are the SoundWire updates (again) for 4.20-rc1/5.0-rc1
This brings in the multi-link streaming support and rst format
corrections. The changes are in linux-next for quite some time.

Please consider pull to receive:

The following changes since commit 8d6ccf5cebbc7ed1dee9986e36853a78dfb64084:

  soundwire: Fix acquiring bus lock twice during master release (2018-08-27=
 09:49:48 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-4.20-rc1

for you to fetch changes up to 502c00d9c3159e7dd3184b0e7c2cd0c0446d2546:

  Documentation: soundwire: fix stream.rst markup warnings (2018-09-17 09:1=
2:36 -0700)

----------------------------------------------------------------
soundwire updates for 4.20-rc1

 - support for multi-link streaming
 - updates in intel driver for multi-link streaming
 - Update Vinod's email
 - Fix rst formatting

----------------------------------------------------------------
Randy Dunlap (1):
      Documentation: soundwire: fix stream.rst markup warnings

Sanyog Kale (2):
      Documentation: soundwire: Add documentation for multi link
      soundwire: Add support to lock across bus instances

Shreyas NC (5):
      soundwire: Initialize completion for defer messages
      soundwire: Add support for multi link bank switch
      soundwire: keep track of Masters in a stream
      soundwire: intel: Add pre/post bank switch ops
      soundwire: intel: Remove duplicate assignment

Vinod Koul (3):
      soundwire: Handle multiple master instances in a stream
      soundwire: intel: Fix uninitialized adev deref
      MAINTAINERS: Update Vinod's email

 Documentation/driver-api/soundwire/stream.rst |  36 ++
 MAINTAINERS                                   |   2 +-
 drivers/soundwire/bus.c                       |   6 +
 drivers/soundwire/bus.h                       |   4 +
 drivers/soundwire/intel.c                     |  68 +++-
 drivers/soundwire/intel_init.c                |   2 +-
 drivers/soundwire/stream.c                    | 488 +++++++++++++++++++---=
----
 include/linux/soundwire/sdw.h                 |  12 +-
 8 files changed, 482 insertions(+), 136 deletions(-)

--=20
~Vinod

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbs39fAAoJEHwUBw8lI4NHpx4P/ig6o8pdqsdmoOrVhtLVjr0p
8jLgoKudCbBTKm5iJWhOsjntaCsTefeQVACGhf7MnDNU6pLx9BYgcBwtDArs4+Xz
wWFbMwHFycgRrL0Kh6ze8oHREVeShs7XXYqziNsF4gOiGB6fv9rxidyfqTzvTFG5
ROqaeXs4acHQD1Rb/4yqAWHnBfBKfbyrPK1Drtqm3kpSjWfAeyOVI6/0ypfU2qMJ
Pu7SpClcNaw4PugssBMdBbRE3pDdxTzELl9h/leRGzFvUV8nxR4jYZYBX0CGgK4k
pqG8k3JVZzDphl/cAM2lPjshfWkgTzeRY1wgq8QD/D1xQHlz2Ovd4SHqRANEFkZR
xi5GC5kve4s0EiKixKImYMCtjRpFnvG3Ein5yR2M78SWqkU+BZ4M9BWPrsRbTQdc
3IIdnIJrnEHj3HX4jS9CB2OhpyBnRdnQxnYQzdkGJvjA/6IET5P2e2HKmWEFPbA3
Pz/n8I/cYWJWYwC2DdosZeneUZPC9k+H1SSV8dfReq/HbE0pQzMyTpA0QYf3Qx6+
zSrNW9NMXtCOHeIPUMkm77jgl8KOa5vyiMUlfkMjwj0Ko0JUlRUAvQl34b/vNTpr
otfuVryChcQTnf+M9RWSl2QigizFdu5vIsN55gPh0wIwrpdckqzGqWKYJe0qu5xT
bQWqrqWamBgoPPnigRKH
=w/xC
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
