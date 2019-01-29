Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED9AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D29520870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfA2Ifr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:35:47 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60694 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbfA2Ifr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:35:47 -0500
Received: from mr2.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0T8Zk9R004169
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:35:46 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0T8ZfMn000315
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:35:46 -0500
Received: by mail-qk1-f200.google.com with SMTP id x125so20812938qka.17
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=YNofE9xL/zFV568kxrNilUcGj+Jr4LnnQAseovd8dHw=;
        b=mKv58B3s1B6+OwApzdnz5eBgzdi6cTb53ueXdYTCTAA2ecx/pl51LyL+C+xNI4a2Tz
         cDyjE3Ej2squpffMlYfuz+AJnuIHvs6p+xeyGlj+JB2SY8Y4H+cT2718WDrSoCIgysf3
         Hf4p9RDcX3f1ZUyUObBOBBkNniXdueUvINymVvQDzKEwuHon+u8A5dduMX2gTU5VKcGQ
         JI7FDRBM6I92SQW1uYt8CKT+fIueszBg4bAl7tljm7Ez0SzM4uogGFWZNbHQfPGwZphM
         zfcYW1lMeEf/m61BU7dXloQ+Cd5DoDyEaCXGNz9ziQ4XKpkO/auIwNbxYmSXeE+SiEEe
         8piQ==
X-Gm-Message-State: AJcUukd50z6f6kDjg8uPAhmQ65wWZFJquXzRwNJy1jw2UQ0d+pitL5au
        Is18R+WkHIpwB8OfqWFSzxTklcpuW6OdSvWf7uCmhkGMHmxD9jUjD9RmCGTkBbdwbq0cWcXZDjI
        oowXCxrZRofUfe5gks391Zdz9kQS9q29Juj0=
X-Received: by 2002:ac8:2b99:: with SMTP id m25mr24784327qtm.36.1548750940828;
        Tue, 29 Jan 2019 00:35:40 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5JQ/qUj4ra1Bb1WljThd+R49PWLWTCzRBdXC4lKqxLtVaKxRDapLivXn90cUfTALCFtTgIYQ==
X-Received: by 2002:ac8:2b99:: with SMTP id m25mr24784317qtm.36.1548750940621;
        Tue, 29 Jan 2019 00:35:40 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id j36sm85529596qtk.15.2019.01.29.00.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 00:35:39 -0800 (PST)
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] init/calibrate.c - provide proper prototype.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 29 Jan 2019 03:35:38 -0500
Message-ID: <18827.1548750938@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse issues a warning:

  CHECK   init/calibrate.c
init/calibrate.c:271:28: warning: symbol 'calibration_delay_done' was not declared. Should it be static?

The actual issue is that it's a __weak symbol that archs can override (in fact,
ARM does so), but no prototype is provided. Let's provide one to prevent
surprises.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/include/linux/delay.h b/include/linux/delay.h
index b78bab4395d8..8e6828094c1e 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -55,6 +55,7 @@ static inline void ndelay(unsigned long x)
 
 extern unsigned long lpj_fine;
 void calibrate_delay(void);
+void __attribute__((weak)) calibration_delay_done(void);
 void msleep(unsigned int msecs);
 unsigned long msleep_interruptible(unsigned int msecs);
 void usleep_range(unsigned long min, unsigned long max);


