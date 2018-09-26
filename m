Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A394EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680A52154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680A52154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeI0GOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeI0GOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:14:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE637308427E;
        Wed, 26 Sep 2018 23:58:36 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 519696D7E1;
        Wed, 26 Sep 2018 23:58:32 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, thgarnie@google.com,
        corbet@lwn.net, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/3] x86/KASLR: Update document about KERNEL_IMAGE_SIZE
Date:   Thu, 27 Sep 2018 07:58:21 +0800
Message-Id: <20180926235823.3567-2-bhe@redhat.com>
In-Reply-To: <20180926235823.3567-1-bhe@redhat.com>
References: <20180926235823.3567-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 26 Sep 2018 23:58:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_RANDOMIZE_BASE=y is default set, update the relevant
document about KERNEL_IMAGE_SIZE.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/page_64_types.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 6afac386a434..2288ceabdb9c 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -61,9 +61,10 @@
 /*
  * Kernel image size is limited to 1GiB due to the fixmap living in the
  * next 1GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S). Use
- * 512MiB by default, leaving 1.5GiB for modules once the page tables
- * are fully set up. If kernel ASLR is configured, it can extend the
- * kernel page table mapping, reducing the size of the modules area.
+ * 1 GiB by default, leaving 1 GiB for modules once the page tables are
+ * fully set up. If kernel ASLR is not configured, it can shrink the
+ * kernel page table mapping to decrease the size of kernel area to 512
+ * MiB, increase the size of the modules area to 1.5 GiB.
  */
 #if defined(CONFIG_RANDOMIZE_BASE)
 #define KERNEL_IMAGE_SIZE	(1024 * 1024 * 1024)
-- 
2.13.6

