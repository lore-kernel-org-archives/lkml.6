Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A36C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D275F2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="g6uJWkro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeLYH4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 02:56:48 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33772 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeLYH4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 02:56:47 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 478F5C0A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 07:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HfCEEKUWP_P9 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 01:56:46 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 14C95BEB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 01:56:46 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id w15so16331786ita.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 23:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DozcSpvbKGa4uPyQGyDlYfvnPqBrqf2D6i8rY2y1aJo=;
        b=g6uJWkroYTjEjEr0DMeJijL9vZYD9fnU0kMeXzteCFbtwwAGR2vQR+HIiiJq1wlzVh
         KEmz0TdqsLPMLEhtwnudIUgYywn4pEhf45Laxity1P+iwma853RHPMw4pqjKBtiGIdP4
         fjQSszINUE+TrVUseQ1TN0z4jtzsgO6DriwOxjjywUUGk5I2RsUilJ1u9qP3PYaOzz4n
         nGoQLGAD9oL+NE6im06RuE68IqN0d0KWoJiu3NCrFM/KATvM2yNaZIEdKP8KPwmg6FMf
         F1e/kyJhuEvWyFnPiEGwsZL5mGecwalXeVIb3s6l4B0HeyidESd63KQU2fPuTQQNxB4H
         oC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DozcSpvbKGa4uPyQGyDlYfvnPqBrqf2D6i8rY2y1aJo=;
        b=aMTe8+eOax5ZJphRUnohhMzHE5UWVcDhQhQ/7csd8tbCzI6DU7CmF3NOYnamMaT6hz
         seYQkJ9IRhKnmWud2aS22fVFd1ubkBLmTfIY6NyxI8o3zt0+5o9ew5h/ITudqDLVZVqd
         53zVdB08Ub8jpxnjcpFe5lxxHUa++3RdHiRmsSNUs1H22g6Tw5RjmYKh5EOmj0MbM31S
         T7Xy4nAWGU++B4UyzTyZ1M1OUyk3QtVlsGxtPnlUE8eoVero0on3KFi3KgWWNJotP8qL
         RfhtE3J3oyxxeTmuuOVb3um+hAigL29oTot2XloFKtjjXO1Wzpx9dFTtRZN1VD7YVmb8
         NceA==
X-Gm-Message-State: AJcUukcGGHTSH3S28MhfhQXLHJIwcKSXXsRDAmGGgrgSGcY0Vm5Ig6qX
        I7uFAJOW0NSaOpHzMhxUIExx9CjH4Ohb12HtEP2oXevcaLmI38EHTGZ/JwXOg70GmOi28mRtWEN
        p/CW7JkMEpAoYh6Vr4qJ+cwkzAvib
X-Received: by 2002:a6b:e019:: with SMTP id z25mr7317223iog.237.1545724604307;
        Mon, 24 Dec 2018 23:56:44 -0800 (PST)
X-Google-Smtp-Source: ALg8bN46u5azByN6/vqtZtV58NZRtSP+iYz+QHPzXjC/Cv+3/XgUKRLeFn2i1xNFsVnh5vkuxa25LA==
X-Received: by 2002:a6b:e019:: with SMTP id z25mr7317211iog.237.1545724604103;
        Mon, 24 Dec 2018 23:56:44 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id o74sm9621215itc.44.2018.12.24.23.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 23:56:43 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Rob Taglang <rob@taglang.io>, Joe Perches <joe@perches.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: (niu) fix missing checks of niu_pci_eeprom_read
Date:   Tue, 25 Dec 2018 01:56:14 -0600
Message-Id: <20181225075617.68058-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niu_pci_eeprom_read() may fail, so we should check its return value
before using the read data.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/sun/niu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 9319d84bf49f..d84501441edd 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -8100,6 +8100,8 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
 		start += 3;
 
 		prop_len = niu_pci_eeprom_read(np, start + 4);
+		if (prop_len < 0)
+			return prop_len;
 		err = niu_pci_vpd_get_propname(np, start + 5, namebuf, 64);
 		if (err < 0)
 			return err;
@@ -8144,8 +8146,12 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
 			netif_printk(np, probe, KERN_DEBUG, np->dev,
 				     "VPD_SCAN: Reading in property [%s] len[%d]\n",
 				     namebuf, prop_len);
-			for (i = 0; i < prop_len; i++)
-				*prop_buf++ = niu_pci_eeprom_read(np, off + i);
+			for (i = 0; i < prop_len; i++) {
+				err = niu_pci_eeprom_read(np, off + i);
+				if (err >= 0)
+					*prop_buf = err;
+				++prop_buf;
+			}
 		}
 
 		start += len;
-- 
2.17.2 (Apple Git-113)

