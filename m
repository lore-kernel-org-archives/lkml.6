Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeC0W54 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:57:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752258AbeC0W5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:57:52 -0400
Subject: [PATCH net-next 0/3] rxrpc: Tracing updates
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2018 23:57:50 +0100
Message-ID: <152219147024.24730.12727053395895392426.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are some patches that update tracing in AF_RXRPC and AFS:

 (1) Add a tracepoint for tracking resend events.

 (2) Use debug_ids in traces rather than pointers (as pointers are now hashed)
     and allow use of the same debug_id in AFS calls as in the corresponding
     AF_RXRPC calls.  This makes filtering the trace output much easier.

 (3) Add a tracepoint for tracking call completion.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-next-20180327

and can also be found on this branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-next

David
---
David Howells (3):
      rxrpc: Trace resend
      rxrpc, afs: Use debug_ids rather than pointers in traces
      rxrpc: Trace call completion


 fs/afs/internal.h            |    1 
 fs/afs/rxrpc.c               |   12 ++
 include/net/af_rxrpc.h       |   11 ++
 include/trace/events/afs.h   |   69 ++++++--------
 include/trace/events/rxrpc.h |  206 +++++++++++++++++++++++++++---------------
 net/rxrpc/af_rxrpc.c         |    7 +
 net/rxrpc/ar-internal.h      |    9 +-
 net/rxrpc/call_accept.c      |   18 ++--
 net/rxrpc/call_event.c       |    1 
 net/rxrpc/call_object.c      |   15 ++-
 net/rxrpc/conn_event.c       |    3 -
 net/rxrpc/input.c            |    6 +
 net/rxrpc/sendmsg.c          |    3 -
 13 files changed, 219 insertions(+), 142 deletions(-)
