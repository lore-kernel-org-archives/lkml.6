Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A466ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0518021479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESEItExX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0518021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJJBPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:15:00 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52813 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJBPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:15:00 -0400
Received: by mail-pg1-f201.google.com with SMTP id m4-v6so1801744pgq.19
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jbUkitrzTYv5uI0nmsoLFGoQCfVIXTsBFswqlAMPmk0=;
        b=ESEItExX3CYE111LZz+1iU/IWNHsqdmbLRpgT59ZElvM+HBtdz0C66QHzoEDJmeUkR
         NMlTvQoF8/hp3t7IyONCZnGeQBUNO5t9ByEJyOfPKCqMoff39icpluiEFMERrBf17l+x
         Ks1FovuVxGnV7nZy1gjd9H50YXxYKNBFtPXPvXXI1aRQWLTcyoLG6TH4+ALATVWtMhWw
         rv4kMmWCNAHo+h6Hul7g/oPXtmA7pV8BBvuChJHVa2bsSNR4KmRVa7fyFA54TcVkhvQn
         x+gpzAhTycrlLQRrDhwXLzCVVQm7z+pad+b045T3yxnM3UFdmBeKLo8CQtepPjretkIj
         kKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jbUkitrzTYv5uI0nmsoLFGoQCfVIXTsBFswqlAMPmk0=;
        b=b7Ox5dBVr7AmBW37RZULrUWCJinoEtCaGY8AVbIeW0UqkOQCcBrBNbMw0Ma1bt/a/l
         Ir66rtRa2wxIO/BMhe6NZsP1PWt3wL8z53OhXEI/BUY1V6gChYllzpB7v/HiMHyDEk4M
         9vlM2oaTLtIe0a/Z/cmW8Oe+WiA/SHVNdS92N6cYzk/iwYNiNjodZukSidJ2gxDWVsru
         vIotgXMkGMbctSEKm0svisYEgMEc3scNnX9l+zXL3K0652SC+wCOWxDyxn3xBwZf7lF1
         SgRGtgRzMQ6p02OsW50NmumGj/U0FDbnvDhZWdJwWAs6ptlNnC3BOfcWvD98Zpnbwv0C
         OKYg==
X-Gm-Message-State: ABuFfohVvrsmdgWBePj9VrKZsIsxSNqVEBBgY0o40irEumRAYiYevWNa
        7lMJDrJbzs8UuiG/MfD8aGXw5emPPpmZ6A==
X-Google-Smtp-Source: ACcGV61aoFq0JPQNNjXSk9swbEzEvgmt8OnXOSVY0Wl2FUxXt/cCTDjXmyGkpB6hearsZg54YTgR5/sJznp1YQ==
X-Received: by 2002:a63:84c1:: with SMTP id k184-v6mr11941756pgd.42.1539107810402;
 Tue, 09 Oct 2018 10:56:50 -0700 (PDT)
Date:   Tue,  9 Oct 2018 10:56:46 -0700
Message-Id: <20181009175646.39921-1-egranata@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2] platform/chrome: Add a new interrupt path for cros_ec_lpc
From:   Enrico Granata <egranata@google.com>
To:     Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        gwendal@google.com
Cc:     Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

This commit allows cros_ec_lpc to register a direct IRQ instead of relying
on the ACPI notification chain to receive MKBP events.

This change is done in the interest of allowing reduced jitter in the
communication path between the CrOS EC and the host for receiving sensor
data.

Signed-off-by: Enrico Granata <egranata@chromium.org>
---
 drivers/platform/chrome/cros_ec_lpc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 31c8b8c49e45..20e97525b1a9 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -25,6 +25,7 @@
 #include <linux/dmi.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
 #include <linux/mfd/cros_ec_lpc_reg.h>
@@ -248,7 +249,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	acpi_status status;
 	struct cros_ec_device *ec_dev;
 	u8 buf[2];
-	int ret;
+	int irq, ret;
 
 	if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
 				 dev_name(dev))) {
@@ -287,6 +288,18 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 			   sizeof(struct ec_response_get_protocol_info);
 	ec_dev->dout_size = sizeof(struct ec_host_request);
 
+	/*
+	 * Some boards do not have an IRQ allotted for cros_ec_lpc,
+	 * which makes ENXIO an expected (and safe) scenario.
+	 */
+	irq = platform_get_irq(pdev, 0);
+	if (irq > 0)
+		ec_dev->irq = irq;
+	else if (irq != -ENXIO) {
+		dev_err(dev, "couldn't retrieve IRQ number (%d)\n", irq);
+		return irq;
+	}
+
 	ret = cros_ec_register(ec_dev);
 	if (ret) {
 		dev_err(dev, "couldn't register ec_dev (%d)\n", ret);
-- 
2.19.0.605.g01d371f741-goog

