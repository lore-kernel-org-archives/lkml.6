Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3825C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA55D2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="DWCbmD2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfBURDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:03:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:15304 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfBURDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550768578;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=TLMlIm/hIkZOX9FyIXY451GG997a+O3Wm5+D1WT15BM=;
        b=DWCbmD2PtWv1b0iX3ssITxyMQTWI7E0ZUH5sOzHMT84JcB7/6WVSWdCSWgOatgOKqD
        dnuqBElet990wfglzp4aICixmrwQq798cgUzFphQzJvh6fvfKmE3IDWBCqrNwGnO10wg
        7QK7GBlow22lvQeJ7sqMU8uFbz8azi1YOaFuQjr+Eqs8nh5uI/+XnLgfkAQVWm92dBhP
        ZNDqZrrZcs226PmwZCQ6HcoZremlq1E3R0YUN6Jbtwb2UrttPwYgJ7PZFiiwAcwPHd4h
        WvxHjSKxdK/vZqeHeEB4nA731PtYMDa/2aL5Z4wWOBdS7KKYWaHWIdjLuYy4ywULe/Zn
        Z/pQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2MzNl43D1ri"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1LH2tLXB
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Feb 2019 18:02:55 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] iio mount matrix - revitalize missing bindings documentation and provide code for bmc150, bmg160, bma180, itg3200, hmc584x
Date:   Thu, 21 Feb 2019 18:02:45 +0100
Message-Id: <cover.1550768574.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes V2:
* make get_mount_matrix() functions more readable (use temp variable)
  (suggested by Jonathan and Andy)
* add these readability improvements also for ak8975 and mpu6050
  (suggested by Jonathan and Andy)
* squash bindings documentation into single commit for better discussion
  (suggested by Linus)
* FOR DISCUSSION: add some more clarifications to the bindings documentation
  and an attempt to define the magnetometer orientation
* add "iio: Allow to read mount matrix from ACPI" to the beginning of
  the series to make it compile
  (suggested by Andy)
* replace of_iio_read_mount_matrix() by iio_read_mount_matrix()
  (required by "iio: Allow to read mount matrix from ACPI")
* drop patch to convert bma180 to devm (potential race)
  (suggested by Jonathan)

PATCH V1 2019-02-20 15:01:02:
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


Andy Shevchenko (1):
  iio: Allow to read mount matrix from ACPI

H. Nikolaus Schaller (8):
  iio: accel: bmc150: add mount matrix support
  iio: accel: bma180: add mount matrix support
  iio: gyro: bmg160: add mount matrix support
  iio: gyro: itg3200: add mount matrix support
  iio: magnetometer: bmc150: add mount matrix support
  iio: magnetometer: hmc5843: add mount matrix support
  iio: mpu6050: improve code readability
  iio: ak8975: improve code readability

Linus Walleij (1):
  iio: document bindings for mounting matrices

 .../devicetree/bindings/iio/mount-matrix.txt  | 204 ++++++++++++++++++
 drivers/iio/accel/bma180.c                    |  18 +-
 drivers/iio/accel/bmc150-accel-core.c         |  21 ++
 drivers/iio/accel/kxsd9.c                     |   4 +-
 drivers/iio/gyro/bmg160_core.c                |  21 ++
 drivers/iio/gyro/itg3200_core.c               |  20 ++
 drivers/iio/gyro/mpu3050-core.c               |   3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  10 +-
 drivers/iio/industrialio-core.c               |  46 ++--
 drivers/iio/magnetometer/ak8974.c             |   5 +-
 drivers/iio/magnetometer/ak8975.c             |  13 +-
 drivers/iio/magnetometer/bmc150_magn.c        |  21 ++
 drivers/iio/magnetometer/hmc5843.h            |   1 +
 drivers/iio/magnetometer/hmc5843_core.c       |  20 +-
 include/linux/iio/gyro/itg3200.h              |   1 +
 include/linux/iio/iio.h                       |   4 +-
 16 files changed, 361 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt

-- 
2.19.1

