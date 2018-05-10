Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2676370-1525981378-2-6290662854078488525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981378; b=C5nGIKh4uMYv7JT8wYsovF6HIcvV4gvYgMWubjXCi+df94gh+d
    /q6NcA+Y+px34RHV1RZMrtOvqr8qpGn3EBKNKJXYRPcnNtm/tLHfelVyc9t+pcr6
    iaVGswiLrt+3YBmaUeWNNmi3nsF3kL4mdAi6P/auQ+/Lqcm2A9TPlwynr1PTC5dt
    EBUxO9Xq2LDW9+xCVpvLTgE9ZlBToeKAgIpbZ2u/OjUwfeWdCOW6iPgIR6wqTlbg
    f18Ebk91oaK5lBAxKZPt6eeUG0Z1zYX5wKAGjgdejVADb/Eq3FSJhgJbAzWbRr4n
    d+WLboOO9k1aOfZCXW61I0IKnu/+z/MRvl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981378; bh=HGAgz
    0Fcuvl45PuHpVC1naxKiNf/QXMAIQiflkf86lc=; b=M+XwKPiKW01PmnqV/qCHe
    OE5if/82iXNY1DCsy40kjf7qbbmD8FGZmgHXk9RcFNPdQ9G10ef7MCAMqM0l57br
    GxsFvwOKYjq5wyIXsg4plFV94Qp6ZF/5D0BDiOWf3TWU+sQLE00IYN5pX13FgWei
    TaY1oU/tusNFljp9tTaE2DNCxqiHyyEn7bOQOwXfsT5iL+Pz8qcGXCcXvsHM2YKX
    mlpbJQm17pFnDnticE17DxLlgzYO8qHBWUGWrltX+q+sP1/t5YbeyIX4MuFNh3pU
    g9G+ikfC6vcsPgQ482+/5P3RTPE5zxgkcFs/kawkTiqhQKjcYkUz0RxesjrXRHS7
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfA2mBqvFP1xuDNHob9elWaN9rGn05b5AVRMmgCvxxZsmWGcNjTls+VoOBsCUc2LA8P7UHoyfyR+1/MOCn/UmmeNh4mohJFFJYB/pxJmD2VcEhuGqnZZn
    66w1AusIHVuWhAa9eA+u8ZAlviEXKLi/263lmcB7RU/bRMUS8w2Bfyk1o3pUvlu7U6rkMJQPtLmL7UeZlg2uI0fN/swR4xe0YvPYLRsRG/C5hncohuCJylPW
    E8edwxt6xP8OT44Clk+E9g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=WFZIRff2AAAA:8 a=-VAfIpHNAAAA:8
    a=DDOyTI_5AAAA:8 a=dQTpkXpQtoApUaC3KAwA:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 10/15] staging: bcm2835-camera: Replace BUG_ON with return
 error
Date: Thu, 10 May 2018 12:42:14 -0700
Message-Id: <20180510194220.30675-11-eric@anholt.net>
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

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

The error conditions don't warrant taking the kernel down, so remove
BUG_ON.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c  | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index c5ca56414139..bd6bf3d991ef 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -302,8 +302,8 @@ static int buffer_prepare(struct vb2_buffer *vb)
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p, vb %p\n",
 		 __func__, dev, vb);
 
-	BUG_ON(!dev->capture.port);
-	BUG_ON(!dev->capture.fmt);
+	if (!dev->capture.port || !dev->capture.fmt)
+		return -ENODEV;
 
 	size = dev->capture.stride * dev->capture.height;
 	if (vb2_plane_size(vb, 0) < size) {
@@ -1017,7 +1017,8 @@ static int mmal_setup_components(struct bm2835_mmal_dev *dev,
 	struct mmal_fmt *mfmt = get_format(f);
 	u32 remove_padding;
 
-	BUG_ON(!mfmt);
+	if (!mfmt)
+		return -EINVAL;
 
 	if (dev->capture.encode_component) {
 		v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
