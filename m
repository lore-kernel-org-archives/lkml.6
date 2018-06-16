Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB51C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD232075A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD232075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965649AbeFPCPE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 22:15:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50412 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbeFPCPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 22:15:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fU0k2-0001x5-Ae; Sat, 16 Jun 2018 02:15:02 +0000
Date:   Sat, 16 Jun 2018 03:15:02 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git afs stuff from dhowells (mostly procfs followups)
Message-ID: <20180616021502.GN30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Assorted AFS stuff - ended up in vfs.git since most of that consists
of David's AFS-related followups to Christoph's procfs series.

The following changes since commit 96362fb474bad694812c18cbc9943fe0f7e2ce31:

  isdn/gigaset: add back gigaset_procinfo assignment (2018-05-17 19:59:55 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git afs-proc

for you to fetch changes up to 47ea0f2ebffd400d36ab5946ec8d6d6e08a67d53:

  afs: Optimise callback breaking by not repeating volume lookup (2018-06-15 15:27:09 +0100)

----------------------------------------------------------------
Al Viro (1):
      Merge tag 'afs-fixes-20180514' into afs-proc

David Howells (14):
      afs: Move /proc management functions to the end of the file
      afs: Rearrange fs/afs/proc.c by moving fops and open functions down
      afs: Rearrange fs/afs/proc.c to move the show routines up
      afs: Rearrange fs/afs/proc.c to remove remaining predeclarations.
      proc: Add a way to make network proc files writable
      afs: Fix a Sparse warning in xdr_decode_AFSFetchStatus()
      afs: Mark afs_net::ws_cell as __rcu and set using rcu functions
      afs: Implement network namespacing
      proc: Make inline name size calculation automatic
      afs: Handle CONFIG_PROC_FS=n
      afs: Show all of a server's addresses in /proc/fs/afs/servers
      afs: Enable IPv6 DNS lookups
      afs: Display manually added cells in dynamic root mount
      afs: Optimise callback breaking by not repeating volume lookup

 fs/afs/Makefile            |   4 +-
 fs/afs/addr_list.c         |  27 +-
 fs/afs/callback.c          | 194 ++++++++---
 fs/afs/cell.c              |  24 +-
 fs/afs/cmservice.c         |  69 ++--
 fs/afs/dir.c               |  54 ++-
 fs/afs/dynroot.c           | 126 ++++++-
 fs/afs/file.c              |   2 +-
 fs/afs/flock.c             |   6 +-
 fs/afs/fsclient.c          | 121 ++++---
 fs/afs/inode.c             |  19 +-
 fs/afs/internal.h          | 100 ++++--
 fs/afs/main.c              |  35 +-
 fs/afs/netdevices.c        |   6 +-
 fs/afs/proc.c              | 793 +++++++++++++++++----------------------------
 fs/afs/rotate.c            |  20 +-
 fs/afs/rxrpc.c             |  20 +-
 fs/afs/security.c          |   7 +-
 fs/afs/server.c            |  23 +-
 fs/afs/server_list.c       |   7 +-
 fs/afs/super.c             |  72 ++--
 fs/afs/write.c             |   2 +-
 fs/namei.c                 |  29 ++
 fs/proc/generic.c          |  26 +-
 fs/proc/inode.c            |   5 +-
 fs/proc/internal.h         |  20 +-
 fs/proc/proc_net.c         |  92 ++++++
 fs/proc/root.c             |   3 +-
 include/linux/namei.h      |   1 +
 include/linux/proc_fs.h    |  12 +
 include/trace/events/afs.h |  42 +++
 31 files changed, 1153 insertions(+), 808 deletions(-)
