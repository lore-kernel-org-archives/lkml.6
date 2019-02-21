Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF2F2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="NAdHM2qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfBURDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:03:10 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:27266 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfBURDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550768583;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=A2m9xK7zBKadIWRqBWBCvfuON+oTisuF1j1Ylta7rcA=;
        b=NAdHM2qOiMescwlbpUXHJfCgw99hNTesj/UqPSAkhvyN6GwmFx7rZgNBXQkoDJm+5g
        olYiODV9zyYjNhjT7QS9bfrNcUvbQGxDSDLa7Rcswokzwd/ssrOdAE93Cz/bBsNg5+Hu
        F7U5px0TI/b/SPBgG+3fCBrUyUTtp/YNn3mNLJMVU58OlMYBU2xtZlfSJfWgHuw6Tit+
        g+uHq96HP7DyKA7lWRa1j+ptlUV2kWfMgXesTFv9PEbWCk/xzxf+NlEGWDSdqhE2uNNa
        KLI4nNqAvt/r4crwv4TNtyW9pbhOlYLCJRLKiFATx7/gHWwYNe6ltJclPYdlVUq8ap0n
        pjog==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2MzNl43D1ri"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1LH2vLXD
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Feb 2019 18:02:57 +0100 (CET)
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
        linux-kernel@vger.kernel.org,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Subject: [PATCH v2 02/10] iio: document bindings for mounting matrices
Date:   Thu, 21 Feb 2019 18:02:47 +0100
Message-Id: <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

The mounting matrix for sensors was introduced in
commit dfc57732ad38 ("iio:core: mounting matrix support")

However the device tree bindings are very terse and since this is
a widely applicable property, we need a proper binding for it
that the other bindings can reference. This will also be useful
for other operating systems and sensor engineering at large.

I think all 3D sensors should support it, the current situation
is probably that the mounting information is confined in magic
userspace components rather than using the mounting matrix, which
is not good for portability and reuse.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Samu Onkalo <samu.onkalo@intel.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/iio/mount-matrix.txt  | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt

diff --git a/Documentation/devicetree/bindings/iio/mount-matrix.txt b/Documentation/devicetree/bindings/iio/mount-matrix.txt
new file mode 100644
index 000000000000..1b64c8b1f689
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/mount-matrix.txt
@@ -0,0 +1,204 @@
+For discussion. Unclear are:
+* is the definition of +/- values practical or counterintuitive?
+* are the definitions unambiguous and easy to follow?
+* are the examples correct?
+* should we have HOWTO engineer a correct matrix for a new device (without comparing to a different one)?
+
+====
+
+
+Mounting matrix
+
+The mounting matrix is a device tree property used to orient any IIO device
+that produce three-dimensional data in relation to the world where it is
+deployed.
+
+The purpose of the mounting matrix is to translate the sensor frame of
+reference into the device frame of reference using a translation matrix as
+defined in linear algebra.
+
+The typical usecase is that where a component has an internal representation
+of the (x,y,z) triplets, such as different registers to read these coordinates,
+and thus implying that the component should be mounted in a certain orientation
+relative to some specific device frame of reference.
+
+For example a device with some kind of screen, where the user is supposed to
+interact with the environment using an accelerometer, gyroscope or magnetometer
+mounted on the same chassis as this screen, will likely take the screen as
+reference to (x,y,z) orientation, with (x,y) corresponding to these axes on the
+screen and (z) being depth, the axis perpendicular to the screen.
+
+For a screen you probably want (x) coordinates to go from negative on the left
+to positive on the right, (y) from negative on the bottom to positive on top
+and (z) depth to be negative under the screen and positive in front of it,
+toward the face of the user.
+
+A sensor can be mounted in any angle along the axes relative to the frame of
+reference. This means that the sensor may be flipped upside-down, left-right,
+or tilted at any angle relative to the frame of reference.
+
+Another frame of reference is how the device with its sensor relates to the
+external world, the environment where the device is deployed. Usually the data
+from the sensor is used to figure out how the device is oriented with respect
+to this world. When using the mounting matrix, the sensor and device orientation
+becomes identical and we can focus on the data as it relates to the surrounding
+world.
+
+Device-to-world examples for some three-dimensional sensor types:
+
+- Accelerometers have their world frame of reference toward the center of
+  gravity, usually to the core of the planet. A reading of the (x,y,z) values
+  from the sensor will give a projection of the gravity vector through the
+  device relative to the center of the planet, i.e. relative to its surface at
+  this point. Up and down in the world relative to the device frame of
+  reference can thus be determined. and users would likely expect a value of
+  9.81 m/s^2 upwards along the (z) axis, i.e. out of the screen when the device
+  is held with its screen flat on the planets surface and 0 on the other axes,
+  as the gravity vector is projected 1:1 onto the sensors (z)-axis.
+
+  If you tilt the device, the g vector virtually coming out of the display
+  is projected onto the (x,y) plane of the display panel.
+
+  Example:
+
+         ^ z: +g                   ^ z: >0
+         !                        /!
+         ! x=y=0                 / ! x: > 0
+     +--------+             +--------+
+     !        !             !        !
+     +--------+             +--------+
+         !                    /
+         !                   /
+         v                  v
+      center of         center of
+       gravity           gravity
+
+
+  If the device is tilted to the left, you get a positive x value. If you point
+  its top towards surface, you get a negative y axis.
+
+     (---------)
+     !         !           y: -g
+     !         !             ^
+     !         !             !
+     !         !
+     !         !  x: +g <- z: +g  -> x: -g
+     ! 1  2  3 !
+     ! 4  5  6 !             !
+     ! 7  8  9 !             v
+     ! *  0  # !           y: +g
+     (---------)
+
+
+- Magnetometers (compasses) have their world frame of reference relative to the
+  geomagnetic field. The system orientation vis-a-vis the world is defined with
+  respect to the local earth geomagnetic reference frame where (y) is in the
+  ground plane and positive towards magnetic North, (x) is in the ground plane,
+  perpendicular to the North axis and positive towards the East and (z) is
+  perpendicular to the ground plane and positive upwards.
+
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
+  Since the geomagnetic field is not uniform this definition fails if we come
+  closer to the poles.
+
+  Sensors and driver can not and should not take care of this because there
+  are complex calculations and empirical data to be taken care of. We leave
+  this up to user space.
+
+  The definition we take:
+
+  If the device is placed at the equator and the top is pointing north, the
+  display is readable by a person standing upright on the earth surface, this
+  defines a positive y value.
+
+
+- Gyroscopes detects the movement relative the device itself. The angular
+  velocity is defined as orthogonal to the plane of rotation, so if you put the
+  device on a flat surface and spin it around the z axis (such as rotating a
+  device with a screen lying flat on a table), you should get a negative value
+  along the (z) axis if rotated clockwise, and a positive value if rotated
+  counter-clockwise according to the right-hand rule.
+
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
+So unless the sensor is ideally mounted, we need a means to indicate the
+relative orientation of any given sensor of this type with respect to the
+frame of reference.
+
+To achieve this, use the device tree property "mount-matrix" for the sensor.
+
+This supplies a 3x3 rotation matrix in the strict linear algebraic sense,
+to orient the senor axes relative to a desired point of reference. This means
+the resulting values from the sensor, after scaling to proper units, should be
+multiplied by this matrix to give the proper vectors values in three-dimensional
+space, relative to the device or world point of reference.
+
+For more information, consult:
+https://en.wikipedia.org/wiki/Rotation_matrix
+
+The mounting matrix has the layout:
+
+ (mxx, myx, mzx)
+ (mxy, myy, mzy)
+ (mxz, myz, mzz)
+
+Values are intended to be multiplied as:
+
+  x' = mxx * x + myx * y + mzx * z
+  y' = mxy * x + myy * y + mzy * z
+  z' = mxz * x + myz * y + mzz * z
+
+It is represented as an array of strings containing the real values for
+producing the transformation matrix. The real values use a decimal point and
+a minus (-) to indicate a negative value.
+
+Examples:
+
+Identity matrix (nothing happens to the coordinates, which means the device was
+mechanically mounted in an ideal way and we need no transformation):
+
+mount-matrix = "1", "0", "0",
+               "0", "1", "0",
+               "0", "0", "1";
+
+The sensor is mounted 30 degrees (Pi/6 radians) tilted along the X axis, so we
+compensate by performing a -30 degrees rotation around the X axis:
+
+mount-matrix = "1", "0", "0",
+               "0", "0.866", "0.5",
+               "0", "-0.5", "0.866";
+
+The sensor is flipped 180 degrees (Pi radians) around the Z axis, i.e. mounted
+upside-down:
+
+mount-matrix = "0.998", "0.054", "0",
+               "-0.054", "0.998", "0",
+               "0", "0", "1";
+
+???: this does not match "180 degrees" - factors indicate ca. 3 degrees compensation
-- 
2.19.1

