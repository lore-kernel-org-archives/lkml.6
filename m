Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB45ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3EA208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuIHne+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3EA208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeGQCkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34239 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbeGQCkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:22 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so2177814plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CGOAKFhwnRNleUszPPYg44Jd4wymWQveg6BQS3i+j/U=;
        b=GuIHne+QAD+Q9JC3MHXBUSYcJLz41GCyolZMEGYpSY+Vgd7QzUmvvKjufFjYT4vChM
         geSzPiQ59E2Nj/g0RomF/8Z/U8AN93YavRdxXP+RdyObrXGWr2viZzYQQiEETx2ya2h8
         CqK/c1jylFOYV7nyy35NYzNq8VSi6Ctm+1hgz3j5A29KgIVqIng/9byUQszpcmlzWmPh
         QO0f9GJGBSxe8lBw8Jze2dSygnhHEyNxUnJkezoMKtPqU1WOs3YgumC2gMnxceLR4XAY
         gsC3j58JZJeWkyrQw9GnVWXKUYeK62H8BtTuMfWerWrVXHZU+y2fgqEKkbV841i+1YPb
         CwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CGOAKFhwnRNleUszPPYg44Jd4wymWQveg6BQS3i+j/U=;
        b=b8R/Bubpnuq/03n8ncu1mlFWmjxeO7zvKYiNNFHzy7WZU0G/pN4vPnURUHhT//wC1i
         wwRUfr+HR08GqPlSXkbDDW2y2Qe6TBPyrDYItfCJJNP/4H21iMI0lZ91DK0MZMuQPC8T
         C3LU4ULKUpxBT05N5fy2SwsDKvgXoYcRpPMRboLxHhFun63H7QUmtsLYukjmndF1k1kt
         PZXgILCZg5YMavQk1tZiUgp46I35BXyh7CIDMp/4VeAS11YYFAvq2LGwHolIkyarp8W1
         9A0Ywa8dQ3P4dxyOryAOJH0+nklSYydkkVCVBIo5f+h2Y890jCrPlWxkvRPNuRvcB90A
         RT1g==
X-Gm-Message-State: AOUpUlEte1qywf2fFtIwxfoN97RV5Awdm8WxZCSlF5GTmsogmqj/Pmdj
        KRHFyhjLdQyTCz+5ayxPNak=
X-Google-Smtp-Source: AAOMgpeN0jfyxT3F6iWI+WrENESlzbnRcfp4mgEfzaIfhGZdsw+bce97q8Knn/0kDHcaP6wO64vgoQ==
X-Received: by 2002:a17:902:8486:: with SMTP id c6-v6mr18567685plo.283.1531793412616;
        Mon, 16 Jul 2018 19:10:12 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:12 -0700 (PDT)
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
Date:   Mon, 16 Jul 2018 19:09:13 -0700
Message-Id: <20180717020926.176408-20-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
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
index 8ceafcb213413..07c6fa3623f77 100644
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

