Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC27C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917252084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfAKQUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:20:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:40482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727900AbfAKQUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:20:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFDBAAFE1;
        Fri, 11 Jan 2019 16:20:45 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/3] sysrq: Simple fixes and console visibility
Date:   Fri, 11 Jan 2019 17:20:35 +0100
Message-Id: <20190111162038.19771-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches are simple bug fixes.

The last one is RFC to fix a bug report. It is not obvious
why sysrq debug operations show only the sysrq header on
the console. The filtering by console_loglevel makes
some sense. The level can actually be set by sysrq.

The solution implemented in the RFC is a warning. It is a simple
idea but the implementation is relatively complicated. Mainly
because all parts sysrq, printk, and consoles are
heavily configurable.

PS: I sent the first patch also separately. It was simple
and it was independent in my first draft of the RFC.
I am sorry for confusion.


Petr Mladek (3):
  sysrq: Restore original console_loglevel when sysrq disabled
  sysrq: Remove duplicated sysrq message
  sysrq: Warn about insufficient console_loglevel

 drivers/tty/sysrq.c    | 34 ++++++++++++++++++++++++++++++----
 include/linux/printk.h |  7 +++++++
 kernel/printk/printk.c |  7 +++----
 3 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.13.7

