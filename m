Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39CCC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3741920874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W21AB0RU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3741920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeGVOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:35:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46992 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeGVOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:35:14 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so4541473ply.13;
        Sun, 22 Jul 2018 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Cp2E+n1aEGt2RO5SPGkxLjDiP4UrKPVu2oDh3fvK290=;
        b=W21AB0RUFurFd6p1bzp4lBqh5ZCLt0/ZWu95cApKkt11fW4pyHYdciNPdFNNV7xD3P
         SH/Y+4J+ffJPLRPQFfYjszL7W80Ne6wo9IqsTm6or7YcGzefcw+5AXvRpY9vrWyA6oE+
         /icBikluynbhwjp7+pCzZXaWRSskzWMV05FOLYSkUm1MioNP1xk3UGDhHFKQJWQBFx/I
         IjoXn9RJqZmWfXRWSRyIs2gAXRdXd4xeOVv1KxTJieV92Rh37NS4zmlgb9iRXNAMe0JM
         PohjPu9rwYQJ9YYFI2SRj1Wg6sNN6nbiRA5UxCyzfDKafVUZIKn9qsVNsLubXPcuAlSO
         R78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Cp2E+n1aEGt2RO5SPGkxLjDiP4UrKPVu2oDh3fvK290=;
        b=mUMWFsjsNYj0bHjNAKHPeIvzMkeYRzL+zOHa7fL7HPnWofuJApqO/ez7BW3ZZFtLGR
         UBYJ7PlgUtjjPs91TU9opxE2J2eWKHR+9XOab0LG6DfZuPNnUu6Dr5HL/06l8WfgF8fq
         etD1WXH1+wnZa7z++2kZglaqWKQvuYFJNlp9sYVAOSiuuvaaZbXcqsh8xfluKEQAd30W
         2VigrVrSItKny8EBwKeANneTKmqBIhuiOCUq9l4M1ETWU6PYZnlj/Lk0DKMe/odCQ0m6
         Tlv/0TczfZtVwbmvWauzMZvmsE5xW/Z4Lm/Gvq52296ER6lRPJElvU9nq+aW8Mky6qkM
         omYg==
X-Gm-Message-State: AOUpUlG/g0A+17YkD5q5vp2eazTT5v1p1uivhTfWQYhq8q5Q2jirkEze
        TwPX5SE02OCfdMX+yW8yvII=
X-Google-Smtp-Source: AAOMgpeEG3JD28EsUPD4qtm3BiC+PnL14HbeTXZg9mUOMgHhWAvNxXZyQZ6jB5fzPUiF+VQ0oBLTFg==
X-Received: by 2002:a17:902:8f96:: with SMTP id z22-v6mr9228538plo.190.1532266710771;
        Sun, 22 Jul 2018 06:38:30 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.185])
        by smtp.gmail.com with ESMTPSA id s66-v6sm5973666pfe.53.2018.07.22.06.38.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 06:38:29 -0700 (PDT)
Date:   Sun, 22 Jul 2018 19:11:09 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Subject: [PATCH] arch/s390: Use new return type vm_fault_t
Message-ID: <20180722134109.GA31840@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use new return type vm_fault_t for fault handler vdso_fault.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/s390/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 09abae4..3031cc6 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -47,7 +47,7 @@
  */
 unsigned int __read_mostly vdso_enabled = 1;
 
-static int vdso_fault(const struct vm_special_mapping *sm,
+static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	struct page **vdso_pagelist;
-- 
1.9.1

