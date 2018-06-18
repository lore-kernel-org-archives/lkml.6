Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32B9C5CFC2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA9120862
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA9120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965311AbeFRKJ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:09:28 -0400
Received: from zulu.geekplace.eu ([5.45.100.158]:42950 "EHLO zulu.geekplace.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934786AbeFRKJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:09:23 -0400
Received: from flo-ubook.informatik.uni-erlangen.de (flowubook.informatik.uni-erlangen.de [131.188.34.88])
        by zulu.geekplace.eu (Postfix) with ESMTPA id 3F1B34A17C1;
        Mon, 18 Jun 2018 12:09:17 +0200 (CEST)
From:   Florian Schmaus <flo@geekplace.eu>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org
Cc:     Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] bcache: Fix variable assignment in if condition in super.c
Date:   Mon, 18 Jun 2018 12:08:59 +0200
Message-Id: <20180618100902.4015-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set attempts to improve bcache's super.c code by moving the
assignment of variables out of 'if' conditions. It does not address
all occurences of this style issue (which is reported as error by
checkpatch.pl).

Florian Schmaus (3):
  bcache: do not assign in if condition register_bcache()
  bcache: do not assign in if condition in bcache_init()
  bcache: do not assign in if condition in bcache_device_init()

 drivers/md/bcache/super.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

-- 
2.16.4

