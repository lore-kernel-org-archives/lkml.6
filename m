Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FHw+FOFHGVuIQQAAmS7hNA
	; Thu, 07 Jun 2018 14:59:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1777B608BF; Thu,  7 Jun 2018 14:59:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8CF83601C3;
	Thu,  7 Jun 2018 14:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CF83601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935642AbeFGO7P (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:59:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41250 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935293AbeFGO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:12 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005Zq-4i; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002u9-C3; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mikulas Patocka" <mpatocka@redhat.com>,
        "Matt Turner" <mattst88@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.327853688@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 146/410] alpha: fix reboot on Avanti platform
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 55fc633c41a08ce9244ff5f528f420b16b1e04d6 upstream.

We need to define NEED_SRM_SAVE_RESTORE on the Avanti, otherwise we get
machine check exception when attempting to reboot the machine.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/alpha/kernel/pci_impl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -143,7 +143,8 @@ struct pci_iommu_arena
 };
 
 #if defined(CONFIG_ALPHA_SRM) && \
-    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA))
+    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA) || \
+     defined(CONFIG_ALPHA_AVANTI))
 # define NEED_SRM_SAVE_RESTORE
 #else
 # undef NEED_SRM_SAVE_RESTORE
