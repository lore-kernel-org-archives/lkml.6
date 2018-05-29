Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933549AbeE2Ly1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933158AbeE2LyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:54:25 -0400
Message-Id: <20180529115329.698052604@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 07:53:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] [GIT PULL] tracing: Two bug fixes that deal with triggers and instances
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

While writing selftests for a new feature, I triggered two existing
bugs that deal with triggers and instances.

 The first is a generic trigger bug where the triggers are not removed
 from a link list properly when deleting an instance.

 The second is specific to snapshots, where the snapshot is does the
 snapshot to the top level buffer, when it is suppose to snapshot the
 buffer associated to the instance the snapshot trigger exists in.

Please pull the latest trace-v4.17-rc4-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.17-rc4-3

Tag SHA1: ef8f65e0fe9fbb92f16cd29b6b77da146338b648
Head SHA1: 2824f5033248600673e3e126a4d135363cbfd9ac


Steven Rostedt (VMware) (2):
      tracing: Fix crash when freeing instances with event triggers
      tracing: Make the snapshot trigger work with instances

----
 kernel/trace/trace.c                | 12 ++++++------
 kernel/trace/trace.h                | 11 +++++++++++
 kernel/trace/trace_events_trigger.c | 15 +++++++++++----
 3 files changed, 28 insertions(+), 10 deletions(-)
