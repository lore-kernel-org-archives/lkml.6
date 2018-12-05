Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4228E2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="GgrYvSUS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bytmm5Dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4228E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeLEAm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:42:56 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43921 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbeLEAmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:42:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7F575F52;
        Tue,  4 Dec 2018 19:42:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Dec 2018 19:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=f6T5afCfbSIx/
        IZSw2eDCVOPTs4vfPtmyp4UlGxir3g=; b=GgrYvSUSV1D6R2TasBIju2SRun1Yi
        IZFvoIOcvoOKF+4iFedP5XoyUyvVUMT+LD3KXh+kSTWZRNw7b7updcVtKFxlNoXt
        EnBVuOmIOfZRFaMmU44MJtxhdyTy8yDJKbXGu2XHe7FPtgeHtTnMXlsz08X7rd38
        aUgF4EvklF43Cfx7Jhe7wXSfkmrbLH/ANXfX8+hJQcg9J/wX+Vwb+lxqSEW20KOi
        uGpRx44R0IFh3QqHXbsY33n/hxi5n5mEprEPfL1UqdNpkajSi2cKxslrMFg3GxFH
        A4oR+BtQPpkeX4ZTMnDQCCimZd1LMDRGBpoVDHGS6eMYkeRNtI/j4v3Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=f6T5afCfbSIx/IZSw2eDCVOPTs4vfPtmyp4UlGxir3g=; b=bytmm5Dh
        pkmwfpjMIsTP2EOMNc7U/IaZQY2Ff71fpAstvQDLx8z985x8kSE/kPk54a6yuJCx
        HOk6tJvrUd/RAqhCGnt0HWI+mYFwPooUg+kyXMLGBFAeGUpIaCQVXJOT6ofV5TcP
        etmCX2YI7q54IQqoSZ72uD6PHNtjMmyYnNlm0TzQbERVUKmQ7nvONzgBoDp+muGx
        5FVmZhFJ+gtGTySe38dQEE8uTlqf2fuEUowi4hZZYDHkB+nui+KhEziUT66uBlP3
        kx51zxp2K84bLCYldPfaIJtPwSHmRsUmpB8ru2FPH9m2tEnaTEqIT58lHaHxON07
        KD5vVs4568vkNg==
X-ME-Sender: <xms:Cx8HXBpETLi09oxZCExT8Vtq5MS43yy0KfTe1L_00lvTdFNr5OeGDw>
X-ME-Proxy: <xmx:DB8HXFlVqNoHaXY5b92S262v-RlXYPEf_e53LAeI3CQnDpFppjg-Ew>
    <xmx:DB8HXM1KHhP0YmphuOWkceoms0N2OoUOC6vdh3H1PMPQYpR2v28VGw>
    <xmx:DB8HXN1X2Zig928ARp4Yk-zpVb0xUqU4XqxrnMAkGmNyjZ-fIfL1pA>
    <xmx:DB8HXGrX6jGUOkvcgIbEPVPq-tZCMtz-SBTK1umqRnoX5gj-HopDvg>
    <xmx:DB8HXBjJXEfmvb76it165kkqmppJVxxAwnRaY1DcZWkIYNJCr0sJ0g>
    <xmx:DB8HXD02lezFZTpwKqJj7r0SxsffDfPCnfRSLRE3yE2PBZxfF0y0Yw>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42F0FE48FA;
        Tue,  4 Dec 2018 19:42:49 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 1/8] Input: add `REL_WHEEL_HI_RES` and `REL_HWHEEL_HI_RES`
Date:   Wed,  5 Dec 2018 10:42:21 +1000
Message-Id: <20181205004228.10714-2-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This event code represents scroll reports from high-resolution wheels and
is modelled after the approach Windows uses. The value 120 is one detent
(wheel click) of movement. Mice with higher-resolution scrolling can send
fractions of 120 which must be accumulated in userspace. Userspace can either
wait for a full 120 to accumulate or scroll by fractions of one logical scroll
movement as the events come in. 120 was picked as magic number because it has
a high number of integer fractions that can be used by high-resolution wheels.

For more information see
https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn613912(v=vs.85)

These new axes obsolete REL_WHEEL and REL_HWHEEL. The legacy axes are emulated
by the kernel but the most accurate (and most granular) data is available
through the new axes.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
No changes since v1

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
index 3eb5a4c3d60a..265ef2028660 100644
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
2.19.2

