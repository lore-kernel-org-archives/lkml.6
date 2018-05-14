Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-457733-1526283871-2-6349333082276440715
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526283871; b=BDqSzhBjjzIDKJhT2rX1sUZgbgdZqAy2FS7xgFrQW559E/IN35
    OrREinp8zX2SSk+eidDycrIPRtBv6qbuE2YgBEgJ6tARdwz2enobIHNf7gZWtzIh
    xkSvKSZ/ne8BO57ITvrjpYFIF9As4ISc2Xn7EBUNlGSJ+FvtiqsVqYzgNTb+KUaU
    plKgndFExk9fQgw9XAVBBzQTVP2zfLpQuzMIP2+Xt546qCPLEeLXo5einsUBvDs8
    oK44r0M7DRuERUUPC6yRHcRotHc9+NR+As+k0oVn3CZF/VdukF1qfc12if8FyNwo
    k6w8i3255PHRSq4tfPfC4OayFZFQSzXq277Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526283871; bh=3t+kL
    1MuVUO3GWOwmVyCRvVjF4Ew4lu20CSfu9LJkI4=; b=efvQNMgK3TFUaJQc9x3YM
    /2f4ZP9JbDSgPpCADBsvQu6IJL6xwEgck+eI+RtAB4WdfeOyHx+ylsU/XRCvxwjd
    boM9kecWOCWyI7RhTExDpJTvQAULlntcqsxndD4deNv/4zf0Msh8o3MaC5qYgDnx
    MkwdhhsEGgju5fMuQHlkWul+UP4MtEc0FnMKIqp4i1y7RdKl5UQ4lLrTz2fijxif
    Tm0CW+X9iNErxKq7bPpDyOgLqRgJohLnBS0xEHT0e/IXDUOdoLVVFq7Qy9M1G5rZ
    yIGrT39ZnS9BifMJRHhTaY+UvmHfOQW7+DjnCwAN2qfNyeZMxWjH+uXh5x/jc0GU
    A==
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
X-CM-Envelope: MS4wfJl1kqsEprxm6XXS2dBsmszkOPTMGKsPtNsNiGJK52zpE/CgxcQbgswrwRjNJUAQhxGr9F9hrspiToiKA1bp8GV4ehAhQDMrT+gHWXFwIfvZDu00uMGQ
    c2SVRBpDamD2RELWnJ/NvFt0ND0dFm9XPqowv9WfT9EaVuqbF7mSYbJRE73ESKOsZuAxr8UccjdfPXMkq11UdqYX5RTSSox51frZQ3vX8xlbp3B1J1ZbNM/U
    4wxMUUxY/n7ZKfsdZ8H/zg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=rOUgymgbAAAA:8
    a=DDOyTI_5AAAA:8 a=tt8vSI4hZ5jyeoGtuyAA:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=MP9ZtiD8KjrkvI0BhSjB:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] staging: bcm2835-camera: Fix module section mismatch warnings.
Date: Mon, 14 May 2018 08:44:11 +0100
Message-Id: <20180514074411.21637-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
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
Cc: Eric Anholt <eric@anholt.net>, Stephen Rothwell <sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Noticed by Stephen Rothwell in -next.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 4bebb0312ea9 ("staging/bcm2835-camera: Set ourselves up as a platform driver.")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

Note: only compile tested here.

 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 53f33fb3998b..ce26741ae9d9 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1548,7 +1548,7 @@ static int set_camera_parameters(struct vchiq_mmal_instance *instance,
 #define MAX_SUPPORTED_ENCODINGS 20
 
 /* MMAL instance and component init */
-static int __init mmal_init(struct bm2835_mmal_dev *dev)
+static int mmal_init(struct bm2835_mmal_dev *dev)
 {
 	int ret;
 	struct mmal_es_format_local *format;
@@ -1756,8 +1756,8 @@ static int __init mmal_init(struct bm2835_mmal_dev *dev)
 	return ret;
 }
 
-static int __init bm2835_mmal_init_device(struct bm2835_mmal_dev *dev,
-					  struct video_device *vfd)
+static int bm2835_mmal_init_device(struct bm2835_mmal_dev *dev,
+				   struct video_device *vfd)
 {
 	int ret;
 
@@ -1836,7 +1836,7 @@ static struct v4l2_format default_v4l2_format = {
 	.fmt.pix.sizeimage = 1024 * 768,
 };
 
-static int __init bcm2835_mmal_probe(struct platform_device *pdev)
+static int bcm2835_mmal_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct bm2835_mmal_dev *dev;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
