Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935547AbeE2PZN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935593AbeE2PXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:35 -0400
Message-Id: <20180529152328.651823046@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        One-of-those-commiters@YouKnowWhoYouAre.org
Subject: [for-next][PATCH 18/19] ring-buffer: Fix a bunch of typos in comments
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0018-ring-buffer-Fix-a-bunch-of-typos-in-comments.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

An anonymous source sent me a bunch of typo fixes in the comments of
ring_buffer.c file. That source did not want to be associated to this patch
because they don't want to be known as "one of those" commiters (you know who
you are!). They gave me permission to sign this off in my own name.

Suggested-by: One-of-those-commiters@YouKnowWhoYouAre.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c9cb9767d49b..6a46af21765c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -809,7 +809,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_normalize_time_stamp);
  *
  *  You can see, it is legitimate for the previous pointer of
  *  the head (or any page) not to point back to itself. But only
- *  temporarially.
+ *  temporarily.
  */
 
 #define RB_PAGE_NORMAL		0UL
@@ -906,7 +906,7 @@ static void rb_list_head_clear(struct list_head *list)
 }
 
 /*
- * rb_head_page_dactivate - clears head page ptr (for free list)
+ * rb_head_page_deactivate - clears head page ptr (for free list)
  */
 static void
 rb_head_page_deactivate(struct ring_buffer_per_cpu *cpu_buffer)
@@ -1780,7 +1780,7 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 
 		put_online_cpus();
 	} else {
-		/* Make sure this CPU has been intitialized */
+		/* Make sure this CPU has been initialized */
 		if (!cpumask_test_cpu(cpu_id, buffer->cpumask))
 			goto out;
 
@@ -2325,7 +2325,7 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 
 	/*
 	 * If we need to add a timestamp, then we
-	 * add it to the start of the resevered space.
+	 * add it to the start of the reserved space.
 	 */
 	if (unlikely(info->add_timestamp)) {
 		bool abs = ring_buffer_time_stamp_abs(cpu_buffer->buffer);
@@ -2681,7 +2681,7 @@ trace_recursive_unlock(struct ring_buffer_per_cpu *cpu_buffer)
  * ring_buffer_nest_start - Allow to trace while nested
  * @buffer: The ring buffer to modify
  *
- * The ring buffer has a safty mechanism to prevent recursion.
+ * The ring buffer has a safety mechanism to prevent recursion.
  * But there may be a case where a trace needs to be done while
  * tracing something else. In this case, calling this function
  * will allow this function to nest within a currently active
@@ -2699,7 +2699,7 @@ void ring_buffer_nest_start(struct ring_buffer *buffer)
 	preempt_disable_notrace();
 	cpu = raw_smp_processor_id();
 	cpu_buffer = buffer->buffers[cpu];
-	/* This is the shift value for the above recusive locking */
+	/* This is the shift value for the above recursive locking */
 	cpu_buffer->nest += NESTED_BITS;
 }
 
@@ -2718,7 +2718,7 @@ void ring_buffer_nest_end(struct ring_buffer *buffer)
 	/* disabled by ring_buffer_nest_start() */
 	cpu = raw_smp_processor_id();
 	cpu_buffer = buffer->buffers[cpu];
-	/* This is the shift value for the above recusive locking */
+	/* This is the shift value for the above recursive locking */
 	cpu_buffer->nest -= NESTED_BITS;
 	preempt_enable_notrace();
 }
@@ -2907,7 +2907,7 @@ rb_reserve_next_event(struct ring_buffer *buffer,
  * @buffer: the ring buffer to reserve from
  * @length: the length of the data to reserve (excluding event header)
  *
- * Returns a reseverd event on the ring buffer to copy directly to.
+ * Returns a reserved event on the ring buffer to copy directly to.
  * The user of this interface will need to get the body to write into
  * and can use the ring_buffer_event_data() interface.
  *
@@ -3009,7 +3009,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
  * This function lets the user discard an event in the ring buffer
  * and then that event will not be read later.
  *
- * This function only works if it is called before the the item has been
+ * This function only works if it is called before the item has been
  * committed. It will try to free the event from the ring buffer
  * if another event has not been added behind it.
  *
@@ -4127,7 +4127,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
  * through the buffer.  Memory is allocated, buffer recording
  * is disabled, and the iterator pointer is returned to the caller.
  *
- * Disabling buffer recordng prevents the reading from being
+ * Disabling buffer recording prevents the reading from being
  * corrupted. This is not a consuming read, so a producer is not
  * expected.
  *
-- 
2.17.0
