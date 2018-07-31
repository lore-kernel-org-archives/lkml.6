Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68CAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD7020894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjoK9JmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD7020894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbeGaWH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37624 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732802AbeGaWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so6643924pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6v/euHUGqdv7IO2hdvTbYImT+YpoO6ycYWKallKwLY=;
        b=rjoK9JmZ+vhUfkpnhG08mnVQXBbb+jQXwV0GOdXz61UDOyv5e13i6ELahCTisPy+4I
         bDaaI4i5WH3SbIektLfNZrUVU+FGqifpbDKKqt0T3oC/M6v1ykCicjW6Yqd7zJl4jfpz
         oAVzXw+zfQ/2ETlZFqYLXGaUdJjOigjFWrEVkPMWVxbl7pmdVhlZE0+1Q1c9JFI6gUJR
         EtcRojUmJGE5n21g6E5QjOdVXLAd2aC46mM7PdJRnXQX837SfmWy17McoTY0iEVfVzWa
         COr0MYQFgDnofY0dvltYEF6adfMB3XaIdnQeaECQEVJhDt+BeHniCBUTOpsT9jgi/dZo
         LkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6v/euHUGqdv7IO2hdvTbYImT+YpoO6ycYWKallKwLY=;
        b=EkTK7zRRSSKhjWFV6ypZleEi1phtFlrzP68TiHgiVK/kkTLdHFl0evsZ2xdpUJIHbR
         WppkDMOHyL3JVz7v6KZotLSNdH4IURM27j4dF2ZVBQn8T/iED3X9GIj8dV2hp8CeS552
         +6cLISTRfXFI8TbbLQwcyK4ZK0SqBsGVvFoT0AcqBxAgDW6wVzNYwlnw984TXtovo+7S
         iHPug9ZUCNMDSiwHLwYVLGRltQAQtl6kbgnQcOi6p8dkjGelaxRfSmT4aiiYh4FD9lbJ
         IBwNe6Z7khUjSvPw1BlQ7awc04cnNjRJKaY0R9Fd/cpDzvfLxra2tAmvkNdOLH8a9sDm
         gF5A==
X-Gm-Message-State: AOUpUlHJ64KvonFGvyHG4pmFlDOzQqABE0KRNt2g+Kx7OtxbqotuASE4
        tiJO/4i7uuDz15iR2X/6aspnWbNqakI=
X-Google-Smtp-Source: AAOMgpeoPLVmwl/WAp9NUaUI2lP3Y1PFpDUIhSSL7jXgjE/lESwNlXlWG9nyhEof9wob4jcLQEskWQ==
X-Received: by 2002:a63:195e:: with SMTP id 30-v6mr21562956pgz.192.1533068725876;
        Tue, 31 Jul 2018 13:25:25 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:25 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 14/15] Revert "staging: gasket: page table: hold references to device and pci_dev"
Date:   Tue, 31 Jul 2018 13:24:47 -0700
Message-Id: <20180731202448.229487-15-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731202448.229487-1-toddpoynor@gmail.com>
References: <20180731202448.229487-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_free_dev() is called only from driver PCI probe and remove
function. It is guaranteed that that pci_dev structure is not going
anywhere during that time; there is no need to take this additional
reference.

This reverts commit dd9d1502feea3c23d412f289aad79e1d4e86d45d.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 13e1d0952a47..ed6ab3c5f038 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -280,7 +280,7 @@ int gasket_page_table_init(struct gasket_page_table **ppg_tbl,
 	pg_tbl->extended_offset_reg =
 		(u64 __iomem *)&bar_data->virt_base[page_table_config->extended_reg];
 	pg_tbl->device = get_device(device);
-	pg_tbl->pci_dev = pci_dev_get(pci_dev);
+	pg_tbl->pci_dev = pci_dev;
 
 	dev_dbg(device, "Page table initialized successfully\n");
 
@@ -378,7 +378,6 @@ void gasket_page_table_cleanup(struct gasket_page_table *pg_tbl)
 	pg_tbl->entries = NULL;
 
 	put_device(pg_tbl->device);
-	pci_dev_put(pg_tbl->pci_dev);
 	kfree(pg_tbl);
 }
 
-- 
2.18.0.345.g5c9ce644c3-goog

