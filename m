Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FFB208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+uPBFqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FFB208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933546AbeGIT1X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:27:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42342 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932795AbeGIT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:27:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1-v6so12126825wrs.9;
        Mon, 09 Jul 2018 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=arriw062GxiD2niqrPzE/26NKdRl2RA5LenzNwze7Ao=;
        b=q+uPBFqt/r7iJRPzO2gcS4bCAufsOAT+WKzdXuabF+9EKQmFZ2a35u5B1GE56EAdDo
         6r2GPsAfMTxUbIr47HgP62G4GaJLLdSfenyUW4YQcwwEj9mNnvIBmR2jkEeIJ+BPev9X
         bNkrt+GR2XTnPOQaLEzYOln9ZeZx3sJMI2UGmcv/CaXWtVMVvV4LTTPmfkWHXgNO/CzR
         sz6WBrzQgf3qGqm+BzwUFrdKdcoT3ml10Mgy19wl/1ovWaLUGLxYM19FOaHlCp7XS9yI
         01DL2/Jodz21VgDOYgCKOJ0YIS0wkH0cgtmKCaZCo6Tj750zE7ap8nG0xJGfXvLKhZxk
         jTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=arriw062GxiD2niqrPzE/26NKdRl2RA5LenzNwze7Ao=;
        b=ekfsLTdvUgdXdMh9wOId6O2mFgf8FtMzxA5l3aNKBRmxjAszEbNW+eigaCTcjjjh7m
         +eTNRTBW7mcNG12Wmy4N9OR703Fzfx9Lj2kcU9UTZ1c6u1WgE8Zx6JcLntt7RNjY6ZoK
         vc++Xkp6uqcizz2YCtpWPa2hm3ZHi1ZjaR6HBZBfE4Z8auk7HuJdw7bLKpeXuS/emR4a
         DKGLEsBeYWVGrnmNMVCLogRi8Uh5tp98WjeBw+bk9Eo6Q+txVo3bfdjpTr/Pd4kIlXVZ
         q79w/j1ayMoUFIjYW14u+aFuQ39WWBPnB8r0k6uYUAiypTVR0HAqUB6D+exaLKA4h5Pc
         vExw==
X-Gm-Message-State: APt69E3QDJhFphIYIhgBS6COgijwWoeKG2tTZhsVMPCCWcJI53hCjpOs
        nL9aCgEQTiq2TVOLbJwd3z5yeApV
X-Google-Smtp-Source: AAOMgpfk0CtUS/30w5c9nEescl7ibTIgAYecm8Gojb1M6KzZXFJdae+npZgDxAV4jMg7O2CRlKVb8A==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr16275763wrj.109.1531164440268;
        Mon, 09 Jul 2018 12:27:20 -0700 (PDT)
Received: from localhost.localdomain ([185.175.214.210])
        by smtp.gmail.com with ESMTPSA id t11-v6sm11685426wro.53.2018.07.09.12.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 12:27:19 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [V9fs-developer] [PATCH] Integer underflow in pdu_read()
Date:   Mon,  9 Jul 2018 21:26:51 +0200
Message-Id: <20180709192651.28095-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pdu_read() function suffers from an integer underflow.
When pdu->offset is greater than pdu->size, the length calculation will have
a wrong result, resulting in an out-of-bound read.
This patch modifies also pdu_write() in the same way to prevent the same
issue from happening there and for consistency.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
---
 net/9p/protocol.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 931ea00c4fed..f1e2425f920b 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -55,16 +55,20 @@ EXPORT_SYMBOL(p9stat_free);
 
 size_t pdu_read(struct p9_fcall *pdu, void *data, size_t size)
 {
-	size_t len = min(pdu->size - pdu->offset, size);
-	memcpy(data, &pdu->sdata[pdu->offset], len);
+	size_t len = pdu->offset > pdu->size ? 0 :
+	 min(pdu->size - pdu->offset, size);
+	if (len != 0)
+		memcpy(data, &pdu->sdata[pdu->offset], len);
 	pdu->offset += len;
 	return size - len;
 }
 
 static size_t pdu_write(struct p9_fcall *pdu, const void *data, size_t size)
 {
-	size_t len = min(pdu->capacity - pdu->size, size);
-	memcpy(&pdu->sdata[pdu->size], data, len);
+	size_t len = pdu->size > pdu->capacity ? 0 :
+	 min(pdu->capacity - pdu->size, size);
+	if (len != 0)
+		memcpy(&pdu->sdata[pdu->size], data, len);
 	pdu->size += len;
 	return size - len;
 }
-- 
2.11.0

