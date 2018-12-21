Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE892C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7564C21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdOqH/kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbeLUH3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:29:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40749 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389137AbeLUH26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:28:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so2179391pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqNMcT0sABAQK9dH1IwCSnU9D8RWueQ7ogJwfMQvVUM=;
        b=jdOqH/ktq72eI/R7dMFGU+bx0MaeaXJal2t34DWWfYH2rLToVCgH/9w85XCoUMQngu
         Wo50PvEMpdsvIk8MuWZ0//RRkliHYOW/6fIwaMIq84NM2szgUfYNx9YDrUIiDLJtvFLx
         lsOUdLB4e0VzM+JH/lf75zCsv3rwx6YxSAGN8D4HZH66Nbm0c3NX6707vWETZrG2yBIZ
         rE6IJX2FPzsO1g78Y2LizYXaeB7sxHpgOteuVT4w0MrUbyKMd2fVBX1Oj0f4r/vY/QGP
         NQF898gfte8ZELsHCxGhfcC05PVwtsVO/WlaGeRj/2+aHm+QbVXL24MlJHSZXlripE3Z
         igQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqNMcT0sABAQK9dH1IwCSnU9D8RWueQ7ogJwfMQvVUM=;
        b=IhdjOl1j+bvmJzIevThhqKDQkAWPwZ8JeeITaQLKT7EMdIwwaOlIOQ/86RJTYr0VXY
         IplaMWkiFHMf0mTa8CSffWK068ZZDDYtoyNlMywRQRdK8EHI25HRIbEdkzDjyidOsepr
         u3HFQp+gOzA2O1rwkvDKEBbL1nQcrezPVk1rp/qY3z0sRvarhlRAJ1KasC4H/UWVzcXH
         lEYIEMy6ftLiES+GLaFHrCJESUoUr9A+WLi85vU1NrTyEjXCoWAKvhGA99lwLUeHJP3t
         /wg5geg5lEgF+M2GHKHQ2d+CLDhv8ElmxbeMp+0KIbI2TF2Ul5jt87PV1QKY3vjTUilk
         LU8A==
X-Gm-Message-State: AJcUukcwDVdLoMNh5z5SeU2kv95+uvSYbm241nWe2B64lWB/lwu6EBeN
        kxF1YLbzm+46ZxR8pI6T7/Ji8K2x
X-Google-Smtp-Source: AFSGD/VebtCshdFW/Z2E2TAIY9jRCdf7+oKBCZPWYiQ6+CF3Hv6PsTYG1I21iUtp9eiZTK0E373aYg==
X-Received: by 2002:a62:868b:: with SMTP id x133mr1483746pfd.252.1545377337088;
        Thu, 20 Dec 2018 23:28:57 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f20sm27688275pfn.177.2018.12.20.23.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:56 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/5] tools/firmware/ihex2fw: Simplify next record offset calculation
Date:   Thu, 20 Dec 2018 23:28:40 -0800
Message-Id: <20181221072841.30199-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072841.30199-1-andrew.smirnov@gmail.com>
References: <20181221072841.30199-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can convert original expression for 'writelen" to use ALIGN as
follows:

    (p->len + 9) & ~3 => (p->len + 6 + 3) & ~3 => ALIGN(p->len + 6, 4)

Now, subsituting "p->len + 6" with "p->len + sizeof(p->addr) +
sizeof(p->len)" we end up with the same expression as used by kernel
couterpart in linux/ihex.h:

    ALIGN(p->len + sizeof(p->addr) + sizeof(p->len), 4)

That is a full size of the record, aligned to 4 bytes. No functional
change intended.

Cc: Chris Healy <cphealy@gmail.com>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 tools/firmware/ihex2fw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/firmware/ihex2fw.c b/tools/firmware/ihex2fw.c
index b58dd061e978..e081cef730d8 100644
--- a/tools/firmware/ihex2fw.c
+++ b/tools/firmware/ihex2fw.c
@@ -24,6 +24,10 @@
 #include <getopt.h>
 
 
+#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))
+
 struct ihex_binrec {
 	struct ihex_binrec *next; /* not part of the real data structure */
         uint32_t addr;
@@ -259,13 +263,18 @@ static void file_record(struct ihex_binrec *record)
 	*p = record;
 }
 
+static uint16_t ihex_binrec_size(struct ihex_binrec *p)
+{
+	return p->len + sizeof(p->addr) + sizeof(p->len);
+}
+
 static int output_records(int outfd)
 {
 	unsigned char zeroes[6] = {0, 0, 0, 0, 0, 0};
 	struct ihex_binrec *p = records;
 
 	while (p) {
-		uint16_t writelen = (p->len + 9) & ~3;
+		uint16_t writelen = ALIGN(ihex_binrec_size(p), 4);
 
 		p->addr = htonl(p->addr);
 		p->len = htons(p->len);
-- 
2.19.1

