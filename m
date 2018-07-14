Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46387ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DCA208D5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y72HHW9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DCA208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeGNGQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36374 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeGNGQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id u16-v6so23741586pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VbKn81NXDrfR5E3AhXGhgl+Y6J0RC6cque23aUgIFFU=;
        b=Y72HHW9A5kDIivRcuefLu6AG+onAJ0C7+0MMseyLfGDYMnziUiuQwiWnPL3ve7sy1J
         EGY/liswyAvSgKkZV3uxqJBNQl00aYznO/dXgjrCiqivmWwr1y92R+4sOsnR0kUjEO0B
         nXhnc6mA0CAX62XyO/QGcvfQl1KIXh1zpGZMeK7+58bf51SguvI6WY2rJLT13MPYI3vl
         mBRnFRHULoOnowqTeOi95uTRnZxtm+wyoNeFi0W96C/kg9eYfJqQQ0adz/m/DhDiYEfc
         Wjy6TOyLJgaTxp1aAh28WfpnaOPMPkDLZoTwUltqwCRMp62E0eagvhyz95eF9mLnYH7V
         yrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VbKn81NXDrfR5E3AhXGhgl+Y6J0RC6cque23aUgIFFU=;
        b=aIxPYVA/NN7lY6aiAgJzXFb+Ke2JfXU/6DbipEZ/rp55ONqYrbDQhK1T9sI59EVLxB
         F5uFOtIGUz+6E/Jp8ow/CSw6C4ZM/l/0bEUMBpAal3n8c/mAt8gUs8BySDDyR52Ayxgo
         wl1byTfhUVyj6T4O3jaqBaHHeefb/KPZVP1HdSg5sNc31QIxxz5nyrR+gpAoLVin5ri7
         n5/h9FV5QSaY6y9/HEj/PO+tSRGxZwUGwJwX71NIJgTzVTlkS3hRZOibdsfTo3cRQqCe
         6bl9ID62DH8n5YHS1A3CSDOYzYz1XPnt9ovgBlxR3WedoXeSKzkvrYfY1ciH3qXNoVpn
         Q7gw==
X-Gm-Message-State: AOUpUlGq3/lEEJlL6XDw9ltSBR8v9YVKBAU2h85kpg5joNYH4069e/4W
        jrMrgaQczk1uhTkJBYyYTY8=
X-Google-Smtp-Source: AAOMgpfrIoIa2zVWMN4bssWcjKG/pvmUB/9lxMUmbv4rjHjL8mDH5GLwQgLyLZtuK41MXNcHPl/4iQ==
X-Received: by 2002:a62:225d:: with SMTP id i90-v6mr9796512pfi.246.1531547937159;
        Fri, 13 Jul 2018 22:58:57 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:56 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 13/18] staging: gasket: gasket_enable_dev fixups
Date:   Fri, 13 Jul 2018 22:58:11 -0700
Message-Id: <20180714055816.223754-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unnecessary variable.

Bail out if no physical device.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 65aa7cf454fb..f7d8f66e8746 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -915,8 +915,6 @@ static int gasket_enable_dev(
 {
 	int tbl_idx;
 	int ret;
-	bool has_dma_ops;
-	struct device *ddev;
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
 
@@ -934,26 +932,21 @@ static int gasket_enable_dev(
 		return ret;
 	}
 
-	has_dma_ops = true;
+	if (!gasket_dev->pci_dev) {
+		gasket_log_error(gasket_dev,
+				 "%s: no physical device", __func__);
+		return -ENODEV;
+	}
 
 	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
 		gasket_log_debug(
 			gasket_dev, "Initializing page table %d.", tbl_idx);
-		if (gasket_dev->pci_dev) {
-			ddev = &gasket_dev->pci_dev->dev;
-		} else {
-			gasket_log_error(
-				gasket_dev,
-				"gasket_enable_dev with no physical device!!");
-			WARN_ON(1);
-			ddev = NULL;
-		}
 		ret = gasket_page_table_init(
 			&gasket_dev->page_table[tbl_idx],
 			&gasket_dev->bar_data[
 				driver_desc->page_table_bar_index],
 			&driver_desc->page_table_configs[tbl_idx],
-			ddev, gasket_dev->pci_dev, has_dma_ops);
+			&gasket_dev->pci_dev->dev, gasket_dev->pci_dev, true);
 		if (ret) {
 			gasket_log_error(
 				gasket_dev,
-- 
2.18.0.203.gfac676dfb9-goog

