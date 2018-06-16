Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E921C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BFE2075A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BFE2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756835AbeFPCOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 22:14:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50406 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbeFPCOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 22:14:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fU0jk-0001wO-OP; Sat, 16 Jun 2018 02:14:44 +0000
Date:   Sat, 16 Jun 2018 03:14:44 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git - misc compat stuff
Message-ID: <20180616021444.GM30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Some biarch patches - getting rid of assorted compat_alloc_user_space()
(mis)uses.  Not much in that area this cycle...

The following changes since commit 4faa99965e027cc057c5145ce45fa772caa04e8d:

  fix io_destroy()/aio_complete() race (2018-05-23 22:53:22 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.compat

for you to fetch changes up to 430ff79170d877c1602acb5a3701453dfa36b566:

  orangefs: simplify compat ioctl handling (2018-06-15 00:23:55 -0400)

----------------------------------------------------------------
Al Viro (3):
      vmsplice(): lift importing iovec into vmsplice(2) and compat counterpart
      signalfd: lift sigmask copyin and size checks to callers of do_signalfd4()
      orangefs: simplify compat ioctl handling

 fs/orangefs/devorangefs-req.c |  54 ++++------------
 fs/signalfd.c                 |  50 +++++++--------
 fs/splice.c                   | 144 ++++++++++++++++++++++--------------------
 3 files changed, 112 insertions(+), 136 deletions(-)
