Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2679656-1525981374-2-11037354551682877151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981373; b=Jw+OM0giHGNJbuB+OzlLIZOnlPaqLAqpWOrCwlNvpkci6Gkfcm
    KitaRqN5+h4Gdj1czOblWnJGO6Zz4qC79igond45uiIlYa3Uu716TVFiL9ZQZWN+
    ahwjaHgiCOHieA4qjTbHe7Ax4YxlYDkSPPSZ1PuAN9t++FF3/ktBH1r1WK2c7vJD
    GpnN8pCEHiZufDnzJCZNzaZV83bQjiJVY+OP6V+RVWKYq25aLP9OSEUHdfEETriF
    mMKMCi7eBfqUmBeuV/b1b3cRn1bmTOqeJOr1eKCrNLpd5Cw39pu9O1t6eNGex9QQ
    LpgwG8eOf8AigsUQGydOLUDyxFK43U8yOb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981373; bh=lfCkp
    QWjBG9tWpvU6tiXsLIQmpmxZCX1/1LnkLdNLRM=; b=fOeiR/N4bTByzqRQetjkp
    XN/lOmLY1GaCeatwNLaqO9xa52myukOdH8i+ZdO30KZ7zRAyNV6dfKJ1bPkyYPNU
    rRmg6f8cKKi1UKx1jwIpsVbYDRSB+6zNi8PZFVo2BTOJwe/iZjgJrZBM9klEyecg
    DzoV99WpsupOkVOUk4qvkEsHNYwJCa/Yk49ZGe7C0BT2FhioteMAVn/ObBkWQ4Se
    NWOHfbIy0c7me3iZ//f5hWGp0Nqj99ZeZdKMNiJU6sp6iXdy3Ss1Wj9JCM+TBRsc
    7cWMJGr/quWOuFCJcc5sQTLcP3s2i+D211di9cQAGJHxgc4L+3JTaOFfZtUVPnRB
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
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
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJaRukvGkQj8fP3APOWKLUV9trY7FRLS/MtnkTT0sLZ2dM9nF62W7svSSLdBJLOuSYIL2efCm8M820nL1FD8JVAK/9inNR33d2/jZ1yy42O9MZj/H1Zu
    Omji3ygzSJZy6tducbIedCJPK5qBu1YMX24elkjyho3KEsVymCWN9ACsdCEZ0tU47ltV0kqdNl2GpdSgdvzxUEmCY1j3ra2/J7nWTHlcG4+NV0ChMshOJCbq
    lFc/CIeNcVnj1qPMyU/nqQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=DDOyTI_5AAAA:8
    a=xzDHn56aIbsgqSmip3gA:9 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 15/15] staging: bcm2835: Fix mmal_port_parameter_get()
 signed/unsigned warnings.
Date: Thu, 10 May 2018 12:42:20 -0700
Message-Id: <20180510194220.30675-17-eric@anholt.net>
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

The arg is a u32 *, so switch over to that in our declarations.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 879c0b0ed958..53f33fb3998b 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -492,7 +492,7 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 {
 	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
 	int ret;
-	int parameter_size;
+	u32 parameter_size;
 
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p\n",
 		 __func__, dev);
@@ -1489,7 +1489,7 @@ static int get_num_cameras(struct vchiq_mmal_instance *instance,
 	int ret;
 	struct vchiq_mmal_component  *cam_info_component;
 	struct mmal_parameter_camera_info_t cam_info = {0};
-	int param_size = sizeof(cam_info);
+	u32 param_size = sizeof(cam_info);
 	int i;
 
 	/* create a camera_info component */
@@ -1553,7 +1553,7 @@ static int __init mmal_init(struct bm2835_mmal_dev *dev)
 	int ret;
 	struct mmal_es_format_local *format;
 	u32 supported_encodings[MAX_SUPPORTED_ENCODINGS];
-	int param_size;
+	u32 param_size;
 	struct vchiq_mmal_component  *camera;
 
 	ret = vchiq_mmal_init(&dev->instance);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
