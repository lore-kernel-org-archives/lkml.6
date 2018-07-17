Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7396ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F69A2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQUU6yTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F69A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbeGQVji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36359 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:37 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so989092plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Y3X8FuzWC0GBsAO7UK9zN60BpvzgFrScgU21ZmN/4Y=;
        b=NQUU6yTKZfDkwfXAJ17a2dC0zrmPQN10pu6KzZ3JBoHjH0qexycn6IU06/WxyU2hmA
         zXooQH0PRLDZ9fYh8elJb/9r5j3AiTD2nc0Z6NotYMyjj+mKfwXHwLmcEsmHym+DHOle
         9g+pnvomhVrfNzHQjv/r4QWUz3G3LUQLz+h8XNxtdOqRjBlawRKPH8uO2cgOiHAx7x1Q
         HKJ9+GV6kiEEJ49lnfa7Z2fJE6DG9SpTmAVNi+ZDCfN6DUBzaWMCUoSR81ukxoqIqfpn
         QdQSzJCImUAsiKpUZZn+Pw7iKxAsWEccoVhSJ0JSaw1Fz6qgHgBHYUQCIfacsvtdJPf8
         iljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Y3X8FuzWC0GBsAO7UK9zN60BpvzgFrScgU21ZmN/4Y=;
        b=C/rDem2cC2htIAUieR/lrpO0UIPWKyRlhLhE8rS+D/gLNDeFBqWK4Ri5MY01qwY/XD
         XUZQ423YzCTpz1FbUMFr+FSGz0m/N4nqXvTduVKwcF30bcv928UwjsBGPE6AOgFTDsmn
         7I3uFg2NVneeZzcAd2mGc8V0Em8FBOVk22KKPqj1qyxUUnYDob2rIOnJZ908oxySijpn
         +2dTih38vUmbg3GE5uHieKjK/xNICgW3a107e5abAeUsmgRktvSllTzUTcPKL4ETikGZ
         CDM1QQDTosMFfNWzBmSjD7fXaA3tbbJcikioTySrN2es092lV5+iIzq+25GHHizf/UdV
         SjUg==
X-Gm-Message-State: AOUpUlGgmQ/p8csI+uzLW77+dPo8Jmvuv9oyVJxpU0jr+l8Pd08tXS62
        y2CATiyBYWTgORMqTFBuaHs=
X-Google-Smtp-Source: AAOMgpfNQA8P591Vo4Kt33N5OSILdOLbF2/Th+q1hAJi5qUaB6EwKQQY2WgyK5+AWTG7Tiva54Ym8g==
X-Received: by 2002:a17:902:b112:: with SMTP id q18-v6mr3074467plr.284.1531861509609;
        Tue, 17 Jul 2018 14:05:09 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:07 -0700 (PDT)
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
Subject: [PATCH 19/32] staging: gasket: remove code for no physical device
Date:   Tue, 17 Jul 2018 13:56:59 -0700
Message-Id: <20180717205712.29495-20-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_enable_dev code for enabling a gasket device with no physical PCI
device registered shouldn't be necessary.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 3f313fc54ff77..0a87bc67eac19 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -899,7 +899,6 @@ static int gasket_enable_dev(
 {
 	int tbl_idx;
 	int ret;
-	struct device *ddev;
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
 
@@ -920,21 +919,12 @@ static int gasket_enable_dev(
 	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
 		gasket_log_debug(
 			gasket_dev, "Initializing page table %d.", tbl_idx);
-		if (gasket_dev->pci_dev) {
-			ddev = &gasket_dev->pci_dev->dev;
-		} else {
-			gasket_log_error(
-				gasket_dev,
-				"%s with no physical device!!", __func__);
-			WARN_ON(1);
-			ddev = NULL;
-		}
 		ret = gasket_page_table_init(
 			&gasket_dev->page_table[tbl_idx],
 			&gasket_dev->bar_data[
 				driver_desc->page_table_bar_index],
 			&driver_desc->page_table_configs[tbl_idx],
-			ddev, gasket_dev->pci_dev, true);
+			&gasket_dev->pci_dev->dev, gasket_dev->pci_dev, true);
 		if (ret) {
 			gasket_log_error(
 				gasket_dev,
-- 
2.18.0.203.gfac676dfb9-goog

