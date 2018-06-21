Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03831C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71DF22532
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Eivj13/Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GKVaqIyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71DF22532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933958AbeFUXPx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:15:53 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34991 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933729AbeFUXPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:15:50 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B43621D1E;
        Thu, 21 Jun 2018 19:15:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 19:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4nti1a0Q8uBjJP8q+
        VZ/JychP8e5B5x42BlssWtnEQw=; b=Eivj13/YL1nsokKylNh8LAKUDIIM5IDTV
        stZa+12dJP+kzPYFJYc6NdYY4O929mK0fP5UKgdvn+S9vd9zLVVJc1Jc680cXtOk
        c6H0dQpuRVNRqx4Xk/ZVs8eLrWaeKYjErwqpRiOnIVLWTtjH9GRzy6yulIoLFBkB
        jej8oSCBjQqPdoLWzxm02NTtfi+Y1NaHasMcwcrhJJKzD6gkVw93oZX7hEfQdvRz
        sQmNl6f6jKh7F1yWx98w72t7hGecsW7iVc2KihAQxPW/fnye7u9zZxf3NpmKVnLG
        +sQpDxl0gY3+F7pkVvhFvXfcuneVmEZex+l7mBxweGaj2d9L5TCcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=4nti1a0Q8uBjJP8q+VZ/JychP8e5B5x42BlssWtnEQw=; b=GKVaqIyH
        G8/JifqERqPzwnYwcGMvoRg7lPfWIOxUsOBZ45WccRe6svTLV1KlMDFapoPFjWPq
        SfvKz8Xup35UZXsjtFfC4fuQOkE4BHEDJ/6xanoq6/rIAvJGgdYt/eayhYFHOOFT
        bMdh+9hmQHzlSvpLUTye+a/HPckBPipbTrkNDKskIrCDrO7q04d+12ngWLhgyGHv
        y2BokUFN+B8eIof1hJRbo+8vAPTdmdIPy4aavzQhY4VQyH0IgcSen6ZGfOZfpD3l
        XaVH7V36PBtDFpwxZbNyeJO3RMigAiLg5JgFWGJqZ6LBF/QTvCEiPeoco9Nilma6
        ZpVe0IYUVsgp/w==
X-ME-Proxy: <xmx:pjEsW_3_aqdgf53hnO1D1nY0mjpiIgtTUfOgkd8c6ZnZ0_nld-T11w>
    <xmx:pjEsW57L6twlM3zpoSCc6FOqw4Bze_kimvM5sZjfZKuWR_O8jiXh1A>
    <xmx:pjEsW3PUbfdtIuvoYNC9YDMQPisjhkOVhStkgxmh1URgDC-X76lYCQ>
    <xmx:pjEsW4GqMZiYq6wKqTFzZQXG0-qTt9MDUHShhPiFU1IwRXT-GENcuw>
    <xmx:pjEsW8wwc0MLgA8ljp6kpI6UyuCFYuuzflNsXOHiQUFDintolVqbkw>
    <xmx:pjEsWzHcCZTD6V8VBr5vE1SklL0y3iIyElYB0OZcXs394FA0mnc0Cw>
X-ME-Sender: <xms:pTEsW6M3M4eY6obijP4qikW7GsX7kfVc_icYehS9wSvFOsER3Omp4A>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B1D8E4329;
        Thu, 21 Jun 2018 19:15:49 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/4] random: Fix whitespace pre random-bytes work
Date:   Fri, 22 Jun 2018 09:15:31 +1000
Message-Id: <20180621231534.32278-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621231534.32278-1-me@tobin.cc>
References: <20180621231534.32278-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of whitespace issues around the function
get_random_bytes_arch().  In preparation for patching this function
let's clean them up.

Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/char/random.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a8fb0020ba5c..ed679099afba 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1736,7 +1736,7 @@ void get_random_bytes_arch(void *buf, int nbytes)
 
 		if (!arch_get_random_long(&v))
 			break;
-		
+
 		memcpy(p, &v, chunk);
 		p += chunk;
 		nbytes -= chunk;
@@ -1747,7 +1747,6 @@ void get_random_bytes_arch(void *buf, int nbytes)
 }
 EXPORT_SYMBOL(get_random_bytes_arch);
 
-
 /*
  * init_std_data - initialize pool with system data
  *
-- 
2.17.1

