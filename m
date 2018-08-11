Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F63C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93A921A1C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93A921A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeHKQ0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeHKQYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECAA121B31;
        Sat, 11 Aug 2018 13:50:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHX-0006BX-1Z; Sat, 11 Aug 2018 09:50:15 -0400
Message-Id: <20180811135014.945362351@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 22/34] ring-buffer: Make ring_buffer_record_is_on() return bool
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The value of ring_buffer_record_is_on() is either true or false, so have its
return value be bool.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h | 2 +-
 kernel/trace/ring_buffer.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 003d09ab308d..5176124fc4ba 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -164,7 +164,7 @@ void ring_buffer_record_disable(struct ring_buffer *buffer);
 void ring_buffer_record_enable(struct ring_buffer *buffer);
 void ring_buffer_record_off(struct ring_buffer *buffer);
 void ring_buffer_record_on(struct ring_buffer *buffer);
-int ring_buffer_record_is_on(struct ring_buffer *buffer);
+bool ring_buffer_record_is_on(struct ring_buffer *buffer);
 int ring_buffer_record_is_set_on(struct ring_buffer *buffer);
 void ring_buffer_record_disable_cpu(struct ring_buffer *buffer, int cpu);
 void ring_buffer_record_enable_cpu(struct ring_buffer *buffer, int cpu);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0b0b688ea166..ffb43cbc5c13 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3221,7 +3221,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_record_on);
  *
  * Returns true if the ring buffer is in a state that it accepts writes.
  */
-int ring_buffer_record_is_on(struct ring_buffer *buffer)
+bool ring_buffer_record_is_on(struct ring_buffer *buffer)
 {
 	return !atomic_read(&buffer->record_disabled);
 }
-- 
2.18.0


