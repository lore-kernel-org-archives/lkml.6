Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D590CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF322174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="r92bUmNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF322174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeHCK6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:58:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45467 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732247AbeHCK6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:58:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id j143-v6so3522931lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0OpAgXoC48voistp5eGYhBCPmn+bfP0qzVOWmU+Aao=;
        b=r92bUmNV2rA6bW7iIyqNbPQzweUhqrd7kxd1FMSX4VQEiUMnAfyFSERPaRAHjHTb7J
         gH1fWz39hAtD4d7dxKlmwxebm/62okB5wTK+yIFtU9YaYPtFFBzTqR+6BoVXojGWcIjm
         wK8Wt8VCFZ+/JDytDi/uPgOf4jyxXlch0idHQX5qAXTMMDQZSD0nAj1zvg6aJ/4J8AVO
         JuvoNCPCcdWm1MJ+P3jNciG1m/ZVEejuH38qMv1MhCMkTCRBmiHCiC/cEchKsnM73xHa
         aqA8SLLymN+18VxS3VJ71NAkKHE2YJw5wzVPN5rhWsvZeJkKx7mBFBuE1LcmXX+eowbO
         0wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0OpAgXoC48voistp5eGYhBCPmn+bfP0qzVOWmU+Aao=;
        b=ct/qi7BQDp5ej5Nu0p9pObKnvgAurQRm47El1SRA9vAkhonLIEu3I2ROgkjMWDXvxb
         iJDuNes4wVwJu9uYB/Uzp0wWjD364qeZnt+OZak5DLlP6BReldh2uy6RGTiDNQ7ho/Eh
         562h8Xgx4jLfM5PpmktnCuL5bL8SZ45ns2q9GCA7dr80MeaUeQ3ysIvpEoN8JGRayxt1
         nhDt6JyqtnNleBw5TbLWTSAaaNIO9AveLVcnlhzujBQcSRRF3kfPxYCdy+OW6bP0wbIA
         ED7QE91Evl/1ZCZ+5hEf+NqZq8y57oziJsBtsKJwQWhck+8VH+tityxmZL6bRZ3ZzxKp
         d2qw==
X-Gm-Message-State: AOUpUlGM7v2n/ygJuo99dM5LdU93YDrS1aFvUQSC/+zhS9LalyBFcVd1
        X4BbvGS50UzqpdNOzT/crLV18KdpXQHD4g==
X-Google-Smtp-Source: AAOMgpdDfbmVXIiNWlpc37SjzZqg/iHjQuWv8LBkXxkYL1SvCy1EFLCgCxFoJzi52kj5fgnmi4tL0w==
X-Received: by 2002:a19:238d:: with SMTP id j135-v6mr4203540lfj.58.1533286965795;
        Fri, 03 Aug 2018 02:02:45 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id m29-v6sm628851lfj.45.2018.08.03.02.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 02:02:44 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: remove minor version check for 2.0
Date:   Fri,  3 Aug 2018 11:02:37 +0200
Message-Id: <20180803090237.2022-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A minor version number increase should not break backwards
compatibility.

Fixes: 3cb98f84d368b ("lightnvm: add minor version to generic geometry")
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index d9e4cccd5b66..a156fe3ca7d3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -414,12 +414,6 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	/* Set compacted version for upper layers */
 	geo->version = NVM_OCSSD_SPEC_20;
 
-	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
-		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
-				geo->major_ver_id, geo->minor_ver_id);
-		return -EINVAL;
-	}
-
 	geo->num_ch = le16_to_cpu(id->num_grp);
 	geo->num_lun = le16_to_cpu(id->num_pu);
 	geo->all_luns = geo->num_ch * geo->num_lun;
-- 
2.11.0

