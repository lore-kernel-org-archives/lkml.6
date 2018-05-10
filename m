Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2676370-1525981360-2-5356683446280891540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981360; b=mG3ll9xIFKNVaNej5AEQWm2KdjIp/vY+6g6ja1uV2rdjp81qPn
    t+WCPqi6Q3eH6uve2BQTqyS4JKj7KilIJR7/PXQbzek2i9L9W9/N64UkxzRmP6/W
    hLQR5xLOLqkvNwEBDpG8vWWCs0rvhXY7fPs4+kFa3AN0Dgf5Fo2Sj1GQtifhxeK/
    39aTgIkn+0VGThI/4XQItuPhG/oAm4azitePLdlvpL3pkh/jmbTqU3Gc+PNuPtgP
    79zP0BVzb/6OEb1qVAMZVRBSFzAiFBmNe+Vf4RvyH43bIfugQ73up74wAoScB4dO
    omssrP1HNO28I+Th8uyNzP5bSMX4/tM9iIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981360; bh=5Ddrm
    5VotVJbNfls92xhMv2pHnRHHopPs2JPaCBBeLU=; b=mAxIcmAHkzzdIIWyLguSg
    xac7SBBCLWgTDw83uNWjH6b6shYHO7AEwJC6it3XiMKZpLReZwUm5zauPFyFeGJt
    ezjTO3hq4wU+/VixJ65pU5TY1sXTsMJ+RCdjqDbCnXQQbDX9FEYpoyN1J6wkM10l
    Cyr4QbTSp8bISvQ0klVhItyxepxSEfe/OrKrlbmizJD2OHj5dZWvsgoMCLnvmlyi
    hLfzI9v24HmtXxeKa/WzwWay9o8r8b2Zg/u179hyhqIcwnMhKG7LQbeoMhHDTut3
    Qu50yPj/53ufw8eMTXcmwZRLZP4DOJOd8NxtLRBfwrDDOBmlSh/lMtZg1fs0eJk4
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD8nFffPJ2ls6grunGU5eyQdMkIPCkzOdrE0tv2KFWJkH6JiDgp7+7hZXh5+9heO3oRjIk8Y6aJqYKK4bsBvI8BgUjprMDYfwWnL8X8xdZjHaNQ2D+M9
    hsCOBawRho1uQU7G/JWbZuRhX0lhqD1uA+oKFgnGfTKtnYM/5qHWuQhMCUVyje13QF286/KKSTTHS5hH9kAJNmXfNw50bV0m4RKO5zHmp4NgZwA230YHOfxO
    ctn/YFFdG6GCTvQzfSvnow==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=DDOyTI_5AAAA:8
    a=R_BO-4Znza9F-IM12VYA:9 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 01/15] staging/vc04_services: Register a platform device for
 the camera driver.
Date: Thu, 10 May 2018 12:42:05 -0700
Message-Id: <20180510194220.30675-2-eric@anholt.net>
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

We had the camera driver set up in a module_init function, but that
meant that the camera driver would fail to load if it was initialized
before VCHI.  By attaching to this platform_device, it can get a
defined load order.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3cd6177a7373..aaa264f3b598 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -168,6 +168,7 @@ static VCHIQ_STATE_T g_state;
 static struct class  *vchiq_class;
 static struct device *vchiq_dev;
 static DEFINE_SPINLOCK(msg_queue_spinlock);
+static struct platform_device *bcm2835_camera;
 
 static const char *const ioctl_names[] = {
 	"CONNECT",
@@ -3638,6 +3639,10 @@ static int vchiq_probe(struct platform_device *pdev)
 		VCHIQ_VERSION, VCHIQ_VERSION_MIN,
 		MAJOR(vchiq_devid), MINOR(vchiq_devid));
 
+	bcm2835_camera = platform_device_register_data(&pdev->dev,
+						       "bcm2835-camera", -1,
+						       NULL, 0);
+
 	return 0;
 
 failed_debugfs_init:
@@ -3655,6 +3660,7 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
+	platform_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	device_destroy(vchiq_class, vchiq_devid);
 	class_destroy(vchiq_class);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
