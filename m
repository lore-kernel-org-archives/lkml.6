Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835306-2-10998927333106496498
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835306; b=FqW4aufIuQ9NvqVHKXBukZ7sfqdFm/KmTBXlpq8iOjUKb0m
    tMjR+3H5XAyMjGiZXF0JgBr52oIEOQGG6G8qpkIgSh51gFPG0bU5Vht/86AQmQ9r
    My+X/uENB/WidrRv5lwAcrtNdOU5qk4AZ+Epv+Va7tcTn6xz54lCnPvBYHU8SlF7
    v906104XDnl/SwbUF/otxjMzpqAO3qZRnmHMYG0Ef1qPt8vZrBkGCujXlyoHgg7h
    ibtNQVt6Gb1759wSVjkllqwK9prjEVwHPPVsh7Css/dyuFKbrKlRYN2PxJ7a68zg
    b7dV7C2A6W8ehuget6ZvDAKMGMOPUi95KOjiNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835306; bh=zoL0afuUrC8dAF6hvoz
    Fo1ekGZyMEYIXdwP5cLM5zhc=; b=rXcZ7dp0NhqMz9cxCjUhelfVLG1zUgJ/CFl
    +ZZUloKYnI0x5AZxz29vHws+JQu2iiIegrMgbwnfV8eRgBEmxbidhQDAuXXNdT/o
    QkP4iOfwxdIq58KozqnF0nfMAepTho85x5jctCH9yMYM2xyP509BLo2Y4wXyxVXz
    +j1sLO2g6DqlAwUbNob0VdrX2CG/+ZK1YMaW1UlSlEtceVJNv4sloM14gtFHm+Eb
    4SkCreI0hMau7QGffV8N4eN1cEH7cAwD2wNLQsHbSiCDTBW369oUXnO6bBFSvGnA
    ZgDruyAUS/RWiVmtDEX9+0iP3QhB+NAUNCccjwJUCu7x1PS+60Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbeB1QPq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:15:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35196 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934483AbeB1QPn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Chunyan Zhang" <chunyan.zhang@spreadtrum.com>,
        "Jing Xia" <jing.xia@spreadtrum.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.965122671@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 145/254] tracing: Fix crash when it fails to alloc
 ring buffer
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jing Xia <jing.xia@spreadtrum.com>

commit 24f2aaf952ee0b59f31c3a18b8b36c9e3d3c2cf5 upstream.

Double free of the ring buffer happens when it fails to alloc new
ring buffer instance for max_buffer if TRACER_MAX_TRACE is configured.
The root cause is that the pointer is not set to NULL after the buffer
is freed in allocate_trace_buffers(), and the freeing of the ring
buffer is invoked again later if the pointer is not equal to Null,
as:

instance_mkdir()
    |-allocate_trace_buffers()
        |-allocate_trace_buffer(tr, &tr->trace_buffer...)
	|-allocate_trace_buffer(tr, &tr->max_buffer...)

          // allocate fail(-ENOMEM),first free
          // and the buffer pointer is not set to null
        |-ring_buffer_free(tr->trace_buffer.buffer)

       // out_free_tr
    |-free_trace_buffers()
        |-free_trace_buffer(&tr->trace_buffer);

	      //if trace_buffer is not null, free again
	    |-ring_buffer_free(buf->buffer)
                |-rb_free_cpu_buffer(buffer->buffers[cpu])
                    // ring_buffer_per_cpu is null, and
                    // crash in ring_buffer_per_cpu->pages

Link: http://lkml.kernel.org/r/20171226071253.8968-1-chunyan.zhang@spreadtrum.com

Fixes: 737223fbca3b1 ("tracing: Consolidate buffer allocation code")
Signed-off-by: Jing Xia <jing.xia@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6243,7 +6243,9 @@ static int allocate_trace_buffers(struct
 				    allocate_snapshot ? size : 1);
 	if (WARN_ON(ret)) {
 		ring_buffer_free(tr->trace_buffer.buffer);
+		tr->trace_buffer.buffer = NULL;
 		free_percpu(tr->trace_buffer.data);
+		tr->trace_buffer.data = NULL;
 		return -ENOMEM;
 	}
 	tr->allocated_snapshot = allocate_snapshot;
