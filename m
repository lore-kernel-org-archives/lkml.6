Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C0CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ABA215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqe5FYTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ABA215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeHRTEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39169 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeHRTD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so6115672edi.6;
        Sat, 18 Aug 2018 08:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yc39MaJWlWuFsUruW/W28tlu/IXsoT4wAtYkbXGwtVU=;
        b=Yqe5FYTQPapMof27ShaTmUr5oFcqJ65+arwZvWOUPyDizGxTEKGiZhL3zS0qEryrVt
         qQhyBcgQRqu6IDeEir6zoeEvRrXZEe/BWLerx3snzNU8vLnIAakd5JqW0NpOHHTTZ1va
         79bLwxkgcFWxrba9w/a3ZoEpNIYkb9GoqH+2sDLF8P/O/hf4TgpZwgPeG0vqBHn42KO6
         dfQOjQoMmi41gj7i/TsXhfzJwNYRf4Qm+alx3mNwRsCRCL/quslaUjEtQ4nOBhOvdh1E
         i5matDsYPYlUoWKC5MMq/JAxV9ceIRptEJbxxXEmW79qjip4hAH9paRh3kYL8EjI9TrN
         7AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yc39MaJWlWuFsUruW/W28tlu/IXsoT4wAtYkbXGwtVU=;
        b=VBvcAdVgKeoJ2l84EkdtPuznwdFv57yN+rQ9H6Hc9Z7zPt+kpdSue9a/RZjRpnuXUP
         jtZY2KvKtCPPHsMaVxNlaiCbZ1QOrDZiGsUq4Kne7TuI7L6Ecm/9lvq0xRLrFlrqaKKi
         Zjord4mkVO/LRWVy7eto2MNy0V8RtZ8PQwx2QYL/Dir+R3joxFZC6qNsQOkoZQXS3XBX
         TGjZYq9Z3IwSymj20/TrQLmV+X59ELwfBGAGvKUwpPrmJ3xavd+ShfPHMHiWxdAEllL7
         fTnfdb+QE/yHy/SKCRYEsL3xLcKdkTpqIJMIylnst2Dn8v61+++V0dAuWVEssRbfhjMq
         /bMw==
X-Gm-Message-State: AOUpUlFx0Mes6s41w4DQiTEvoYWkQ5eJrwIMl0JRARHzkYPoyF7GvzNn
        4zQbPUnM7KfCfaHJwZ7MHVOEFfoT
X-Google-Smtp-Source: AA+uWPz1Uow8650udYtxf/GSg+w+KcahLuxdyREbxvfmdUDWitxryf2PMxeLzoDxPALUy6cIK6icow==
X-Received: by 2002:a50:d54a:: with SMTP id f10-v6mr28836944edj.151.1534607749115;
        Sat, 18 Aug 2018 08:55:49 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/19] memory: tegra: Read client ID on GART page fault
Date:   Sat, 18 Aug 2018 18:54:21 +0300
Message-Id: <20180818155430.5586-11-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the device tree binding changes, now Memory Controller has access to
GART registers. Hence it is now possible to read client ID on GART page
fault to get information about what memory client causes the fault.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 3bf3138769f4..ab383d7a7842 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -38,6 +38,7 @@
 
 #define MC_ERR_ADR 0x0c
 
+#define MC_GART_ERROR_REQ		0x30
 #define MC_DECERR_EMEM_OTHERS_STATUS	0x58
 #define MC_SECURITY_VIOLATION_STATUS	0x74
 
@@ -575,8 +576,15 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 			break;
 
 		case MC_INT_INVALID_GART_PAGE:
-			dev_err_ratelimited(mc->dev, "%s\n", error);
-			continue;
+			reg = MC_GART_ERROR_REQ;
+			value = mc_readl(mc, reg);
+
+			id = (value >> 1) & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(0))
+				direction = "write";
+			break;
 
 		case MC_INT_SECURITY_VIOLATION:
 			reg = MC_SECURITY_VIOLATION_STATUS;
-- 
2.18.0

