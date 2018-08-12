Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FD1C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 07:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF2C21A5E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 07:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IexXBd9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF2C21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeHLJpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 05:45:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35689 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeHLJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 05:45:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10-v6so6177805pgv.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YBrcLRvJMlTXpJcW2Cg4qIRV5WwSfL/dJR2jgM0zSB0=;
        b=IexXBd9jaodGHjdXUblJpGBAKzGLiC+djOr3xq9bRr4EZ6SvaNgGTo1/n+HEjxKUrf
         xd20n/RcA+yleRcq5SpOdC4HkhYMXn7yg3dxR9HVKOfnetIWZY+uHVr7oiGNTfJ09csT
         4QxRcxZjO861hFn6U0TI7ewVXGIYhieoQs3goqK4jS5ly/xN2ehL7g15/we5ADV5+ENi
         93q/7kUBr8PO9Ub5VPHLCVh7Uu2v2SMcQogozL61nqNMEgoOLoUTFK/SF2CqoKGp4ylX
         nC4m7szAIIGdX1m5gLoZxeyEk8BIdI0rXJbCI17rQM+iqSx/zOq2iQs30PLrXoTurToh
         WP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YBrcLRvJMlTXpJcW2Cg4qIRV5WwSfL/dJR2jgM0zSB0=;
        b=bclGmez4GfN0tqj/7/ZV+4mHOAzAu/B4WYRIO8mPxvWyZRDWisNKkaHzMgdNrStaV5
         lmy0yOk2zy2DCvWZ/wof6bIRDUSLDTphHecmH4xbBHaAkByGWJ7kWYGlXM5Hxk6G81RJ
         T33zdoFziHZ0jp4ztg0nXNs9rsJGyxTiZUnLUck8rZdwsVreNkuvp12JqRbtixwj0Dsp
         1KpJ703bbC+nl39IOd1y3sCDkLJ9uZ8SVNPD2oe9RUNz0CFDRw6my8CU7ermjjh1c1kh
         z+KVb4AcjyMoK0Zhr760Ep61L75Qqm+zQVFMJMxpz8thYrgHYNxQ4L0WYV6aRuWe0xAx
         PG8w==
X-Gm-Message-State: AOUpUlE40jxeooJeWyG9SsXu+ShEogs2CBokFRV9r8KL1fgbCxS5oOac
        oktS1TweyvQF2ZW3ZzozttmC9F1RW2k=
X-Google-Smtp-Source: AA+uWPyg8F0J7+F0I6ILITtBIfqZOr7c0jHPiL06/GzFsmScyHDUiuVXBQkmBxY6RTHUACDl48Z3dQ==
X-Received: by 2002:a65:658d:: with SMTP id u13-v6mr12684165pgv.20.1534057703161;
        Sun, 12 Aug 2018 00:08:23 -0700 (PDT)
Received: from ubuntu ([119.82.107.14])
        by smtp.gmail.com with ESMTPSA id u11-v6sm24065132pfd.117.2018.08.12.00.08.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Aug 2018 00:08:22 -0700 (PDT)
Date:   Sun, 12 Aug 2018 12:38:19 +0530
From:   Sumit Kumar <sumit686215@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gasket: remove null ptr check before kfree
Message-ID: <20180812070819.GA20860@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove null ptr check before kfree because kfree is null ptr safe.
Issue found by checkpatch.

Signed-off-by: Sumit Kumar <sumit686215@gmail.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index d4c5f8a..bd921dc 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1328,10 +1328,8 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 				  num_pages * PAGE_SIZE, mem, handle);
 	}
 
-	if (gasket_dev->page_table[index]->coherent_pages) {
-		kfree(gasket_dev->page_table[index]->coherent_pages);
-		gasket_dev->page_table[index]->coherent_pages = NULL;
-	}
+	kfree(gasket_dev->page_table[index]->coherent_pages);
+	gasket_dev->page_table[index]->coherent_pages = NULL;
 	gasket_dev->page_table[index]->num_coherent_pages = 0;
 	return -ENOMEM;
 }
-- 
2.7.4

