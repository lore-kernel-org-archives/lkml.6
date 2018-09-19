Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B64CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDDB2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1bwH0EV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDDB2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbeITBaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:30:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47033 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeITBaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:30:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so7000946wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3jLnzS/g+OYEnXwzSMpP5SGDmKTj9odkfUKJjvIUHo=;
        b=P1bwH0EV6F3yztaP6jI3KY5mqwtVxHD6oQ4O0VL9SrhJ+6RrC8T+W6xjIzbkCIkE2k
         Ec6yPkOFeh+qvJrd+wbrHXS8WTbaQ9yOWTkN/ZGJDnmDGRDjnaWyBVrR95qJlRj7frsy
         ga/aggd0UtlWe///bZbxIx8XxIOxOYCnVdCkx/0BAufhpcBbPhwhGwGI+tCP5XpyHYhC
         WeuSsKCNr7bPuyMS+NMYNT1j2yj4/6s+D6KOYrUJ9CSOU/GC61dIwm4gCTPkn1GvjcKR
         no5IxEeVEBXdPTMEKwbGFCrBF4j4yISX9LtIAYrXWatvfYrscpr0BUajlUt+ofSZ3mHA
         wjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3jLnzS/g+OYEnXwzSMpP5SGDmKTj9odkfUKJjvIUHo=;
        b=ArUQNM5Q0a6hZG3lxVf1H1eMYgUq+Fc9RO2MqnJtV8HIKiMGp26bzl+hWxu+wuXZ+m
         sU+Td1PDxVtP+WoG3Qm42LeyIaPBgw28WHf5S3Kv7fNI2d4iSM0cusMNa9I49oWzK7S3
         iHrxopyDUfRaIBE97LZ7gX+1E9lpTIsZcdYRRAhRvHF8krVlwfe4jjer/Qo356ZZJbIs
         o+OuLNr1eEHaMIldzUR9OsEJeUxyDbyNwdSN2CwfKCuLuBJIcK6E8hBUDqUEiY4AL3uB
         g18flO7M31gYpXr8xnm73hLquZ68IiR/J4pciBtXx0TQkZlQ2j96hWCu/OZCEmtwztWT
         qtaA==
X-Gm-Message-State: APzg51B4bh1aFf4BKrM4xWpD5BNh5lCAvgyjLOADGZ9/1ne4ns1OKefC
        z/MkeVUXhOA7x9r6hrKhjQ0=
X-Google-Smtp-Source: ANB0VdYDbVMd6E/Vt3NZcfIKwf+xArpQ7OkCNLN9GdmZ8D4Fk0gVZ7Bd2jSHlwK+vt2GkB6ru28vtg==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr31088278wro.263.1537386656276;
        Wed, 19 Sep 2018 12:50:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w94-v6sm7408025wrc.38.2018.09.19.12.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 12:50:54 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] misc: mic: scif: Remove unused variable
Date:   Wed, 19 Sep 2018 12:50:22 -0700
Message-Id: <20180919195022.23724-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a variable is assigned to itself.

drivers/misc/mic/scif/scif_dma.c:1577:12: warning: explicitly assigning
value of variable of type 'bool' (aka '_Bool') to itself [-Wself-assign]
        dst_local = dst_local;
        ~~~~~~~~~ ^ ~~~~~~~~~
1 warning generated.

This is usually done to avoid an unused variable warning, which is the
case here. dst_local is used nowhere in this function, which has been
the case since the initial code drop in commit 7cc31cd27752 ("misc: mic:
SCIF DMA and CPU copy interface") in 2015. Just remove the variable, it
can be added back if it was intended to be used.

Link: https://github.com/ClangBuiltLinux/linux/issues/107
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/misc/mic/scif/scif_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_dma.c b/drivers/misc/mic/scif/scif_dma.c
index 6369aeaa7056..03af8b5b7b0d 100644
--- a/drivers/misc/mic/scif/scif_dma.c
+++ b/drivers/misc/mic/scif/scif_dma.c
@@ -1553,7 +1553,7 @@ static int scif_rma_list_dma_copy_wrapper(struct scif_endpt *epd,
 	int src_cache_off, dst_cache_off;
 	s64 src_offset = work->src_offset, dst_offset = work->dst_offset;
 	u8 *temp = NULL;
-	bool src_local = true, dst_local = false;
+	bool src_local = true;
 	struct scif_dma_comp_cb *comp_cb;
 	dma_addr_t src_dma_addr, dst_dma_addr;
 	int err;
@@ -1572,9 +1572,7 @@ static int scif_rma_list_dma_copy_wrapper(struct scif_endpt *epd,
 	src_dma_addr = __scif_off_to_dma_addr(work->src_window, src_offset);
 	dst_dma_addr = __scif_off_to_dma_addr(work->dst_window, dst_offset);
 	src_local = work->src_window->type == SCIF_WINDOW_SELF;
-	dst_local = work->dst_window->type == SCIF_WINDOW_SELF;
 
-	dst_local = dst_local;
 	/* Allocate dma_completion cb */
 	comp_cb = kzalloc(sizeof(*comp_cb), GFP_KERNEL);
 	if (!comp_cb)
-- 
2.19.0

