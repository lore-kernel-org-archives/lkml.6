Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38919C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4345208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4345208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756347AbeFPCLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 22:11:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50350 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbeFPCLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 22:11:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fU0gf-0001sO-Cl; Sat, 16 Jun 2018 02:11:33 +0000
Date:   Sat, 16 Jun 2018 03:11:33 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git - more aio followups
Message-ID: <20180616021133.GL30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Assorted AIO followups and fixes.

The following changes since commit 9a6d9a62e0fd4b9927c3124db0f25fc6b4fb6576:

  fs: aio ioprio use ioprio_check_cap ret val (2018-06-04 14:20:39 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.aio

for you to fetch changes up to 11c5ad0ec441129adef42c16bbd5139707a8c5b6:

  eventpoll: switch to ->poll_mask (2018-06-14 20:09:28 -0400)

----------------------------------------------------------------
Avi Kivity (2):
      aio: mark __aio_sigset::sigmask const
      eventfd: only return events requested in poll_mask()

Ben Noordhuis (1):
      eventpoll: switch to ->poll_mask

Christoph Hellwig (1):
      aio: only return events requested in poll_mask() for IOCB_CMD_POLL

 fs/aio.c                     |  4 ++--
 fs/eventfd.c                 |  4 ++--
 fs/eventpoll.c               | 15 ++++++++++-----
 include/uapi/linux/aio_abi.h |  2 +-
 4 files changed, 15 insertions(+), 10 deletions(-)
