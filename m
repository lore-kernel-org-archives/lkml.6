Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754183AbeD3XUY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:20:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752614AbeD3XUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:20:23 -0400
Subject: [PATCH 0/3] afs: Network-namespacing and proc
From: David Howells <dhowells@redhat.com>
To: hch@lst.de
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 01 May 2018 00:20:20 +0100
Message-ID: <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk>
In-Reply-To: <20180425154827.32251-22-hch@lst.de>
References: <20180425154827.32251-22-hch@lst.de>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Christoph,

Can you drop your "afs: simplify procfs code" patch please and replace with
these three?  The patches are:

 (1) Rearrange fs/afs/proc.c to get rid of the forward declarations and
     simplify the commenting.

 (2) Supply functions that allow writable net proc files to be created (this
     could be extended to provide writing on non-net proc files).

 (3) Implement network namespacing in AFS and simplify the proc usage, using
     the new convenience functions provided.

David
---
David Howells (3):
      afs: Rearrange fs/afs/proc.c
      proc: Add a way to make network proc files writable
      afs: Implement namespacing


 fs/afs/cell.c           |    4 
 fs/afs/cmservice.c      |    2 
 fs/afs/internal.h       |   43 +-
 fs/afs/main.c           |   33 +-
 fs/afs/netdevices.c     |    6 
 fs/afs/proc.c           |  881 +++++++++++++++--------------------------------
 fs/afs/rxrpc.c          |    2 
 fs/afs/super.c          |   20 +
 fs/proc/generic.c       |   24 +
 fs/proc/internal.h      |    2 
 fs/proc/proc_net.c      |   92 +++++
 include/linux/proc_fs.h |   12 +
 12 files changed, 487 insertions(+), 634 deletions(-)
