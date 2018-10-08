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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6C9C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8057520858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heWLSe4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8057520858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJHV0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:26:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33689 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJHV0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:26:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so21058012wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3NYDjAiu1pTV6yNJR4bq7j34AUfLXRU8GuI8voz6iac=;
        b=heWLSe4IKFMp8NU+Yi/UvYXUbQVJf0FzNYj0iksXfEb0FdAZqTeK6upyx2Snzu3NIH
         4MxSoy0IpjJuq0mGsjV8sVlADA9a8mfuH3cp6DLzGdTpuxkpX36ntKssl9WmALbtF8id
         CU2MuvnPjDyWF4hxGtgkoa1xNTglrhxxwBKcJa4mZni06Bg4ThoyOQk63xQ6mtaCX74n
         obribZPMY8TgKC+CiPg1D1nPIBX43IND0CLkHvPVj9uzsnrqhaeaEI0/7XLS7Il4jUH2
         IWu3zTDyKa9MZeyFtsW5fm7O5TOjHF3qn00SUIz2EbQOcrNVX5vQY4cMFO/2d80yhB71
         /a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3NYDjAiu1pTV6yNJR4bq7j34AUfLXRU8GuI8voz6iac=;
        b=RjYQ6tHY58kGDYQJ2rqrHCfbCjxSXDux+3ZVHYMA6V4g1pqWGA4wgeI2xb86KtjjKQ
         X8RBWaieN30Q7b86SwIHrMTlvX+vgCAvRSDHMe+tbEopDoJGbsUykSuUeyHpGTtbXen5
         eRmcKFRq0iKTx/ytatdfQXH0MXCkzQESO9TJdGNEacCwoZSMLFyi9oPUS97xmsZJmIKm
         3R9NX3XnDjJ6tV/cFVCDWDwRl6tncePNj9GyboTHlQXo3xCX1d1L+KmYCXfG/etw2zjd
         KYzjSLgfGpTgF/ml2Qs+kaH4ynbfQJ5m101p9+pEMCeQfcXBln9CBRZP6ZQdQX7v/YtO
         iAkA==
X-Gm-Message-State: ABuFfogZFYeY2lh9msIzaAyITy6LYOx3w85xZnCZCfrZfV9bpzg2M3os
        QZOZlwfDERue/oP0O5ENIH/mihrxWjM=
X-Google-Smtp-Source: ACcGV63P7F5kcqG2yeSZjxN7odWkjIt25/EC8fNUyTOKHAlyi3ffYA3/n94X6SOHDoDVj2SYgZ0Gaw==
X-Received: by 2002:adf:a352:: with SMTP id d18-v6mr16569112wrb.31.1539008060773;
        Mon, 08 Oct 2018 07:14:20 -0700 (PDT)
Received: from ltourlonias-VirtualBox (c2fa8d22.fsp.oleane.fr. [194.250.141.34])
        by smtp.gmail.com with ESMTPSA id a1-v6sm11523540wrt.79.2018.10.08.07.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 07:14:20 -0700 (PDT)
From:   Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
Subject: [PATCH v2] staging: erofs: add SPDX identifer
Date:   Mon,  8 Oct 2018 16:14:09 +0200
Message-Id: <20181008141409.2624-1-loic.tourlonias.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifier to simplify header and remove whole license text

v1 -> v2:

Move SPDX identifier to first line and change comment delimiter

Signed-off-by: Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
---
 drivers/staging/erofs/lz4defs.h | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/erofs/lz4defs.h b/drivers/staging/erofs/lz4defs.h
index 00a0b58a0871..cdacc57e6a08 100644
--- a/drivers/staging/erofs/lz4defs.h
+++ b/drivers/staging/erofs/lz4defs.h
@@ -1,32 +1,12 @@
+/* SPDX-License-Identifier: BSD-2-Clause*/
 #ifndef __LZ4DEFS_H__
 #define __LZ4DEFS_H__
-
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

