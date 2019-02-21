Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA59C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198842084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="L8ZmpFe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfBURDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:03:34 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.121]:26169 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfBURDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550768583;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/vKjHstlbkF/gn80TIMS2PAHdi7H6t37WZ0u54p80Q0=;
        b=L8ZmpFe5bw7Fyxi/zqGBSJZiSO8PsyspkPPrlDk/5NGqMHnf9l4K7mGMoz3UqdUujT
        YyGn6HDSUuZe+KY2WpuHWvPo8R7b+YNuR1kPh5jUhzgeNYHurRQV3Ub0xvXPGJ0vmWPk
        5b43NfuJwAm/5PrSJORYgLmT2IXTIG+FGM/SpjmQdDIEsqhtSO7EFaHxHLnLYRAPNOKQ
        5GCvyE/FPKEZuZVvgA+52TcfEBexdXrfdvDb7z3cji5WGwYEjglkDM0Smwz0TGgPa30s
        20EC8yCASEwuKZIG/N+2+UjwYoBk/LR78mkZW9JfNYih11XYiZxGXknsyvHEp2DOcSJO
        vvFA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2MzNl43D1ri"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1LH33LXL
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Feb 2019 18:03:03 +0100 (CET)
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
Subject: [PATCH v2 10/10] iio: ak8975: improve code readability
Date:   Thu, 21 Feb 2019 18:02:55 +0100
Message-Id: <8a4498a761bf63e38c16f17d437715be0399a957.1550768574.git.hns@goldelico.com>
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
 drivers/iio/magnetometer/ak8975.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index db7214ac514c..43d08c089792 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -746,12 +746,14 @@ static const struct iio_mount_matrix *
 ak8975_get_mount_matrix(const struct iio_dev *indio_dev,
 			const struct iio_chan_spec *chan)
 {
-	return &((struct ak8975_data *)iio_priv(indio_dev))->orientation;
+	struct ak8975_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
 }
 
 static const struct iio_chan_spec_ext_info ak8975_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, ak8975_get_mount_matrix),
-	{ },
+	{ }
 };
 
 #define AK8975_CHANNEL(axis, index)					\
@@ -792,7 +794,7 @@ static const struct acpi_device_id ak_acpi_match[] = {
 	{"AK09911", AK09911},
 	{"AKM9911", AK09911},
 	{"AK09912", AK09912},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
 #endif
-- 
2.19.1

