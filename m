Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A764C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4E020685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="UAAVQz6m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yB42fFZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4E020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404774AbeKVRNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:13:06 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33351 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732955AbeKVRNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:13:04 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6467921F6E;
        Thu, 22 Nov 2018 01:35:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 22 Nov 2018 01:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=rqGA+sHkbk+eb
        jBuT8Yp6ziYbTakIen1wcALDPQO6Og=; b=UAAVQz6mWmvqXMHj66ec9mC30oFoB
        VuQ0VCSZgDdAg5L1kVR7EV/sV2HPkNbQdQoeUOAxgXjD0ChBOz5FJmpPiwA+c96p
        ykn37YmdHMBX/1BQuJKktD/TGRm3aQqngNZsVjLs3auliVziZHemebKEtCEcCsu5
        MzR22z8jWLK2hMUeGXoCGnMiVrUY5AjPhSqsLHkAJUa/Fn3kP9CaGsIhdEKZ7wzw
        9gYZj4J7yQeTfFNPJ0Ja0+kA9mzrybQGLmekIEUwRJQCWmc3XFR0/gxOP503HGMm
        Sha8KbO4sumeD3USZKiuXP5cOwNRK6WxYVke2T8srMVdFAGM9Pv+4Nwdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=rqGA+sHkbk+ebjBuT8Yp6ziYbTakIen1wcALDPQO6Og=; b=yB42fFZ4
        uzHh1SSMMwPXdA8AItWDjonqHA9UpVLJXg/0JxW7/zGvB+YODI50tpvMHggS8gQn
        0UJnEev1DX3hgnd9rgvHjImhkXoXdkxLXEl3N/HXSY8Aj6bhTi/U7IwE5kIttSbY
        xMcyl+eNGbNJBXIEZGNxLDCQJ3p2N0JngFF76uPE2NRvrAD4yc/u7lqX15eGHN7H
        PP1oDL8ZmGMu6PMrA5vOZN+dgP8iOI98xNY3DxOCR+WAH20Lk2Ti2x1jhfaGlD9u
        xnFFKH30tIqz5hTuhvc73X5/WRER4dl9mVbDNvfKNhC4tw18G80xXGQppjR65NSE
        RTCDm4XTSXS3QA==
X-ME-Sender: <xms:GU72W6usVRX_yl7CjsvHiVYxu8nCjQuDTBlvGjcHylb-BYnIDNJc6w>
X-ME-Proxy: <xmx:GU72W4GK7yk5XEhn-YjQY5GjesVdawNwq6e9aiBydzo3QE0DaBknCA>
    <xmx:GU72W-wkNPFG0I9xuWVl9wA1dR1QH3LEmI1eQHbWtfo1TFlvpobVNA>
    <xmx:GU72WyF8QFzk8tLMOBsvgVkFoYeG2ItnfoJOIxjFq2IlZN0tcJPrCQ>
    <xmx:GU72W7sYq60ZCt5DGowUY8vRPjaZkwr1lcl9DvZLNoBNyyiHwwAM7Q>
    <xmx:GU72W-XhOcs_9WtUlZxTVZuaXEGuobooZ6pnkuDJhvkiP6pLSOEB1w>
    <xmx:GU72W62LuzdLPosU7Q3jkFFrJt0Q6D75pacH2gnePC7GwnCMyPlXpg>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 832CA102EE;
        Thu, 22 Nov 2018 01:35:02 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/8] HID: logitech-hidpp: fix typo, hiddpp to hidpp
Date:   Thu, 22 Nov 2018 16:34:06 +1000
Message-Id: <20181122063409.15816-6-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/hid-logitech-hidpp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 19cc980eebce..22b37a3844d1 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1465,7 +1465,7 @@ struct hidpp_ff_work_data {
 	u8 size;
 };
 
-static const signed short hiddpp_ff_effects[] = {
+static const signed short hidpp_ff_effects[] = {
 	FF_CONSTANT,
 	FF_PERIODIC,
 	FF_SINE,
@@ -1480,7 +1480,7 @@ static const signed short hiddpp_ff_effects[] = {
 	-1
 };
 
-static const signed short hiddpp_ff_effects_v2[] = {
+static const signed short hidpp_ff_effects_v2[] = {
 	FF_RAMP,
 	FF_FRICTION,
 	FF_INERTIA,
@@ -1873,11 +1873,11 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	version = bcdDevice & 255;
 
 	/* Set supported force feedback capabilities */
-	for (j = 0; hiddpp_ff_effects[j] >= 0; j++)
-		set_bit(hiddpp_ff_effects[j], dev->ffbit);
+	for (j = 0; hidpp_ff_effects[j] >= 0; j++)
+		set_bit(hidpp_ff_effects[j], dev->ffbit);
 	if (version > 1)
-		for (j = 0; hiddpp_ff_effects_v2[j] >= 0; j++)
-			set_bit(hiddpp_ff_effects_v2[j], dev->ffbit);
+		for (j = 0; hidpp_ff_effects_v2[j] >= 0; j++)
+			set_bit(hidpp_ff_effects_v2[j], dev->ffbit);
 
 	/* Read number of slots available in device */
 	error = hidpp_send_fap_command_sync(hidpp, feature_index,
-- 
2.19.1

