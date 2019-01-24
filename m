Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C46C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AB9218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSE4l6eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfAXQ1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:27:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32787 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfAXQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:27:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so5100167eds.0;
        Thu, 24 Jan 2019 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ReKAc+2bfV1kjjLHD9o7Q2cR/fNn02xcjuHZAWu8n/o=;
        b=QSE4l6eAs+qJrF0zH9sOZ5na/CqB823IHsU/uOg6JgH6HjFEVEaFWKl1dwqrGdxqKq
         wc4ZZNhkONalWegCn6PtwqLw0xI8nx3b3/q0zbDIINY0a/v9qN25NtNIew8+BcNAF6l/
         CSvcBx2NXzDcR50/gCkhMLIUTFJjZ3tZv2I+xW8VKvWMC4VV0nwyoKUYhy6QbsDbOVpq
         DuvNgbNWIV2M2OiKUOZhoyk0IwQ6K75HtpsaQcv68R9HaNBX32naopEIooBrmQCDUPTn
         4b4Ln0ksDlAxi/7buXMeW9FUevDrkR0iImUXUju9M7nwOYWTdf8s8ring1DkneDzPjVF
         sHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ReKAc+2bfV1kjjLHD9o7Q2cR/fNn02xcjuHZAWu8n/o=;
        b=DlqB1Ipkf2J4RbZNzeVI/hBZcZhjWKCbUsY4UiBoKVQGI3dikzBzVtKtqMkd4cEo0C
         H69kaHGjKjs6e1Kz5ZRxu+tXeIS8/vxquAHjLLcWyM3hmQ7vl7JCL6hs1r4aD2JRKLos
         HaNo92pXgY4t+BHa2NE3D2+Aohmao4iSUzaozl0BBEBMAk0Qqkc/h4mFs3QzL2wCygxE
         WmBdvhT96+jFQ2Xj1B9TZ2Sq80j8ZMaUcfG78rjEa9rZ9hVAsmUqJpDg/HdpqT4QuGW0
         t/ZoJCdTl/a7Zpc5n+qCyS9Jclti9DlZYGURwl9v6nlg/AQvWINHx0uTk+cff2U5LGPD
         MF9g==
X-Gm-Message-State: AJcUukecz2lz4BNqkjCccNRtkZ3zu1n6swYHur2VVLLQw/m0S3ey/c3l
        /XkCmGP4x2mZ8uoPdSoSy2k=
X-Google-Smtp-Source: ALg8bN7gCnwslG66cworqLCEnsqRhlMVur655AlVOmM3yy63e92mxmZBPfSQLVtktW7FIbX6li5u5g==
X-Received: by 2002:a17:906:a499:: with SMTP id m25mr4585641ejz.104.1548347233181;
        Thu, 24 Jan 2019 08:27:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id h9sm11925744ede.93.2019.01.24.08.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 08:27:12 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     Tomer Tayar <tomer.tayar@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] qede: Don't implicitly cast enumerated types in __qede_probe
Date:   Thu, 24 Jan 2019 09:27:00 -0700
Message-Id: <20190124162700.19989-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/ethernet/qlogic/qede/qede_main.c:1183:29: warning: implicit
conversion from enumeration type 'enum qede_rdma_probe_mode' to
different enumeration type 'enum qede_rdma_remove_mode'
[-Wenum-conversion]
        qede_rdma_dev_remove(edev, QEDE_RDMA_PROBE_MODE(mode));
        ~~~~~~~~~~~~~~~~~~~~       ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/qlogic/qede/qede_main.c:1074:33: note: expanded
from macro 'QEDE_RDMA_PROBE_MODE'
        ((mode) == QEDE_PROBE_NORMAL ? QEDE_RDMA_PROBE_NORMAL \
                                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/qlogic/qede/qede_main.c:1183:29: warning: implicit
conversion from enumeration type 'enum qede_rdma_probe_mode' to
different enumeration type 'enum qede_rdma_remove_mode'
[-Wenum-conversion]
        qede_rdma_dev_remove(edev, QEDE_RDMA_PROBE_MODE(mode));
        ~~~~~~~~~~~~~~~~~~~~       ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/qlogic/qede/qede_main.c:1075:12: note: expanded
from macro 'QEDE_RDMA_PROBE_MODE'
                                     : QEDE_RDMA_PROBE_RECOVERY)
                                       ^~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.

qede_rdma_dev_remove expects an value from enumerated type
qede_rdma_remove_mode. Hoist the definitions of qede_remove_mode
and QEDE_RDMA_REMOVE_MODE up above __qede_probe so they can be
used there, eliminating this warning.

Fixes: 278396de78a9 ("qede: Error recovery process")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index de955f2b2980..06bdba90d521 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -1074,6 +1074,15 @@ enum qede_probe_mode {
 	((mode) == QEDE_PROBE_NORMAL ? QEDE_RDMA_PROBE_NORMAL \
 				     : QEDE_RDMA_PROBE_RECOVERY)
 
+enum qede_remove_mode {
+	QEDE_REMOVE_NORMAL,
+	QEDE_REMOVE_RECOVERY,
+};
+
+#define QEDE_RDMA_REMOVE_MODE(mode) \
+	((mode) == QEDE_REMOVE_NORMAL ? QEDE_RDMA_REMOVE_NORMAL \
+				      : QEDE_RDMA_REMOVE_RECOVERY)
+
 static int __qede_probe(struct pci_dev *pdev, u32 dp_module, u8 dp_level,
 			bool is_vf, enum qede_probe_mode mode)
 {
@@ -1180,7 +1189,7 @@ static int __qede_probe(struct pci_dev *pdev, u32 dp_module, u8 dp_level,
 	return 0;
 
 err4:
-	qede_rdma_dev_remove(edev, QEDE_RDMA_PROBE_MODE(mode));
+	qede_rdma_dev_remove(edev, QEDE_RDMA_REMOVE_MODE(mode));
 err3:
 	free_netdev(edev->ndev);
 err2:
@@ -1214,15 +1223,6 @@ static int qede_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			    QEDE_PROBE_NORMAL);
 }
 
-enum qede_remove_mode {
-	QEDE_REMOVE_NORMAL,
-	QEDE_REMOVE_RECOVERY,
-};
-
-#define QEDE_RDMA_REMOVE_MODE(mode) \
-	((mode) == QEDE_REMOVE_NORMAL ? QEDE_RDMA_REMOVE_NORMAL \
-			      : QEDE_RDMA_REMOVE_RECOVERY)
-
 static void __qede_remove(struct pci_dev *pdev, enum qede_remove_mode mode)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
-- 
2.20.1

