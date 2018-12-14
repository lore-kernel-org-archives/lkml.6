Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA1C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE632053B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbyzuMzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE632053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbeLNNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:22:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38051 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbeLNNW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:22:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so4890412lja.5;
        Fri, 14 Dec 2018 05:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UE/GqWYt6cWY+EDpV4YK0XhG5yJ8nu3NgUgV+oNXdc0=;
        b=cbyzuMzTewwkl5mwhuFnL5iJ7fJVU4L8Tu5hGuiErfAQd95uXQqkSR9ulvDqEvBhMK
         uvgAC1we/NOzlrJLkaS3tmw7z/1MNld1pVY9urHbiQ5El/bVPVvsdc4bqqUGdkhPvwc/
         MZfdZmAkX8SsJJt6/RuNlk1c4lagRk5MyQHFVplV9fWesZaXhrcz1EpZgork+nHfcg0Z
         p7XzF0mZm4J7COlv3J+ntDTXLEA6bYwBgVZZmuMdqJEvQ8sroOhC8wEkXAnPx+K1nYww
         WsKcdpdrjXlTAeCnS96ZJuD7XdROwtCX0OExGJQLlQYTKTtYs9cYz5CluKYALB7K0HVf
         OBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UE/GqWYt6cWY+EDpV4YK0XhG5yJ8nu3NgUgV+oNXdc0=;
        b=m6IdMwXuIUZ0nFOUZ6xgIgGDdzjsCiPOogcSINXG/cUhbPhgZnC5t8V3zG4b4sIbCO
         E+Wq7kfcMa+Zf6G9G4WTEnnoBuKB3BtA0+sIP0u9Eu9Q33m72CImRTs+QGe+0ai5vq3J
         hkMcdcCqjyvpZXyBgLOUn+tUeMq+MlwtcfgPxoru0VGjDJ3fUPNcqMNLY6hjH2pgPoiI
         uGY8SPPCfaWDYUHdGty5+Z0k0RhI3QH9O6NTva+T3wT/8HqrheYza+CT5fRsPqfjpHrm
         xdVzw8i5Ss7ZQ01LodCJOHZG8Irs5I7tri363ASsgwWao1RznX/DHB5Vst49yjlpBZnR
         UhLg==
X-Gm-Message-State: AA+aEWY62d4CGlO8f2qHJdqQK3/RUyZDw27dYXIISQNWetohVJSgUBHr
        vTq0QLP1eXYEb/HOtF1IDe7okUKQ02fpxsuE
X-Google-Smtp-Source: AFSGD/XZHLEP3qoE6D6sswAoFJrSle4uWQUGDlK+5waBs49Yl3wIEez1M/nGAe9jSm2WSD3GSFv67g==
X-Received: by 2002:a2e:449c:: with SMTP id b28-v6mr1805484ljf.47.1544793746036;
        Fri, 14 Dec 2018 05:22:26 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id u79-v6sm944101lje.36.2018.12.14.05.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 05:22:25 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-scsi@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com
Subject: [PATCH 4/6] scsi: hpsa: Ignore HBA flag from NVRAM if logical devices exist
Date:   Fri, 14 Dec 2018 18:21:13 +0500
Message-Id: <20181214132115.21440-5-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214132115.21440-1-mironov.ivan@gmail.com>
References: <20181214132115.21440-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simultaneous use of physical devices and logical RAID devices may be
dangerous.

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/scsi/hpsa.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 60f1f7949d8d..0b5b3a651b70 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -4364,10 +4364,11 @@ static int hpsa_nvram_hba_flag_enabled(struct ctlr_info *h, bool *flag_enabled)
 	return rc;
 }
 
-static int hpsa_update_nvram_hba_mode(struct ctlr_info *h)
+static int hpsa_update_nvram_hba_mode(struct ctlr_info *h, u32 nlogicals)
 {
 	int rc;
 	bool flag_enabled;
+	bool ignore;
 
 	if (!hpsa_use_nvram_hba_flag)
 		return 0;
@@ -4378,10 +4379,13 @@ static int hpsa_update_nvram_hba_mode(struct ctlr_info *h)
 	if (rc)
 		return rc;
 
-	dev_info(&h->pdev->dev, "NVRAM HBA flag: %s\n",
-		flag_enabled ? "enabled" : "disabled");
+	ignore = flag_enabled && nlogicals;
 
-	h->nvram_hba_mode_enabled = flag_enabled;
+	dev_info(&h->pdev->dev, "NVRAM HBA flag: %s%s\n",
+		flag_enabled ? "enabled" : "disabled",
+		ignore ? " (ignored because of existing logical devices)" : "");
+
+	h->nvram_hba_mode_enabled = flag_enabled && !ignore;
 
 	return 0;
 }
@@ -4442,7 +4446,7 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 			__func__);
 	}
 
-	if (hpsa_update_nvram_hba_mode(h)) {
+	if (hpsa_update_nvram_hba_mode(h, nlogicals)) {
 		h->drv_req_rescan = 1;
 		goto out;
 	}
-- 
2.19.2

