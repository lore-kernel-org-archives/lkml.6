Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D044C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FE52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqoHnrlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FE52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeLGK6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:58:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39313 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeLGK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:58:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so3173516ljh.6;
        Fri, 07 Dec 2018 02:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YslIsTGo9qgmfVXiD3oj00yw3ONTqt+QCNQIbkFOgCc=;
        b=jqoHnrlFDLed7nsJxaEpkoMtsWhS6Co2usNe6DIeZpXBhQcX1DJCl8nw6c4QKbzzZr
         XMGyS/0W4hjeIaZSF7FNBeEi6TL0N+Pex1nD/MsATJVZJCzb3hZBP1WxPaPB42QGBlsr
         yx2kdJWqR/ylz85Oh/eOO0ctcR6cAulf4OYnK0huwEU3QC5CptuF0s3Np8KOYJEOa9mb
         K2VtPgs5udNzWGWVqYENMFYOV+r1nFVeDdLC8Jr9iA7gUpW32oIbKU4UYC/didIO4tL/
         jCG2znXIX+6YoowL6UzkK35tnrYOqUv8iJa3JySl9o6+i0jL2Y3Sco5WJ13mFIkqBZ1A
         Px2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YslIsTGo9qgmfVXiD3oj00yw3ONTqt+QCNQIbkFOgCc=;
        b=VYmtRIqYsTFP92AJ7vcynXDhWRr/Qwa1YQJ9ISrOfI0WLLh1EMNj8puE1gtu9XX5Yp
         Q8idA2RYCqXsVJChPqDxIm0Cwld/TGbP/fwZNLJwjllduh9jkvq6mM0+OwBb/kGzzaQk
         uC9vWpCvUZD1NqacKl1VNbVdNiz8RFj6rElnnVlQUfLhNKmvUvOx4HNA/Q7GnqSPnp7/
         6w64K6RqSraM+1Puf5143bxgKYSoYe7Yw/9cQRE2q8V4BAw8DYUFWSYm9nF1PDB2DVVU
         wvz2Bn7t6FKQnqdAU6aTh9leqx+4VMD7KWUG6YGtDH7mAmgJCFieinz0mJdgEo0GoqiI
         SVxw==
X-Gm-Message-State: AA+aEWZl8shTNcWoxNYXmGRXoloXG1UplK5sazZXDkx4v/PUnvGND85/
        mLeOflkOkuMcIDc3O75Cys8=
X-Google-Smtp-Source: AFSGD/Xd0iShYWKJy1TA0nieMvwq5hktlGEVmhdjwT74S5Xd8xzMgeFh25r6SX8yU5GBpFEKOD68zA==
X-Received: by 2002:a2e:9655:: with SMTP id z21-v6mr1171955ljh.136.1544180303904;
        Fri, 07 Dec 2018 02:58:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm523362ljf.28.2018.12.07.02.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:58:23 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH 3/8] Input: tm2-touchkey: Use predefined device name
Date:   Fri,  7 Dec 2018 11:58:06 +0100
Message-Id: <20181207105811.1831-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Purely a cosmetic fix, using the names defined earlier

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 37a5ced24009..cc713b901bf2 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -57,13 +57,13 @@ struct tm2_touchkey_data {
 };
 
 static struct touchkey_variant tm2_touchkey_variant = {
-	.name = "tm2-touchkey",
+	.name = TM2_TOUCHKEY_DEV_NAME,
 	.keycode_reg = 0x03,
 	.base_reg = 0x00,
 };
 
 static struct touchkey_variant midas_touchkey_variant = {
-	.name = "midas-touchkey",
+	.name = MIDAS_TOUCHKEY_DEV_NAME,
 	.keycode_reg = 0x00,
 	.base_reg = 0x00,
 };
-- 
2.17.1

