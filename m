Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9ADC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB4D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+GMFnnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB4D21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbeIUBCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35494 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbeIUBCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id 205-v6so3932626pgd.2;
        Thu, 20 Sep 2018 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=193CNgmBH8R6+te4PJDyCo0NhXQlORas2WPVssI+RmU=;
        b=e+GMFnnnXx7ob6/SWZtMw7RxwRCxAMXL6XEEMZUHtvREX7qGGjIZE9OfVk6w10HTEJ
         hoKaf3z/orXDc/H1BIZjINaH4XbPLtSGDuW+/ztQKKbY48quQrHvv5hjOkz3SCX4hDos
         1n9O74TDenmm1M14WiLxsjGROe9/Hsca1+6IMwz21yXhBXKkPsgnKcp6AZ3qrXzkyNEP
         EtDxBwf6QXVzVvx9maLfO7vySFApKvCFwznFgTKmPWdTnNHmNZhfvN5Z15UJa3E4C3RG
         QYMO2akAYFZF2lDlIOP2CZoMhkHZquw2FRx153o0+JzJHCXnruNM0XiK7kl4RkU0G+h5
         q+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=193CNgmBH8R6+te4PJDyCo0NhXQlORas2WPVssI+RmU=;
        b=CoYcXrUa9eqhRuNSJlXyDcGhEOa2/qvTAwxJPG83bsEzlxpglJ+bKw4ySpaZ4xlyTO
         5bOvYAkObB7UPy6FmjxhGv4+i1zMiq7RNwFFKDNGuJzAKGP40ghHqejvKB7P0wBjU8bW
         LmXz9YWif0HrzcOfv5oNIlwi7eS1TPpWZdn8+PTzQDYNeci05TzPyb4p4aaY6YZwg2lO
         xfN/2MUUN/eIZKUQ4u8bn8w5uIKwiLP38teXycMePJkTdUcfESEuWE32DXdyiE/sKfsz
         5ocXJEMYaL+NM1BFwVyuM49jWx7T9U2rQjCaH3A9BnkI3RFz7oRS0bi9N9cjjzZFSZqk
         iLVg==
X-Gm-Message-State: APzg51AWszT8MtWLVImA9IznYsRluX0UXLSe4DZ4hb/F2XZsTeLmzHMb
        Rez5cCEtaZ0+gVTczsxPs0dqLdX2
X-Google-Smtp-Source: ANB0VdaRdSexZ6YF6l2RzJv90/n+IJWZySBKIF1t9cKxPU/ykNtRsr/ywZIvJjYUwZc1Tos+t4vRGA==
X-Received: by 2002:a63:1316:: with SMTP id i22-v6mr37559006pgl.86.1537471045635;
        Thu, 20 Sep 2018 12:17:25 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:24 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 5/9] ata: ahci_brcm: Allow optional reset controller to be used
Date:   Thu, 20 Sep 2018 12:16:40 -0700
Message-Id: <20180920191646.18198-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On BCM63138, we need to reset the AHCI core prior to start utilizing it,
grab the reset controller device cookie and do that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index f3d557777d82..d535e87151dc 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/string.h>
 
 #include "ahci.h"
@@ -94,6 +95,7 @@ struct brcm_ahci_priv {
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
+	struct reset_control *rcdev;
 };
 
 static inline u32 brcm_sata_readreg(void __iomem *addr)
@@ -411,6 +413,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	priv->rcdev = of_reset_control_get(pdev->dev.of_node, NULL);
+	if (!IS_ERR(priv->rcdev))
+		reset_control_deassert(priv->rcdev);
+
 	if ((priv->version == BRCM_SATA_BCM7425) ||
 		(priv->version == BRCM_SATA_NSP)) {
 		priv->quirks |= BRCM_AHCI_QUIRK_NO_NCQ;
@@ -464,6 +470,9 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 
 	brcm_sata_phys_disable(priv);
 
+	if (!IS_ERR(priv->rcdev))
+		reset_control_assert(priv->rcdev);
+
 	return 0;
 }
 
-- 
2.17.1

