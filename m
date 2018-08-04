Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5BBC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577B72183B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7IMG2Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577B72183B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeHDQg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42459 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so3124893edp.9;
        Sat, 04 Aug 2018 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xZFsKMHTLK8T8j2VEidYOcCIWo9hvsagpaz6nhB75A8=;
        b=n7IMG2GlBNuCInKdLg/T/6dq7Lp46kkJY7Dc6fc8yeboNIL88gL3B+F5W4ziwUuSlp
         DFlxH4eKc0O76uPnmCtYacL9LfoH/sQ6ytV+/cUwlIH/qTO+ZFHnw3KAGw4Xjia0RLXx
         wPBBysIueBMrhTZNRjegmbh+PoBWdMWlgLG0GNuxCvSn8B1IrzXfsd+rBzzrNSkCd1pJ
         h7YQXlW2DBE5SD3HqLf2KTK7VfGfepjSOr/SmsrWn/esEX9bA626Uypjq2o9yZM/6qsf
         ol7kBccHce0r1QM3ZlZoE5rusk8Df9oNFvc1+fGuVUoe3a6vZm3w/hVYdlxTNwX5dF50
         OHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xZFsKMHTLK8T8j2VEidYOcCIWo9hvsagpaz6nhB75A8=;
        b=ZKdm2chJqPHeicI1J9/1cIKmtXGS9sMLhP/OfgwnmSdfmvihCnrPfreP/cmuM+TP5S
         cjg+gRvqWXhypIVd8En4sLQ8A8tLC/KDmwZfAZ6fT/qRXdMatht/1PGzDQ/w+R8e7qDX
         gHbNRZDCtmB1XnqGwhnJW2hdv8SHaS5mflyV0OeIKY8biQ7ACy8tZ9yr+4DIuZJyoSJe
         U7oUCTFCnkLZDslzWVm6ctIKXL3MjKtucozEp7CBkiApq6t1TgTQc2awCI6Ab07ONQWO
         zTuwj+E6V/nChKhC8zghRzlelJruBWGjNkW54S9L90Lxvx2U5s37VLYsjPWbVoV/I7vm
         ncXw==
X-Gm-Message-State: AOUpUlEeeDtT3BbG/9R81sufm216X7Sta/1Wri5Yx7XZi+VppLESF+H3
        Q6qsRrZWbdKjBpPxWc4uLeI=
X-Google-Smtp-Source: AAOMgpeUOp1hfnKR8IKzfKfmAyGVYo3eEBRGHk3l3hATzgc6QB4Df5d+X+4mcKZqj2pfENfRS8KwOw==
X-Received: by 2002:a50:940b:: with SMTP id p11-v6mr11290699eda.107.1533393331929;
        Sat, 04 Aug 2018 07:35:31 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y20-v6sm589379edq.55.2018.08.04.07.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] iommu/tegra: gart: Remove pr_fmt and clean up includes
Date:   Sat,  4 Aug 2018 17:29:59 +0300
Message-Id: <20180804143003.15817-5-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded headers inclusion and sort the headers in alphabet order.
Remove pr_fmt macro since there is no pr_*() in the code and it doesn't
affect dev_*() functions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 141ff0c79ee4..9a427cb35340 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -17,24 +17,17 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#define pr_fmt(fmt)	"%s(): " fmt, __func__
-
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/vmalloc.h>
-#include <linux/mm.h>
-#include <linux/list.h>
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/iommu.h>
-#include <linux/of.h>
 
 #include <soc/tegra/mc.h>
 
-#include <asm/cacheflush.h>
-
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
 
-- 
2.18.0

