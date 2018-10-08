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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BC4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36D821471
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V18LaXl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36D821471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJHXYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:24:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJHXYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:24:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so9093530wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PyQshF1GR8gtEFjVv9FLyNEa0HYOGVSYTw2uQN0cIU4=;
        b=V18LaXl2GLFjDILF5NSdPZgpU/rHqccQDCKPRn1qUTMS7hcQGNX5eyF7yo2tzO7Mqt
         2NXG01v9cE6g8appsG1GbcesoBRrlkxcbF4NEz0YDPgvOsnzVst+xOqFf3UI9hNcyFBp
         NA1N3LiHWnlti/3Yvo1uXMDZPJQxylDLX3XD0qwcE++j0imAHfNhS7JGz40RNJpw7HTD
         JbEFIx2txyhPWtP2ZV+5MHA02aZsDqtqNXB1VR3qU/KlDCYAuZi4qvvrVTuh+iiP3ckM
         F3AtIjHEVyJl0rWuEj+Q+QpV/Vg/7m9pRefhdf2rIQI03vZRO8S0DIwgJxLmsD69WBIL
         uc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PyQshF1GR8gtEFjVv9FLyNEa0HYOGVSYTw2uQN0cIU4=;
        b=DW0fBGJiXbVPX3CwJxBAo0fff3hJ/KcHMTkCKOOIm+irlnh57QORPXGvXi1BHfvj1q
         ST4qymQQx2EwYECXPtqB/zETwQtTXzU7l3XMCYFE4KmCDLN2VGJ6ZeYAW7u8P6Q6Mnkc
         8pXZ3YWRZswMVXs9p2d81lOICSmhcgPUuFq1vx26mT9qh5/20Bqv5iXTD74GIQXkrnhD
         6lyWFrzlADGPlMYeiKNYnCb0wnHH/NARLOq/+noj9WOhm28v5NkfdaSN13rtUEL7Myd5
         2trQJOUvGtr567T3/GIkOFe1EcHsO5zoDU6r36+8sSHmpbWXwYHCw18gjLPbQlSJPhBE
         KGFg==
X-Gm-Message-State: ABuFfognUwMhpj6DwK19cT9HrKdKlvw30sYwQ31ysFiEMfeKwqwwmVxc
        lWSrDLH5RHhT23a+vezPh14=
X-Google-Smtp-Source: ACcGV639uB99aOQsZ6pLE8MElpv8K9l+9W+wq6ntaaif9211kSUhkhanwR1FkPp4PV5oj1SJEWPa4A==
X-Received: by 2002:a1c:8b94:: with SMTP id n142-v6mr16518619wmd.38.1539015139027;
        Mon, 08 Oct 2018 09:12:19 -0700 (PDT)
Received: from ltourlonias-VirtualBox ([109.190.253.11])
        by smtp.gmail.com with ESMTPSA id b128-v6sm7629609wmh.22.2018.10.08.09.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 09:12:18 -0700 (PDT)
From:   Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
Subject: [PATCH v3] staging: erofs: add SPDX identifer
Date:   Mon,  8 Oct 2018 18:12:14 +0200
Message-Id: <20181008161214.2212-1-loic.tourlonias.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifier to simplify header and remove whole license text

Signed-off-by: Loic Tourlonias <loic.tourlonias.lkml@gmail.com>

---

v2 -> v3:

- Revert undesired new line suppression,
- Fix patch format

v1 -> v2:

Move SPDX identifier to first line and change comment delimiter

 drivers/staging/erofs/lz4defs.h | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/erofs/lz4defs.h b/drivers/staging/erofs/lz4defs.h
index 00a0b58a0871..3b8a694d2ac8 100644
--- a/drivers/staging/erofs/lz4defs.h
+++ b/drivers/staging/erofs/lz4defs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: BSD-2-Clause*/
 #ifndef __LZ4DEFS_H__
 #define __LZ4DEFS_H__
 
@@ -6,27 +7,7 @@
 
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

