Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54776C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C47721908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBHGC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:02:58 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36736 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBHGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:02:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id r9so2745412qtt.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 22:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W8PeqJuk3az7qB2ahrJc1USuNPZ3pOX/V39POuWovhY=;
        b=TqDxq1xW/zJV7Hs2UhukCAAvj3USgWb+SIlDBeG6rqRBc1/HCQY/dMePC5QfiGFz1L
         2/HmcrlWR9IUIQFIerN6byouGytSrnO9OW95S/Pvp0OiNFdJGThZRqcVi/xSWiUitLLt
         oayhUP+dreIUaNQe4HmOgZU2SocyPqqNG1Ydb/rjPIUEUdqVFMck/uYmf705IamChBV+
         m4J7BdWUo8d039d35oHqArvRFfVvXIGCdvMS4gxFje5iF2TLC6udx1z/KUemO1G1Jeth
         KYJPk/oBw9tDpvfqIOH+NFh4KOudR8EclnYlqG5NKI21oTVLbv0EgqCLTI2qNNBeeGKj
         B1DQ==
X-Gm-Message-State: AHQUAuabzK7DaGKIvq7fSJC8Dmbuuy3/zdAJQjot1MP2dbEBD/GYkxFo
        hA08Ybmp5ROddwyB186Vlk3vcoWZWS4g4g==
X-Google-Smtp-Source: AHgI3IYUpsntHYhzarfx9r7Ynw0Mz1XP1ErgAtqrpJ+Jj9ttFfmZbm/3X02FmDXikvGo+XBtbLpRPA==
X-Received: by 2002:ac8:7497:: with SMTP id v23mr14505554qtq.38.1549605775539;
        Thu, 07 Feb 2019 22:02:55 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id j189sm1028525qkc.77.2019.02.07.22.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 22:02:54 -0800 (PST)
Date:   Fri, 8 Feb 2019 01:02:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 1/3] x86/mpx: tweak header name
Message-ID: <20190124142448.23243-2-mst@redhat.com>
References: <20190124142448.23243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use linux/mman.h to make sure we get all mmap flags we need.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/x86/mm/mpx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index de1851d15699..c805db6236b4 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -9,12 +9,12 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm_types.h>
+#include <linux/mman.h>
 #include <linux/syscalls.h>
 #include <linux/sched/sysctl.h>
 
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
-#include <asm/mman.h>
 #include <asm/mmu_context.h>
 #include <asm/mpx.h>
 #include <asm/processor.h>
-- 
MST

