Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2ACC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11A5214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11A5214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeHUQzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:55:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11157 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbeHUQzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:55:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2495DC857AD4;
        Tue, 21 Aug 2018 21:34:45 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Tue, 21 Aug 2018
 21:34:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <wolffhardt.schwabe@fau.de>, <Dave.Martin@arm.com>,
        <yang.shi@linux.alibaba.com>, <gregkh@linuxfoundation.org>,
        <keescook@chromium.org>, <arnd@arndb.de>, <tglx@linutronix.de>,
        <akpm@linux-foundation.org>, <linux@dominikbrodowski.net>,
        <gorcunov@gmail.com>, <kstewart@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] kernel: remove duplicated include from sys.c
Date:   Tue, 21 Aug 2018 21:34:24 +0800
Message-ID: <20180821133424.18716-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/sys.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 45dc552..d0281b5 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -71,9 +71,6 @@
 #include <asm/io.h>
 #include <asm/unistd.h>
 
-/* Hardening for Spectre-v1 */
-#include <linux/nospec.h>
-
 #include "uid16.h"
 
 #ifndef SET_UNALIGN_CTL
-- 
2.7.0


