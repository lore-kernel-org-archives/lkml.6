Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1070C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E0C20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM5jLiBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E0C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeG2VIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36695 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2VId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so6028805pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1tGC8EAz2lyYqzO/4tdDz1/cNTtgugxp6N1PgqmJfc=;
        b=UM5jLiBkNag7IiJatldjGLW6RSHkH+GBt7Q6d9YLeJ3+Km3ZbGmIrjnrC9Rm/zauI6
         j5GabcTkbzhdsLcwo5clxSsvqkMRyrYXYeqWyekk2KYNGjbEQGKF/tCeGH1v5hQPuIf1
         svMF7yWT3rQHmCGLmKgp2/J5dvMW5x1DU6XZEoTry3pkiDSfyhPEeYujc/4M2pTv/UI/
         02fW5l3w7e1uENEVI9Ef7S/7SAz04PiYmS/vNOXhHXSa4xFXZ4RDtj0JTvwAmTbWb25K
         0EcXv8VB6/CNZaVWA+3FXMOU/icrAZkZX6Djb9wrwHITMZzh9oVl46XNQ4ljjf2iotBo
         IZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1tGC8EAz2lyYqzO/4tdDz1/cNTtgugxp6N1PgqmJfc=;
        b=fQGqzDqyFSxYVSqyPWgczGUQJJBI9vvAzvFETUlnjTijN0jdPXSWSMn2Yobbtjfmi3
         9zNFFAtl40YhOGqaq+6ZXEGy/sL+sYSTdeqnooNPVDkKa9hILs5YE8fRSx3H8RMQxnC8
         I9pAgmr0yIfCRCEJLr3/7Opaw7qAkgz5i7tBDWEMzskq3zZl1Et6vuYM6gbSsC6qiF/1
         JBSbHOD8wvXthxC4JlNl2v7bSSYHkjMvt6C8/2b1wLQsFipQkRuv73/D25OGEl7xa9j0
         wUbICa67lkkxqDskpAlMMORgF1fjk6y+a1n9esVXstHFnKoMDSRuiAALWyte0xjZlbOh
         NmcA==
X-Gm-Message-State: AOUpUlFR6+Jniu30VMzOabVz7qF3rrc2u7W814qoUX53Hg0EEA0kNK6j
        K8DgayfFId8MMTqWV3zVSOg=
X-Google-Smtp-Source: AAOMgpcRVAQ61iVD8BcuhGgXya6G3tK+mR9CHAid/Vb/QFr89pVynJ8shDaOeKUpY2N+yuDNOhtC4Q==
X-Received: by 2002:a63:b445:: with SMTP id n5-v6mr13986032pgu.104.1532893020950;
        Sun, 29 Jul 2018 12:37:00 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:00 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/13] staging: gasket: page table: hold references to device and pci_dev
Date:   Sun, 29 Jul 2018 12:36:36 -0700
Message-Id: <20180729193646.201721-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Hold references to the struct device and the pci_dev for the page table
while the data structures contian pointers to these.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index b9304d221722b..6b946a155ee3a 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -345,8 +345,8 @@ int gasket_page_table_init(
 		bar_data->virt_base[page_table_config->base_reg]);
 	pg_tbl->extended_offset_reg = (u64 __iomem *)&(
 		bar_data->virt_base[page_table_config->extended_reg]);
-	pg_tbl->device = device;
-	pg_tbl->pci_dev = pci_dev;
+	pg_tbl->device = get_device(device);
+	pg_tbl->pci_dev = pci_dev_get(pci_dev);
 
 	dev_dbg(device, "Page table initialized successfully\n");
 
@@ -364,6 +364,8 @@ void gasket_page_table_cleanup(struct gasket_page_table *pg_tbl)
 	vfree(pg_tbl->entries);
 	pg_tbl->entries = NULL;
 
+	put_device(pg_tbl->device);
+	pci_dev_put(pg_tbl->pci_dev);
 	kfree(pg_tbl);
 }
 
-- 
2.18.0.345.g5c9ce644c3-goog

