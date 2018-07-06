Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55801C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA0F2241C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHGdhiFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA0F2241C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934202AbeGFSDC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:03:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42309 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932895AbeGFSDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:03:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id 1-v6so9742744ljv.9;
        Fri, 06 Jul 2018 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XOZa5hKvxAW/UgmrkQW2urno3LmKuo+j1r+oyBj68g8=;
        b=HHGdhiFYiH/pqSIEgyFkNI8rl36I+UD4VczqGyDT59GBtFIOzAEN+g248J5lruQ5Ng
         OzMtKnpg5BCIkQnzJtdqg8wwzuwj0rMXAPrijiPmMfvpLw9BxEeYInaI1NfqQH14/8dg
         JowdpMuEF9oqK1h5Hk28quj1YmBHNmVTQHO6T4j6FNrNP8/2cUlP0lrh0XEp33QBBJqZ
         2U7wX0Xtz5FykS1O2WF2JkD89Gpg+z+w5sURkCRL0micBXyyRlkleshGowaRGfJGruXy
         JGZmYBtzctA7A1a8sF5GNX2Q8dMel/KjBKydRQ5dw0avpy/yCHhiLqVBskW06yT9ofZi
         ap7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XOZa5hKvxAW/UgmrkQW2urno3LmKuo+j1r+oyBj68g8=;
        b=bgw4lfZiwe8MPBMBXF0poZKJRyUJ0XTAEhAr4PknCHV59nzqxPHSjqRiz5Etwx8Kvj
         x2t3ASxLRJcJ7ivC+ZdeGbglZYhzl8zeCRtTvs+xcv4pJjZr3LK1HL1HLuEkonMQX9Zs
         MwdnHlx3WQh7ofELH4xVUuC1T/pJibVFMSashcz8QqUCeGLOtHVpw+0k7BBlAWKq5SAS
         SVIOw/n8hzztI2DA30k8SgMkkZlMERyv1/gHTh4vXjU9VGEX+TdTCHnkLsisve/MDHYd
         JkasVBH3n2ZxBA+EbuwQHVDHImMcnMXVEGZpRMy4JzuWospONtX9fdErYOUC625y64a9
         ybVw==
X-Gm-Message-State: APt69E1N7n+Qv5cBpLzV2W+sbEf3qIC0srnPIr1P+MdOBjCEanDOtbyV
        AWM1ajAycLF0vGfcru74LBESIozD
X-Google-Smtp-Source: AAOMgpd016s9H5uWPda4IvZyEB90BbOTzyx23gxKUzLoZA912VKGoVd4nK39TAR8mccpUAHhjjLh2w==
X-Received: by 2002:a2e:658d:: with SMTP id e13-v6mr7384197ljf.57.1530900179524;
        Fri, 06 Jul 2018 11:02:59 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id j12-v6sm2304692lfg.42.2018.07.06.11.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 11:02:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: host1x: Check whether size of unpin isn't 0
Date:   Fri,  6 Jul 2018 21:02:36 +0300
Message-Id: <20180706180236.27896-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only gather pins are mapped by the Host1x driver, regular BO relocations
are not. Check whether size of unpin isn't 0, otherwise IOVA allocation at
0x0 could be erroneously released.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/job.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index e2f4a4d93d20..527a1cddb14f 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -569,7 +569,8 @@ void host1x_job_unpin(struct host1x_job *job)
 	for (i = 0; i < job->num_unpins; i++) {
 		struct host1x_job_unpin_data *unpin = &job->unpins[i];
 
-		if (!IS_ENABLED(CONFIG_TEGRA_HOST1X_FIREWALL) && host->domain) {
+		if (!IS_ENABLED(CONFIG_TEGRA_HOST1X_FIREWALL) &&
+		    unpin->size && host->domain) {
 			iommu_unmap(host->domain, job->addr_phys[i],
 				    unpin->size);
 			free_iova(&host->iova,
-- 
2.18.0

