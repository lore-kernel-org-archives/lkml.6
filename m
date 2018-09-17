Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79949ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6CE214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDxk0VVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6CE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIRAC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:02:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41451 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRACz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:02:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so7824823plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GPxEOjtjRb5FzIdtwFMOhqaLT0uUhzQCKrA3nsjl2UM=;
        b=LDxk0VVu4RiRG7HKW0CeBYwPe4dcYUz7oEyIvNYHOUOK/aJtzhYDWUWsRiDKVwAB8b
         fwnjoqOfMEEatUdPVmvK9tljLc8ScbAtcATHbG7p/4TZGXN8eZ6Apn1tdykLbTRocwRP
         VzzkQdwJU/z2CynrQLIPzv1Nd0z1WfJTJ48x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GPxEOjtjRb5FzIdtwFMOhqaLT0uUhzQCKrA3nsjl2UM=;
        b=b7Am3aRgnIVImCUw+o6DG+BkVKqEuhoHf2C2dDQOwSwjn6gEYRxriIC7rhIA6iqOpL
         giyCzaHu29+gI2s8YpTrE13F5D3y1eoYV8JOi5BV6KkzaBXXXK7yiFYaU8sQgbHbmV7c
         67YqjpWCjFSSK4fOnEBdwZnhOuzou8JvGWgLokoESUW4IKGRd7MZxmfvt234JTgrLpj/
         VLDrRcWjD3YMFpcoC43+uB9xWEi5WC7gJiPL0WubvwDQgDWWTCKyyPR16Z6D3X+Dy71n
         DzpxCGpS5ItpgyAIr69C/ioxj+Li2RGiEuw+hDWP+phdc29twtE+Td3Aqecj40J3r4PE
         9aFQ==
X-Gm-Message-State: APzg51AkGrdI10NdSm1a3JQOd3EKAh32nKWc9Ffs0vUdX+KrUd8A/bD7
        gZasd63S2vlw+Uv6awq75tCFpA==
X-Google-Smtp-Source: ANB0VdYHAd9g7p7iO9ivnt4iK6pO0vaPlhfSIHZ2YNVdys+nyZKo/ArAw10SJtpV2H6rBYYtofG/Qg==
X-Received: by 2002:a17:902:b283:: with SMTP id u3-v6mr25493239plr.2.1537209262573;
        Mon, 17 Sep 2018 11:34:22 -0700 (PDT)
Received: from ubuntu.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id i7-v6sm17544137pgs.17.2018.09.17.11.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Sep 2018 11:34:22 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        broonie@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] serial: sprd: Remove unused structure
Date:   Mon, 17 Sep 2018 11:33:40 -0700
Message-Id: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused reg_backup structure.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
Changes from v1:
 - Add acked tag from Chunyan.
---
 drivers/tty/serial/sprd_serial.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 828f114..1b0e3fb 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -95,19 +95,8 @@
 #define SPRD_IMSR_BREAK_DETECT		BIT(7)
 #define SPRD_IMSR_TIMEOUT		BIT(13)
 
-struct reg_backup {
-	u32 ien;
-	u32 ctrl0;
-	u32 ctrl1;
-	u32 ctrl2;
-	u32 clkd0;
-	u32 clkd1;
-	u32 dspwait;
-};
-
 struct sprd_uart_port {
 	struct uart_port port;
-	struct reg_backup reg_bak;
 	char name[16];
 };
 
-- 
1.9.1

