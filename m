Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0F0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4432086B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da0Xkp07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4432086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeHWI4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:56:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34527 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeHWI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:56:40 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so1885158plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fHH5TD6YRf77MzHh7sDvwWo7y4Ij078zVJ7PZ5B6Jc8=;
        b=Da0Xkp07FNXC9kMn04fMUCIVzTR8ZadAm54ZvN9R8lI96iBWYlNVePhPinAn4w8yOp
         +WFM+IXrIs3e10UILm9gOGulNpRf5t4NBbQOrO5vp7QkjWWglyV863nYe6scG70E02sZ
         Tr9q9MwixgybejhaXW2QWpf/y2uxTMCzJfPRqcO+M689AQXF7iL6CyqmW0lHgy7vm8+b
         lvhiHfr1zTHhGoTI46h3xY1qyR3SyL/2pa18VZgP9MxnH6bSWMxcpe351isjBayhxRjk
         CdgAG6mX9T0zAHkXPuMaj2R9Ap2y0WmCe4V8rlQ2rXbukKSgW8SBe4Wc1bODR1VERmhs
         pyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fHH5TD6YRf77MzHh7sDvwWo7y4Ij078zVJ7PZ5B6Jc8=;
        b=YvB/WxnP09EJ57fW5Obz70ZZ1QW3+/+Jsw9v8nbNnKpefkhwX+UdQk66+0G2W6RUBq
         JTEByEeay38kjyQvBnlHd3FueiIJWD6TpQMUSpZxDouk+h907shE+97GUfhs7N2hSxd8
         hg8VgKEYuWg2dFHYCoaqvKutlD5DH1nHtNg8NzVv1jncCYFtiI1zrzNIWEDoJRctv/Va
         +rCHpyGU8yy7v3xw6hkjio8xeWfx/vTICRWO63HSgBGZu6YtM1jzdeydhD8TcZGz/jph
         R5J9yPfsuszXiVOIu/2YFlSL2D9cEqxuFJ3QhYQZ5BkN4E0FalSFW2jypWzwxFdQSc/M
         cpRg==
X-Gm-Message-State: AOUpUlGMu9e5zQtVGGMhu2oZZnuuW9mS0AZBXBGaurxxcmB0SQzA/i0e
        PZuIcKkipar02z5+uqTcjxXSGwkT
X-Google-Smtp-Source: AA+uWPwhrgM4t7wsYuCL4ibtnuTjZ+UGHfsxQfyvpem9qlFMSh31IdfaRFUp9IMTRumWPdh9J9zgYw==
X-Received: by 2002:a17:902:24e1:: with SMTP id l30-v6mr25548057plg.315.1535002125000;
        Wed, 22 Aug 2018 22:28:45 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id k5-v6sm7342405pfj.30.2018.08.22.22.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 22:28:43 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] mei: fix use-after-free in mei_cl_write
Date:   Wed, 22 Aug 2018 22:28:40 -0700
Message-Id: <20180823052840.16364-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.18.0
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

KASAN reports a use-after-free during startup, in mei_cl_write:

    BUG: KASAN: use-after-free in mei_cl_write+0x601/0x870 [mei]
       (drivers/misc/mei/client.c:1770)

This is caused by commit 98e70866aacb ("mei: add support for variable
length mei headers."), which changed the return value from len, to
buf-size. That ends up using a stale buf pointer, because in some
situations, the cb (callback) is deleted before it gets here.

However, fortunately, len remains unchanged throughout the function
(and I don't see anything else that would require re-reading buf->size
either), so the fix is to simply revert the change, and return len, as
before.

CC: Tomas Winkler <tomas.winkler@intel.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/misc/mei/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 4ab6251d418e..ebdcf0b450e2 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1767,7 +1767,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 		}
 	}
 
-	rets = buf->size;
+	rets = len;
 err:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
-- 
2.18.0

