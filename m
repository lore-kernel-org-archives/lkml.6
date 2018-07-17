Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6295DECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1846E208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btkvaR/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1846E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeGQCkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42770 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbeGQCkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id f4-v6so11901580plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4aO7+or1wTtRWN97YD/mWuj9orNeruqDT98TJ0vWPak=;
        b=btkvaR/G/AXT4MlzzgfHo50Zt23fhwwGilnIzg7Y8XAivUp3mwIPTz39q71tA9o6MG
         RAVvtcUoD5rrjKu6Dz1+BJGpkAuEOWyZ4XwG8sfAmw8DXbIE+oWxEEQml13hIc6eYhLR
         wL1Zp+5OS4CBqNXleURdnEn4MD4X/Z9NpehqIo8L8YN50+P1/bs7S1gr+v2AWym23x/3
         S7JevuZJfYY8l5oUU4zMzIG/gjYAaME0c0KR5XNUnlp2G10Cwegw86qWy3Qnr3M5FAYX
         gWudkTCrb2CqMdV+HFVzK3f2vW0uTCM7QJ13aCUew1dO6orX1wWihhk5aZyXAs1qyNfC
         Z2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4aO7+or1wTtRWN97YD/mWuj9orNeruqDT98TJ0vWPak=;
        b=pwuwcEwXci0B+VkGVwHiZN/b7ajIPbi7atrX82kuCjAoN0RFWoIszgGsY+aC4JtxXr
         TFMqLjV1NDHmeklgZhTtP1dnz+9ASeV14K3012HRRC9P4tl0TsLaFMREoMUdkXeFq95s
         W1tn8qADinII9oz7NdDLe3Dvxh6depcUm8L+kS++khf0g9QlA2PJfwM3DF+FWYfDe/Nv
         b2PHLyKD6zRPElpbas58qJWzCMtbaMNaZuNOx2+cIhdV+EBuq3YrTmXEzUTlsVuf+XZu
         T1Jh0USDXGGNwFhNzuKpXSGs0Ki3+kW9K5lSRnvrKGl70mSKgKaFmCVo0bBVXUa6OX2l
         OD2w==
X-Gm-Message-State: AOUpUlG8zdBKvCmYQadfMOUYANnCaTL8ZUcXWcrFRseoU9Tykvt+9Br2
        TvNQr3O5ABL0Cma34ITTzNw=
X-Google-Smtp-Source: AAOMgpdeJD9EKW6lvkRdnzw30pFu6A0ETymZawdyMAv5JVDyava0vBBZpZqasZGULNfLcUUDR6UkIA==
X-Received: by 2002:a17:902:9687:: with SMTP id n7-v6mr18353763plp.33.1531793411107;
        Mon, 16 Jul 2018 19:10:11 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:10 -0700 (PDT)
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
Date:   Mon, 16 Jul 2018 19:09:12 -0700
Message-Id: <20180717020926.176408-19-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
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
index 9f974f179e378..8ceafcb213413 100644
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

