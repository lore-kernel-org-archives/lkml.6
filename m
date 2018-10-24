Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C14ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A14620833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A14620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeJYDMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:12:30 -0400
Received: from anholt.net ([50.246.234.109]:53134 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbeJYDMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:12:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8652710A1314;
        Wed, 24 Oct 2018 11:43:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id X2d8OUir6d31; Wed, 24 Oct 2018 11:43:18 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EE10510A12D8;
        Wed, 24 Oct 2018 11:43:14 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 710332FE1BF0; Wed, 24 Oct 2018 11:43:13 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/3] drm: tinydrm driver for adafruit PiTFT 3.5" touchscreen
Date:   Wed, 24 Oct 2018 11:43:10 -0700
Message-Id: <20181024184313.2967-1-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was going to start working on making the vc4 driver work with
tinydrm panels, but it turned out tinydrm didn't have the panel I had
previously bought.  So, last night I ported the fbtft staging
driver over to DRM.

It seems to work (with DT at
https://github.com/anholt/linux/commits/drm-misc-next-hx8357d) --
fbdev works great including rotated, and so does modetest.  However,
when X11 comes up at 16bpp, I get:

https://photos.app.goo.gl/8tuhzPFFoDGamEfk8

If I have tinydrm set a preferred bpp of 24, X looks great.  Noralf,
any ideas?

Eric Anholt (3):
  dt-bindings: new binding for Himax HX8357D display panels
  drm: Add an hx8367d tinydrm driver.
  drm/tinydrm: Fix setting of the column/page end addresses.

 .../bindings/display/himax,hx8357d.txt        |  25 ++
 drivers/gpu/drm/tinydrm/Kconfig               |  11 +
 drivers/gpu/drm/tinydrm/Makefile              |   1 +
 drivers/gpu/drm/tinydrm/hx8357d.c             | 262 ++++++++++++++++++
 drivers/gpu/drm/tinydrm/hx8357d.h             |  71 +++++
 drivers/gpu/drm/tinydrm/mipi-dbi.c            |   4 +-
 6 files changed, 372 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/himax,hx8357d.txt
 create mode 100644 drivers/gpu/drm/tinydrm/hx8357d.c
 create mode 100644 drivers/gpu/drm/tinydrm/hx8357d.h

-- 
2.19.1

