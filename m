Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0F2C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B5620661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amy+OVam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B5620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeLIUcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:32:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42729 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeLIUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so7756560lja.9;
        Sun, 09 Dec 2018 12:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukU2nsrKjiF6glqzjylQ07Vd1ixac0NtcTFyTtmpwus=;
        b=amy+OVamESmMx2KKD6Qo14DYuChhGt9VrpVySVfH0gp+Ca9WLVhboClT6SffVrBCH2
         1+daAvZs4f1ywRI8EkjWqsDuXm6qX4ikgZPYohekwZa5jFxIYtyLB3VBu5jPpJks9Sbc
         0sIP1u4YRpM150up1h3KciE2UVahDiNG5L3rQ1Thb5Zx3cyzdeRKEuO94PqjJUwST8xX
         4adIqUsict96r+vS+5iTHcDIsg6m17OcH7i2pvlNxOFWl280edaKp/Gkj+jOxzF23Hv6
         pvx7/UIuwItA3TngQt7hy4TdOzQOqZeIxtNkW7yzaovEd7pQf/H8xz0tWHsml9+WcX9o
         Wy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukU2nsrKjiF6glqzjylQ07Vd1ixac0NtcTFyTtmpwus=;
        b=bYhzfGXLvQ1RVXx+hvKC0OaBeNXVQqw/EcxuHn9vj5j+K6Lck4MUMvy1dpYeb3p7O8
         ua7zZvjX+TVhpwRtaVQv5fwXA3uoJFX2hV4Xxa87AyGPgJIwGDS/Q5pcfzt2MbYz2kOj
         5JH0c0WPp2OJJDu7oUudAG+y/6ka9meEXPZrSQPzJ8sQ9zv8qu6udCBNEIKpdFmdXMRw
         /LUQLx4GxTlzXL0Ie2569/PVfpQJwi8kN5y6Ie/EV1K8IrC3NRMPap5C/5CqjPRGChNP
         4s1B8AEMKs20Cq3yD9MkSpR5TBRr/2eyLD/8Rou6ZanG8fVmDXkmNwQg/43u6kEQtHBi
         y3bw==
X-Gm-Message-State: AA+aEWY4/NkIlo1hA8iNgQU8JKA/7dlgQyTiDYZ2/5UzcvkpgNbEILgZ
        SSulvewo87ZDQ2w6LSW7ACc=
X-Google-Smtp-Source: AFSGD/WwqFZgeBF0KByHXasmiSBC7o7dGMKc0tFhYqyY4EcOe4vWh5KXdYMkGfz0QgcxkhKz+6G1kg==
X-Received: by 2002:a2e:5555:: with SMTP id j82-v6mr6353064ljb.69.1544387468844;
        Sun, 09 Dec 2018 12:31:08 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:08 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/21] memory: tegra: Read client ID on GART page fault
Date:   Sun,  9 Dec 2018 23:29:39 +0300
Message-Id: <20181209202950.31486-11-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 59db13287b47..ce8cf81b55d7 100644
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
2.19.1

