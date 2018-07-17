Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98518ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B58720693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsqPMQHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B58720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbeGQVjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:36 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44346 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:35 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so982582pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0H19hoFcOursJn5hcBPeEtt5v4Agw2KvCgtRzE/N4rk=;
        b=CsqPMQHxV4dcvDQv1g2epx/rETOd7N98vHH2jLPCBwXT/qlYcVVyMcqbHyI3Qw91XV
         uyrnB1vFW/3kZTCahxuJt5TFE3az8f56gAHNFXy9sIhUA0vh2xSG0s6rLsCoUGVZwFCO
         +SVwdMpvJhI6haAic1Op+r+3IZ0NsgpllEcDv/l7MVPsPe4Jk3WiiuIgbZidvqqnQDDe
         ZlVuxfMvQZWtCn5P9N4rtV2jJQAGvN6tjCtTZeB8Eyav9KcyqyG2D/YITPtlVja21pTQ
         yslkrGMD64BIcpSPiHb2G4yOOskAgWGXEnk0m6oFFvYWxzqksoOBAvLkHAZ7/Q2et60S
         RwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0H19hoFcOursJn5hcBPeEtt5v4Agw2KvCgtRzE/N4rk=;
        b=RxRh5cdodnWh8fCFettHhs9av3lB9ZSG4+YiIe8h6Hp3pFiGuQcSHFRNV4TMzgrb53
         XmVWBIjVbocAqClONxFHH0+XUCVTJL1HKpwVDz03XnalcvtNtymkku3QVwjaSMWeKL+R
         s6tKbJon1lGMw2s4mcdYU7Y8TqAFFn/F/FPGh4naqzVr5k3WIY95v/ZjfrowwDywq6I2
         177dKakbuHCN2vfjqcKX/yH9Vag7UJzglWPN+pEKJfbqrF6V/pj3YWGm6iSWj0DAbMtl
         +/31eSyGJPjHGTbCF/8k+qs0dPzwUQkQ0d7wzA/j3gPSTusha/Iq7NuoDdU6Qvrqhn6n
         nnRQ==
X-Gm-Message-State: AOUpUlE6y+C1X36/IA81sn1CSMvvVO3oST7+DXkbDIRWr76oaQQ0vnNO
        zPy1Ph/mc6mApRgIilNoDyw=
X-Google-Smtp-Source: AAOMgpeXVEe+82FOyQ56/BYCunWoDEpjY5BXN8QDMTij5xHnUbmOQuob3DmvoVV8Kk3uGQXgkGkgYw==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr3158101plb.24.1531861507314;
        Tue, 17 Jul 2018 14:05:07 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:06 -0700 (PDT)
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
Subject: [PATCH 18/32] staging: gasket: gasket_enable_dev remove unnecessary variable
Date:   Tue, 17 Jul 2018 13:56:58 -0700
Message-Id: <20180717205712.29495-19-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unnecessary variable, pass constant param instead.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index ff34af42bbe7c..3f313fc54ff77 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -899,7 +899,6 @@ static int gasket_enable_dev(
 {
 	int tbl_idx;
 	int ret;
-	bool has_dma_ops;
 	struct device *ddev;
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
@@ -918,8 +917,6 @@ static int gasket_enable_dev(
 		return ret;
 	}
 
-	has_dma_ops = true;
-
 	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
 		gasket_log_debug(
 			gasket_dev, "Initializing page table %d.", tbl_idx);
@@ -937,7 +934,7 @@ static int gasket_enable_dev(
 			&gasket_dev->bar_data[
 				driver_desc->page_table_bar_index],
 			&driver_desc->page_table_configs[tbl_idx],
-			ddev, gasket_dev->pci_dev, has_dma_ops);
+			ddev, gasket_dev->pci_dev, true);
 		if (ret) {
 			gasket_log_error(
 				gasket_dev,
-- 
2.18.0.203.gfac676dfb9-goog

