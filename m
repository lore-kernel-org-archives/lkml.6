Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A1C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DED3219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHqmRnb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DED3219E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeHHSt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHHSt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:49:26 -0400
Received: from localhost (unknown [122.167.122.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE54921776;
        Wed,  8 Aug 2018 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533745739;
        bh=2c/bTfJAVUlDiMsyTn6q8ruptXrrRYzOKPOr1gRk18Q=;
        h=Date:From:To:Cc:Subject:From;
        b=vHqmRnb6NY6ex7Ey39JQBh6K97My0QBs7lfzd94hOLPqVguJAI3/tuY4nlKV+LYhL
         ayBHoQX+/3gh6z5FyN7syPrCaPUhG/PY5o2D+AUjEyfOhtpyfDeM+/62ReGsJlESC3
         jLLlpcViudmZz8QtPuSjQQqPeLwmuMKRpZe4lYcY=
Date:   Wed, 8 Aug 2018 21:58:50 +0530
From:   Vinod <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [GIT PULL] soundwire updates for v4.19-rc1
Message-ID: <20180808162850.GN2395@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

Please PULL to receive the soundwire update for v4.19-rc1 with a signed
tag as you requested last time and the norm :-)

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-4.19-rc1

for you to fetch changes up to 14b0c44af4e980f6aaa6f06cc9d50973425e7432:

  soundwire: intel: Remove duplicate assignment (2018-08-07 21:53:40 +0530)

----------------------------------------------------------------
soundwire updates for 4.19-rc1

 - support for multi-link streaming
 - fixes in intel driver and core
 - Update Vinod's email

----------------------------------------------------------------
Sanyog Kale (3):
      soundwire: Fix acquiring bus lock twice during master release
      Documentation: soundwire: Add documentation for multi link
      soundwire: Add support to lock across bus instances

Shreyas NC (7):
      soundwire: Fix duplicate stream state assignment
      soundwire: Fix incorrect exit after configuring stream
      soundwire: Initialize completion for defer messages
      soundwire: Add support for multi link bank switch
      soundwire: keep track of Masters in a stream
      soundwire: intel: Add pre/post bank switch ops
      soundwire: intel: Remove duplicate assignment

Vinod Koul (3):
      soundwire: Handle multiple master instances in a stream
      soundwire: intel: Fix uninitialized adev deref
      MAINTAINERS: Update Vinod's email

 Documentation/driver-api/soundwire/stream.rst |  28 ++
 MAINTAINERS                                   |   2 +-
 drivers/soundwire/bus.c                       |   6 +
 drivers/soundwire/bus.h                       |   4 +
 drivers/soundwire/intel.c                     |  68 +++-
 drivers/soundwire/intel_init.c                |   2 +-
 drivers/soundwire/stream.c                    | 511 +++++++++++++++++++---=
----
 include/linux/soundwire/sdw.h                 |  12 +-
 8 files changed, 491 insertions(+), 142 deletions(-)
--=20
~Vinod

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbaxpCAAoJEHwUBw8lI4NHoQoP/jdxLTzZ7pXOGIvR2/ITBumW
3fuivRqrv8UwbNNPADeANmXI9XK5rSVxEyeGG5hEjtXu01419rqaPzbCtEkv4XNU
ieUuB9lWMELlPiBcxJFTWBx9V1+NIYqnoVDDcSFdwdZADmzhQJx500Q5Rgkuurd3
+PgMMBFQfYiOUr9DEXYAzzxsZkAyvbYRHs/Z6MpznbnpSL4D0PgrW758JgqAhlux
4Kr8Nhg0REUK7ksg8q09kiyzyvFIiMejvV2okWtcudpf0HLSNIE4FGlzkqFKPnrY
Qxpxo5IHBQfhcqyFoXm9iYGk7IosdmI9Xixlqm903HfLV6IcJUbbAHPkCUs750c2
9Zi8tZ/EWCvpUXs+R5EVtbOMzHS/4v6LTSEqpemoJRup96xuxm9QFhGWNwt+htZf
cWrJ36A+6uqCJFdGlwjECABTpw34aXUrPXV6lwR4vRjzkKwnWFyWSdjVvLkJQung
2/u9RmEXvCy1QXF5zRMVqr9eVHMsLtj60RkbYaGHkYYP/WeSjneQyeyENYAZ5Nnd
ViIlwFaJm2UXSjceB9E/eN9CscbIG8KqAbzp7L17Dl5fyvlBql4Ma5pgNaEkmu0Z
k6Y764Gtr1acFcWlJ7hQhXt25YJUqwor4a1rY6MuHq6TzkIIHUPrLcxcXsNSFIS/
xPgTmND7H3kh6AHGcD7T
=0Cga
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
