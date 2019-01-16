Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33351C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0927320657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405710AbfAPQdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:33:01 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:42701 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfAPQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:33:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 16B4D1855E;
        Wed, 16 Jan 2019 17:32:59 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id q-2rmP8s9fHD; Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 366AF18525;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CBDC1E075;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10CAA1E06E;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 047E0177;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id F2F3E80B4B; Wed, 16 Jan 2019 17:32:57 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 3/8] vop: Add definition of readq/writeq if missing
Date:   Wed, 16 Jan 2019 17:32:48 +0100
Message-Id: <20190116163253.23780-4-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/io-64-nonatomic-lo-hi.h> so that readq/writeq are
replaced by two readl/writel on systems that do not support them.  The
values read/written are pointers which will be 32-bit on 32-bit systems
so the non-atomicity should not matter.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/vop/vop_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 5a366cf68d95..26b23f2cf94c 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "vop_main.h"
 
-- 
2.20.0

