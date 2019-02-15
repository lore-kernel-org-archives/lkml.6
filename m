Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B889C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EC321A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfBOOVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfBOOVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:21:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5EEB2192D;
        Fri, 15 Feb 2019 14:21:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gueMb-00069u-QG; Fri, 15 Feb 2019 09:21:13 -0500
Message-Id: <20190215142015.860423791@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 15 Feb 2019 09:20:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] [GIT PULL] tracing: Two more fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Two more tracing fixes

 - Have kprobes not use copy_from_user to access kernel addresses
   as this is now considered a security issue.

 - Put back the entries counter in the tracing output that was accidentally
   removed.

Please pull the latest trace-v5.0-rc4-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.0-rc4-2

Tag SHA1: bf7473622f886c893f828195c0e7febc0b6c7e1f
Head SHA1: 177a0fd380f825734f0307d6c5d4da5a0a9445ce


Changbin Du (1):
      kprobe: Do not use uaccess functions to access kernel memory

Quentin Perret (1):
      tracing: Fix number of entries in trace header

----
 kernel/trace/trace.c        |  2 ++
 kernel/trace/trace_kprobe.c | 10 +---------
 2 files changed, 3 insertions(+), 9 deletions(-)
