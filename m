Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69A8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9EE2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbeLTN1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:27:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:37972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729096AbeLTN1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:27:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E826B08F;
        Thu, 20 Dec 2018 13:27:41 +0000 (UTC)
Date:   Thu, 20 Dec 2018 14:27:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 4.21
Message-ID: <20181220132740.pl2apy5nmfhwmbqy@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-4.21

==================

- Keep spinlocks busted until the end of panic()

- Fix races between calculating number of messages that would fit
  into user space buffers, filling the buffers, and switching
  printk.time parameter

- Some code clean up

----------------------------------------------------------------
Sergey Senozhatsky (1):
      panic: avoid deadlocks in re-entrant console drivers

Tetsuo Handa (3):
      printk: Make printk_emit() local function.
      printk: fix printk_time race.
      printk: Remove print_prefix() calls with NULL buffer.

 include/linux/printk.h |   5 --
 kernel/panic.c         |   6 ++-
 kernel/printk/printk.c | 131 ++++++++++++++++++++++++-------------------------
 3 files changed, 68 insertions(+), 74 deletions(-)
