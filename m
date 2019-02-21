Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4568AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1236E2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="W9C5VznC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfBURDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:03:23 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.124]:22383 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfBURDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550768583;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=om4yHxvARHVzUBURVF43RiiPc/zmEfyQWi5eZUdSxRY=;
        b=W9C5VznCzFtZl7l3pcWPzP0EPmlThcYG8ooa4AJlO7ac3qD6Bbb8m1sNJYJ11c1Boz
        ih5rrEm/vBYBbOexC2b2W/NQnVtcIADg55xQOUUuujuUsA6LgE/qwc2Aai86gn7q4trQ
        clBOm8CVC0F78bjuriOrhOib6ujyT9XGyAb3yKVyHfHA3harL3+RnwKPXknsXoMpZpbY
        o19vZcmCu4W4/BQ29RPPIGVzWnSdQJVvP2U7ZP/ATWPDg+hXoSYIjK7cI4n6jVhrLMh7
        VVGGRmfuWXoj9osKrOEA07ZSAa0zjRmlmrypeugVoh0bZu+qvNjjVx28uet7zR0iy21z
        xfFg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2MzNl43D1ri"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1LH32LXK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Feb 2019 18:03:02 +0100 (CET)
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
Subject: [PATCH v2 09/10] iio: mpu6050: improve code readability
Date:   Thu, 21 Feb 2019 18:02:54 +0100
Message-Id: <1493d22e5c0710a4ced34bf3bc714d367bdf58a3.1550768574.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- use temporary variable in get_mount_matrix()
- remove , after { }

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 533d1f8321ac..e7721b6fb441 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -765,12 +765,14 @@ static const struct iio_mount_matrix *
 inv_get_mount_matrix(const struct iio_dev *indio_dev,
 		     const struct iio_chan_spec *chan)
 {
-	return &((struct inv_mpu6050_state *)iio_priv(indio_dev))->orientation;
+	struct inv_mpu6050_state *data = iio_priv(indio_dev);
+
+	return &data->orientation;
 }
 
 static const struct iio_chan_spec_ext_info inv_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, inv_get_mount_matrix),
-	{ },
+	{ }
 };
 
 #define INV_MPU6050_CHAN(_type, _channel2, _index)                    \
-- 
2.19.1

