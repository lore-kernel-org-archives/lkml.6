Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5810CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162E32082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEZwUB3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162E32082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeH3XFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42210 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeH3XFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so9022741wrr.9;
        Thu, 30 Aug 2018 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uNj/VFnQ8ClUwahEmW/nsQHB3Tb5wCIwIO0nNsAKcxw=;
        b=FEZwUB3Mxqu3I2HveWXbgjeeLpkCRzAfpH7tKqoRBFDxUFALUdOmJ4mWYpohlzglL1
         NtEPtxVQfhGjdM/CgpeFwYO8ZSDEvUsU9Z1hJhzfnruafzx8KtC55j1PbodUkPaxxyio
         //Erxs96nnV61D7JlMgLX601RDgoZ8V0wxuQKdPpX4/C9EUoXS5ByDyyLDnBZwH/Z8pR
         w16fSJ2+B4KZnXxPHHlKVSbF/D62UlGX12D9upR2ERu+VDYV5hkMxM329J8KOujbGLN/
         maPOvYaQRyk0huvmRJe2crxeM4aCoNkW3CRCJWN/FhdC6x+/eUakkoRCY1N/mABWU9h0
         8oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uNj/VFnQ8ClUwahEmW/nsQHB3Tb5wCIwIO0nNsAKcxw=;
        b=uK3SAXtm17QfWR9hJ6x/qSRHdbGmmYIbPutp8MWyLtWjwKJd0oOF9gyi4fXjoP1wdn
         YI/dI69xF6o9ehzxLgWeUbW/pvdZ9CUhx8MFyISmGhvgFRgHPOZzlacujlAyN+4khWvS
         LPCULDXigdz8TSVtdRDlMDHB/bcD9EquH4nscoSIaGqAx5ZrvWFFgjPaBx6LhrCAxYU6
         SZOCyQfcLDkpKT/FP3RfIENyAiRICvNokUlfiC3mPhZjiaTA0P2mRMkhJgTNOeocsDf4
         n9TtQnLg4pnFUMge3qw2l4nJEgSiY2nf2y7ah4ETNDHfM3lR0sXY5b5TtfpvX9gaKFD/
         aieg==
X-Gm-Message-State: APzg51BrxhrYGR2O0hi4mC3/UmZ+yOGlxyTEI/PQSs0SF6XGlI04+DRz
        Q4YH8C/A6V2TXqfHD1FBFsg=
X-Google-Smtp-Source: ANB0VdZRAwHfUOZ48d6y6t7O+JRXtmhQU2Kqy9ynLpQWcvfu3YVYEUEfuBNXyRXgKBV5PiWn6SVLkQ==
X-Received: by 2002:adf:a602:: with SMTP id k2-v6mr7952700wrc.181.1535655701025;
        Thu, 30 Aug 2018 12:01:41 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:40 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 08/13] ata: ahci_sunxi: add support for r40
Date:   Thu, 30 Aug 2018 21:01:15 +0200
Message-Id: <20180830190120.722-9-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the r40 compatible to the ahci_sunxi's supported list of
compatible.

Since R40 need ahci_platform to handle the reset controller, we also add
the new AHCI_PLATFORM_GET_RESETS flag for ahci_platform_get_resources().
This has no consequence for older platform (a10, a20) since the reset is
optional.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/ata/ahci_sunxi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index a09d189c6dda..b8cf3a1be80b 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -190,7 +190,7 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev, 0);
+	hpriv = ahci_platform_get_resources(pdev, AHCI_PLATFORM_GET_RESETS);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
@@ -259,6 +259,7 @@ static SIMPLE_DEV_PM_OPS(ahci_sunxi_pm_ops, ahci_platform_suspend,
 
 static const struct of_device_id ahci_sunxi_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-ahci", },
+	{ .compatible = "allwinner,sun8i-r40-ahci", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_sunxi_of_match);
-- 
2.16.4

