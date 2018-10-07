Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C261C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDC920895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXuPVSqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDC920895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJHEst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:48:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56156 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJHEss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so6291462wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCqh8rwkJK28NyovS4WPbWgloje21smQJmqJtUSUxN8=;
        b=SXuPVSqs2LrOY90f0qGeGRS9DkxLrxmhP04Utn4wK/is+DmsSD/s7qb1Y5+QdfDl0V
         SKkT6zHspgQyK7MXJVFMzKKiaPol1ksIVFf9BegfGTPYZdZPfMfhJdvRPXaphvpYQIJS
         sAjM+YZHYEEA2+Kv0U2hWaw214eDzqlLPJLeuT0yBDyxMG1BKhWYP3x3CPdr+v/tntlI
         v/0CEeRruUiBwtaOLQqHM4NnD4Civ2Lm/9z+QHFmAtcSj0cSI7cje8V0R2cEx7XJR0h8
         6z1xTCxV/iJ0GGaLRnXL5wqqcDl5bWMT+W0GYQJLm7LhEiXk/YboMibkVTQvigZ4kOsm
         L0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCqh8rwkJK28NyovS4WPbWgloje21smQJmqJtUSUxN8=;
        b=j4KNZdaUfUqDnMWBGxOOpiKtWtDYi5Oq+FabSAe0frOOSU2R2PI0vBQf9hQBa/2U2Y
         mmTrb83dlBaVKHRSSpYZ6TG+nawFzvd5GnVlpEczwpOxnjq/ks8bdKjYHUm8tqLKocZ1
         06JLxmQp0eqwWV5GfCJp9kwiRkuxel7DypVREdgtNp1YpTiFTP1wTRTtZzuKW1zPPT6W
         N6DVVK0OzzvfL7sdoZQBoNFKWhArLc3wd2xKoUTLx9lVyS4Usu6c4cW1NnWKgzAREeKn
         3bsuttN8fjDYYclsQOy7k/swld/Xrr9kWR+rppBCFMS3goTNbOrRJhnBNfTzWUmJTKsf
         IEHw==
X-Gm-Message-State: ABuFfoi/lrluCMzgLxhYhHqKG0qlZvjWqJwdxxrw4guKHNMliDpvRMmr
        NOpV2bb01uJA6vxI5zWREqaxtXx9
X-Google-Smtp-Source: ACcGV63XZ96yyMLV9mQi5Fj+scdlh5NpFidV80cyXfqCHhos/T54XIhAnCLwifkbnk3LirRdQGwbdg==
X-Received: by 2002:a1c:6655:: with SMTP id a82-v6mr10280357wmc.10.1538948411269;
        Sun, 07 Oct 2018 14:40:11 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:10 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/11] staging:rtl8192u: Clear error with line ending ( - Style
Date:   Sun,  7 Oct 2018 22:40:17 +0100
Message-Id: <20181007214025.25469-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite function call to clear the checkpatch issue with lines ending
with a '(' character.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index bd64d126ba2b..20348a1f2d32 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -64,9 +64,9 @@ static inline int ieee80211_networks_allocate(struct ieee80211_device *ieee)
 	if (ieee->networks)
 		return 0;
 
-	ieee->networks = kcalloc(
-		MAX_NETWORK_COUNT, sizeof(struct ieee80211_network),
-		GFP_KERNEL);
+	ieee->networks = kcalloc(MAX_NETWORK_COUNT,
+				 sizeof(struct ieee80211_network),
+				 GFP_KERNEL);
 	if (!ieee->networks) {
 		printk(KERN_WARNING "%s: Out of memory allocating beacons\n",
 		       ieee->dev->name);
-- 
2.19.0

