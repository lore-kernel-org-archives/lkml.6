Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2679656-1525981372-5-3371934451060849024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981372; b=J+nShz3Z3FbpH5mpXWqHB5SLC82FlxPKjaQ5Zzd/jBxCPgnf3n
    US9yLzZTWYOlmeLl1oaytjLzbdmEhGSKltgwHMEuyE3uErC2dqtZiFyzwTvm5a6K
    3FhVx1tAKQe37g1KR9Xk+tcBkI4Wk54AJaUl1K5SV9a4YbNvZ/+EIAF9bO5rec0g
    A6mdcIbIXyPDBghIiipkAqeQxuGjxZWl4IXrAdMg5lV9rni4io4cp4Uxyu7X4TR3
    yLXdkceByuiQU/pAS8t5z1RqqDtcUp+zHOXh2UEp5yNWYCD7ZC0S6cnml1bnoN1Z
    QtWiSOpvuYaZZox+ca/a73xApiGUSCK7GT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981372; bh=Qab1d
    GnuAPQkXtUxLXtaznJGb74Y5JMbYarMrDL3sHA=; b=HpmZYXN8pv4XsCH882eZ3
    1ETcCZdy4Yo8vzPyhJcRQROL1f2UE4ttfTFnD1S4G61viT/rv7Tw0YRbIXwmcDym
    KNBeIIDkeBk0NM1og6oljEy2PpEz2ITVfnniHr6+X0/SYwcgNssAKjpzfbogns0Z
    rvYS3dHbP+YyX7RbGCTXNAy4IW6KMHJ8GmeH83jqpM34xiZDsY1zZVLFx2unhK7F
    GSwzKsviNPupPQBnDhnReBOUt9mkSXTXy9qOd/LFWhArk4oPiCVNvNJH97BQpt2l
    T9JAJ27PyCPZxabdrQoLH68GAf9aIeBRLtlt0bPvygFb25uesab6RKiiifb21IQw
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfATgZC38vfqW8pbusoCVx9Kfi7y0aY3o7UsWz+tCla6mc9xjGVY0falzXStqgeIALkp236a/tWbwe+76JtbzdSHnD9IfxP87bBvQ0Zsb+yXFnkfQ/Yp0
    YU5RozsfyfE/9/MUvO5PzdR5JIHppvfYNmnB9K6AtERH+t/R5zLfMD2J3RO1CXxc5fm/15mpad+P6uaxxENTnXqwWhDPLZp3wNox0C/srkpRdPoyOiK0pDX5
    r6n1nJJnti8gP3YMdoa/yA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=DDOyTI_5AAAA:8
    a=lsLIWMlXBlr6d1UKuQsA:9 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 14/15] staging: bcm2835: Remove dead code related to framerate.
Date: Thu, 10 May 2018 12:42:19 -0700
Message-Id: <20180510194220.30675-16-eric@anholt.net>
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

Fixes a compiler warning about a set-but-not-used variable. I think
this was just leftover dead code from before set_framerate_params(),
since that also sets up some mmal_parameter_rational structs for fps.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c    | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 2007088ab504..879c0b0ed958 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1397,7 +1397,6 @@ static int vidioc_s_parm(struct file *file, void *priv,
 {
 	struct bm2835_mmal_dev *dev = video_drvdata(file);
 	struct v4l2_fract tpf;
-	struct mmal_parameter_rational fps_param;
 
 	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
@@ -1414,10 +1413,6 @@ static int vidioc_s_parm(struct file *file, void *priv,
 	parm->parm.capture.readbuffers  = 1;
 	parm->parm.capture.capability   = V4L2_CAP_TIMEPERFRAME;
 
-	fps_param.num = 0;	/* Select variable fps, and then use
-				 * FPS_RANGE to select the actual limits.
-				 */
-	fps_param.den = 1;
 	set_framerate_params(dev);
 
 	return 0;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
