Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C0CC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 22:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C81A24D58
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 22:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C81A24D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeFWWmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 18:42:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52065 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeFWWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 18:42:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fWrEO-0000pQ-Vb; Sat, 23 Jun 2018 22:42:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: make afs_volume_record_life static and remove afs_volume_gc_delay
Date:   Sat, 23 Jun 2018 23:42:08 +0100
Message-Id: <20180623224208.7141-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable afs_volume_record_life is local to the source and does not need
to be in global scope, so make it static.  Variable afs_volume_gc_delay
is not referenced at all in the source, it is unused and can be removed.

Cleans up sparse warnings:
symbol 'afs_volume_gc_delay' was not declared. Should it be static?
symbol 'afs_volume_record_life' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/afs/volume.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 7adcddf02e66..f924ead1c7a1 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -13,8 +13,7 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-unsigned __read_mostly afs_volume_gc_delay = 10;
-unsigned __read_mostly afs_volume_record_life = 60 * 60;
+static unsigned __read_mostly afs_volume_record_life = 60 * 60;
 
 static const char *const afs_voltypes[] = { "R/W", "R/O", "BAK" };
 
-- 
2.17.0

