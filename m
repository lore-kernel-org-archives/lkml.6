Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B5CC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778C821871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/lGr1k/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeLRU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:28:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36834 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeLRU2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:28:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so13306022lfg.3;
        Tue, 18 Dec 2018 12:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxuUruPrx2AwRFhEUbpQarpz+UKvYpYbIIEbJJWLdqc=;
        b=e/lGr1k/w/95+U93unxEl+lWozVHwKuD6Ul203ObmpJzkEyeJseYp7+zKEB4ms+kGw
         BvdXS8MNCajO6TUO9TiGfZVhkxtT7Xj4FxH5ajv+0QjprZijYNJNoA8ZK6tkvsKINr6h
         FakTcs8qo3GzJY79XXQTwu7jJ+MvHK5HroEI5J3WEUIdpTFW+zZtNS6uGpRIbXS24ikr
         0K3yEONWtJ++SKUU80gWUjjgttQyz+AXSba2fTmy5JJlAAX2mzgA7fpSECso+3GLQiYB
         A16mNZeqFRxlWfjMif/bGYkFbKGZMbnAt0MhO8+AIxMZmGZw9J4a6OBSqU6c/wSBGvhh
         gPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxuUruPrx2AwRFhEUbpQarpz+UKvYpYbIIEbJJWLdqc=;
        b=eAy82cfzy8tlXo1StbTHXGiue7KwBQP5jxx4jGLBimRqF8srNyFiBD3LS74piChP8a
         rb9vg1L58LjWMKOgyLsGG+lRlLW4QEaZTZSWPkFDFqEk4DUpm/PE/lWQughJ6yo3Y5CJ
         G/MrVQh69sHhKAky56v2Ly17Kj4/fo5M1Crm6N0SZVngjyuYIqdIaXhWEwLd7TmrlNhn
         C3oOszMnF+GQjH/mQU/jJjrjFrtAnOdNIKsv7E52ZaZ1HsBnzE6df3U6nSKqyJ8GcaRI
         Uq0EqAz8sPKJVvpp9lM2a1jbA5SZ1jBRpC+fd+KVkDb9bsbwvAvapqkLESzzdLijA7SQ
         BJCQ==
X-Gm-Message-State: AA+aEWYA5J2MKE+Wm2yFyFugdxlAf4i7zQw18xUfG802f9FE2J2rDwEg
        kMniGWMtHiEc56fSV/jC+4UEcYZE
X-Google-Smtp-Source: AFSGD/WhUKy1kgR/ctdtn5zE3hUOr/jaY6cYudO80G4hxiCJLGsx6/HyANEjAl3N2tzO6p1OLry4cw==
X-Received: by 2002:a19:aace:: with SMTP id t197mr10642476lfe.7.1545164913349;
        Tue, 18 Dec 2018 12:28:33 -0800 (PST)
Received: from arch.domain.name (89-70-220-87.dynamic.chello.pl. [89.70.220.87])
        by smtp.gmail.com with ESMTPSA id y81-v6sm3272822lje.30.2018.12.18.12.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 12:28:32 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2] iio: chemical: sps30: add support for self cleaning
Date:   Tue, 18 Dec 2018 21:28:09 +0100
Message-Id: <20181218202809.25822-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Self cleaning is especially useful in cases where sensor undergoes
frequent power on/off cycles. In such scenarios it is recommended to
turn self cleaning at least once per week in order to maintain reliable
measurements.

Self cleaning is activated by writing 1 to a dedicated attribute.
Internal fan accelerates to its maximum speed and keeps spinning
for about 10 seconds blowing out accumulated dust.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
v2:
 * removed TODO item
 * sensor cleaning is not measurement related per se so drop in_ prefix

 Documentation/ABI/testing/sysfs-bus-iio-sps30 |  8 +++++
 drivers/iio/chemical/sps30.c                  | 35 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sps30

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
new file mode 100644
index 000000000000..e7ce2c57635e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
@@ -0,0 +1,8 @@
+What:		/sys/bus/iio/devices/iio:deviceX/start_cleaning
+Date:		December 2018
+KernelVersion:	4.22
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Writing 1 starts sensor self cleaning. Internal fan accelerates
+		to its maximum speed and keeps spinning for about 10 seconds in
+		order to blow out accumulated dust.
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index fa3cd409b90b..f3b4390c8f5c 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -7,7 +7,6 @@
  * I2C slave address: 0x69
  *
  * TODO:
- *  - support for turning on fan cleaning
  *  - support for reading/setting auto cleaning interval
  */

@@ -37,6 +36,7 @@
 #define SPS30_READ_DATA_READY_FLAG 0x0202
 #define SPS30_READ_DATA 0x0300
 #define SPS30_READ_SERIAL 0xd033
+#define SPS30_START_FAN_CLEANING 0x5607

 enum {
 	PM1,
@@ -104,6 +104,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
 		break;
 	case SPS30_STOP_MEAS:
 	case SPS30_RESET:
+	case SPS30_START_FAN_CLEANING:
 		ret = sps30_write_then_read(state, buf, 2, NULL, 0);
 		break;
 	case SPS30_READ_DATA_READY_FLAG:
@@ -275,7 +276,39 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }

+static ssize_t start_cleaning_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sps30_state *state = iio_priv(indio_dev);
+	int val, ret;
+
+	if (kstrtoint(buf, 0, &val) || val != 1)
+		return -EINVAL;
+
+	mutex_lock(&state->lock);
+	ret = sps30_do_cmd(state, SPS30_START_FAN_CLEANING, NULL, 0);
+	mutex_unlock(&state->lock);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_WO(start_cleaning, 0);
+
+static struct attribute *sps30_attrs[] = {
+	&iio_dev_attr_start_cleaning.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group sps30_attr_group = {
+	.attrs = sps30_attrs,
+};
+
 static const struct iio_info sps30_info = {
+	.attrs = &sps30_attr_group,
 	.read_raw = sps30_read_raw,
 };

--
2.20.1

