Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31EEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7912F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJTV2GMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7912F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJJJdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:33:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37848 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeJJJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:33:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so1732347plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 19:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=swzdF5gQLX9lUsKuPNJqKKcFN3bk29lT9GenMhcfUCI=;
        b=LJTV2GMAME5i2OORyGmQHeYtl8c+PmNtQotnrSBsRNjU3qagzETt8HkeTUBsijY4uo
         c/gClD2Kgj0vxyeLxBzUs4AMb3ZdR2MfZsaMyl+vwgyH/GwJ3uFBecLXhtEQ8iEP16yq
         H4grTVHCxGM0uni9SQ5D2Sdn+U1PtbfgX2FwESQwU5ShzZEjK//uRXiYpcOypH7JC1uW
         RI+z79KzqUkSUNKgVEnn4C0fvEMXfmeTsCOPY8OlN4mgcJV2ZljZaPhxe0hrw8H2xMg4
         ShJ5lE0Lfpx+hSLlm3kmKGVHgeejHrBEFJTTolhEetGDDhaPeZvFlYboN8kmOjCsGp7+
         7Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=swzdF5gQLX9lUsKuPNJqKKcFN3bk29lT9GenMhcfUCI=;
        b=G7GzW2OQ27agvoqB4Sf/svpon6FiCnEEYXy9FZYIP/2H8dGoemiY6ps6MaovoWGFyr
         oCNS3GlXCRVvfgVR8K2OUtalMnK2/dPJ9S+0SvoWcIZM0J1LNmmrC4MbuW1ccfL2l25h
         357t4MMbF/OoX70IKNgMaKfzJRCxmyKSfJoHTO3L2fnIWOZ8fJgGe5syOAw2YCqQMp40
         7jRQcEH1v366ggtAXPaHASNzNGUm7Lzs+knQbIozmKKBbmaxLM9kzXdRGf9FlUaOZ31K
         PNgl95osDl4l8ndp0BYfHI+Wq6vcYEWOsCB2ivTlJyE8ctVKczBV9kHrHqMZf4OGfjwX
         pcuQ==
X-Gm-Message-State: ABuFfogvGuQ7aqxeZ8SJfSCkfg6WwCNATUywXBlxOjnHt5Sfpgnxx2vk
        MnZ1saYwMjzTgalZZ2qnsaA=
X-Google-Smtp-Source: ACcGV63DFHzbWnIAiRq7gjwHxYaedU/7/zbJaogFF9eT684upsMuRnkcnb5jjIQ8hCgxS59wN0u13w==
X-Received: by 2002:a17:902:b598:: with SMTP id a24-v6mr30865258pls.40.1539137640035;
        Tue, 09 Oct 2018 19:14:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t26-v6sm31749417pfa.158.2018.10.09.19.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 19:13:59 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] lib/rbtree.c: fix typo in comment of rb_insert_augmented()
Date:   Wed, 10 Oct 2018 10:13:44 +0800
Message-Id: <20181010021344.60433-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function name in the comment is not correct.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/rbtree_augmented.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index af8a61be2d8d..9510c677ac70 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -51,8 +51,8 @@ extern void __rb_insert_augmented(struct rb_node *node,
  *
  * On insertion, the user must update the augmented information on the path
  * leading to the inserted node, then call rb_link_node() as usual and
- * rb_augment_inserted() instead of the usual rb_insert_color() call.
- * If rb_augment_inserted() rebalances the rbtree, it will callback into
+ * rb_insert_augmented() instead of the usual rb_insert_color() call.
+ * If rb_insert_augmented() rebalances the rbtree, it will callback into
  * a user provided function to update the augmented information on the
  * affected subtrees.
  */
-- 
2.15.1

