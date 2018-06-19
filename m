Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA0AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74A62075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlerBEPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74A62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030834AbeFST5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:57:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41846 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030796AbeFST5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:57:08 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so854843wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zrnXgoo8X4bPGsJTTyOJwYFDppz3v5EZ1RMK6oc1S3s=;
        b=DlerBEPW0U1F3/a8BG+l45CpzYHORQlS+kdEimXycyJxr81WH2qWfxXuyaoKnkMFtl
         YsJ7QemImlAt75EoE+ZsGahWlkfpZy0oAoguMZlLh36Dgkuwo5XSyWhvzUpMexQM0o3Y
         xxczMhZP+8l9PwmVOhV2Zpg2vGih9EsjZVu2ic8H0iU1ovUHUxapXNbFOM1uPNvFIC9z
         2G6rzhPWKYVDWgsJGPWgnoO1+AayEG4PG0w7MWRPa7rkfvzglbnvEvL0nNpyp2nCgsSY
         MMJNOrBRXjChQBE3vDdQUBHaCr/FQaETSC/8IUOf7qM2KXYmVcITnRI/+BOAdOR31OsL
         UEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zrnXgoo8X4bPGsJTTyOJwYFDppz3v5EZ1RMK6oc1S3s=;
        b=YTd15mu9pXNEO8cs877oYxOCQyaXlpBT6JlzkSpxpWZjoeu0PhtzztfwbWXVEGOJFo
         XV2Dd+vPPa3orvJPz7I3SF/bi8mS1QvLLEh3p9cE7445M3DB0UPDnnmyjNvhZrpC0xFJ
         0BISf1qcRlgEIfokhJdp8hKsgE/byzXbcnhJbkfXC00PcEzHq9gbpNevhtsS7qrYOQD/
         3VC61P+CLK3c1JrixehkIPzLuOyG5xQUThkbYH08O33yk3VBD1qr/0QnjVRKM8vsoumK
         ZGCV27tojhXqdIzJFB48zDgHi5qzfMI72gPjGkqNfoabp2tlBbP8qXnm5d0GukeuDDCB
         0w+A==
X-Gm-Message-State: APt69E316TPeaBg8F5TdOWvZnJPwFK6qJrfBXAFkTwezD44keB9C9NkI
        fe8n63Shi8iACkXRzE6t1xOr2A==
X-Google-Smtp-Source: ADUXVKKVXym1fvadZ89mGMr0jEy8cQcLQkNb8TJCl8EYynU/EDyAhfjORZOk7Gp+lKT9uXGG8wkdJA==
X-Received: by 2002:adf:9525:: with SMTP id 34-v6mr14368585wrs.99.1529438227680;
        Tue, 19 Jun 2018 12:57:07 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1105983wrg.12.2018.06.19.12.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:57:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 8/9] staging: rtl8192u: Correct if statement - Coding Style
Date:   Tue, 19 Jun 2018 20:56:04 +0100
Message-Id: <20180619195605.31321-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619195605.31321-1-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected the coding style of if statement.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 98688f9fdee6..05f0c8130458 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -738,8 +738,8 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	 * mode, enable this section of code.
 	 */
 #if 0
-	if(IS_UNDER_11N_AES_MODE(Adapter))
-		posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
+	if (IS_UNDER_11N_AES_MODE(Adapter))
+		posRT2RTAgg->Octet[5] |= RT_HT_CAP_USE_AMPDU;
 	else
 		posRT2RTAgg->Octet[5] &= 0xfb;
 #endif
-- 
2.17.1

