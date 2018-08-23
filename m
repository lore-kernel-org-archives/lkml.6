Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9ABC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAD8208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BparjLy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAD8208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbeHWMfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:35:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42919 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeHWM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:28:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so2243084pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G8wSzdtoRNiMaLVb7pD3PeExnyV73Q1lSCHz09KWTwk=;
        b=BparjLy7qejScg0Va8lnp/643phch+Wa51fVT+z6f6jjWRN7Z5gyIt/e5fM1oqklvx
         wDRGVMfRTzPvW3lpZaTuWdRqVoskAjHGs2p5wC3f0kNpPRlhm4N84mo0Uufro0vcqGXa
         pivmLqGgY6olEGlPAQWYNTjWPTXsxfEKJxW7KLfYkEmw5ZgjJPnMqRDn8h6u0I0zBOd6
         2cJJCCLnYP1gDoNR4wevJF/KFztrhIUHlGS5iCGkmLfWVlsMQ4Yg5d3XM18Jxi6vRhv1
         vcPWe2r5oCKnzs/ZH29C8/UApbuPE1KluCBD88bTXhBgRzodf/ADjwpI2tVrcGNlm9Ez
         cP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G8wSzdtoRNiMaLVb7pD3PeExnyV73Q1lSCHz09KWTwk=;
        b=hRAlghEHrq+7znf4cvsFPSaarivnt2qRgWtWqIcSkuhR5FnYeieH78xdQ9Yp+XZQBS
         FyGFQ5WkkVQrIA0I0kGVos0LAYVm6qOfWVf9tHQg3piXibIt24xob8hxQ8B3WEoz0uf4
         J9vLzOu2YiIT5k5NrWI2ZvwWeNMy+xJHGNKZeel2hHrrUnS70wEtx8ZCxHxnkESxH4CR
         QujpoHMvLvaqQwDsnrH1JM7CSKzUfQ7nLyhvfk2sUxZIdKs1HBgQuOrhHlR+g9obcGwj
         lX4z54pwkaeX2EEQv3kg1FoUB/2ZH7AaFH/QVW/2NOhXaqaeUY9RfNM7+UyMPMjcEI8L
         OzcA==
X-Gm-Message-State: AOUpUlFdm0yuIr6WFDlIrZs+Cg7UqSNzCJ3zY/WQ8FEr2cymOgdwFT1Q
        jScz/h+P7YnOwEFtD8UlQJ4=
X-Google-Smtp-Source: AA+uWPw7ccpsHEYVwkRGgK1Nn8ePO1O1VK5keLXiuCcN3FCILpkynmDdsbF9yvNzNPSVFc8ZpTMZCA==
X-Received: by 2002:a63:2744:: with SMTP id n65-v6mr25237644pgn.29.1535014762031;
        Thu, 23 Aug 2018 01:59:22 -0700 (PDT)
Received: from localhost.localdomain ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id t86-v6sm808643pfe.109.2018.08.23.01.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Aug 2018 01:59:21 -0700 (PDT)
From:   Weikang Shi <swkhack@gmail.com>
To:     akpm@linux-foundation.org
Cc:     alexander.h.duyck@intel.com, mhocko@suse.com, vbabka@suse.cz,
        mgorman@suse.de, l.stach@pengutronix.de, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        my_email@gmail.com, Weikang Shi <swkhack@gmail.com>
Subject: [PATCH] fs: fix local var type
Date:   Thu, 23 Aug 2018 01:59:14 -0700
Message-Id: <1535014754-31918-1-git-send-email-swkhack@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the seq_hex_dump function,the remaining variable is int, but it receive a type of size_t argument.
So I change the type of remaining

Signed-off-by: Weikang Shi <swkhack@gmail.com>
---
 fs/seq_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1dea7a8..d0e8bec 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -847,7 +847,8 @@ void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
 		  bool ascii)
 {
 	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
+	int i, linelen;
+	size_t remaining = len;
 	char *buffer;
 	size_t size;
 	int ret;
-- 
2.7.4

