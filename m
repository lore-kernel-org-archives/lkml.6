Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EE737C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD0820693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOJ6vm9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD0820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933585AbeFLHtt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:49:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37323 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933348AbeFLHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:49:13 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so32533836lfb.4;
        Tue, 12 Jun 2018 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aeYlAw6zzL39UODlCI4I7JnN5rvSsiKx3KLbZ4Toj9U=;
        b=TOJ6vm9dFmByKLB6Y1v1SSB14sr6y9WVfQ9NsGo7lakyegQoYRaCqiVDeWBknxjBA/
         N07FSEeM3Ms0GyJ68nj6IBcj2XA855n0KoeZl68McDswsVufytMLY/kCZ6NaarvMqf7r
         MZbymZnS0bv9acXLZpxP3ezpfBfqT0d+Xib8ng+NVHlpCocjJyP6qteZteDeVjjeZGbO
         B6BI0qoCze15f4eZgXoOL+U9Z7ZaGsWvcDLLoPObBUq9/oIay4I9b/zgsy9hOt5BUnWj
         ZYF6xxSOymKhFWun28xDNiNo6kbcklLW9ydXHJi8FE2xOv2ag11bjsXQJHqqdZ8dxkEX
         mglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aeYlAw6zzL39UODlCI4I7JnN5rvSsiKx3KLbZ4Toj9U=;
        b=QYk29BWExXl2lRtmcVIlEUcAOFD4guoGWNBN01CdQG39K88TYYkOnd4uoxhCgOOFkd
         mAimlUYokTcVRfQe+km4GDYO/fA2zy4JkZ65h1NKhHwYkw9w1uZhBVuAPG5Gsy0NZjDu
         PpxcDCC7BssKX1eYhvlSuzaa66h/MQ1bcWC759xVSJiGP9ChAE3+deSxiIfOOh87YZIB
         Hlf85m4fNQqiUKARTLrcDOwkuQg0CqkbfWWYU3cHTuSAUdxr7utxM7LZ4TyPmM97QMzn
         Kvx9bo1AItd7dS39Sz8huJvZiIb94HAcCgXtLSOqeiT5lncflyrEVy3XyoLacnIA4nxl
         vxNg==
X-Gm-Message-State: APt69E2RTrDrNtnt4sjugZ9QEYbT+z+qMXSy4/KzadD8e3y1VBsRVYwJ
        p5WDlYdI1OBm61XNGTNNzmA=
X-Google-Smtp-Source: ADUXVKLL1y/QpafVK9CQo3eXiiahEV/BrU36KGkBwxUW+9EK+AkA6DSbJIvesjkUEuHq1R/RscWBjA==
X-Received: by 2002:a19:1156:: with SMTP id g83-v6mr1320659lfi.142.1528789751543;
        Tue, 12 Jun 2018 00:49:11 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id b65-v6sm62657lfe.80.2018.06.12.00.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 00:49:10 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc:     konrad.wilk@oracle.com, andr2000@gmail.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v5 1/3] xen: Sync up with the canonical protocol definitions in Xen
Date:   Tue, 12 Jun 2018 10:48:54 +0300
Message-Id: <20180612074856.28451-2-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612074856.28451-1-andr2000@gmail.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

This is the sync up with the canonical definitions of the input,
sound and display protocols in Xen.

Changes to kbdif:
1. Add missing string constants for {feature|request}-raw-pointer
   to align with the rest of the interface file.

2. Add new XenStore feature fields, so it is possible to individually
   control set of exposed virtual devices for each guest OS:
     - set feature-disable-keyboard to 1 if no keyboard device needs
       to be created
     - set feature-disable-pointer to 1 if no pointer device needs
       to be created

3. Move multi-touch device parameters to backend nodes: these are
    described as a part of frontend's XenBus configuration nodes
    while they belong to backend's configuration. Fix this by moving
    the parameters to the proper section.

Unique-id field:
1. Add unique-id XenBus entry for virtual input and display.

2. Change type of unique-id field to string for sndif to align with
display and input protocols.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 include/xen/interface/io/displif.h |  8 +++
 include/xen/interface/io/kbdif.h   | 78 ++++++++++++++++++++++--------
 include/xen/interface/io/sndif.h   | 10 ++--
 3 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/include/xen/interface/io/displif.h b/include/xen/interface/io/displif.h
index 596578d9be3e..fdc279dc4a88 100644
--- a/include/xen/interface/io/displif.h
+++ b/include/xen/interface/io/displif.h
@@ -189,6 +189,13 @@
  *
  *----------------------------- Connector settings ----------------------------
  *
+ * unique-id
+ *      Values:         <string>
+ *
+ *      After device instance initialization each connector is assigned a
+ *      unique ID, so it can be identified by the backend by this ID.
+ *      This can be UUID or such.
+ *
  * resolution
  *      Values:         <width, uint32_t>x<height, uint32_t>
  *
@@ -368,6 +375,7 @@
 #define XENDISPL_FIELD_EVT_CHANNEL	"evt-event-channel"
 #define XENDISPL_FIELD_RESOLUTION	"resolution"
 #define XENDISPL_FIELD_BE_ALLOC		"be-alloc"
+#define XENDISPL_FIELD_UNIQUE_ID	"unique-id"
 
 /*
  ******************************************************************************
diff --git a/include/xen/interface/io/kbdif.h b/include/xen/interface/io/kbdif.h
index 2a9510ade701..b4439cf48220 100644
--- a/include/xen/interface/io/kbdif.h
+++ b/include/xen/interface/io/kbdif.h
@@ -51,6 +51,18 @@
  * corresponding entries in XenStore and puts 1 as the value of the entry.
  * If a feature is not supported then 0 must be set or feature entry omitted.
  *
+ * feature-disable-keyboard
+ *      Values:         <uint>
+ *
+ *      If there is no need to expose a virtual keyboard device by the
+ *      frontend then this must be set to 1.
+ *
+ * feature-disable-pointer
+ *      Values:         <uint>
+ *
+ *      If there is no need to expose a virtual pointer device by the
+ *      frontend then this must be set to 1.
+ *
  * feature-abs-pointer
  *      Values:         <uint>
  *
@@ -63,6 +75,22 @@
  *      Backends, which support reporting of multi-touch events
  *      should set this to 1.
  *
+ * feature-raw-pointer
+ *      Values:        <uint>
+ *
+ *      Backends, which support reporting raw (unscaled) absolute coordinates
+ *      for pointer devices should set this to 1. Raw (unscaled) values have
+ *      a range of [0, 0x7fff].
+ *
+ *-----------------------  Device Instance Parameters ------------------------
+ *
+ * unique-id
+ *      Values:         <string>
+ *
+ *      After device instance initialization it is assigned a unique ID,
+ *      so every instance of the frontend can be identified by the backend
+ *      by this ID. This can be UUID or such.
+ *
  *------------------------- Pointer Device Parameters ------------------------
  *
  * width
@@ -77,6 +105,25 @@
  *      Maximum Y coordinate (height) to be used by the frontend
  *      while reporting input events, pixels, [0; UINT32_MAX].
  *
+ *----------------------- Multi-touch Device Parameters ----------------------
+ *
+ * multi-touch-num-contacts
+ *      Values:         <uint>
+ *
+ *      Number of simultaneous touches reported.
+ *
+ * multi-touch-width
+ *      Values:         <uint>
+ *
+ *      Width of the touch area to be used by the frontend
+ *      while reporting input events, pixels, [0; UINT32_MAX].
+ *
+ * multi-touch-height
+ *      Values:         <uint>
+ *
+ *      Height of the touch area to be used by the frontend
+ *      while reporting input events, pixels, [0; UINT32_MAX].
+ *
  *****************************************************************************
  *                            Frontend XenBus Nodes
  *****************************************************************************
@@ -98,6 +145,13 @@
  *
  *      Request backend to report multi-touch events.
  *
+ * request-raw-pointer
+ *      Values:         <uint>
+ *
+ *      Request backend to report raw unscaled absolute pointer coordinates.
+ *      This option is only valid if request-abs-pointer is also set.
+ *      Raw unscaled coordinates have the range [0, 0x7fff]
+ *
  *----------------------- Request Transport Parameters -----------------------
  *
  * event-channel
@@ -117,25 +171,6 @@
  *
  *      OBSOLETE, not recommended for use.
  *      PFN of the shared page.
- *
- *----------------------- Multi-touch Device Parameters -----------------------
- *
- * multi-touch-num-contacts
- *      Values:         <uint>
- *
- *      Number of simultaneous touches reported.
- *
- * multi-touch-width
- *      Values:         <uint>
- *
- *      Width of the touch area to be used by the frontend
- *      while reporting input events, pixels, [0; UINT32_MAX].
- *
- * multi-touch-height
- *      Values:         <uint>
- *
- *      Height of the touch area to be used by the frontend
- *      while reporting input events, pixels, [0; UINT32_MAX].
  */
 
 /*
@@ -163,9 +198,13 @@
 
 #define XENKBD_DRIVER_NAME		"vkbd"
 
+#define XENKBD_FIELD_FEAT_DSBL_KEYBRD	"feature-disable-keyboard"
+#define XENKBD_FIELD_FEAT_DSBL_POINTER	"feature-disable-pointer"
 #define XENKBD_FIELD_FEAT_ABS_POINTER	"feature-abs-pointer"
+#define XENKBD_FIELD_FEAT_RAW_POINTER	"feature-raw-pointer"
 #define XENKBD_FIELD_FEAT_MTOUCH	"feature-multi-touch"
 #define XENKBD_FIELD_REQ_ABS_POINTER	"request-abs-pointer"
+#define XENKBD_FIELD_REQ_RAW_POINTER	"request-raw-pointer"
 #define XENKBD_FIELD_REQ_MTOUCH		"request-multi-touch"
 #define XENKBD_FIELD_RING_GREF		"page-gref"
 #define XENKBD_FIELD_EVT_CHANNEL	"event-channel"
@@ -174,6 +213,7 @@
 #define XENKBD_FIELD_MT_WIDTH		"multi-touch-width"
 #define XENKBD_FIELD_MT_HEIGHT		"multi-touch-height"
 #define XENKBD_FIELD_MT_NUM_CONTACTS	"multi-touch-num-contacts"
+#define XENKBD_FIELD_UNIQUE_ID		"unique-id"
 
 /* OBSOLETE, not recommended for use */
 #define XENKBD_FIELD_RING_REF		"page-ref"
diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
index 78bb5d9f8d83..2aac8f73614c 100644
--- a/include/xen/interface/io/sndif.h
+++ b/include/xen/interface/io/sndif.h
@@ -278,13 +278,11 @@
  *      defined under the same device.
  *
  * unique-id
- *      Values:         <uint32_t>
+ *      Values:         <string>
  *
- *      After stream initialization it is assigned a unique ID (within the front
- *      driver), so every stream of the frontend can be identified by the
- *      backend by this ID. This is not equal to stream-idx as the later is
- *      zero based within the device, but this index is contigous within the
- *      driver.
+ *      After stream initialization it is assigned a unique ID, so every
+ *      stream of the frontend can be identified by the backend by this ID.
+ *      This can be UUID or such.
  *
  *-------------------- Stream Request Transport Parameters --------------------
  *
-- 
2.17.1

