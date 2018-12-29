Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C34C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A20D2176F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeL2NN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:13:58 -0500
Received: from mail.CARNet.hr ([161.53.123.6]:33507 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbeL2NN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:13:58 -0500
X-Greylist: delayed 1513 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Dec 2018 08:13:57 EST
Received: from cnzgrivvl-t440p.carpriv.carnet.hr ([161.53.12.131]:48060 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1gdE2i-0006To-8Y; Sat, 29 Dec 2018 13:48:40 +0100
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id EF86621B7C; Sat, 29 Dec 2018 13:48:39 +0100 (CET)
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Valentin Vidic <Valentin.Vidic@CARNet.hr>
Date:   Sat, 29 Dec 2018 13:48:29 +0100
Message-Id: <20181229124829.3745-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH] n_tty: update comment for WAKEUP_CHARS define
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give a better descriptions of what WAKEUP_CHARS represents.

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/tty/n_tty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3ad460219fd6..1dfbd45746da 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -50,8 +50,10 @@
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
 
-
-/* number of characters left in xmit buffer before select has we have room */
+/*
+ * Until this number of characters is queued in the xmit buffer, select will
+ * return "we have room for writes".
+ */
 #define WAKEUP_CHARS 256
 
 /*
-- 
2.20.1

