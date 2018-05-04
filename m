Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3509029-1525402422-2-7896441276522767402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525402421; b=WLroRG8p6t2Nv4+oqLYq739s2reyz0lgF65cGyDHqhw7Zo+rQx
    9vqlhkbKYFFbqR7CPd8Qrc0/5hSwQYFU4ygnFhJSVH3yuD2YZbTSi5a90sD+ZYOl
    lkDrK1Xxe+fRhefroPBDqPeCNY3kJxAKM1FCzm3iINxIZN6ZXTtp+77YF1sR9CrQ
    gGE5RAkRN7MrAzwAObkQReOKHVcpTtmtYwyYFs30oZBblJCAblDMHlJ7GicJ7vrk
    XMDg6JVP3oWx6GTjbs5wKZjB16O3eQmWbrbJmIKw1ejfZUAOJjujGBSFNK/ioDzB
    wYyjkcOes9NxsTp9gK+0hhwMvxP/zTKNOm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402421; bh=R+l+4
    qdh3qr53y3fBnEt/irssBHVQ5G8t/iNsETZNQg=; b=EGyIsFZALmEMuomv8V2SM
    0JHBfeOuAkBqFPzX4K0G6JNtLngVvd7jipjj6RJQE0rPLnYb2g/X2ntf5vM7i1s3
    +4Wriafrk5LvWZFAQCeW9Y3Pk+SSJCCmbhiXVW0KuDrxmhUaqMHvvhnAvucFXJsR
    zol2rvITZD3CZtms6SzClC4py0ga9iUL/8foB098798HE2KoRBRjrUj7sa3smehH
    UIoAemvpVUHtSQYGBpbdHYhuOXq0WBx80Ovhtt3MPLkS/LoQo+DKFU3axdWce5Zf
    Ab0K9xIeUnqQfJidE3cbsA+MSiRrovRQnp6X1TAVRZjRpwEHiEZ1702TN9HibcAP
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=IfZ6S2dT
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=onstation.org
    header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=IfZ6S2dT
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK87a4AXsyWLFrySdWY0RC0O/G3zzsRZlTlj1/uOFtWpX+x61HHqVi9RF6g2ueQKdH1VBAFqYjHvQSVhdxSUIKffMOHvD/a5U5XeyX5z4UOEnfuY3dXb
    PjBIh5dxuXT/qoMVzLnqDOmlaDnDRwc5gID25Mi0aYrqsxFwKMaH8knCJxZ+41mWCPqAQSXdhWqDc731vp4TuAkuzREdHlkMcDd75I3rAB5Fb8p/qaIbgTM8
    K1M7QwRvx0676JoruYZEJw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=ha1XIJamg1ZOMLQLxb4A:9 a=qdEb9oVtdDD0Rhcz:21 a=LRMXIpm60RzXVUJa:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 03/11] staging: iio: tsl2x7x: don't setup event handlers if
 interrupts are not configured
Date: Thu,  3 May 2018 22:53:11 -0400
Message-Id: <20180504025319.28953-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180504025319.28953-1-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 drew.paterson@ams.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver would expose to userspace the events directory even if the
interrupts were not configured. This patch changes the driver so that
the events directory is not exposed to user space if interrupts are
not configured. This patch also corrects the indentation of the
chan_table_elements and info structure members.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 130 +++++++++++++++++++++++++++++++-----
 1 file changed, 112 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index b4d77f65ca12..7e8db5178a2c 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -134,8 +134,9 @@ struct tsl2x7x_als_info {
 
 struct tsl2x7x_chip_info {
 	int chan_table_elements;
-	struct iio_chan_spec		channel[4];
-	const struct iio_info		*info;
+	struct iio_chan_spec channel_with_events[4];
+	struct iio_chan_spec channel_without_events[4];
+	const struct iio_info *info;
 };
 
 struct tsl2X7X_chip {
@@ -1447,7 +1448,7 @@ static const struct iio_event_spec tsl2x7x_events[] = {
 
 static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 	[ALS] = {
-		.channel = {
+		.channel_with_events = {
 			{
 			.type = IIO_LIGHT,
 			.indexed = 1,
@@ -1469,11 +1470,31 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.channel = 1,
 			},
 		},
-	.chan_table_elements = 3,
-	.info = &tsl2X7X_device_info[ALS],
+		.channel_without_events = {
+			{
+			.type = IIO_LIGHT,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+			}, {
+			.type = IIO_INTENSITY,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+			}, {
+			.type = IIO_INTENSITY,
+			.indexed = 1,
+			.channel = 1,
+			},
+		},
+		.chan_table_elements = 3,
+		.info = &tsl2X7X_device_info[ALS],
 	},
 	[PRX] = {
-		.channel = {
+		.channel_with_events = {
 			{
 			.type = IIO_PROXIMITY,
 			.indexed = 1,
@@ -1483,11 +1504,19 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			},
 		},
-	.chan_table_elements = 1,
-	.info = &tsl2X7X_device_info[PRX],
+		.channel_without_events = {
+			{
+			.type = IIO_PROXIMITY,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+			},
+		},
+		.chan_table_elements = 1,
+		.info = &tsl2X7X_device_info[PRX],
 	},
 	[ALSPRX] = {
-		.channel = {
+		.channel_with_events = {
 			{
 			.type = IIO_LIGHT,
 			.indexed = 1,
@@ -1517,11 +1546,37 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			},
 		},
-	.chan_table_elements = 4,
-	.info = &tsl2X7X_device_info[ALSPRX],
+		.channel_without_events = {
+			{
+			.type = IIO_LIGHT,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+			}, {
+			.type = IIO_INTENSITY,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+			}, {
+			.type = IIO_INTENSITY,
+			.indexed = 1,
+			.channel = 1,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+			}, {
+			.type = IIO_PROXIMITY,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+			},
+		},
+		.chan_table_elements = 4,
+		.info = &tsl2X7X_device_info[ALSPRX],
 	},
 	[PRX2] = {
-		.channel = {
+		.channel_with_events = {
 			{
 			.type = IIO_PROXIMITY,
 			.indexed = 1,
@@ -1532,11 +1587,20 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			},
 		},
-	.chan_table_elements = 1,
-	.info = &tsl2X7X_device_info[PRX2],
+		.channel_without_events = {
+			{
+			.type = IIO_PROXIMITY,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE),
+			},
+		},
+		.chan_table_elements = 1,
+		.info = &tsl2X7X_device_info[PRX2],
 	},
 	[ALSPRX2] = {
-		.channel = {
+		.channel_with_events = {
 			{
 			.type = IIO_LIGHT,
 			.indexed = 1,
@@ -1567,8 +1631,35 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			},
 		},
-	.chan_table_elements = 4,
-	.info = &tsl2X7X_device_info[ALSPRX2],
+		.channel_without_events = {
+			{
+			.type = IIO_LIGHT,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+			}, {
+			.type = IIO_INTENSITY,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+			}, {
+			.type = IIO_INTENSITY,
+			.indexed = 1,
+			.channel = 1,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+			}, {
+			.type = IIO_PROXIMITY,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE),
+			},
+		},
+		.chan_table_elements = 4,
+		.info = &tsl2X7X_device_info[ALSPRX2],
 	},
 };
 
@@ -1620,10 +1711,11 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 	indio_dev->dev.parent = &clientp->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->client->name;
-	indio_dev->channels = chip->chip_info->channel;
 	indio_dev->num_channels = chip->chip_info->chan_table_elements;
 
 	if (clientp->irq) {
+		indio_dev->channels = chip->chip_info->channel_with_events;
+
 		ret = devm_request_threaded_irq(&clientp->dev, clientp->irq,
 						NULL,
 						&tsl2x7x_event_handler,
@@ -1636,6 +1728,8 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 				"%s: irq request failed\n", __func__);
 			return ret;
 		}
+	} else {
+		indio_dev->channels = chip->chip_info->channel_without_events;
 	}
 
 	tsl2x7x_defaults(chip);
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
