Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECE0C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2925A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzBNCgBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2925A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeHaCkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46426 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so8529881ljj.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ELrCwb70Eswi1rgH9pKht4m90s8Ue7VvEGevoqh5MT4=;
        b=tzBNCgBX1luThMBNhKWbCw0/jpKnuxb3OnZmWULtBDFdsuo1YvkDTrgLaEr5iZvGyk
         ftO/nx9CwOS72fkR6HY9YSV673tKNgaZ2WG1qfWpd7zAR2UZiHZASVPZefLPOnBNHdUG
         bdeN8J1DKUAsSGiuTAYLhzwIeG/fp+RqA0b/JaPSMr/4e9WanMm7/6o1WQ4LSaH0nJRO
         YD+cvPa3v3BSaVF42xcZNgZnHYfkMpf/H6+5JlI1Y0UtbwoopQsbNs/7kVLCGJpYGHTj
         HBkM+v5CFbNqVKSqAr/rxBEVTcbJHrty27p2hlmj1eAPXPmWSLOe89ioOr94L9wy9kbm
         8+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ELrCwb70Eswi1rgH9pKht4m90s8Ue7VvEGevoqh5MT4=;
        b=AOSt6VwNSTPaclPZeLcpHGZVCxrdRaEjDTzOqY89XVs00TK+dpD9YhJWP3IOwTgHDk
         AoOsC1ymsYXIcu88fHI3g5Ma2ZTwHfC7bLHe+/Cen80D3tkuQCtBRAxEH3B0ap1IbqNf
         vm6Xrp4haiMpAy5o3NUePbnpYjVewvuvzFJ7x9q2sMbhiX/IkkhnfxwloTI2HfZ2s0BL
         k32BuMgmyW+Zm5C6+dkVzB3i8BXtNepUjE3XFFwr7cMuyN2cybbVJ/fh69Ilo4/lYK3k
         XT6pkZG+jjEuOQY/HuidFtawEc06b44er+kNJcNNVBHu0A9BUI5rEoRkn36iPCGgwfTS
         Z9wA==
X-Gm-Message-State: APzg51Cqv14entSspAF/VzN3OBIuBjyOr+x59Yv/nK1lW5I0Fs+iN9mA
        3glCWvqfO+FttcD/+diX0/bfRAEMYAI=
X-Google-Smtp-Source: ANB0VdaOlk+zqM8YOCMAUiDPZx0Zev2AJ41PphntEUtEB9s+Sl/liqbnjHrxnAjEqIf1BoCTc+vMkA==
X-Received: by 2002:a2e:82c9:: with SMTP id n9-v6mr8356446ljh.111.1535668542704;
        Thu, 30 Aug 2018 15:35:42 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:42 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH 14/23] wimax: i2400m: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:20 +0300
Message-Id: <20180830223429.30051-15-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
---
 drivers/net/wimax/i2400m/tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wimax/i2400m/tx.c b/drivers/net/wimax/i2400m/tx.c
index f20886ade1cc..59c70d928249 100644
--- a/drivers/net/wimax/i2400m/tx.c
+++ b/drivers/net/wimax/i2400m/tx.c
@@ -655,8 +655,7 @@ void i2400m_tx_close(struct i2400m *i2400m)
 	padding = aligned_size - tx_msg_moved->size;
 	if (padding > 0) {
 		pad_buf = i2400m_tx_fifo_push(i2400m, padding, 0, 0);
-		if (unlikely(WARN_ON(pad_buf == NULL
-				     || pad_buf == TAIL_FULL))) {
+		if (WARN_ON(!pad_buf || pad_buf == TAIL_FULL)) {
 			/* This should not happen -- append should verify
 			 * there is always space left at least to append
 			 * tx_block_size */
-- 
2.17.1

