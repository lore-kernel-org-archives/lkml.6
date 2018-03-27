Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeC0WoN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:44:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752204AbeC0WoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:44:11 -0400
Subject: [PATCH net-next 0/6] rxrpc: Fixes
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2018 23:44:05 +0100
Message-ID: <152219064515.24098.9428175357244257284.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are six patches for AF_RXRPC:

 (1) Fix the use of VERSION packets to keep firewall routes open.

 (2) Fix the incorrect current time usage in a tracepoint.

 (3) Fix Tx ring annotation corruption.

 (4) Fix accidental conversion of call-level abort into connection-level
     abort.

 (5) Fix calculation of resend time.

 (6) Remove a couple of unused variables.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-fixes-20180327

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David
---
David Howells (4):
      rxrpc: Fix firewall route keepalive
      rxrpc: Fix a bit of time confusion
      rxrpc: Fix Tx ring annotation after initial Tx failure
      rxrpc: Don't treat call aborts as conn aborts

Marc Dionne (1):
      rxrpc: Fix resend event time calculation

Sebastian Andrzej Siewior (1):
      rxrpc: remove unused static variables


 net/rxrpc/af_rxrpc.c    |    4 ++
 net/rxrpc/ar-internal.h |   14 ++++++-
 net/rxrpc/call_event.c  |    4 +-
 net/rxrpc/conn_event.c  |    3 +
 net/rxrpc/input.c       |   17 +++++---
 net/rxrpc/net_ns.c      |   21 ++++++++++
 net/rxrpc/output.c      |   59 ++++++++++++++++++++++++++++-
 net/rxrpc/peer_event.c  |   96 +++++++++++++++++++++++++++++++++++++++++++++++
 net/rxrpc/peer_object.c |    7 +++
 net/rxrpc/rxkad.c       |    2 +
 net/rxrpc/security.c    |    3 -
 net/rxrpc/sendmsg.c     |    4 +-
 12 files changed, 218 insertions(+), 16 deletions(-)
