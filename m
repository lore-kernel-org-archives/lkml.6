Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B642ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A8B21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcrPxylt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A8B21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbeIUBCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35504 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbeIUBCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id 205-v6so3932822pgd.2;
        Thu, 20 Sep 2018 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2ixfzE8WjRphU4mULMrc0jTfwZKV4C9jTHwi22GuuOo=;
        b=rcrPxyltBh+1gC/PZk73sE7ucfYKsBIdymaPGbBoL4+7WXTqY3Fh5tYfK7gDgyjb1M
         NklbYJFYvF3fBueN0FSIgHxA6i937dq8Wfq5w42Zn6jbssF4VzTwjhLzrLXJDag/mNbF
         GcyR+IU+8E75hwAxnDhfdVtm7dNe9pF64m5rJ0uuoOZLVmq+7rsfXLs5Mv/KX7nSo1Qx
         H0OS+yo+0lx0OywJoIFFCq04qETIKWr+e+vIu/YmOH33hBLeG8Gp4hghuTnLF3Of2sO3
         XYNclMcHfwqL3wwUItTxk2k1EXNl5whl1ON2m+TGwLlTUZwpxB3Mf/9zQLlh7+YsFtqm
         qbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ixfzE8WjRphU4mULMrc0jTfwZKV4C9jTHwi22GuuOo=;
        b=DLWQtu8kB8v3UUQP3XTeGn5HWC064TuNyxkA7bhBXwD7I1tB8Rt6HqWV6hNU+AFHS5
         YRc6THqRPWrkn+lLdi9coYhqWilD5/UIsJ/1y/S9djY+dI5E0OPjjLrEASRsdN8sppqE
         OL8zAy5D07xka2tSdqMjrr/VaLHI9UKWCjLOooSsZfSWU2zZuhqM7sgZxz6g1Rj9DUfj
         jIt4B+vsTsm3agil3265QS6O6lnGN251v4bTS9UzO1/dle8GrdLpo+Qbn/zAfOV7Hq2V
         evM3MXbWAeOyl4ZHpY5DirwqsKoKwBdGd2w6ZfXB9pHKwOgWUtCWTnlC2pDerzo2bA9J
         iTVQ==
X-Gm-Message-State: APzg51CzEbP2NGi2P6Cun9HGJh81khLEPK6hCdBMpQNRbJyrfNM4+46L
        iumnKb7AWmtsoeuwGDvb+aTV3YDj
X-Google-Smtp-Source: ANB0VdaABnbyBspWS9scPDklanq4NPa0DtvkWCGCuxFkq79nc2kOaNUpmtdd/1EIw+RXwg5eH9I2wQ==
X-Received: by 2002:a63:1125:: with SMTP id g37-v6mr38186225pgl.187.1537471057209;
        Thu, 20 Sep 2018 12:17:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:36 -0700 (PDT)
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
Subject: [PATCH 9/9] ARM: bcm63138: Enable SATA AHCI and PHY
Date:   Thu, 20 Sep 2018 12:16:46 -0700
Message-Id: <20180920191646.18198-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom BCM963138DVT board has an eSATA port which is fully
functional, turn on the AHCI controller and the companion SATA PHY.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm963138dvt.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm963138dvt.dts b/arch/arm/boot/dts/bcm963138dvt.dts
index c61673638fa8..8dca97eeaf57 100644
--- a/arch/arm/boot/dts/bcm963138dvt.dts
+++ b/arch/arm/boot/dts/bcm963138dvt.dts
@@ -41,3 +41,11 @@
 		brcm,nand-oob-sectors-size = <16>;
 	};
 };
+
+&ahci {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
-- 
2.17.1

