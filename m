Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8BBC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AFE21D19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AFE21D19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbeHINZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:25:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49946 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHINZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:25:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fnigT-000893-Jb; Thu, 09 Aug 2018 11:00:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc: remove redundant static int 'zero'
Date:   Thu,  9 Aug 2018 12:00:49 +0100
Message-Id: <20180809110049.32497-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The static int 'zero' is defined but is never used hence it is
redundant and can be removed. The use of this variable was removed
with commit a158bdd3247b ("rxrpc: Fix call timeouts").

Cleans up clang warning:
warning: 'zero' defined but not used [-Wunused-const-variable=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/rxrpc/sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index 4a7af7aff37d..d75bd15151e6 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -15,7 +15,6 @@
 #include "ar-internal.h"
 
 static struct ctl_table_header *rxrpc_sysctl_reg_table;
-static const unsigned int zero = 0;
 static const unsigned int one = 1;
 static const unsigned int four = 4;
 static const unsigned int thirtytwo = 32;
-- 
2.17.1

