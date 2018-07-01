Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9A1C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2325454
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZdKsM9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E2325454
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeGAAUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 20:20:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39924 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeGAAUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 20:20:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id s21-v6so5840675pfm.6;
        Sat, 30 Jun 2018 17:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJImHBF2EwXLlmdkVXoaXDFCNFb51x1QyyG4T9zW/E4=;
        b=DZdKsM9gH4e+GY7qP4HxJIjBmAaKD/unCTpZVUfMI00l4QR4jByVbRd789W0o3Zf3M
         tdYVNhcRzcjvui/qdgGtS0NyoAxFhHcyI/ZwETOcoWvP3k5xYY1Ad9Xslue1MeZKzlI4
         ib0b2zRFQgp2RIcWP77w81CAmuyB2XATtmR2dOfTrs2A8VujDZ6k6U1hLLGNiuxCTirH
         AW4glZmwPVdrF4rcAS6xXW6rtWMV2Rop7oCG5uJ2Cta8Jp5uxIKiSgmn5spuBMIj0Wkx
         f+hNO42y1atlFvkTh2J4x4Oq+LHjmq5yO0SkuSF036mZcLhH3ebN18xzNX6xfmkS3pwe
         0SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJImHBF2EwXLlmdkVXoaXDFCNFb51x1QyyG4T9zW/E4=;
        b=YR5bff6EF3eht/t7Tqf0bKltAOg7tgRolgNBvqGYFe1Fbyfnf2ruDd1wilt8dv0sXK
         SyhvmKeXgUZPpf/ZTkn5g9kbOn8W/Jhqnp+WFG3LPbPkoR1uwvxj2h8s6NCvA+ilkWiW
         6atr5PnA7YUk7cak4S6Vv/6pkmNPf6oOiTyOc2BZzYzJP6yWhnIwZMLg8v4Vd16pdq2X
         O8PkMVy55JqL6CkKBpwnv1QJezS+5khIvITXkb7CfRDc2K7dhS9ECz5DI2aHLF5WLf6Q
         j/91n6GJf/INmrz7DC7ehPJCeDVZ0Z+0UC4h2w3Hm3xkqoMIloHPgIAvTptzL+KiP8xi
         WeiQ==
X-Gm-Message-State: APt69E1uOdmlA2MAUMeyFYEGn2Rtne4fiOpo+7VqN1N/d2xy37nSAUMr
        XgEWtq83xhQYBFyfLw4wxc+bmg==
X-Google-Smtp-Source: AAOMgpfYFXQoC53btLL6OlvRYpeiWO4DJjPYrJLoy95gFXKTjZPRMnKI3P9VTVoUE5Oi7LVoCtGpzQ==
X-Received: by 2002:a62:904c:: with SMTP id a73-v6mr20026986pfe.145.1530404399460;
        Sat, 30 Jun 2018 17:19:59 -0700 (PDT)
Received: from hobbes.alyptik.lan ([2605:e000:1117:c002:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id b123-v6sm8424566pfb.156.2018.06.30.17.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 17:19:58 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH 2/4] HID: multitouch: don't check HID_GROUP_MULTITOUCH_WIN_8 for serial protocol
Date:   Sat, 30 Jun 2018 14:19:51 -1000
Message-Id: <0aaacf083be5b68a830f9e174f9abee3b00c5a51.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HID_GROUP_MULTITOUCH_WIN_8 group never needs to check for the serial
protocol, so avoid setting `td->serial_maybe = true;` in order to avoid
an unnecessary mt_post_parse_default_settings() call

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a793076139d7d0db9b..c0654db0b736543ca0 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1460,11 +1460,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!td->fields) {
 		dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
 		return -ENOMEM;
 	}
 
-	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
+	if (id->vendor == HID_ANY_ID
+			&& id->product == HID_ANY_ID
+			&& id->group != HID_GROUP_MULTITOUCH_WIN_8)
 		td->serial_maybe = true;
 
 	/* This allows the driver to correctly support devices
 	 * that emit events over several HID messages.
 	 */
-- 
2.18.0

