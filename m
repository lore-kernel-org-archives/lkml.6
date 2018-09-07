Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654F42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654F42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeIGVcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:32:55 -0400
Received: from nautica.notk.org ([91.121.71.147]:38067 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbeIGVcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:32:55 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7BDBDC009; Fri,  7 Sep 2018 18:51:07 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 0/4] 9p coverity fixes
Date:   Fri,  7 Sep 2018 18:50:53 +0200
Message-Id: <1536339057-21974-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

Since we already had one coverity fix for 9p, I figured I could request
an account and look at stuff that actually could matter.

The leak of glock.client_id wasn't found by coverity but when I was
looking at a false positive there, of the rest the rdma one is useless
but the other two are pretty important -- I will probably mark the three
useful ones to backport to stable kernels.

As usual, comments more than welcome, but I'll probably push them to
linux-next along with the other patches that need test after testing the
whole batch together next week.


Dominique Martinet (4):
  9p: acl: fix uninitialized iattr access
  9p/rdma: remove useless check in cm_event_handler
  9p: p9dirent_read: check network-provided name length
  9p locks: fix glock.client_id leak in do_lock

 fs/9p/acl.c         |  2 +-
 fs/9p/vfs_file.c    | 16 ++++++++++++++--
 net/9p/protocol.c   | 12 +++++++++---
 net/9p/trans_rdma.c |  3 +--
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.17.1

