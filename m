Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4760EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258242146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfBTOBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:01:08 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:22868 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTOBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:01:04 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE0wEqU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 15:00:58 +0100 (CET)
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
Subject: [PATCH 2/9] iio: bindings: clarifications for mount-matrix bindings
Date:   Wed, 20 Feb 2019 15:00:49 +0100
Message-Id: <aec7d48bcb514e37604be901f210c98ec1a52c02.1550671256.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550671256.git.hns@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds some clarifications and drawings to make the
orientation of the X/Y/Z axis more clear and better
prescribe how the values of the matrix are intended to
be used.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/iio/mount-matrix.txt  | 60 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/mount-matrix.txt b/Documentation/devicetree/bindings/iio/mount-matrix.txt
index a3714727f739..003279fd735b 100644
--- a/Documentation/devicetree/bindings/iio/mount-matrix.txt
+++ b/Documentation/devicetree/bindings/iio/mount-matrix.txt
@@ -23,6 +23,8 @@ For a screen you probably want (x) coordinates to go from negative on the left
 to positive on the right and (z) depth to be negative under the screen and
 positive in front of it, toward the face of the user.
 
+??? whatabout y-axis orientation - bottop-up or top-down?
+
 A sensor can be mounted in any angle along the axes relative to the frame of
 reference. This means that the sensor may be flipped upside-down, left-right,
 or tilted at any angle relative to the frame of reference.
@@ -46,6 +48,20 @@ Device-to-world examples for some three-dimensional sensor types:
   is held with its screen flat on the planets surface and 0 on the other axes,
   as the gravity vector is projected 1:1 onto the sensors (z)-axis.
 
+
+     (---------)
+     !         !           y: +g
+     !         !             ^
+     !         !             !
+     !         !
+     !         !  x; -g <- z: +g  -> x: +g
+     ! 1  2  3 !
+     ! 4  5  6 !             !
+     ! 7  8  9 !             v
+     ! *  0  # !           y: -g
+     (---------)
+
+
 - Magnetometers (compasses) have their world frame of reference relative to the
   geomagnetic field. The system orientation vis-a-vis the world is defined with
   respect to the local earth geomagnetic reference frame where (y) is in the
@@ -53,6 +69,22 @@ Device-to-world examples for some three-dimensional sensor types:
   perpendicular to the North axis and positive towards the East and (z) is
   perpendicular to the ground plane and positive upwards.
 
+
+     ^^^ North: y > 0
+
+     (---------)
+     !         !
+     !         !
+     !         !
+     !         !  >
+     !         !  > North: x > 0
+     ! 1  2  3 !  >
+     ! 4  5  6 !
+     ! 7  8  9 !
+     ! *  0  # !
+     (---------)
+
+
 - Gyroscopes detects the movement relative the device itself. The angular
   velocity is defined as orthogonal to the plane of rotation, so if you put the
   device on a flat surface and spin it around the z axis (such as rotating a
@@ -60,6 +92,20 @@ Device-to-world examples for some three-dimensional sensor types:
   along the (z) axis if rotated clockwise, and a positive value if rotated
   counter-clockwise according to the right-hand rule.
 
+
+     (---------)     y > 0
+     !         !     v---\
+     !         !
+     !         !
+     !         !      <--\
+     !         !         ! z > 0
+     ! 1  2  3 !       --/
+     ! 4  5  6 !
+     ! 7  8  9 !
+     ! *  0  # !
+     (---------)
+
+
 So unless the sensor is ideally mounted, we need a means to indicate the
 relative orientation of any given sensor of this type with respect to the
 frame of reference.
@@ -76,9 +122,15 @@ https://en.wikipedia.org/wiki/Rotation_matrix
 
 The mounting matrix has the layout:
 
- (x0, y0, z0)
- (x1, y1, z1)
- (x2, y2, z3)
+ (mxx, myx, mzx)
+ (mxy, myy, mzy)
+ (mxz, myz, mzz)
+
+Values are intended to be multiplied as:
+
+  x' = mxx * x + myx * y + mzx * z
+  y' = mxy * x + myy * y + mzy * z
+  z' = mxz * x + myz * y + mzz * z
 
 And it is represented as an array of strings containing the real values for
 producing the transformation matrix. The real values use a decimal point and
@@ -106,3 +158,5 @@ upside-down:
 mount-matrix = "0.998", "0.054", "0",
                "-0.054", "0.998", "0",
                "0", "0", "1";
+
+??? does not match "180 degrees" - factors indicate ca. 3 degrees compensation
-- 
2.19.1

