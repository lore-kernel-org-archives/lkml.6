Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E773FC6778D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01A925462
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E84xo5eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01A925462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeGAAUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 20:20:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41827 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeGAAUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 20:20:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so5537930pgl.8;
        Sat, 30 Jun 2018 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lP4IG4mDY9DgV+tOoDW146wl3lit/aOFC7RSHZ9QL6c=;
        b=E84xo5eQKz4KNGxu7uDS0UKfA3B1D62Zw1K/4tHTOorVNsDWjRY04O1nJH3uDAafsK
         7P6C/8dARm1FEPPiOLTvUU9gz7OUP3IEeeCf4nNnJvFjj1nR8Tuz+m77Lj+P20S3GmMI
         sIFwmRCixl00l2EgStY7IRXBQ3MW26Fg5+FjA8uYUCiGLTnotKaBGTTho10eC/TtneTt
         4oGEW/oyjHb5d02c3XAgnJYCRsBcgX5LcTLYms1yjvNgiCCRhFWWnj03YMYf1IpFg9Xb
         2pUVw9RUG9idZX2cs2rYBXtwcMx/4NJyVAkpdyA7Nc0pJH4/xBox9xIfZFG+CDclKk3T
         5qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lP4IG4mDY9DgV+tOoDW146wl3lit/aOFC7RSHZ9QL6c=;
        b=aAI/0Uc6rzG4mpn/wcdXoT2YnIE5uVIMLJlA+9GDphe6Yh4qTaoKC3ZnjtxjZkOy8C
         4lFH1wWsl2Y9Yc3qwVlMliOHTGKDCV1P11Cd/gDbpMeZoDAH7Fxmm6d+HKsaGCdqIGSq
         peJ3CP8NtXOvM+XXf3KVho5+AzNzr0LRee8VuagbEO8TTPqOpmlHmYkmJAOsWgh4Ip2m
         ydHyfY/zCRs0kEw8yimP8NNQbzQpjz1ISeBjiokZCFK1EnjZcvL4jwY7el0GogxOMyVc
         6KhNtMWEV5Ldw+J0AsbFkeb5ecKgEreJqX3EP5BcoBaBnVCtMBlN3WotF5+uvcBwRyWP
         05jw==
X-Gm-Message-State: APt69E3Lni98y2u0CftrIjjkDi7hnSlMi+yLGN7/KU3oRubolNVFqR7l
        /l8sNvRynpzPjMso927K+D0kIw==
X-Google-Smtp-Source: AAOMgpdE64+1zV7GJaXTBdEg3SRPrxLh8GJ+isMaAZUmLxh0Y2PhJsD7c0Q5SUzLmZ6eAx22p8Osvg==
X-Received: by 2002:a62:ae08:: with SMTP id q8-v6mr19171813pff.126.1530404400761;
        Sat, 30 Jun 2018 17:20:00 -0700 (PDT)
Received: from hobbes.alyptik.lan ([2605:e000:1117:c002:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id b123-v6sm8424566pfb.156.2018.06.30.17.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 17:20:00 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH 3/4] HID: multitouch: drop reports containing invalid values
Date:   Sat, 30 Jun 2018 14:19:52 -1000
Message-Id: <29ad484c1b357fd7fd670a6f252d097677b808f8.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid processing reports containing invalid values to reduce
multitouch input stutter.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c0654db0b736543ca0..08b50e5908cecdda66 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -694,10 +694,19 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 {
 	if ((td->mtclass.quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
 	    td->num_received >= td->num_expected)
 		return;
 
+	/* drop invalid values after counting them */
+	if (td->curdata.x == 0xffff &&
+			td->curdata.y == 0xffff &&
+			td->curdata.w == 0xffff &&
+			td->curdata.h == 0xffff) {
+		td->num_received++;
+		return;
+	}
+
 	if (td->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
 		int active;
 		int slotnum = mt_compute_slot(td, input);
 		struct mt_slot *s = &td->curdata;
 		struct input_mt *mt = input->mt;
-- 
2.18.0

