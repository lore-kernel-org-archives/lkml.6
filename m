Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB60C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEDB223BD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnuww0wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEDB223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeHJFta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46590 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeHJFt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so3809322pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yKRoNB8jaLqCKetKdjFfRuRMieIWkj2B3lhufLvp+E=;
        b=Cnuww0wdw/NKe7o1DU5uP1hwaHOxnHs+CGFAbLlZwBa96TbAgZZPGbR4Fo6AL5N057
         ymNUM8P1yZpswcz9TactVbcEMvnh06drwSmW+3pOyDkQ0cNJwLFm0rAv4gFXdrRpNMkm
         wGnci3+pVhj+9Y2ctwRhJzww1bTWKyLiBhrni5RmIdcQeeqH5RhWsUXbabnMNxRMaHxS
         v5poQWQsrGZZhDmh/ASc2Kd71TuUbsx3PFqSEnyU7qSDm82VvNr08xt1QmJ9M9W2SXex
         RxXnd08HEyGqwSTrrBQivKQeyjG43UuyjE33lUsgpBi5gf4ob8nSBGR4GSb9UZWPWlmp
         PoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yKRoNB8jaLqCKetKdjFfRuRMieIWkj2B3lhufLvp+E=;
        b=eAGWcxVFo864qJosWdB4BJ0GqX/loZffuhOHwDIX0/veHf7e/PL9FFf3pmML+7zY6M
         Rl6eBqXZvdKaxKgYfKGIdr/qHxAXUu5/jLPlksNURH2ogD+h/R6IbrLc42VGbX4RgQ3O
         br3qRN6I11WQ/cZcruMNL/dVEdefjR++qWOwdmn0TiDF5m5SNQFwIn+BUHGzmmeTl4vW
         Db7wJDdAGrH3apcAC4Q2be70STj17/rn0AS6QFYG312zfzvLVFwmfkSdpGwqEOTKh/8I
         USKzKjV2Rr9On7WG3+8ED9sLhM/YaXvTFsIoxi2qzP6XU9WDd2XztseJZC9oV4OQKOiK
         +QYw==
X-Gm-Message-State: AOUpUlFEx7wwdaFjjdKcxd2fiCeFYEUkIBR0tfw/LBwnBgr/xk7AhgI0
        M4bqU6Z60Ies3aSZuU0H0I7/V+Hg
X-Google-Smtp-Source: AA+uWPyKQ67Ew1W0VTWDZlIox6HVMSt54wYe/m5Gksx8CA8O3IwRgqa3OfAaTluHIDEhDV37EouQLA==
X-Received: by 2002:a63:dc17:: with SMTP id s23-v6mr4679669pgg.40.1533871296265;
        Thu, 09 Aug 2018 20:21:36 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:35 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 13/16] staging: gasket: core: rename lookup_internal_desc to be PCI-specific
Date:   Thu,  9 Aug 2018 20:21:08 -0700
Message-Id: <20180810032111.197743-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Rename lookup_internal_desc() to lookup_pci_internal_desc() to reflect
use for PCI devices only, in prep for non-PCI devices in the future.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 5e048f6e16e12..99f3f11d75ce2 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -651,13 +651,13 @@ void gasket_disable_device(struct gasket_dev *gasket_dev)
 EXPORT_SYMBOL(gasket_disable_device);
 
 /*
- * Registered descriptor lookup.
+ * Registered driver descriptor lookup for PCI devices.
  *
  * Precondition: Called with g_mutex held (to avoid a race on return).
  * Returns NULL if no matching device was found.
  */
 static struct gasket_internal_desc *
-lookup_internal_desc(struct pci_dev *pci_dev)
+lookup_pci_internal_desc(struct pci_dev *pci_dev)
 {
 	int i;
 
@@ -1488,7 +1488,7 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 	dev_dbg(&pci_dev->dev, "add PCI gasket device\n");
 
 	mutex_lock(&g_mutex);
-	internal_desc = lookup_internal_desc(pci_dev);
+	internal_desc = lookup_pci_internal_desc(pci_dev);
 	mutex_unlock(&g_mutex);
 	if (!internal_desc) {
 		dev_err(&pci_dev->dev,
@@ -1536,7 +1536,7 @@ void gasket_pci_remove_device(struct pci_dev *pci_dev)
 	struct gasket_dev *gasket_dev = NULL;
 	/* Find the device desc. */
 	mutex_lock(&g_mutex);
-	internal_desc = lookup_internal_desc(pci_dev);
+	internal_desc = lookup_pci_internal_desc(pci_dev);
 	if (!internal_desc) {
 		mutex_unlock(&g_mutex);
 		return;
-- 
2.18.0.597.ga71716f1ad-goog

