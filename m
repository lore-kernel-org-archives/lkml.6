Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83055ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442892084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442892084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbeGPRXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:23:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:54294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727618AbeGPRXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 720F6AF52;
        Mon, 16 Jul 2018 16:55:26 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Coly Li <colyli@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 1/4] lib/crc64: add crc64 option to lib/Kconfig
Date:   Tue, 17 Jul 2018 00:55:04 +0800
Message-Id: <20180716165507.23100-2-colyli@suse.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716165507.23100-1-colyli@suse.de>
References: <20180716165507.23100-1-colyli@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch adds crc64 option entry in lib/Kconfig. This patch is part of
a patch originally written by Andy Shevchenko, Coly Li cherry-picks it
and compose the commit log for a re-written crc64 source code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Coly Li <colyli@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
---
 lib/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 706836ec314d..4059df9ec4c7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -170,6 +170,14 @@ config CRC32_BIT
 
 endchoice
 
+config CRC64
+	tristate "CRC64 functions"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require CRC64 functions, but a module built outside
+	  the kernel tree does. Such modules that use library CRC64
+	  functions require M he
+
 config CRC4
 	tristate "CRC4 functions"
 	help
-- 
2.17.1

