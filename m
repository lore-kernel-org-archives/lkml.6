Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491EF20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M83IDU4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491EF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbeGYCAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:00:54 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:40387 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388420AbeGYCAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:00:54 -0400
Received: by mail-qt0-f202.google.com with SMTP id 13-v6so4660395qtt.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 17:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ViKdSNtwNvF4IrGWzd1FVPCshvJStAz4kdtAw+u39EM=;
        b=M83IDU4EH22kMToY93S7bV1Dwaiec2hGZml87+qgKLKPKhqj5WVE0F39f1SbCbJK36
         9yBNZGNAca0kU4TXR/kyhjjqgxN+HdVowf7dY/GVtuIvKidmlc1WRakQhkLcjXCmgqlU
         cbfimP7lZhwWgvV02ggPatPETKnp7017Q/Ta+0UO8CvpE656CuTYP09Tgqv5laoCdVO8
         uy1nAoHs3sWPQTQOlb5QONn0Qc7UviGeM5Yccek8uaPXpZos+EsK2Qj8ilE/ggaFQE86
         vBcoOEnNZ5tp8r1k5OK7+5YGIc1Re4dm1jICIUVZ9/cMsz3Nhkx4gNJ9TrrigZPiW4C3
         Fibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ViKdSNtwNvF4IrGWzd1FVPCshvJStAz4kdtAw+u39EM=;
        b=V38bpD4jn0n6WZFaGSO2K+AVcDbJqGElaBi9lirKIka5V043RkEG3bmScpme6ef/y4
         fGWrNprVl9qyi0kGbRsw1UNDmHYfPNderREbdJBBdGeF6WxXu3u8s0KC7BDmErj4xYFw
         3bIhg+hpnhVSiE4Ndg3CTakSEr9v2wjJcJdQ6Ikp1JHd+8z2aMylHkwZuKGt0nfw8kBz
         S7+X1Jzh9R1cuWVY7cuWTobxchB3s3HeIW0UWRrmXIimCdbCN3AxsDQ6soqYMZoSv2VY
         q6mLR/7w9S2u6F57g9CN4BS9Dv3TFeFyqrOFktRlya8Tvon87l5EZLxwlF5dxG+v7f7w
         x4IQ==
X-Gm-Message-State: AOUpUlFEHHgomd3OI1fZcnenhZ86MwAGZ9JA8vsvlSOYxmSrUxp1cD1p
        xEz7YBMQ9hbMN6E3ff0lyolNY7iF
X-Google-Smtp-Source: AAOMgpdKps6/+clibeuNK8NlVJqRmqSsSPRQ80o1xsbKStWP2L7hdPOOpv9uRclRONsWyiucMXk6v6uq
MIME-Version: 1.0
X-Received: by 2002:a0c:be06:: with SMTP id k6-v6mr10384613qvg.56.1532479908967;
 Tue, 24 Jul 2018 17:51:48 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:51:32 -0700
In-Reply-To: <20180725005133.107823-1-rkir@google.com>
Message-Id: <20180725005133.107823-2-rkir@google.com>
References: <20180725005133.107823-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH v2 2/3] tty: Make constants to be enums instead of #define in goldfish.c
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

enums produce better compilation errors than defines.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v2:
 - Added the enum types (goldfish_tty_reg and goldfish_tty_cmd).

 drivers/tty/goldfish.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index a92fcb2b0002..173383f2a4c1 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -19,18 +19,22 @@
 #include <linux/serial_core.h>
 
 /* Goldfish tty register's offsets */
-#define	GOLDFISH_TTY_REG_BYTES_READY	0x04
-#define	GOLDFISH_TTY_REG_CMD		0x08
-#define	GOLDFISH_TTY_REG_DATA_PTR	0x10
-#define	GOLDFISH_TTY_REG_DATA_LEN	0x14
-#define	GOLDFISH_TTY_REG_DATA_PTR_HIGH	0x18
-#define	GOLDFISH_TTY_REG_VERSION	0x20
+enum goldfish_tty_reg {
+	GOLDFISH_TTY_REG_BYTES_READY	= 0x04,
+	GOLDFISH_TTY_REG_CMD		= 0x08,
+	GOLDFISH_TTY_REG_DATA_PTR	= 0x10,
+	GOLDFISH_TTY_REG_DATA_LEN	= 0x14,
+	GOLDFISH_TTY_REG_DATA_PTR_HIGH	= 0x18,
+	GOLDFISH_TTY_REG_VERSION	= 0x20,
+};
 
 /* Goldfish tty commands */
-#define	GOLDFISH_TTY_CMD_INT_DISABLE	0
-#define	GOLDFISH_TTY_CMD_INT_ENABLE	1
-#define	GOLDFISH_TTY_CMD_WRITE_BUFFER	2
-#define	GOLDFISH_TTY_CMD_READ_BUFFER	3
+enum goldfish_tty_cmd {
+	GOLDFISH_TTY_CMD_INT_DISABLE	= 0,
+	GOLDFISH_TTY_CMD_INT_ENABLE	= 1,
+	GOLDFISH_TTY_CMD_WRITE_BUFFER	= 2,
+	GOLDFISH_TTY_CMD_READ_BUFFER	= 3,
+};
 
 struct goldfish_tty {
 	struct tty_port port;
-- 
2.18.0.233.g985f88cf7e-goog

