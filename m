Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D6AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F289420645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F289420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeH1FpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:45:01 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40606 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeH1Fob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:31 -0400
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so9008oig.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BjSv54kYqZQm8xIY+2ze5d49wD7KR5gbWBlvsmgOD/8=;
        b=gsAWBJfo6rlFpbOyXSGn1OlkSgfs/24re/8RO4NYzoGf3dshOTAzqs6j0vLz6sNKIR
         wBasEF9QgsVNRU/oO5WtIJgsFpxTjiR5voIbFoTk+977J1PjWO8P+6mSqQFP2qY2ajuA
         aXA+6962tD29FDT3mDtxF+/QCJ2n7XPAkVGWYgjYRjjydNtCrcQ8BiVK2ZSRpTD3Pov+
         ENSsI2U+DR16zoiFXJEl4Skf786y4elEWNVqS/y+kihcBX75eUuqHmSnk2ceDAckDjeM
         WXhY5UMNQwPkzKxTUqhWv9ds7c3awXMDO3BijUCB+qEO6siwZkJxmkVDVAaZczgzvwF4
         5M5A==
X-Gm-Message-State: APzg51BTMYTeuTNUjbhw/xrbXCj2ren7MzYIvWXL1eHNGMplKct2j6Sm
        QNUxU61T2EisZUF6f1x9LfrRtw8=
X-Google-Smtp-Source: ANB0VdYrI1pu+z9uh2Yyj59nWpVMjLpHDlHGNIegw1xA2vP/zErQg+VE57R7gspqAb4BqOVnd4PNlg==
X-Received: by 2002:aca:2111:: with SMTP id 17-v6mr971046oiz.241.1535421315824;
        Mon, 27 Aug 2018 18:55:15 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] uio: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:48 -0500
Message-Id: <20180828015252.28511-47-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/uio/uio_fsl_elbc_gpcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index bbc17effae5e..9cc37fe07d35 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -382,8 +382,7 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 	}
 
 	/* set all UIO data */
-	if (node->name)
-		info->mem[0].name = kstrdup(node->name, GFP_KERNEL);
+	info->mem[0].name = kasprintf(GFP_KERNEL, "%pOFn", node);
 	info->mem[0].addr = res.start;
 	info->mem[0].size = resource_size(&res);
 	info->mem[0].memtype = UIO_MEM_PHYS;
-- 
2.17.1

