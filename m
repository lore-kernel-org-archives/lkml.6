Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2679656-1525981378-2-8920832636436923843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ensvsk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981377; b=LMcMh/poloZ0mgT85glSTPETQMkNRqi2sndv3AhBGT8b4FfmCA
    ieCdNo+R4XV/s4PIhE7Nt/tSwbSnG7j204JaHQ7aoYCKsDJljzt3gr9GPyzhVOWc
    ovp6zepPQnl+FBuqjxjDm41l3hCXU83Ss5hsi182B52Ls3Vaxu/0tj0fqVhw3liQ
    E7LOTT/p3pxXuQLwTP5GQKI/kay9N1dsH6KaW4FO6hmELqHiU4is29h527q0wS5Z
    4Hu4lvLlm69JoOClDFTJCrskdH3AqeH1uEPL92cdjwyWFcQPh/bxUJ1kyICeWu3X
    A7AW+10giqcmi029XXvO4oEeBfgE2DmbCayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981377; bh=gSmNd
    PM1Kgww9G+KROEMBOExzOvtgW0CZwvAg2Ne1zw=; b=YUOpcenGVgVUxyk2bDrvR
    kWWeOiGdkONnO1ctvtGmVADOeUZbBYf1CjdyM1WwopLVUo++P1Oi8gi2rir3/7j6
    PPRmxXAA5d4C0C8x/Hiv+UF6abY+fexWN3Jx7zLZqJbdhuNPZ2NEM37vtWirTrre
    eUihWj2VZmcz/6GSviuwN+Z2TEzAuNzLHGOJxP/Yzg9Ke97Qs73Uoq9qk5MsFwFS
    Z0Oq8E9jH+1Tj5+ttGLgUqppo0j5HjCYxFBkXeGdwPed8kO6Yb/d4Xcy2xfiUmCe
    uepL22HuAzCxenFPqWcRBApyLQiwJAs+CqKGww+UlXNEmCn17hT93H7YPdSrsx66
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
X-CM-Envelope: MS4wfMtYGuV/gxGMNxZZ3khzFW7f+/Cxm7xfH4G0U6TuE0SQgs/HKkaK08JYrnsy+thw+wxzG/0MK19aT6UvLjutDefZfP2l8V5vDB4dYFNc+HnAk3NZqBFG
    b30BBH5fd/61fvYmK3/NxnAAeAUJ1f9YK4bthBGC9rY9GKA93tiF/ZCqV5ZTEGnPGGwWxUTG3X0X/9kQdNlO+/GQwbzeuCQle2BFwb+lOOscoItHdomJWh8A
    +5cyROu/babcsUgPylnW/A==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=WFZIRff2AAAA:8 a=-VAfIpHNAAAA:8
    a=DDOyTI_5AAAA:8 a=kpU_8PFO9vaYqbZsKhcA:9 a=Yf6lXSJG8N3KO3hE:21
    a=5EOsJRRowPeWxCMK:21 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 09/15] staging: bcm2835-camera: Move struct vchiq_mmal_rect
Date: Thu, 10 May 2018 12:42:13 -0700
Message-Id: <20180510194220.30675-10-eric@anholt.net>
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

struct vchiq_mmal_rect is only referenced from mmal-parameters.h, yet
was defined in mmal-vchiq.h.

Move it to avoid having to include multiple headers for no reason.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../vc04_services/bcm2835-camera/mmal-parameters.h        | 8 ++++++++
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-parameters.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-parameters.h
index 3dc50593a665..184024dfb8b7 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-parameters.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-parameters.h
@@ -564,6 +564,14 @@ enum mmal_parameter_displayset {
 	MMAL_DISPLAY_SET_ALPHA = 0x400,
 };
 
+/* rectangle, used lots so it gets its own struct */
+struct vchiq_mmal_rect {
+	s32 x;
+	s32 y;
+	s32 width;
+	s32 height;
+};
+
 struct mmal_parameter_displayregion {
 	/** Bitfield that indicates which fields are set and should be
 	 * used. All other fields will maintain their current value.
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
index 0ab9f660b822..22b839ecd5f0 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
@@ -32,14 +32,6 @@ enum vchiq_mmal_es_type {
 	MMAL_ES_TYPE_SUBPICTURE   /**< Sub-picture elementary stream */
 };
 
-/* rectangle, used lots so it gets its own struct */
-struct vchiq_mmal_rect {
-	s32 x;
-	s32 y;
-	s32 width;
-	s32 height;
-};
-
 struct vchiq_mmal_port_buffer {
 	unsigned int num; /* number of buffers */
 	u32 size; /* size of buffers */
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
