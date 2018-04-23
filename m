Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932631AbeDWVih (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:38:37 -0400
Received: from bert.emutex.com ([91.103.1.109]:54290 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932522AbeDWVi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:38:29 -0400
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Arteaga <javier@emutex.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: adc128s052: Add pin-compatible IDs
Date: Mon, 23 Apr 2018 22:38:03 +0100
Message-Id: <20180423213805.12591-2-javier@emutex.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423213805.12591-1-javier@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  The datasheets for ADC122S021 and ADC124S021 list two more
    pin-compatible alternatives for each device. Add their IDs as compatible
   strings. Suggested-by: Jonathan Cameron <jic23@kernel.org> Signed-off-by:
   Javier Arteaga <javier@emutex.com> --- drivers/iio/adc/ti-adc128s052.c | 16
    ++++++++++++---- 1 file changed, 12 insertions(+), 4 deletions(-) [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheets for ADC122S021 and ADC124S021 list two more
pin-compatible alternatives for each device.

Add their IDs as compatible strings.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Javier Arteaga <javier@emutex.com>
---
 drivers/iio/adc/ti-adc128s052.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 7cf39b3e2416..e6716c326c5e 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -186,15 +186,23 @@ static int adc128_remove(struct spi_device *spi)
 static const struct of_device_id adc128_of_match[] = {
 	{ .compatible = "ti,adc128s052", },
 	{ .compatible = "ti,adc122s021", },
+	{ .compatible = "ti,adc122s051", },
+	{ .compatible = "ti,adc122s101", },
 	{ .compatible = "ti,adc124s021", },
-	{ /* sentinel */ },
+	{ .compatible = "ti,adc124s051", },
+	{ .compatible = "ti,adc124s101", },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
 
 static const struct spi_device_id adc128_id[] = {
-	{ "adc128s052", 0},	/* index into adc128_config */
-	{ "adc122s021",	1},
-	{ "adc124s021", 2},
+	{ "adc128s052", 0 },	/* index into adc128_config */
+	{ "adc122s021",	1 },
+	{ "adc122s051",	1 },
+	{ "adc122s101",	1 },
+	{ "adc124s021", 2 },
+	{ "adc124s051", 2 },
+	{ "adc124s101", 2 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
-- 
2.17.0
