Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3467DECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07E821522
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07E821522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeISDFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:05:06 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:1294 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730308AbeISDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:05:05 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 18 Sep 2018 14:30:10 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 68925B0BFC;
        Tue, 18 Sep 2018 17:30:35 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>, Chris Zankel <chris@zankel.net>,
        <linux-xtensa@linux-xtensa.org>
Subject: [PATCH v8 01/10] xtensa: defining LINKER_SCRIPT for the linker script
Date:   Tue, 18 Sep 2018 14:28:38 -0700
Message-ID: <20180918212847.199085-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918212847.199085-1-namit@vmware.com>
References: <20180918212847.199085-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining the LINKER_SCRIPT when building the linker script as being done
in other architectures. This is required for the next Makefile changes
would otherwise break things.

Cc: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/xtensa/kernel/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index 91907590d183..8dff506caf07 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -35,8 +35,8 @@ sed-y = -e ':a; s/\*(\([^)]*\)\.text\.unlikely/*(\1.literal.unlikely .{text}.unl
 	-e 's/\.{text}/.text/g'
 
 quiet_cmd__cpp_lds_S = LDS     $@
-cmd__cpp_lds_S = $(CPP) $(cpp_flags) -P -C -Uxtensa -D__ASSEMBLY__ $<    \
-                 | sed $(sed-y) >$@
+cmd__cpp_lds_S = $(CPP) $(cpp_flags) -P -C -Uxtensa -D__ASSEMBLY__ \
+		 -DLINKER_SCRIPT $< | sed $(sed-y) >$@
 
 $(obj)/vmlinux.lds: $(src)/vmlinux.lds.S FORCE
 	$(call if_changed_dep,_cpp_lds_S)
-- 
2.17.1

