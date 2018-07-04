Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C22FC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D860224207
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXKV/ZDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D860224207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934558AbeGDJGj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:06:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36975 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934211AbeGDJGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:06:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id c11-v6so3724563lja.4;
        Wed, 04 Jul 2018 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jqwQES6wP84+SSY+ArQuC0n9vxe76r7gIUD4trKRe8=;
        b=SXKV/ZDx7YYTiuawROlD5Zq5IOpCgP4SLGTTvDAVEldROYZrduFm5wisWLnAOZ6+Jl
         hE2HVVHmWhEyUHs6tdm4ugdyNTcn7cyu64l5HEfjDoHHDIQA64UzomzohKDUisDkd3ZM
         0DKSzJsriWOs69XTwvuH/qCUys2Iqoq+oPsE64M0Q5arAlDVBpwlbI17kJ4ID/qaT/bN
         mDJqTV+cmkPq1WC6KpVMIiMUWFirsHhaNXE0FK8s+cUiCP88tYDbgqXlmEhmRFWgOykb
         5FfzZPNqSaOpMxoETgqGLfSzMs4RviOIV2U9ImKafKtB9yR9KdjJg6fX3+0vP6b2FYGx
         Pl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5jqwQES6wP84+SSY+ArQuC0n9vxe76r7gIUD4trKRe8=;
        b=G1fdai/tTAGnsvsULZ9VR3dzrqxPiwr49yIH1GLdTvgLEvjdeFiZXDDKiXpPvejsTU
         B6Te2QqkC1r7q4kEEdcaBSI6eSbJejl2X2bzF0vkO0NucoelNZrZcwWf6Zr8reXR9vaS
         5DFXERshGagQI6K4NN/PzNfXkW+dKxdG8PemEAMxPG/Nv3X6UdhbXffmHrvcYLTp3AHX
         HGtzOn5ePP4ZRwW1nf5dbCoxppxEiijtajRJDGegAYUHc16XF9iUJfQ5OJ6nbg0A6FkW
         JXxXsvcKkEuU3MqLukxmVs3xITm+Tv2sfjSWdm7RuJ1hZ4A7XZH4I5kobNuXS8HBufju
         h5TA==
X-Gm-Message-State: APt69E0Hx60E1VqGUXhP/T3DGmYtxX4YIuFvc5VUSLdZfxkuLnh3lfNk
        ac8DQ07Sd/wHjItmF5Tz4rU=
X-Google-Smtp-Source: AAOMgpdK66cmlyqmYS0yTcDsmGfEI9M409U7CcFm57LxJh65Rn/nvWkWwEHoqvwSspd23luyA3jAqA==
X-Received: by 2002:a2e:87da:: with SMTP id v26-v6mr893698ljj.69.1530695189673;
        Wed, 04 Jul 2018 02:06:29 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id 26-v6sm505088lje.26.2018.07.04.02.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 02:06:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fadjv-0004LV-LD; Wed, 04 Jul 2018 11:06:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] rtc: omap: add missing register lock in error path
Date:   Wed,  4 Jul 2018 11:05:57 +0200
Message-Id: <20180704090558.16647-4-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
References: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For completeness re-lock the registers also in the power-off error path.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 6a7b804c3074..7f9ee559dd99 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -449,6 +449,7 @@ static void omap_rtc_power_off(void)
 
 	if (tm2bcd(&tm) < 0) {
 		dev_err(&rtc->rtc->dev, "power off failed\n");
+		rtc->type->lock(rtc);
 		return;
 	}
 
-- 
2.18.0

