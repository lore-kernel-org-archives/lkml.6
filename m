Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B3C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49918217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49918217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeHKQZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbeHKQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6AC21A1C;
        Sat, 11 Aug 2018 13:50:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHX-0006C4-6U; Sat, 11 Aug 2018 09:50:15 -0400
Message-Id: <20180811135015.099519260@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 23/34] ring-buffer: Make ring_buffer_record_is_set_on() return bool
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The value of ring_buffer_record_is_set_on() is either true or false, so have
its return value be bool.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h | 2 +-
 kernel/trace/ring_buffer.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 5176124fc4ba..0940fda59872 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -165,7 +165,7 @@ void ring_buffer_record_enable(struct ring_buffer *buffer);
 void ring_buffer_record_off(struct ring_buffer *buffer);
 void ring_buffer_record_on(struct ring_buffer *buffer);
 bool ring_buffer_record_is_on(struct ring_buffer *buffer);
-int ring_buffer_record_is_set_on(struct ring_buffer *buffer);
+bool ring_buffer_record_is_set_on(struct ring_buffer *buffer);
 void ring_buffer_record_disable_cpu(struct ring_buffer *buffer, int cpu);
 void ring_buffer_record_enable_cpu(struct ring_buffer *buffer, int cpu);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ffb43cbc5c13..b386830b4d51 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3237,7 +3237,7 @@ bool ring_buffer_record_is_on(struct ring_buffer *buffer)
  * ring_buffer_record_disable(), as that is a temporary disabling of
  * the ring buffer.
  */
-int ring_buffer_record_is_set_on(struct ring_buffer *buffer)
+bool ring_buffer_record_is_set_on(struct ring_buffer *buffer)
 {
 	return !(atomic_read(&buffer->record_disabled) & RB_BUFFER_OFF);
 }
-- 
2.18.0


