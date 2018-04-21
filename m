Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2946402-1524271357-2-17492824157055129429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271356; b=N/dn10pZAtZgAi0Q/0tfNq7c80Jt1bLO5LZvQ52Fv/BVMsIslr
    iqY2G+NKMfjqEEa+in/5J4z3GQSzKZvzt+oN+jqCNX0OB2NXmw7o3Hkhb9gJd5Ag
    3YuNzTrWBplbKPxjmTXUBpwogYO8ZeKF6B5T4xRKhj9HkROywiNqJo9sqOo+faAF
    G9sSPCehDn2J6OLHv8+ehn1DbDAmGt65+gY8ZEy1pizj3mbTH7K/Gp6RNc17z+xK
    dJkAmw26CeOs29oSH5dv/tAootgc/HNTSbwGb95EjqVIKUV5rt5IBxJU6V+Fra2g
    msPSWt5mR9fdTa2X+izOvp39apS4DCUoepFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271356; bh=FFJhr
    nro329IdoRhWE/79Mihgjd7MEQcck+qF1T0WRQ=; b=nmqTrENyzZ5EM16AcxBxq
    OKrWC5+srHvwFy25+Ddtv1d24NqcgGWRxx8bLLS1Nsp2tK+r+Q4DbsR3uJJd6fh+
    OkY3f6ljPzXLIdaqQe83+DGht4YyAKlyqysHgZpuTBooRsj6NZE9dhD64iElDUvj
    rDlXp7i97zRLqkZaHERU35irH2d1GzViT4dWDC6Z5B3tAu35WkF1TiK7rlDrElcR
    hoQSpBKMLJpHWIZS4TVqz8R6IS4KdUoFMjKDyDAXgTdvrc767dFmtGVGp5MfyBYp
    YBnU4/+IN6GNfczgBpEDxmj+9knLS1pN4+ayEq2fjtHLH52nffHnWjA6zPswKtuy
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=NEhDK5x0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=NEhDK5x0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBYUd5kZA9ZAKU2ifR5ss1BBnFqxkOBAB3nwKeugnQohfA7273NM/P3zvotI7IzZol1oTfneKp88x/aOlvUk0E9+GnHOJq8zvrXBbSWkaGZinjZcmMWn
    YJH2WpDmKXFyCcOIQZtgcgCwjJns/MP8Lm9EoTj5Sfu1byEksjPmxrS54zw8V2aQ0f9cL7ZZTvwS1nbkQ43oNI7XiGGfiwMlRF0GAfajtEQVm2f7VTHsKrzz
    Vkuu5ecq8bu/JO9dCHgFPg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=H-wI8ikmdK_kP2pCvTsA:9 a=Gw3kG6IHBeNGh9M4:21 a=qn4n-HwUksWeuz-E:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 10/13] staging: iio: tsl2x7x: rename prx to prox for
 consistency
Date: Fri, 20 Apr 2018 20:41:50 -0400
Message-Id: <20180421004153.19073-11-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
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
 linux-kernel@vger.kernel.org, Jon.Brenner@ams.com, pmeerw@pmeerw.net,
 knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver mostly uses the 'prox' naming convention for most of the
proximity settings, however prx_time and tsl2x7x_prx_gain was present.
This patch renames these to prox_time and tsl2x7x_prox_gain for
consistency with everything else in the driver.

The kernel documentation for prx_gain is corrected to prox_gain so that
it matches what is actually in the structure.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 12 ++++++------
 drivers/staging/iio/light/tsl2x7x.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 87b99deef7a8..a7b4fcba7935 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -203,7 +203,7 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
 static const struct tsl2x7x_settings tsl2x7x_default_settings = {
 	.als_time = 219, /* 101 ms */
 	.als_gain = 0,
-	.prx_time = 254, /* 5.4 ms */
+	.prox_time = 254, /* 5.4 ms */
 	.prox_gain = 0,
 	.wait_time = 245,
 	.prox_config = 0,
@@ -230,7 +230,7 @@ static const s16 tsl2x7x_als_gain[] = {
 	120
 };
 
-static const s16 tsl2x7x_prx_gain[] = {
+static const s16 tsl2x7x_prox_gain[] = {
 	1,
 	2,
 	4,
@@ -594,7 +594,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	u8 *dev_reg, reg_val;
 
 	/* Non calculated parameters */
-	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
+	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prox_time;
 	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
 	chip->tsl2x7x_config[TSL2X7X_PRX_CONFIG] = chip->settings.prox_config;
 
@@ -1021,7 +1021,7 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 		if (chan->type == IIO_INTENSITY)
 			time = chip->settings.als_time;
 		else
-			time = chip->settings.prx_time;
+			time = chip->settings.prox_time;
 
 		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
 		z = y * TSL2X7X_MIN_ITIME;
@@ -1090,7 +1090,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 			time = chip->settings.als_time;
 			mult = chip->settings.als_persistence;
 		} else {
-			time = chip->settings.prx_time;
+			time = chip->settings.prox_time;
 			mult = chip->settings.prox_persistence;
 		}
 
@@ -1153,7 +1153,7 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 		if (chan->type == IIO_LIGHT)
 			*val = tsl2x7x_als_gain[chip->settings.als_gain];
 		else
-			*val = tsl2x7x_prx_gain[chip->settings.prox_gain];
+			*val = tsl2x7x_prox_gain[chip->settings.prox_gain];
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index 2c96f0b39b1e..408e5a89edb1 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -44,9 +44,9 @@ struct tsl2x7x_lux {
  *                          aperture effects.
  *  @wait_time:             Time between PRX and ALS cycles
  *                          in 2.7 periods
- *  @prx_time:              5.2ms prox integration time -
+ *  @prox_time:             5.2ms prox integration time -
  *                          decrease in 2.7ms periods
- *  @prx_gain:              Proximity gain index
+ *  @prox_gain:             Proximity gain index
  *  @prox_config:           Prox configuration filters.
  *  @als_cal_target:        Known external ALS reading for
  *                          calibration.
@@ -68,7 +68,7 @@ struct tsl2x7x_settings {
 	int als_gain;
 	int als_gain_trim;
 	int wait_time;
-	int prx_time;
+	int prox_time;
 	int prox_gain;
 	int prox_config;
 	int als_cal_target;
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
