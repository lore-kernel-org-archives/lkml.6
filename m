Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB41FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EFC208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1MjEZG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EFC208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935956AbeFNN4S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:56:18 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37123 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755064AbeFNN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:56:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so3602751plc.4;
        Thu, 14 Jun 2018 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MDHFqi6TfCuUOuNr4wb4pBhZm0cWifImhuUe9blRcbU=;
        b=n1MjEZG6Ly4SIqXxReltjNY2ocjJe19aoIVQPkJcBWgIw6fIM1iG1C11ySOHK7Mtmc
         OM8+FtAMp+hzWdDHk/QfGbh7s0SdlCkhYAr31RzkW80sLEyGOFdI1dBvqDodfLEIceDL
         kwC7JWcdK3U6MtD/XyT2TrMI9TBp2WB7Q+qqhDazOzR+a+mEprlMFvAVJ71FpulW0Ase
         6pVnPPLaBGquDGzGMlociBX7dRV9he6ojIIewSrUULTLbaOcthuw3+IZZF/jzIZBmrPC
         j8VGRKkWnLkqMYgmU8Rn4jeHXvt3aTQM4fi7zQq6/fazOxk1HWGIh4mcuVDzuMtwK8So
         0s5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MDHFqi6TfCuUOuNr4wb4pBhZm0cWifImhuUe9blRcbU=;
        b=Wup+FuzgYQHUFf3QcJ0lkY06xrbqd5NJp75qmBRsaouhxi81kOqQEjcDV3hq4MFp42
         HgLRUr6kZlYMxP/Vi9IUQtohMaKt5PozshSnOns9zEeeD2MmeGpqySUCN45wXPkH/LQP
         utdNwXJtv3Y4bD4epA6SH46zWuqx083U0A9n0O3f4MtQ4a1KFw01V2t9sjH2TJ/t/cmO
         VVEjT7Db5FHTbNxZl7BKRGZqmSXkxTIFXBxC9hWA58hfYMwtktN4OSEFtyk0ibH3XIzn
         f/o3Td9ajgl2KaM69O6IYCfqW3aPopEjNHbcTIRo+M1b9SCFa941/0JTIklZPZhsjSRY
         Jz6w==
X-Gm-Message-State: APt69E1o6J6Fx65rCEJ5QapfYh100x2FXkZOe0yE9QxVLF7Qdb9vEEM4
        QoEWOtvW03PGYcLPPIkLhhL9Vxgxi/I=
X-Google-Smtp-Source: ADUXVKJ6fhFx6miHPfCroFa7/bOztPbtLW0QaZlmmUKUt+BHO0JQWwP9EUU2zCdcjRnp/d7QFBJrbw==
X-Received: by 2002:a17:902:7442:: with SMTP id e2-v6mr3247200plt.28.1528984576201;
        Thu, 14 Jun 2018 06:56:16 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id k129-v6sm7337636pga.94.2018.06.14.06.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 06:56:15 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Santosh Raspatur <santosh@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: cxgb3: add error handling for sysfs_create_group
Date:   Thu, 14 Jun 2018 21:56:11 +0800
Message-Id: <1528984571-53320-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sysfs_create_group fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling sysfs_create_group.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 2edfdbd..73d6aa9 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -3362,6 +3362,10 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = sysfs_create_group(&adapter->port[0]->dev.kobj,
 				 &cxgb3_attr_group);
+	if (err) {
+		dev_err(&pdev->dev, "cannot create sysfs group\n");
+		goto out_free_dev;
+	}
 
 	print_port_info(adapter, ai);
 	return 0;
-- 
2.7.4

