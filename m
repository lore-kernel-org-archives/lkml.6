Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-393451-1521921982-2-119709726770854046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521921982; b=Jiteug0w/2vg85o6zu8OZz6g5GzCy9hw13Iqzl4Euaxd++8
    87AGFfSZ24SYgnuhCZCgf/sDzkWngC1KNPsjNp1e8jb1C+Cv6fnTna2/gBR3sfS4
    n4rlwRkDcmF4dVp8XizI9Vsy5CtxJT6D3Sk927xHcaoXjTJAplgmfDMfQFsTbqbt
    LCwTicV5Lf/5QCMpGRixA0qS1LwwFzmdFJHdjwSsXoyr5+S8/fj20ChTulayV4+I
    OMVjkGBc3hsB9JGO6A4Ey/8GbJyUHcYqhGkaSlgM4c0I+vQCj8O1ZvsJrqvb239Q
    6RbJnWe/As1P0EvBb/m5cUGk97L+SxzK/KVGkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521921982; bh=1
    lBfRybxwe+gqsHKODZceZgpaVW1bSZcg3R/UiS4MdU=; b=tytduf0NwcEEYL4V+
    UItQ11bnLaP7USKbJY7KzZXbdqWIveKt5r2KwBWOrp1dAkeVx1AppRHuGcXDDoCB
    G9Or37I+Of8xMIw9srDOYiMbnx4sOa0TjQ7rvWTNIkTdon7fy6nucg7N5S1pMaYG
    x5Bb1vRikGuSlumVaWAgyQrClFH4HH5+lpv0vh7cpuWw7gqGeODs2K3E6ZYARRsu
    0edwrGhwZ9yexa4mTklF1mNi4WS8ygcpdR+ouB1sUbLzA+aD5jaRxOiUFk8TAkZ3
    ODXMmLsS724XfO6N7jUJOh9caLl5tHCmZg3Voy5GdrmQ/l/T9R+O6U2gR6cVMd/x
    BLN4w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=MKsWjME3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=MKsWjME3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/4] staging: iio: tsl2x7x: move IIO_CHAN_INFO_CALIB{SCALE,
 BIAS} to IIO_LIGHT channel
Date: Sat, 24 Mar 2018 16:05:53 -0400
Message-Id: <20180324200555.1403-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200555.1403-1-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
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

The IIO_CHAN_INFO_CALIBSCALE and IIO_CHAN_INFO_CALIBBIAS masks are
currently associated with the IIO_INTENSITY channel but should be
associated with the IIO_LIGHT channel since these values are used to
calculate the lux. Directory listing of the sysfs attributes for a
TSL2772 with this patch applied:

dev
events
in_illuminance0_calibbias
in_illuminance0_calibrate
in_illuminance0_calibscale
in_illuminance0_calibscale_available
in_illuminance0_input
in_illuminance0_integration_time
in_illuminance0_integration_time_available
in_illuminance0_lux_table
in_illuminance0_target_input
in_intensity0_raw
in_intensity1_raw
in_proximity0_calibrate
in_proximity0_calibscale
in_proximity0_calibscale_available
in_proximity0_raw
name
of_node
power
subsystem
uevent

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 8530bccdb317..d5a237fb0a0b 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1491,14 +1491,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_CALIBSCALE) |
-				BIT(IIO_CHAN_INFO_CALIBBIAS),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			.event_spec = tsl2x7x_events,
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			}, {
@@ -1531,14 +1531,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_CALIBSCALE) |
-				BIT(IIO_CHAN_INFO_CALIBBIAS),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			.event_spec = tsl2x7x_events,
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			}, {
@@ -1580,14 +1580,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_CALIBSCALE) |
-				BIT(IIO_CHAN_INFO_CALIBBIAS),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			.event_spec = tsl2x7x_events,
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			}, {
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
