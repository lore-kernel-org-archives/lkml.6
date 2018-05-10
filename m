Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2679656-1525981359-3-12493335594809862008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981358; b=BNTflKENmWJZ1YBbKrguNUUK5WBp9WuTB2hYSyKxRTUjiT/gCI
    oZXOxQOddNOMh8+yBeyNB/XfIqR8WQjq6HIZphG/ZZN2h2ihOO1KPO1OmExbzmbo
    xVPgGdzmg4rMeVWzrxOryGPE5F7y0R3bpBGe+hRK6HioCAnlBKYI3jDUUIKLo6k/
    j/zXwzCUoD4ZabR63LCpiQ/goPanStTdFxPkdBMT9FCy/wljRugEIQoXfOuiEpog
    AcI/S8fXGaaH6DHhcEAAXtCKxTrfzJIlGeWZgIyX2LGy2BhSCCN/XZG6+5tUK5kg
    /lOO9R7zSqSoLaQ6ibc3QvoOjoWi8olkSTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981358; bh=e94cY
    H6vPfW3CHisEWkBoJBn57O+8KIjdjd8JUZcvxU=; b=BHTwNKK8F8dUrDlZeJo0t
    iZ2WvuhPp6NsK4UOw7CPPK062xGKDEWC04KU5TkLSac9vlkWlnW3kFY/w/vaTdlD
    kVZrugl/OXQuXdaPvZsbivJpPskFEgo715oOKilo0OB6wUvxieFFIxpUIwlWtvFJ
    DnK3qiHIWiMxyaBH1PjXoduUwQIk3CltPRV6iTdXaS97UYKMseLrCLBaXKEfBoss
    CgOzUARIadXYN+QoLmoXXHRI1AlHfcoiiiGskh+rOhRpDok/yqGozPoCV6pQjcPs
    YzP4/sdEmf6+RdRkbS6RotqPb40H6q46Z2bY7yCdg6XIT/mvjCJ3EbJL1hAplV5m
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMBn3xI5RNw8AIjWfCnC52yVU5dagySKQ0Mng3hy5yu5Qraw/x77Y0oqIPG+Y9BqhWUQoeqB42u0Mx6Qo+SSWkhNtYHdYfdR0zsUoaWyIOg3ibZrytD9
    bYytVi27JOZq2pqY3MCAbuG3PuIpiE9n9hTPF1oIag25IFpeknTjclIimj+Q7b18bNJAhkBOgWKse37XY8V010deSvCiO/xmXZEgirrJjiN1f7RDkF2fY9cF
    XaXd5hzDOHf2dbpKGBw5kA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=DDOyTI_5AAAA:8
    a=-B4B5sOZg7tpHuUgsZwA:9 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 02/15] staging/bcm2835-camera: Set ourselves up as a platform
 driver.
Date: Thu, 10 May 2018 12:42:06 -0700
Message-Id: <20180510194220.30675-3-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510194220.30675-1-eric@anholt.net>
References: <20180510194220.30675-1-eric@anholt.net>
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
Cc: Eric Anholt <eric@anholt.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This allows bcm2835-camera to automatically probe after VCHI has
loaded, rather than only successfully probing if the arbitrary probe
order chooses us after VCHI.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../staging/vc04_services/bcm2835-camera/TODO  | 11 -----------
 .../bcm2835-camera/bcm2835-camera.c            | 18 ++++++++++++++----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
index 0ab9e88d769a..cefce72d814f 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/TODO
+++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
@@ -21,14 +21,3 @@ less copy it needed to do.
 The bulk_receive() does some manual cache flushing that are 32-bit ARM
 only, which we should convert to proper cross-platform APIs.
 
-4) Convert to be a platform driver.
-
-Right now when the module probes, it tries to initialize VCHI and
-errors out if it wasn't ready yet.  If bcm2835-v4l2 was built in, then
-VCHI generally isn't ready because it depends on both the firmware and
-mailbox drivers having already loaded.
-
-We should have VCHI create a platform device once it's initialized,
-and have this driver bind to it, so that we automatically load the
-v4l2 module after VCHI loads.
-
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index d2262275a870..aac876c35dea 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -23,6 +23,7 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-common.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 
 #include "mmal-common.h"
 #include "mmal-encodings.h"
@@ -1803,7 +1804,7 @@ static struct v4l2_format default_v4l2_format = {
 	.fmt.pix.sizeimage = 1024 * 768,
 };
 
-static int __init bm2835_mmal_init(void)
+static int __init bcm2835_mmal_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct bm2835_mmal_dev *dev;
@@ -1923,7 +1924,7 @@ static int __init bm2835_mmal_init(void)
 	return ret;
 }
 
-static void __exit bm2835_mmal_exit(void)
+static int bcm2835_mmal_remove(struct platform_device *pdev)
 {
 	int camera;
 	struct vchiq_mmal_instance *instance = gdev[0]->instance;
@@ -1933,7 +1934,16 @@ static void __exit bm2835_mmal_exit(void)
 		gdev[camera] = NULL;
 	}
 	vchiq_mmal_finalise(instance);
+
+	return 0;
 }
 
-module_init(bm2835_mmal_init);
-module_exit(bm2835_mmal_exit);
+static struct platform_driver bcm2835_camera_driver = {
+	.probe		= bcm2835_mmal_probe,
+	.remove		= bcm2835_mmal_remove,
+	.driver		= {
+		.name	= "bcm2835-camera",
+	},
+};
+
+module_platform_driver(bcm2835_camera_driver)
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
