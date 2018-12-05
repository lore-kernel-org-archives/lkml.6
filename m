Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D7C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A6F2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="GZ7sdT0j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HxOnTWEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A6F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeLEAnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:43:10 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45061 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbeLEAnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:43:08 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BDD52F55;
        Tue,  4 Dec 2018 19:43:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Dec 2018 19:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=9mpnncxGYKGhn
        b4VIU3POQ0P/Q4AaNNvBQuHvU6YplA=; b=GZ7sdT0jEcg0fm7V3xGxWbpRpFoj7
        vJtXYOoECWACbJCSQVleIDHUCev7eSMfKee+ad1yK6pib+tBGJQ5ZxPVC+LU5Olj
        x6mwxZ7fNnvXpybnjUbJXuQtBn4vm/cTcryQpAETGaU8NdVOUBc/04mQHhqhOLhM
        TKFJBCGIdTqsHb8wLkxYUHF5JxjQgzu5tcgspZWc4vmmuysbBsbaNHDYN8jobe9G
        OnTJNXC1xCZNY3uBzwsxv7wGAF05qFO1Bbdj6E17whZD9nv8eMAlqdTjAZndQ3tn
        R3VWAXB83SMZPbLlLqYBWFNnJtD66QKm5lGhSY5Klzu4BMZaX8Asrj3KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=9mpnncxGYKGhnb4VIU3POQ0P/Q4AaNNvBQuHvU6YplA=; b=HxOnTWEU
        Ddu/baJvN1v+8HhG+WvK1XDCNrPafanr10opxYSq8WuWhyR3Gs2UPho5cot2pY3F
        +jTBJqRrJEKyjcs846isr8ORORvLjlOVFz/Ysfz4kuPTJ6yzYRbyrxQf3A4PDM6f
        g0exBw6oh1cyNivsaqxZt6f7qN30SHE4p59rwICCQzJcXb8lIK4cMY2jLwlG3Nqg
        eP2lMckJqf5aDgcIpS5UC05C9BIkNcgyrGsD/Yv//dCvla3mp6w2mgmwXjrG0gFY
        +YWhT8F9hU0lRxDz8Kb4ZYB6KVVVrKzJHjy1TXHhNpPE0e/jAFLM57+kptN+3OYx
        7V2K4Dfm3K/Tlw==
X-ME-Sender: <xms:Gh8HXJIgGhX-V1zsp0JteJsLl_wSABssKuzK16dUHoloLGTejK1hsw>
X-ME-Proxy: <xmx:Gh8HXOcmaAxu0jbluC1qwkzrAO__IdjF21b8j37F4TvnXKsEGV3vvQ>
    <xmx:Gh8HXPTm0YvltjEz3b9NgTrN2nElmGZFKvej_dKyH6EM87UVhRZA4Q>
    <xmx:Gh8HXHjWA-7D4ezpWdW9WK81Bx7kUh3DmdSjGBbx9CLcLaXQl9AJiw>
    <xmx:Gh8HXNotUhFnduDYI9EzkAoB1JeXgmzgX6QUYTLikBDnD_30K9Cu2w>
    <xmx:Gh8HXDuPqOlCVJEz0vaBC3_XrEnPch4wxAHDmtlutAJqPWcnl30uig>
    <xmx:Gh8HXOvwT3Si6slkjq2G6-e55Q2BF3nZ9lkq4sfp1q2ASGb8u34Dcw>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0FA38E450E;
        Tue,  4 Dec 2018 19:43:01 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 5/8] HID: logitech-hidpp: fix typo, hiddpp to hidpp
Date:   Wed,  5 Dec 2018 10:42:25 +1000
Message-Id: <20181205004228.10714-6-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Unchanged since v1

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
2.19.2

