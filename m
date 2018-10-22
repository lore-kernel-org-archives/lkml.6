Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD3AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4776205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO4R4Rnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4776205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeJWBdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:33:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43521 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWBdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:33:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so19357401plb.10;
        Mon, 22 Oct 2018 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pLkG0HIJAj3KbkgNecEmQgtRzJFgvSmpnolcOr7zFiI=;
        b=iO4R4RnlkkxDD77YduynsJqYajuMAClgoloX4Z+Mes2a+F/C1EUSxLd9D1iquLMUCi
         3J9h3vs9uMil4F6kfuIaQfB0wPvth+eSi8rXmk0NwpxmZx0Fe4bnV4w+stIZfyaAD7eT
         cYqHBWkgtOd04Mhc7PgPrBLVA4hk8KHla+QVzIf4hvZ4tbIdHzn9IW0k9AD1WrdUrhaG
         PTaqNOw0mQnp350ksx7gbBh4m02SQ7SbYXgcT4pumQLlI6Ycasnu8wZmU056PIl49KHk
         q/WyI3k3w8Ku3uKGHfoqrJJbR2rba6k52fotQJIi72BUe6iGzVvrRB8ZJ5xCnzvBY1NA
         LsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pLkG0HIJAj3KbkgNecEmQgtRzJFgvSmpnolcOr7zFiI=;
        b=TeLnnCxUzGAr/XKMsoinfWEb2qx7s+wHRywFr6/OGMDzsNI74yUY+UjGL7+1tyjZi1
         F2msuhQbDNGKl50p9OHWlGyTeyciWaRv/7nVv/n+bOJpx4uleCQrgofW+o/Q2m9KuQC4
         Gk28NE4rPmD8vXt9e0QnfaqIZl5hPGME+2r9nkcx2wd1yBZ9PPnmxn40L+/YC6875fOs
         h5N6y39O3fjqNIbI9HDSgg8qW7/v74ZPrvRDg9VlMUm5zStvY7fmQ6XCFUpLiX8/SmaO
         hZGai0ANjYJ1quMZbqGzQtRP/hGvyv7f+v03GTAKyrvMtgtWSTCsv4MXuW5nHkk+WG9D
         24Rg==
X-Gm-Message-State: ABuFfojcM+Jwd1x4ISVfEX5OQaLfZrD2rrDjTjyBuUbHwKhu1+1SwD7V
        U3AGuPjPTvi5YYN91Ay/G9g=
X-Google-Smtp-Source: ACcGV63UmZv1TgjTfC5IH45mRCDVWb7yO9b03XR50jtG88PJv7KzqGU+pn17GQaM5PLUSFvVCcmaOQ==
X-Received: by 2002:a17:902:5a89:: with SMTP id r9-v6mr44745607pli.95.1540228470313;
        Mon, 22 Oct 2018 10:14:30 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id a16-v6sm7973812pgb.6.2018.10.22.10.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 10:14:29 -0700 (PDT)
Date:   Mon, 22 Oct 2018 22:44:22 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Slawomir Stepien <sst@poczta.fm>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adt7316: Switch to the gpio descriptor
 interface
Message-ID: <20181022171418.GA2612@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor
interface for ldac_pin.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 3f22d1088713..94f945ba0097 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -177,7 +177,7 @@
 
 struct adt7316_chip_info {
 	struct adt7316_bus	bus;
-	u16			ldac_pin;
+	struct gpio_desc	*ldac_pin;
 	u16			int_mask;	/* 0x2f */
 	u8			config1;
 	u8			config2;
@@ -950,8 +950,8 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 		if (ret)
 			return -EIO;
 	} else {
-		gpio_set_value(chip->ldac_pin, 0);
-		gpio_set_value(chip->ldac_pin, 1);
+		gpiod_set_value(chip->ldac_pin, 0);
+		gpiod_set_value(chip->ldac_pin, 1);
 	}
 
 	return len;
@@ -2120,7 +2120,14 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	else
 		return -ENODEV;
 
-	chip->ldac_pin = adt7316_platform_data[1];
+	chip->ldac_pin = devm_gpiod_get(dev, "ldac", GPIOD_OUT_HIGH);
+	if (IS_ERR(chip->ldac_pin)) {
+		ret = PTR_ERR(chip->ldac_pin);
+		dev_err(dev, "Failed to request ldac GPIO: %d\n",
+			ret);
+		return ret;
+	}
+
 	if (chip->ldac_pin) {
 		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
 		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-- 
2.17.1

