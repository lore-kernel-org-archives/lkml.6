Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0712021019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightbitslabs-com.20150623.gappssmtp.com header.i=@lightbitslabs-com.20150623.gappssmtp.com header.b="PESCsPXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeLaL6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 06:58:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39277 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeLaL6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 06:58:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so26337923wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 03:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=KQNrUefm3GzUX/F5605K1SA559kW8YelkDAIwoatBLE=;
        b=PESCsPXiHo33SnO9j8/oHTANH57OTkp/NwLGuXPFs5HqvBx4zvVsQm7L+IoxFPLvy7
         xxrwSKAoD43g/M5DcnVTBkFZeFz1rzT4/wIK5L2PyE3fcpF0lv0mGLB8o5gKntctXYzR
         ltlpk7zy848vG0ZKHIODPKL3z7qEW6yCqAVQjUz0KSK9jT4d7uPTSp9YmgKiLpRmBzIb
         UnsCvvLSvgd9C4jE9nQ/I9vTUVWywcqCKY8OHR7k1bIX08cynirhgqAm5shZxcAIU0FD
         bnaosbS/BIWaOZGX6FOdh5CUzITVQk9aOPLQuuBXMsQTLJIzn2lYH3SsmUxHzxKFosL3
         BC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KQNrUefm3GzUX/F5605K1SA559kW8YelkDAIwoatBLE=;
        b=MDH17eKBfosL8V8kEV11P6ope8G9ks1iPXqnSrLxb6sRsbXQzKOsqYV8RCvMCK4QDQ
         031fuMtSnJrQZjvW8VTTEPY55w4EnXcg16gYr8qupRzYeKTFtLJ88TPILjLmIcnR9D/W
         aJpzyZ5/igrateHdIqRgtiKECAzicmAGWQm+KvaUkJXIOxfdMRSSTEYnUdyjrqnmI9wJ
         bdwohmZryUwjuMtcL/DVUT6y5aHCecRA2mKKdCiiS8EiDnGU+rKi4DS++OEYeeJ3crr0
         lnH5jQabl74xP8tQsCltMHxH1agYNkJvAAj5tQU+wNnUHEEBDI+BbmLhkAJQz8n2uYsm
         YYJg==
X-Gm-Message-State: AJcUukfuhzM+sgREJz85yckB536qEt9czSnZxNxxiYuaVPvEsG+ZXvA0
        wyv+9ykowev9DnMqDNxPXqNGpRFE8kb+YCsS
X-Google-Smtp-Source: ALg8bN7GjMJzKqHN0GaYZbvhc59fefCD9V+krvClgPSSxBabbpwh0WldD2+F2tAlv1bsOZyFrnQSFQ==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr31244350wrx.259.1546257521425;
        Mon, 31 Dec 2018 03:58:41 -0800 (PST)
Received: from build02.lbits (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k15sm64936751wru.8.2018.12.31.03.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 03:58:40 -0800 (PST)
From:   Elazar Leibovich <elazar@lightbitslabs.com>
To:     linux-kernel@vger.kernel.org
Cc:     Elazar Leibovich <elazar@lightbitslabs.com>,
        Orit Wasserman <orit.was@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] tracefs: fix partial reading of tracefs id file
Date:   Mon, 31 Dec 2018 13:58:37 +0200
Message-Id: <20181231115837.4932-1-elazar@lightbitslabs.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading only part of the id file, the ppos isn't tracked correctly.
This is taken care by simple_read_from_buffer.

Reading a sinlge byte, and then the next byte would result EOF.

While this seems like not a big deal, this breaks abstractions that
reads information from files unbuffered. See for example
https://github.com/golang/go/issues/29399

This code was mentioned as problematic in
commit cd458ba9d5a5
("tracing: Do not (ab)use trace_seq in event_id_read()")

An example C code that show this bug is:

  #include <stdio.h>
  #include <stdint.h>

  #include <sys/types.h>
  #include <sys/stat.h>
  #include <fcntl.h>
  #include <unistd.h>

  int main(int argc, char **argv) {
    if (argc < 2)
      return 1;
    int fd = open(argv[1], O_RDONLY);
    char c;
    read(fd, &c, 1);
    printf("First  %c\n", c);
    read(fd, &c, 1);
    printf("Second %c\n", c);
  }

Then run with, e.g.

  sudo ./a.out /sys/kernel/debug/tracing/events/tcp/tcp_set_state/id

You'll notice you're getting the first character twice, instead of the
first two characters in the id file.

Cc: Orit Wasserman <orit.was@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Elazar Leibovich <elazar@lightbitslabs.com>
---
 kernel/trace/trace_events.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f94be0c2827b..7345f5f8f3fe 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1318,9 +1318,6 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 	char buf[32];
 	int len;
 
-	if (*ppos)
-		return 0;
-
 	if (unlikely(!id))
 		return -ENODEV;
 
-- 
2.14.1

