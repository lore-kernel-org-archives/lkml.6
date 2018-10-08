Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD8C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815F42085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMhOLlTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815F42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJHRwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:52:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36351 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeJHRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:52:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so20254512wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tKiqz77Jmwp7LmxADxlYoUbWc1fWcR9xCmZHpl3hCso=;
        b=LMhOLlTchVLqol1DPJ4L1uPyj7O6Zj+9kDHePani4HJsbM8lyMeC47EWxCWOHDnJfC
         8J0uOMyhVNqt1SF+5W8gLf+aAiqaH2tFLgjbAbIV1aN/cPUEMjiIg0z+V62f7IYQGZpS
         bY7jBv0lRKPYGgBSFZJgvG940eIfU1cl6FjvlSNMvgqTzlqKh5VIYslR6iADQZYDBazB
         JLB/wSUNL3wx8CDA9OphWVFrGiJb8uNwvWxkzm/xoJOuX/SIrlYAYpJSfrmhNiBOphva
         M09V1DEdjqk5cLYdbahQzMow2ykptsMMLacGhBDmrbizL3YEp0xzHda/QnxIWxErlAKk
         TEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tKiqz77Jmwp7LmxADxlYoUbWc1fWcR9xCmZHpl3hCso=;
        b=rr1c4tywbSyhc+xdFiMqDvgQXQucv8oghtmXhYA+Ejnye7zQrvvu+q+Y3I+UkSHDeq
         I/sYfNcHvIubRAF2MxBs+uv++82MjV/52+dYDbT+KVjb3908pgnDf0nou8t4wC4UyMv5
         pd3iLcWRklY8RFPQQRIBoHLr3nZ1KWKGT5rKBt7MFUy1LECExN53CUvfjckrq9sRWhE8
         +pDWNYekGEl16DDSdXKjNlsyadjjaBLpR4SajG7Hdvxud7fiOZ+6anDkBXvEF0qYhRH0
         LBfwF/KF8758VAzF/HawJ8NikEJnhIvcQ9CJborrMOJZb4FMsJpusSQuNiy+vE8UV6sM
         8oHQ==
X-Gm-Message-State: ABuFfog/z+JqFGhF8Yr6sCs3dAeTfTIxmDJZ18OE3Pa2gu9TVqpkFmrj
        GpvFHUAusCo5N9qiW0O3HIY=
X-Google-Smtp-Source: ACcGV63xOb+BeM823lhqu6q8hlWASgQhau2pAtUQNRIpfe8TJX2jroDe5uF3UHW8R3rkSbZgdH/lHw==
X-Received: by 2002:adf:bc13:: with SMTP id s19-v6mr17047751wrg.255.1538995264724;
        Mon, 08 Oct 2018 03:41:04 -0700 (PDT)
Received: from ltourlonias-VirtualBox (c2fa8d22.fsp.oleane.fr. [194.250.141.34])
        by smtp.gmail.com with ESMTPSA id i7-v6sm15271872wrb.30.2018.10.08.03.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 03:41:03 -0700 (PDT)
From:   Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
Subject: [PATCH] staging: erofs: add SPDX identifer
Date:   Mon,  8 Oct 2018 12:41:00 +0200
Message-Id: <20181008104100.2369-1-loic.tourlonias.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifier to simplify header and remove whole license text

Signed-off-by: Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
---
 drivers/staging/erofs/lz4defs.h | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/erofs/lz4defs.h b/drivers/staging/erofs/lz4defs.h
index 00a0b58a0871..bdb1022981d8 100644
--- a/drivers/staging/erofs/lz4defs.h
+++ b/drivers/staging/erofs/lz4defs.h
@@ -1,32 +1,13 @@
 #ifndef __LZ4DEFS_H__
 #define __LZ4DEFS_H__
 
+// SPDX-License-Identifier: BSD-2-Clause
 /*
  * lz4defs.h -- common and architecture specific defines for the kernel usage
 
  * LZ4 - Fast LZ compression algorithm
  * Copyright (C) 2011-2016, Yann Collet.
- * BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are
- * met:
- *	* Redistributions of source code must retain the above copyright
- *	  notice, this list of conditions and the following disclaimer.
- *	* Redistributions in binary form must reproduce the above
- * copyright notice, this list of conditions and the following disclaimer
- * in the documentation and/or other materials provided with the
- * distribution.
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
  * You can contact the author at :
  *	- LZ4 homepage : http://www.lz4.org
  *	- LZ4 source repository : https://github.com/lz4/lz4
-- 
2.17.1

