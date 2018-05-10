Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2679656-1525981364-2-11496334813622771149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981363; b=KzlPkcIi10NjQTWl9xw/PQCeHiuUST/HHu0unK9BPISbuhvY8e
    1V1TZ8LWE1SEqBOcrbbpJUXs1QhsXWqLIBOXp4PUE/TLJHTEJtTkjGZFgvubSHCx
    nvbSioeyDStIELmpdeyAFTFke5GwRRW4tBoyeOY2CjAL5oUG7sY5bWlyWzWWR7Ia
    Wi+qvKsA/CpSrKICUT/dVGZbHxsNwM78vrj/STupwC+AbzcEJfuJ0MLSPU9QJ61I
    VfnMXwMm/xo7Ro+FhyBzlq2ekBkeei6M+FmuVg/2f5r1w6AVXTepOiYAfrEkfyqH
    1S8wbksB4rkN+pmYz3uIWq3FKoQy1NCiReAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981363; bh=xT1Z+
    YE+zTFeXEFx11tq4DE70+DQtIBO+LgzVbVEAwY=; b=GHg5n5lHq4vkg4JQa3PtZ
    32JYSDMAP061+VqwYT9o08TR3vfOs1hJTqU2LrH61eT0eEXV9ri2PbFWw90Cn6Rx
    WEij6HtVfXy7//QFekTvC2lYiJCG8r/yM9aJgOl5+4Gti/bXx251WJg31OlTWJ/E
    E1GCQDngz1Pz5x75MOpWgP49L9xBWYOtqwXJzcvW+y/VSdQtXTMLknLPvFDl6J3T
    qfXzelpWepHAU1qxzoujoQC5eHnXM+xOP9/GqQHtjDd77w4nSQ6M7pF6zFMguW5E
    Qh5avhwzgPBrxsqBuNTEEU/HiFfjAGQE/pcrjAOC0ztPPSQrCheQrgs5IJFK1dwI
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfAgRudtaF2ynlYd+5nHZVKqHDoq0kpt3+PIiHYif8WF+sKXPtnWw86FqmjM74rvIKd7kX5/3dNcrT3s3mH+c8gR7t7GtX+xXBHroT7xo8e6hv0c/0q5M
    40TdM9RWISGcLtPXJQ3qxPB/9er5dMAu/uZJg1wvcb4JNriLhMmCrNbPWkMxrfekzCsY0zo3sZ97v29IdnJY6p8z2HhmbzDxmlhz/JsflHNIkM0f4Je0mF6m
    +xg8XaBpCzJ3TFtmXkRDow==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=DDOyTI_5AAAA:8
    a=pDSJwOOx0C7JtDsgWaUA:9 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 13/15] staging: bcm2835-camera: Fix warnings about string ops
 on v4l2 uapi.
Date: Thu, 10 May 2018 12:42:18 -0700
Message-Id: <20180510194220.30675-15-eric@anholt.net>
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

The v4l2 uapi uses u8[] for strings, so cast those to char * to avoid
compiler warnings about unsigned vs signed with sprintf() and friends.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index ad53bce5c786..2007088ab504 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -693,7 +693,7 @@ static int vidioc_enum_fmt_vid_overlay(struct file *file, void *priv,
 
 	fmt = &formats[f->index];
 
-	strlcpy(f->description, fmt->name, sizeof(f->description));
+	strlcpy((char *)f->description, fmt->name, sizeof(f->description));
 	f->pixelformat = fmt->fourcc;
 	f->flags = fmt->flags;
 
@@ -851,7 +851,7 @@ static int vidioc_enum_input(struct file *file, void *priv,
 		return -EINVAL;
 
 	inp->type = V4L2_INPUT_TYPE_CAMERA;
-	sprintf(inp->name, "Camera %u", inp->index);
+	sprintf((char *)inp->name, "Camera %u", inp->index);
 	return 0;
 }
 
@@ -879,11 +879,11 @@ static int vidioc_querycap(struct file *file, void *priv,
 
 	vchiq_mmal_version(dev->instance, &major, &minor);
 
-	strcpy(cap->driver, "bm2835 mmal");
-	snprintf(cap->card, sizeof(cap->card), "mmal service %d.%d",
+	strcpy((char *)cap->driver, "bm2835 mmal");
+	snprintf((char *)cap->card, sizeof(cap->card), "mmal service %d.%d",
 		 major, minor);
 
-	snprintf(cap->bus_info, sizeof(cap->bus_info),
+	snprintf((char *)cap->bus_info, sizeof(cap->bus_info),
 		 "platform:%s", dev->v4l2_dev.name);
 	cap->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_VIDEO_OVERLAY |
 	    V4L2_CAP_STREAMING | V4L2_CAP_READWRITE;
@@ -902,7 +902,7 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
 
 	fmt = &formats[f->index];
 
-	strlcpy(f->description, fmt->name, sizeof(f->description));
+	strlcpy((char *)f->description, fmt->name, sizeof(f->description));
 	f->pixelformat = fmt->fourcc;
 	f->flags = fmt->flags;
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
