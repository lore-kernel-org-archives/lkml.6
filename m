Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E5DC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54980208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqOtFrxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54980208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeGHR6o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 13:58:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39580 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754239AbeGHR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 13:58:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id t7-v6so12425901ljj.6;
        Sun, 08 Jul 2018 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C3ewxTalH0Xjzs4mLGQ5RRfJQ7855pQzE7NHTdIYvgk=;
        b=hqOtFrxk3hJPa/8DPu0GYEMFeF+hCGr7dQi7A1Rzz7gh6pDYNNFlTQBK6ACCNyS6Qa
         qCTpU2qLcoXZ52s/RVkXLf1k7qd90nR95I/IssN5b+0KmAcMaQnOXQ1ZNafuJJ3Yei94
         DmISwkBjKDqc1aOLyEEmO98eue2ZuJ9/vrgYY/A22/uEjgFEllWa67VnL00jAn40q7Bo
         06Grc0QDDmsS1EcjMiItc2xpVTPpoD2/y4cX+LzyMWlfKct+s28ED0Lo2//vzgmuL/fi
         mLU6tRLueZYWy8pKzFEfGFqLxElOuqPf3iFmMTl+IsXt3e9KRbA106dH+E5qqQ9PWbYN
         LdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C3ewxTalH0Xjzs4mLGQ5RRfJQ7855pQzE7NHTdIYvgk=;
        b=hiJ5EZmDuT03hCnxKiwqECca+0XP/6onRDRUkLEZrP7FDVZ9gA0EhgMTeVrdsG4Xto
         SoY2PdiAFyJTL08Os2m3Zb6x4dCc9QdEgByY2PBFuS77vuQmWy89Yd5fPUmEi8Dx3/XA
         karV0gVQ+T4N3gK5uVtqBZsXs2GEfIv6QenHYQO4p34MI//WDCDR7Y6oaaOaRZrsOrHu
         dNcj3+UUdmwGlJOR+GZQjbD2GQNG0YyZbGFoqNPCdUldSDOkEhnzjOx1oSlOeB6m31R9
         XQXFXF/Y1xPsm0oKdr1Mbg7nlLYB4iIdOb4lIuZlyc3LaG8Yed5Tg/ZS6ojFGo+HYVUk
         vNLQ==
X-Gm-Message-State: APt69E2qNFHPwaPbDrF2Xv1vvbQOsgH5RCtm45Qa66x6w1ltD3SMAH1M
        94kIoNFf5lRFXkk21I08380zWsJgp4Q=
X-Google-Smtp-Source: AAOMgpdGq8qqEhBua4PD3sG87A2Ec1eI+71gXN61dvj/lpMCb7HlUp0UF0Yxuap7reDngL/QU4j/AA==
X-Received: by 2002:a2e:9d0e:: with SMTP id t14-v6mr6668189lji.112.1531072720998;
        Sun, 08 Jul 2018 10:58:40 -0700 (PDT)
Received: from abrodkin-7480l.local ([91.237.150.126])
        by smtp.gmail.com with ESMTPSA id a26-v6sm2033171ljd.12.2018.07.08.10.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Jul 2018 10:58:39 -0700 (PDT)
From:   Alexey Brodkin <alexey.brodkin@gmail.com>
X-Google-Original-From: Alexey Brodkin <abrodkin@synopsys.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: [PATCH v2] devres: Really align data field to unsigned long long
Date:   Sun,  8 Jul 2018 20:56:21 +0300
Message-Id: <20180708175621.6951-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on ABI "long long" type of a particular 32-bit CPU
might be aligned by either word (32-bits) or double word (64-bits).
Make sure "data" is really 64-bit aligned for any 32-bit CPU.

At least for 32-bit ARC cores ABI requires "long long" types
to be aligned by normal 32-bit word. This makes "data" field aligned to
12 bytes. Which is still OK as long as we use 32-bit data only.

But once we want to use native atomic64_t type (i.e. when we use special
instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
misaligned access exception.

That's because even on CPUs capable of non-aligned data access LL/SC
instructions require strict alignment.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---

Changes v1 -> v2:

 * Reworded commit message
 * Inserted comment right in source [Thomas]

 drivers/base/devres.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f98a097e73f2..466fa59c866a 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -24,8 +24,12 @@ struct devres_node {
 
 struct devres {
 	struct devres_node		node;
-	/* -- 3 pointers */
-	unsigned long long		data[];	/* guarantee ull alignment */
+	/*
+	 * Depending on ABI "long long" type of a particular 32-bit CPU
+	 * might be aligned by either word (32-bits) or double word (64-bits).
+	 * Make sure "data" is really 64-bit aligned for any 32-bit CPU.
+	 */
+	unsigned long long		data[] __aligned(sizeof(unsigned long long));
 };
 
 struct devres_group {
-- 
2.17.1

