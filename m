Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030A6ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07B021532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xec6ernA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07B021532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbeIVScd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:32:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39815 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeIVScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:32:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id v77-v6so13193115lfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCaiOk3F/KGB7VVMwtkjn1h1KxQNoK32W3u0wilmq9Q=;
        b=Xec6ernAbprb5FhQ6kJewQjG9Y0N9XeFqvrgRT88cGffsAbUzhzBBfw/2EJJNRvD99
         LUDc1utUmYyC42tK7rnvJptZCuVx4dSnmsBhMTUS/sx7lDnJr0BVvjV4wdNrYikL/RHX
         zLR7dlInoPwFisTBGjLgR/rW2FZ11Ax+eAdLSA1x4asHl0aB1yLHJLsDgP+xLvDZkXOw
         RqIEAIAXi31tbY1jHPYkQm7hFcbSBWT9WzlGpCV2qGIHok3Q3hyE7imZDcCgePB7+g5Z
         mLhT7D76PWz0Dv6MzjJI3jMSTovGhDF0zmTOx/MscYo20pVr3itoWx92G880ZpLeHekF
         rZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCaiOk3F/KGB7VVMwtkjn1h1KxQNoK32W3u0wilmq9Q=;
        b=Np1dyzfMgqpodPhKoS/lruJXBQRSdprlYbDh4xnqrz3XNkYwj8LgMAtR0HhA8F/m7w
         Tyt2UhpnDi5V/ttGQXIHJ4Mi1MkY7mz4Mr7rsIFP2jLMY6Ii24VHpvJfqvbtdvkIrbMF
         en9hFdjtZVqokzUH0c2dAE4UbT7tsMop027LYU/K9zCGVMoZqH7sScx3J4LE5OG2H/Ys
         HXObhRhGvEkMAwfJBCze6VpK03udXW3syUCv7cDYI9OBdL+zq+WxHUeLb/YkTIGEfcsh
         g2sVjrDT/c2jQui8KOZ+w85MG0PIikcCsCmRsoHD48w41L/V3zbHumF6PRNS0xek92Br
         zOfg==
X-Gm-Message-State: APzg51D+c2WBPxzU5VQ7uBZAR0Xf0ioe6nmGfL+wbFfaJrevhDD4S8rl
        akoKx1JJNkT1d3zV1WxEons=
X-Google-Smtp-Source: ANB0VdYRLQ2tZB8Ovz/5jdOpBmBYX/BAwxS055/4R6o22KMa/jH049I+/jYJqcalPGChkNtv3ON5NA==
X-Received: by 2002:a19:1447:: with SMTP id k68-v6mr1525623lfi.4.1537619944499;
        Sat, 22 Sep 2018 05:39:04 -0700 (PDT)
Received: from VB.local (89-64-36-36.dynamic.chello.pl. [89.64.36.36])
        by smtp.gmail.com with ESMTPSA id b20-v6sm2766061lfa.97.2018.09.22.05.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 05:39:03 -0700 (PDT)
From:   =?UTF-8?q?Przemys=C5=82aw=20G=C5=82=C4=99bocki?= 
        <glebocki.przemyslaw@gmail.com>
To:     eparis@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Przemys=C5=82aw=20G=C5=82=C4=99bocki?= 
        <glebocki.przemyslaw@gmail.com>
Subject: [PATCH] audit: fixed a braces coding style issue
Date:   Sat, 22 Sep 2018 14:38:31 +0200
Message-Id: <20180922123831.1571-1-glebocki.przemyslaw@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Przemysław Głębocki <glebocki.przemyslaw@gmail.com>
---
 kernel/audit_tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index ea43181cde4a..3d0e45fa765d 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -112,10 +112,9 @@ static void free_chunk(struct audit_chunk *chunk)
 {
 	int i;
 
-	for (i = 0; i < chunk->count; i++) {
+	for (i = 0; i < chunk->count; i++)
 		if (chunk->owners[i].owner)
 			put_tree(chunk->owners[i].owner);
-	}
 	kfree(chunk);
 }
 
-- 
2.17.1

