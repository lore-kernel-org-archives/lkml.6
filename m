Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CDFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A0B208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A0B208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbeJAVGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:06:38 -0400
Received: from foss.arm.com ([217.140.101.70]:50418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbeJAVGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:06:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C7FD7A9;
        Mon,  1 Oct 2018 07:28:33 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C6223F5B3;
        Mon,  1 Oct 2018 07:28:33 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id AE74A1AE3C57; Mon,  1 Oct 2018 15:28:56 +0100 (BST)
Date:   Mon, 1 Oct 2018 15:28:56 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Low <jason.low2@hpe.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: Bad MAINTAINERS pattern in section 'LOCKING PRIMITIVES'
Message-ID: <20181001142856.GC9716@arm.com>
References: <20180928215436.29842-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928215436.29842-1-joe@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 02:54:36PM -0700, Joe Perches wrote:
> Please fix this defect appropriately.

Patch below, which was probably less effort to write than your report ;)

Will

--->8

From 867b47473ad490c21591378a7041fe7c06b71b59 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Mon, 1 Oct 2018 14:47:58 +0100
Subject: [PATCH] MAINTAINERS: Remove dead path from LOCKING PRIMITIVES entry

Since 890658b7ab48 ("locking/mutex: Kill arch specific code"), there
are no mutex header files under arch/, so we can remove the redundant
entry from MAINTAINERS.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb57c887..276c32df137a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8582,7 +8582,6 @@ F:	include/linux/spinlock*.h
 F:	arch/*/include/asm/spinlock*.h
 F:	include/linux/rwlock*.h
 F:	include/linux/mutex*.h
-F:	arch/*/include/asm/mutex*.h
 F:	include/linux/rwsem*.h
 F:	arch/*/include/asm/rwsem.h
 F:	include/linux/seqlock.h
-- 
2.1.4

