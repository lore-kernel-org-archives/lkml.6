Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EDE20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="Je6/lt2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t4D/FzN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EDE20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404719AbeKVRMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:12:54 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52187 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732955AbeKVRMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:12:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 56EDF221CB;
        Thu, 22 Nov 2018 01:34:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 22 Nov 2018 01:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=43Mnox5bB+Skb
        hDE/lCawN4GL6A3tAvydhv4FyW2C3k=; b=Je6/lt2HagR5Q+9XTrM2vG2VQeGrK
        PAub4Z9+iXXZJkKinNBBw/EOS7xCJhX0VkCNcwDFCvvLsaE7zJ8d8R8fRqaMF0CO
        YV2YGQQM0ROPoN1jhUHuQGLN2yoQD25BaLCG7UtuZppnVZGrywIepcy0ZF2O687r
        wdwCKFE5guQgkWipDTyisUq95jIrNrL3zhDVAzv47sXubqsRodLel9N8J5cMB8Lc
        MHCKMSlpBMdfU5igrIMY0zwaooewMwtreLmPzykqq31kVBta6h82jmVyzMBC6AcU
        78Si1yGzb0Z7/eVPODW05sYo4S2m51/y7NfGzotJ0ROqQwUua72drdE7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=43Mnox5bB+SkbhDE/lCawN4GL6A3tAvydhv4FyW2C3k=; b=t4D/FzN8
        +fYwczNLmg7mtjWp5xnbnZGaMsd9ctOr462AuxvCuR+6DGlW5FEKTNHpqm1P4SOe
        ANgVXDQseAGLAkZ61Dw6y5GRio5H6+ruf8iZ4enlYop0ML34QleWRxh5V4rIxnd7
        sPOOjQVIlNkjK+iYRenyYk4gk8Wkc2Jdo9ofe/iXISR3n/HJ6aDlYlJPJ3n+7nr1
        11oZGY5ZZ5Y2wKoYsCAaFZUJbdUWrjY/vbtT55sbmWifu29w8TqNEuCW43ER+M//
        KsryzOjcOrZy7RY4Ky+MkYAV4ODrV2k/+hcdLvyKwaY64+ONl61kZntupADRpZ8S
        XDMDtDimplTDdw==
X-ME-Sender: <xms:DU72W64bhHN3mWQOqPPW3YX5hMvHPKKWmhx8gGUlW7H0lfjQPCfQog>
X-ME-Proxy: <xmx:DU72W10V_VSm-h-2MIVXXxaLi5x6AjG7_W3pdoCCR9tKb6gRG2AvJw>
    <xmx:DU72W4gnP8xMWPLzOiaPWdrUbfO4vEvN93g21sN89v37pXhnxgyBxw>
    <xmx:DU72W9JPpiDn4LJBwO1uNa5suLBKm1_UOO5f7d1MyS0Qv0rdFzu-_Q>
    <xmx:DU72W5XEc8Hny93mN5Ozx71WVmKMp0CutQAxjGlJm7QFCPSe5ML_EQ>
    <xmx:DU72W4X2JySoj1REqq9gZXtOOHd0F9Arx1M6DKZ9fWmRZqpT6VwR5g>
    <xmx:DU72WzaWhHbCGno6eqTf5QDXwrdVdOfwTMi8fDarjmmxS3YUL3NPRg>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A6BE10304;
        Thu, 22 Nov 2018 01:34:50 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/8] Input: add `REL_WHEEL_HI_RES` and `REL_HWHEEL_HI_RES`
Date:   Thu, 22 Nov 2018 16:34:02 +1000
Message-Id: <20181122063409.15816-2-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This event code represents scroll reports from high-resolution wheels and
is modelled after the approach Windows uses. The value 120 is one detent
(wheel click) of movement. Mice with higher-resolution scrolling can send
fractions of 120 to be accumulate in userspace. Userspace can either wait
for 120 to accumulate or scroll by fractions of one logical scroll movement
as the events come in.

For more information see
https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn613912(v=vs.85)

These new axes obsolete REL_WHEEL and REL_HWHEEL. The legacy axes are
emulated but the most accurate (and most granular) data is available
through the new axes.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 Documentation/input/event-codes.rst    | 21 ++++++++++++++++++++-
 include/uapi/linux/input-event-codes.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index a8c0873beb95..b24b5343f5eb 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -190,7 +190,26 @@ A few EV_REL codes have special meanings:
 * REL_WHEEL, REL_HWHEEL:
 
   - These codes are used for vertical and horizontal scroll wheels,
-    respectively.
+    respectively. The value is the number of detents moved on the wheel, the
+    physical size of which varies by device. For high-resolution wheels
+    this may be an approximation based on the high-resolution scroll events,
+    see REL_WHEEL_HI_RES. These event codes are legacy codes and
+    REL_WHEEL_HI_RES and REL_HWHEEL_HI_RES should be preferred where
+    available.
+
+* REL_WHEEL_HI_RES, REL_HWHEEL_HI_RES:
+
+  - High-resolution scroll wheel data. The accumulated value 120 represents
+    movement by one detent. For devices that do not provide high-resolution
+    scrolling, the value is always a multiple of 120. For devices with
+    high-resolution scrolling, the value may be a fraction of 120.
+
+    If a vertical scroll wheel supports high-resolution scrolling, this code
+    will be emitted in addition to REL_WHEEL or REL_HWHEEL. The REL_WHEEL
+    and REL_HWHEEL may be an approximation based on the high-resolution
+    scroll events. There is no guarantee that the high-resolution data
+    is a multiple of 120 at the time of an emulated REL_WHEEL or REL_HWHEEL
+    event.
 
 EV_ABS
 ------
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index ae366b87426a..7f14d4a66c28 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -716,6 +716,8 @@
  * the situation described above.
  */
 #define REL_RESERVED		0x0a
+#define REL_WHEEL_HI_RES	0x0b
+#define REL_HWHEEL_HI_RES	0x0c
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
-- 
2.19.1

