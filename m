Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7943A21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l716UMDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7943A21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbeIUBCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39051 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbeIUBCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so4791247plp.6;
        Thu, 20 Sep 2018 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3q5yHdmt2ZOMxDln96L5e6epgJ+iuke2PxN+1yKq7WY=;
        b=l716UMDzOkeR7I/nEFyCozCVE54+bLR///ioPiQ1dwYVHxCNAkVv6FkRxdYLRekEv1
         szqC3qghU7FVjNPYSWu4XWRL8h2AaKyN/NyeNoLbsWBcLvQQLyxop7HDqGfQcpwwfSJF
         CB0mEAI3InZf4cSz4MjJJOcb/Hdb0EsgLmBcAfhPuUEiN0yWMCSXdbDZlm9jAFFLqPxE
         R7Ii9ySeIsiNF27gJ25GykcaSDwsYitaMzBcodbG9wbiYmC4kRQSkucHxqCmx/qRGGwQ
         p4DR80NyyODcTRCYr5gRXKdetHYkLrac/mW9PHh3wMcxwZ4gLm0zA5Q0SeUBmBgqN1pr
         ZDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3q5yHdmt2ZOMxDln96L5e6epgJ+iuke2PxN+1yKq7WY=;
        b=G3bqeUhF5hiNrrybU26It+3h3u/LcknVBJ7MO354HHDJDisLi2AJCpC0Np7kf+NUu1
         sHDxTHG0vxqMScMvAtuWw6ICvADNs+4C8FCSKX24up0zZwmue1QD6myP5mJgke4yt3O9
         w5SChuyY0JBM88xpesN4aSxE3WfGzvLtcKEl79HQRuCj/eXx81v8Nmu1scx8hfgTijsx
         tAKw5OhR+kp5UI5JnWe0hwmigSO713Te1X2DHuc7I6AywZqIFtsWnd8yBFPnVypCxnVq
         Op7m/tLGLdzVFyGF6WyiluxU2xi6OSWBE8yITphBFs8Y9Xst+2ZQa4wX/hVgNFuS2G7e
         9vkg==
X-Gm-Message-State: APzg51CjyfUzSNomVcUz/F+0kdC9gZiLu7nZsn7dBWR2VsEoeEonLvnM
        4k3kTSfzsw9zRkwQHFx2yd5JPN+y
X-Google-Smtp-Source: ANB0VdYXfFdf3g9YxsRDjBTj8uHchcjHZ5lbzLIT0DVZZfNe8rReJwM2SMLc/JrlG7uGcJhc94DokA==
X-Received: by 2002:a17:902:b947:: with SMTP id h7-v6mr41243865pls.157.1537471051429;
        Thu, 20 Sep 2018 12:17:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:30 -0700 (PDT)
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
Subject: [PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings
Date:   Thu, 20 Sep 2018 12:16:43 -0700
Message-Id: <20180920191646.18198-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index d535e87151dc..43f4e4fe4742 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -383,6 +383,7 @@ static struct scsi_host_template ahci_platform_sht = {
 static const struct of_device_id ahci_of_match[] = {
 	{.compatible = "brcm,bcm7425-ahci", .data = (void *)BRCM_SATA_BCM7425},
 	{.compatible = "brcm,bcm7445-ahci", .data = (void *)BRCM_SATA_BCM7445},
+	{.compatible = "brcm,bcm63138-ahci", .data = (void *)BRCM_SATA_BCM7445},
 	{.compatible = "brcm,bcm-nsp-ahci", .data = (void *)BRCM_SATA_NSP},
 	{},
 };
-- 
2.17.1

