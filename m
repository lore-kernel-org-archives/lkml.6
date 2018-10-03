Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D7CC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2C220835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmwwHw48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2C220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJCTvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:51:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38841 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeJCTvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:51:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so1555343pgr.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 06:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62NFzvpjKHfM9qFmlLXORqKi3ISMGsSUWrxglE0A1Bo=;
        b=OmwwHw48w0oW5xiFzGmUud7LK2hloFjZ7eqIhMW5uU7nsLsKCp9UN9r/Y2iBEMTweo
         qW8tyyy7g+AnG1qvzsN5hIxb6iIvXPFXPQljh7ziblsnqb9j4soqnaoYH+ghuadu1yd2
         Z2FjxTKZTh3VhSlymrQLEmG1Rjw5bTyjpa5YEX4KseRMs2o6nJPDrIWKISUwT2IPHodi
         xFEnfvKMOvUpiHM74wz2k92UopghaUVflpiZw6rTn4PMDhlPt9iufOk/gDsreuogXGUj
         edsagN/MG27W0e1vLF/w4mBigWip8BBcj7EQ9g/isB+DdOXeXFfX3sTO2NptYCcfK478
         h+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62NFzvpjKHfM9qFmlLXORqKi3ISMGsSUWrxglE0A1Bo=;
        b=sB9qEuRa29+WObvatEEeQqANFd2VV+00ihSWWxcqRX+I4uJSEpImvH7idm1yFG3Vfk
         +gyiEBJB+Da5DKC5IFOSdum19J9qKDibkCR2bTrpuED/MXrxDBVtQptIL4m09qVjRH3H
         67SvinRgkKwBhsJP3hdRfbonzfDil7I6gQu7tuLi9kKVQxpBS9ff5dnz24uEbZB/JSJp
         Vlxr78w5QlYD7DtLcHLnq9hjtVzeDgVJqdVZxMdE77BrGyqgd7hcqb2QeojfKaNSnBXE
         H5W1n6QP49ZjOSrr3t8RxxwRYm1glTouwPJDC+nu/IW8MCK4sJZtySiS/K3bVWDc65C1
         MqIQ==
X-Gm-Message-State: ABuFfoh9AQShr3fU2fRq7NbYk8odvYt9Ubg9YvUbuopg8ZJu3N4toBnk
        CaFosM8t0TqgLn1sNrCDnJ0=
X-Google-Smtp-Source: ACcGV619TkRs/nu8uZHNstx6mXvXZhh60RJX5NUXJwwl0ZYhgcmDh9xxoXnwKgMzWdanDAaAhRA33Q==
X-Received: by 2002:a62:6786:: with SMTP id t6-v6mr1548686pfj.92.1538571775679;
        Wed, 03 Oct 2018 06:02:55 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id l6-v6sm2704293pfl.169.2018.10.03.06.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:02:54 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH] lib/seq_buf: auto-correct some typos
Date:   Wed,  3 Oct 2018 22:02:41 +0900
Message-Id: <20181003130241.2573-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct vnprintf() typo + several aspell corrections.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 lib/seq_buf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 11f2ae0f9099..738b4e92780c 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -50,7 +50,7 @@ int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s)
  * @fmt: printf format string
  * @args: va_list of arguments from a printf() type function
  *
- * Writes a vnprintf() format into the sequencce buffer.
+ * Writes a vsprintf() format into the sequence buffer.
  *
  * Returns zero on success, -1 on overflow.
  */
@@ -175,7 +175,7 @@ int seq_buf_putc(struct seq_buf *s, unsigned char c)
 }
 
 /**
- * seq_buf_putmem - write raw data into the sequenc buffer
+ * seq_buf_putmem - write raw data into the sequence buffer
  * @s: seq_buf descriptor
  * @mem: The raw memory to copy into the buffer
  * @len: The length of the raw memory to copy (in bytes)
@@ -280,7 +280,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
 }
 
 /**
- * seq_buf_to_user - copy the squence buffer to user space
+ * seq_buf_to_user - copy the sequence buffer to user space
  * @s: seq_buf descriptor
  * @ubuf: The userspace memory location to copy to
  * @cnt: The amount to copy
-- 
2.19.0

