Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE4C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D5B251DF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D5B251DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeGALMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:12:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752082AbeGALI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:08:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78657AE0B;
        Sun,  1 Jul 2018 11:08:57 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 02/15] net: lora: Define sockaddr_lora
Date:   Sun,  1 Jul 2018 13:07:51 +0200
Message-Id: <20180701110804.32415-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare a uapi linux/lora.h header defining sockaddr_lora for AF_LORA.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 include/uapi/linux/lora.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/uapi/linux/lora.h

diff --git a/include/uapi/linux/lora.h b/include/uapi/linux/lora.h
new file mode 100644
index 000000000000..9368e8a84f3a
--- /dev/null
+++ b/include/uapi/linux/lora.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later WITH Linux-syscall-note) */
+/*
+ * linux/lora.h
+ *
+ * Copyright (c) 2017-2018 Andreas Färber
+ */
+#ifndef _UAPI_LINUX_LORA_H
+#define _UAPI_LINUX_LORA_H
+
+#include <linux/types.h>
+#include <linux/socket.h>
+
+struct sockaddr_lora {
+	__kernel_sa_family_t lora_family;
+	int lora_ifindex;
+	union {
+	} lora_addr;
+};
+
+#endif /* _UAPI_LINUX_LORA_H */
-- 
2.16.4

