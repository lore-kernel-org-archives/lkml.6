Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA9AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E59320661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWmHpgVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E59320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeLIUbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33171 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeLIUbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so6523514lfc.0;
        Sun, 09 Dec 2018 12:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lj29166vEedOd0lY9Ey+tMd6cTWK5w4fd0anT0Vb+Ew=;
        b=jWmHpgVkVkspMAvO3hQfil/xros1OIfV+rUF1Jb1mjZqzJqj/WWu511hdLJD8r62IK
         9SO5wAbPGyZMiOFT/pEBke+zV3dOhYkDuSz6BOohTktSIRTS4SfWiRC6y2r3uimZd5nW
         Z0Mbv77mf0jjAqtrpW8IR01EZ6wQFpx+jy27ayBaHjRpEo2bJa1YjVKXGwFzLnoGD6Wi
         qEXDwS1i2zGmeSHFxnghdJRwPknUuh1eVtq2T5tm0G9AGtnK+QL7CaOvceeO5tZcBZQo
         gZRdjDflJQkjLJCe46zKEMfMwsdVG64Hutwh2jNugZKT3buM0LKC778zVAZq1xxr9Lst
         k3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lj29166vEedOd0lY9Ey+tMd6cTWK5w4fd0anT0Vb+Ew=;
        b=VAUTSKLm3CKssvn4ZabaDJ7NqiiMESKwyYpdylA6iNmApxeDg4hu9A5/QeE52bsa68
         BNhF71aqzZVEdjcZCvH8b5Yf2KXZfn1XVlZ0o26rYMMh1+a4Dqh1TsHqKvpGAXImhVDJ
         enXKUVtLboJe850tOBjhlSPnn/6ltF2vg8F9gYLh4MiSAaI8Nquz2RMXaJEn7ievOnSZ
         6xGc3rZCSrLDMNhiW9sQq74AlcQV4STh74y43hF38O2uzyf25EkP1vhKNcOvvlEqI7S7
         cIOPuZc1593wKYlhQiNvJyNiTceup79eaYmZ1hxgMrg5UAaYuH2uukzKujHXTgfsfHPF
         yw2w==
X-Gm-Message-State: AA+aEWbnqkIIBdZBqmmKboBFQJjySWps/MQ9tPugM3lxgTz2gEr0G/Lh
        XCR0uQRwQn3ZUc8wK5BZXno=
X-Google-Smtp-Source: AFSGD/WrTftwYAR+NjDC4JwMXDqPKCuF4c/O+7/Nv9EwoWaW9WsuPCZRjR74NEI4oKJHujzFIOuWvg==
X-Received: by 2002:a19:d90c:: with SMTP id q12mr5102391lfg.24.1544387458105;
        Sun, 09 Dec 2018 12:30:58 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:30:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/21] iommu/tegra: gart: Remove pr_fmt and clean up includes
Date:   Sun,  9 Dec 2018 23:29:30 +0300
Message-Id: <20181209202950.31486-2-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded headers inclusion and sort the headers in alphabet order.
Remove pr_fmt macro since there is no pr_*() in the code and it doesn't
affect dev_*() functions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index da6a4e357b2b..ff75cf60117b 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -19,22 +19,15 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#define pr_fmt(fmt)	"%s(): " fmt, __func__
-
 #include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
 #include <linux/moduleparam.h>
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
-
-#include <asm/cacheflush.h>
 
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
-- 
2.19.1

