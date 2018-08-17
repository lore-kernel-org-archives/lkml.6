Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FA021A05
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOUA4w2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FA021A05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeHQUiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:38:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42357 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbeHQUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:38:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so3874374pgp.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pa0lK3Aj1rxe07mkL0OZNTwWofCunayCAGbPe7r3Ot0=;
        b=qOUA4w2jbxu6h+V7cXpXsHIsOgXfAFc8OsN4cFTVYryMDi5CEeSGM/KXAeQEZRXeQH
         fs69tFMZPCaNqVNdTq5DMfBPY8klA1vc/3wwcvbiZ/1O+Jagl6aRd8nhFRw7kAPeB8AH
         duwdWkgP26FCFbyhaybm5aQjs6Zlj1MkZ9VF789kq37rRPe4reLy/8N7O6mqKQeQs6jm
         S/YKQugg2F3wDLrzJho0aAEvqfF+0SowofNBKXWfAwy3TN3F6/XhW199WHDEdUEp+Mrx
         KBXyCcUUdqb+vd/P1RK0p6DgMK3OSuSDBm4V/t6P1GypN6pAuyvwpJSxPv2LjxqiGaOs
         IElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pa0lK3Aj1rxe07mkL0OZNTwWofCunayCAGbPe7r3Ot0=;
        b=Fa0nSV5goxEHcvbYmV0RH+iBUM49OjxoyPviRaiRYcD96bHiVBd5wGuGjyDYV7e6rn
         jo+g9rQExDJeF/XUq8TX+eB8mihDWjRq4vbcG0bN4TV+SxQoC53F1GzOx8k7GycNuODV
         nS2WJVowGB+9i8NOH3MQgRABxfNQ1gmco4hJmQPohxHEhIaVdnmQV+MKhW5urey/1JqG
         K72BgS7i+0C4qYYqXaUZUHdbnO0p9BR4YuYkYtwSd34gRsKPhPSHJuJqAEHVM/H9ghoc
         e9HPIhFxqh/CSmifp/x34RTgN+5LQRheRQFQYjHuDDHzw788NRUjV83JkFIWmagpJbJk
         8ZTg==
X-Gm-Message-State: AOUpUlHBERAysLMVCTZ4JHnauIyZG1uNKrvChyPcexm3bTf522SSahi1
        j8cCCA49OX9yP0d/khmwMAYLt0QP
X-Google-Smtp-Source: AA+uWPyvqj5q+ZQFMT+5p8IlyENb3TV652EHQBeywCpNRRQ/izH6VUlEe5+jCFVGvmnteblf7DEpzQ==
X-Received: by 2002:a65:5307:: with SMTP id m7-v6mr31787808pgq.431.1534527238524;
        Fri, 17 Aug 2018 10:33:58 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:fcbb:efeb:dd4c:26d2])
        by smtp.gmail.com with ESMTPSA id l85-v6sm4076076pfk.34.2018.08.17.10.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 10:33:57 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Tim Bird <tim.bird@sony.com>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: fix typo in table describing 4.16 development cycle
Date:   Sat, 18 Aug 2018 02:33:30 +0900
Message-Id: <1534527210-1947-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix s/4.17/4.16/ typo.

Fixes: 8962e40c1993 ("docs: update kernel versions and dates in tables")
Cc: Tim Bird <tim.bird@sony.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 Documentation/process/2.Process.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index 51d0349..ae020d8 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -82,7 +82,7 @@ As an example, here is how the 4.16 development cycle went (all dates in
 	March 11	4.16-rc5
 	March 18	4.16-rc6
 	March 25	4.16-rc7
-	April 1		4.17 stable release
+	April 1		4.16 stable release
 	==============  ===============================
 
 How do the developers decide when to close the development cycle and create
-- 
2.7.4

