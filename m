Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED5820880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfBTOBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:01:46 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:32177 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbfBTOBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:01:03 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE0vEqS
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 15:00:57 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>
Cc:     letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] iio mount matrix - revitalize missing bindings documentation and provide code for bmc150, bmg160, bma180, itg3200, hmc584x
Date:   Wed, 20 Feb 2019 15:00:47 +0100
Message-Id: <cover.1550671256.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the mount-matrix to several iio sensor drivers
used in handheld devices.

The mount-matrix translates the quite arbitrary orientation of the sensor
on some printed circuit board to user-tangible orientation in handheld
devices that relates to typical screen orientation.

There was a bindings documentation by Linus Walleij but the patch
did not make it into mainline. Therefore I resend it here.

Next I have added some clarifications (at least I hope it clarifies)
in a second patch.

Finally, the patch set implements the hooks for the mount matrix
in several iio drivers: bmc150, bma180, bmg160, itg3200, hmc5843.
This includes also one patch for the bma180 to convert it to devm API.

We use them in different variants of the omap3-gta04 so a separate
patch set will provide device tree additions for them.


H. Nikolaus Schaller (8):
  iio: bindings: clarifications for mount-matrix bindings
  iio: accel: bmc150: add mount matrix support
  iio: accel: bma180: add mount matrix support
  iio: accel: bma180: convert to devm
  iio: gyro: bmg160: add mount matrix support
  iio: gyro: itg3200: add mount matrix support
  iio: magnetometer: bmc150: add mount matrix support
  iio: magnetometer: hmc5843: add mount matrix support

Linus Walleij (1):
  iio: document bindings for mounting matrices

 .../devicetree/bindings/iio/mount-matrix.txt  | 162 ++++++++++++++++++
 drivers/iio/accel/bma180.c                    |  70 ++++----
 drivers/iio/accel/bmc150-accel-core.c         |  19 ++
 drivers/iio/gyro/bmg160_core.c                |  19 ++
 drivers/iio/gyro/itg3200_core.c               |  18 ++
 drivers/iio/magnetometer/bmc150_magn.c        |  19 ++
 drivers/iio/magnetometer/hmc5843.h            |   1 +
 drivers/iio/magnetometer/hmc5843_core.c       |  14 ++
 include/linux/iio/gyro/itg3200.h              |   1 +
 9 files changed, 288 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt

-- 
2.19.1

