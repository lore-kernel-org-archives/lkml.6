Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbeDAUnO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753918AbeDAUnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:11 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 29/45] C++: Move the print_line_t enum before first use
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:09 +0100
Message-ID: <152261538985.30503.55319175500721372.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the print_line_t enum definition to before its first use.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/trace_events.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a1442c4e513..38a7667827ca 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -104,6 +104,14 @@ struct trace_iterator {
 	/* All new field here will be zeroed out in pipe_read */
 };
 
+/* Return values for print_line callback */
+enum print_line_t {
+	TRACE_TYPE_PARTIAL_LINE	= 0,	/* Retry after flushing the seq */
+	TRACE_TYPE_HANDLED	= 1,
+	TRACE_TYPE_UNHANDLED	= 2,	/* Relay to other output functions */
+	TRACE_TYPE_NO_CONSUME	= 3	/* Handled but ask to not consume */
+};
+
 enum trace_iter_flags {
 	TRACE_FILE_LAT_FMT	= 1,
 	TRACE_FILE_ANNOTATE	= 2,
@@ -131,14 +139,6 @@ struct trace_event {
 extern int register_trace_event(struct trace_event *event);
 extern int unregister_trace_event(struct trace_event *event);
 
-/* Return values for print_line callback */
-enum print_line_t {
-	TRACE_TYPE_PARTIAL_LINE	= 0,	/* Retry after flushing the seq */
-	TRACE_TYPE_HANDLED	= 1,
-	TRACE_TYPE_UNHANDLED	= 2,	/* Relay to other output functions */
-	TRACE_TYPE_NO_CONSUME	= 3	/* Handled but ask to not consume */
-};
-
 enum print_line_t trace_handle_return(struct trace_seq *s);
 
 void tracing_generic_entry_update(struct trace_entry *entry,
