Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeAaPst (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:48:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:40248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932066AbeAaPss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:48:48 -0500
Date: Wed, 31 Jan 2018 16:48:46 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 4.16
Message-ID: <nycvar.YFH.7.76.1801311638380.11852@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/livepatching.git for-linus

to receive livepatching updates for 4.16:

=====
- handling of 'infinitely'-long sleeping tasks, from Miroslav Benes
- removal of 'immediate' feature, as it turns out it doesn't provide
  the originally expected semantics, and brings more issues than value
=====

Thanks.

----------------------------------------------------------------
Miroslav Benes (4):
      livepatch: send a fake signal to all blocking tasks
      livepatch: force transition to finish
      livepatch: Remove immediate feature
      livepatch: add locking to force and signal functions

 Documentation/ABI/testing/sysfs-kernel-livepatch |  26 +++++
 Documentation/livepatch/livepatch.txt            | 114 ++++++++++------------
 arch/powerpc/kernel/signal.c                     |   6 +-
 arch/x86/entry/common.c                          |   6 +-
 include/linux/livepatch.h                        |   4 -
 kernel/livepatch/core.c                          |  76 ++++++++++++---
 kernel/livepatch/transition.c                    | 116 +++++++++++++++--------
 kernel/livepatch/transition.h                    |   2 +
 kernel/signal.c                                  |   4 +-
 samples/livepatch/livepatch-callbacks-demo.c     |  15 ---
 samples/livepatch/livepatch-sample.c             |  15 ---
 samples/livepatch/livepatch-shadow-fix1.c        |  15 ---
 samples/livepatch/livepatch-shadow-fix2.c        |  15 ---
 13 files changed, 227 insertions(+), 187 deletions(-)

-- 
Jiri Kosina
SUSE Labs
