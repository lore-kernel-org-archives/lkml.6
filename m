Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531B6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B72A21936
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B72A21936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeHQMy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:54:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57658 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeHQMyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:54:55 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lsdqf-1g1pnj24OP-012Fgn; Fri, 17 Aug 2018 11:51:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Zha Qipeng <qipeng.zha@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] intel_punit_ipc: include linux/io.h
Date:   Fri, 17 Aug 2018 11:51:21 +0200
Message-Id: <20180817095131.2557798-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:LU0X5+N1ghY9y0T+uBjYKkxVbWEUM48HmYE19ebNfA9wGEzRvxh
 3RsBExFvuJECoV5LYHbvigYrcZQ7/gzhhDn7OIKSxUNF4GTMBIIL+US6ICbHb+FB/KTaCMZ
 E31Q+5WwTYYnTziQxE+mmiCq5PYCYZWgMPfQ0rmZ88kPSRK0m9Uly7gsCrFRYaAG1oVo6Fo
 vWkzrx5sSkvLZM3ii2V2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WfcevEyDoYc=:ok9H6paFRf4PzNk2BnO+x2
 CQrSrciLm33/bjNTdW56dA2d1JBtQ42Om9XSKK69x+GRm9N13M2pPJ1S84M9pdn0KDiY5uGEq
 LCNGFygNKXYxZ2xeUZeyNorBi4gBzwnm98ruNYdU80OcKbE6A7aAH6wDwRat8z61LVUDh5J2c
 tQQ8k1RxGBuyedzHxcHdCflBYDqHmEl3sQFxQxGqCOdQZS5ZG5z4y1/nrD73DKrugfP0r9phK
 AuSqLs3qJgqfzJBKalqG0bJJu85soD7Hw3psOxajphXc0k+XwknNe3MA72fZA8jeEkL2borWB
 lwtcC0c5qGMJQVdFjm9P8SUAwgxxHb4iMjJX2sRF4gk3bhkn23kzYs270aUbj6IHneXzxjssA
 HkEj66o8H8eu15TP6wzFjxHUvt6Ovk90AsMJiWpd0qTuM02RlwyNbNOdmxUDs28g4GYZkNfF1
 SiZ2w/DYj2X1xGBsOoAtJ5OfKBACutjh8ekwCFFQ5zZsvgstq9U3ZykeLVHa6lX5ImIyIPxIR
 d7bc+SLOfgvnNtEc5sA37AuhdlgDOqWi1AF6iJwsT/vFZqnvnte+fFtJyLb75N0ZnzaRMvYfK
 pARA/0khll3UApl/hh67IBuzCHfW40jT2fqervF5gHqnYvW5YehX2/SNJsW9jLjsVMCSohdbb
 FHWpF6D1wHL9OI1uKklp31nkh+2AgX+LO7xZxgmt1UqPb/ewFqWWv4UAIb+8t6ElPZYw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we stop including linux/irq.h implicitly, we don't see linux/io.h
in intel_punit_ipc.c, leading to a build failure:

drivers/platform/x86/intel_punit_ipc.c: In function 'ipc_read_status':
drivers/platform/x86/intel_punit_ipc.c:55:9: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]

Add back the include that is clearly needed.

Fixes: 447ae3166702 ("x86: Don't include linux/irq.h from asm/hardirq.h")
Cc: Nicolai Stange <nstange@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/intel_punit_ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
index f1afc0ebbc68..2efeab650345 100644
--- a/drivers/platform/x86/intel_punit_ipc.c
+++ b/drivers/platform/x86/intel_punit_ipc.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <asm/intel_punit_ipc.h>
 
-- 
2.18.0

