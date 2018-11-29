Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6473B2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6473B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeK3COO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:14:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7517 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbeK3CON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:14:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B2CCC05D3F3;
        Thu, 29 Nov 2018 15:08:34 +0000 (UTC)
Received: from xps.redhat.com (ovpn-116-75.phx2.redhat.com [10.3.116.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39FD82633E;
        Thu, 29 Nov 2018 15:08:27 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net, virgile@acceis.fr,
        linux-mm@kvack.org, william.kucharski@oracle.com
Subject: [PATCH v2] sysctl: clean up nr_pdflush_threads leftover
Date:   Thu, 29 Nov 2018 10:08:17 -0500
Message-Id: <20181129150817.24443-1-aquini@redhat.com>
In-Reply-To: <20181128152407.19062-1-aquini@redhat.com>
References: <20181128152407.19062-1-aquini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 29 Nov 2018 15:08:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_pdflush_threads has been long deprecated and
removed, but a remnant of its glorious past is
still around in CTL_VM names enum. This patch
is a minor clean-up to that case.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
v2:
 - adjust typo "was;" for VM_UNUSED2 comment       [wkucharski]
 - add colon after "int" for VM_UNUSED15 comment   [wkucharski]

 include/uapi/linux/sysctl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index d71013fffaf6..9df59925ed55 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -161,7 +161,7 @@ enum
 enum
 {
 	VM_UNUSED1=1,		/* was: struct: Set vm swapping control */
-	VM_UNUSED2=2,		/* was; int: Linear or sqrt() swapout for hogs */
+	VM_UNUSED2=2,		/* was: int: Linear or sqrt() swapout for hogs */
 	VM_UNUSED3=3,		/* was: struct: Set free page thresholds */
 	VM_UNUSED4=4,		/* Spare */
 	VM_OVERCOMMIT_MEMORY=5,	/* Turn off the virtual memory safety limit */
@@ -174,7 +174,7 @@ enum
 	VM_DIRTY_RATIO=12,	/* dirty_ratio */
 	VM_DIRTY_WB_CS=13,	/* dirty_writeback_centisecs */
 	VM_DIRTY_EXPIRE_CS=14,	/* dirty_expire_centisecs */
-	VM_NR_PDFLUSH_THREADS=15, /* nr_pdflush_threads */
+	VM_UNUSED15=15,		/* was: int: nr_pdflush_threads */
 	VM_OVERCOMMIT_RATIO=16, /* percent of RAM to allow overcommit in */
 	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
-- 
2.17.2

