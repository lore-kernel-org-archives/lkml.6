Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D456C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1C52084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfBLOyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:54:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfBLOyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:54:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AA7581DEB;
        Tue, 12 Feb 2019 14:54:24 +0000 (UTC)
Received: from llong.com (ovpn-124-193.rdu2.redhat.com [10.10.124.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CE7D5C21A;
        Tue, 12 Feb 2019 14:54:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip] genirq: Add missing documentation for tot_count
Date:   Tue, 12 Feb 2019 09:54:13 -0500
Message-Id: <1549983253-19107-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 12 Feb 2019 14:54:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1136b0728969 ("genirq: Avoid summation loops for /proc/stat") adds
a new tot_count field to the irq_desc structure without documenting it.
This patch adds the missing piece of documentation.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/irqdesc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 875c41b..1d679fe 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -28,6 +28,7 @@
  * @core_internal_state__do_not_mess_with_it: core internal status information
  * @depth:		disable-depth, for nested irq_disable() calls
  * @wake_depth:		enable depth, for multiple irq_set_irq_wake() callers
+ * @tot_count:		stats field for non-percpu irqs
  * @irq_count:		stats field to detect stalled irqs
  * @last_unhandled:	aging timer for unhandled count
  * @irqs_unhandled:	stats field for spurious unhandled interrupts
-- 
1.8.3.1

