Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC867C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B56B20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtYNPjYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B56B20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeKRWXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 17:23:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42117 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKRWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 17:23:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id x21-v6so10519515pln.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b1ZYnLYN4ir4UacvVkD3Q/B6raJ1AexezCEPoh1Pabs=;
        b=qtYNPjYko/dnt43DWz6PBVj872BUtmlIVz3LcNxt9bB0G/E9ONzlE1jjswnx0Kbf9i
         BDBJ+HONKG2Lc8Yy8nEKFNs13fv85wQcKuigkYRpMSukmJw0iEWlTdsev8wXSqfEHLjU
         jk/bszc9TWBmm6nWG/B/0WKo/PKYhoC/XO6t2EkHfk4sl1EAMnLzN/oAmURsN9Rnvj8j
         2Q/9x8NgN07alDXszwY3JD2i3TJTPHLyQecyo5G6zE/DAAxbdXV+7hi69kIFV3xjFyqr
         ruvBdXg9JYO33UJLVlrx04hEvwyEkKJb3/4pDxNj5k6AFmXhBd3oHkAKrxuwAw6f5ztZ
         TEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b1ZYnLYN4ir4UacvVkD3Q/B6raJ1AexezCEPoh1Pabs=;
        b=ECo4p/pLH7tt4KxCxVLaqPnLbqyxhdL+Fq2oWgmVRRBcTS7QdWx7Vin9s86aAVbk6D
         32bB/4NWTByLQbo9qfK1EpJVOmWzAHtSq2glDqFGkUckhj4Wzy1C3i0VXOylnGDzt490
         fqRsMWW8MlX5Q8FU+e5sCJACq9B2P1P658QuP7Mb2MP0LDsHxJ4+EiRo/pN3D5XIap4K
         mbD9WfAlzEm78aqLltGAU3aiIXjHH4s5YDiFFScKYHKYnIjFAYoescz1MD85TW2+ApGw
         G0dl0JYebLhRwdNPwf4FPmfSVX8hB1VSFcjVTJAaL4uuu7oR7tnxpoG5MgYSMLRZ/UWv
         OD8g==
X-Gm-Message-State: AGRZ1gJmGJOWk4MHN46ozEFrcaSYpR3RmE2qPtJfx6oeiG9BWvZyuN2J
        9RGwNzmr8bqfItaAwxmo24M=
X-Google-Smtp-Source: AJdET5cDQ6utLkkHphvBu58J/8NIsRXNIlEGtv61ACddLjK1bPiOLlR6kHjvoQBAVNbBkJhCUltygw==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8-v6mr17825829plo.94.1542542585694;
        Sun, 18 Nov 2018 04:03:05 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id i21sm36748495pgm.17.2018.11.18.04.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 04:03:04 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     willy@infradead.org, akpm@linux-foundation.org,
        darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] mm/filemap.c: minor optimization in write_iter file operation
Date:   Sun, 18 Nov 2018 20:02:18 +0800
Message-Id: <1542542538-11938-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This little adjustment on bitwise operation could make the code a little
faster.
As write_iter is used in lots of critical path, so this code change is
useful for performance.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/filemap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 81adec8..a65056ea 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2881,7 +2881,8 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_APPEND)
 		iocb->ki_pos = i_size_read(inode);
 
-	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
+	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) ==
+	    IOCB_NOWAIT)
 		return -EINVAL;
 
 	count = iov_iter_count(from);
-- 
1.8.3.1

