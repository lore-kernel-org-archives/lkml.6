Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33714C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51FB218CD
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51FB218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeHMBgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 21:36:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34806 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeHMBgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 21:36:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fozI9-0002NL-HN; Sun, 12 Aug 2018 22:56:57 +0000
Date:   Sun, 12 Aug 2018 23:56:57 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] Christoph's aio poll, saner this time around
Message-ID: <20180812225657.GP6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This time it's pretty much local to fs/aio.c.  Hopefully race-free...

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.aio

for you to fetch changes up to e8693bcfa0b4a56268946f0756153d942cb66cf7:

  aio: allow direct aio poll comletions for keyed wakeups (2018-08-06 10:24:39 +0200)

----------------------------------------------------------------
Christoph Hellwig (4):
      timerfd: add support for keyed wakeups
      aio: add a iocb refcount
      aio: implement IOCB_CMD_POLL
      aio: allow direct aio poll comletions for keyed wakeups

 fs/aio.c                     | 208 ++++++++++++++++++++++++++++++++++++++++++-
 fs/timerfd.c                 |   6 +-
 include/uapi/linux/aio_abi.h |   6 +-
 3 files changed, 209 insertions(+), 11 deletions(-)
