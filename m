Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0988DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DE820856
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU4gsHP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DE820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeH1Wsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:48:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35711 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeH1Wsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:48:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so2144908edq.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q6GW750Fdnv9844n6FQeIVo7f6yjAHH1o8ao3enhz0M=;
        b=CU4gsHP3L4dCndcBqjH7NisYy42HW5NGIygc1PX02IfglbktlsmkK+wJRLY8spH5Y4
         EREsIfqRPC7tm56wsDb5ib67Z5IQ/aJSazdvsEWkHaixAOFRd4oCQ84cRimqF8+Odsjd
         pTAyTFbKSPmjENdz6MXi/1vWkzw+6muNmWcfIUPzgQCtkkmWeEC4mN1Xh1dXxnv8YIO/
         k/9jRuAOeX/+7WArs8UtOup4Uf4sMsirXfBkg68bQs7cr0IfpCJNRyTDKx3RkIVdFM8b
         7K8psEWfWmfcw+mPoWu2SNq9sa7k3IVfQ3BmeoJ2MkdJj2AJOSiF8tDDF1YjYnsJtgva
         7DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q6GW750Fdnv9844n6FQeIVo7f6yjAHH1o8ao3enhz0M=;
        b=KSPvXowLiIL+v4f7J/BvfhIb2yDcJwNdHjK01QhrwRwThXfMGXje1YeZ/Whhjhcxit
         tpm7ncSxNCh5nyAhs/OPjK0j0Ob0C/D7zZEBeOclMZWCtZTwqe+Oljz6N0kSgn4oZyk0
         0/9eE/sOVrPjs0XUaLWk1F8bD/4NtMiljk5qSiPe/aLCgSYzGIHHGaxhZ868yYmUltWz
         1VFxQ2f4j1nVNugxgFVWP+S3EVNs69kQYY3aC8PPeXYdwtytpXfRu8Ql4fvdnZn1paEl
         SgkPoEBjOqFKrVN7X+v9h6JBJg+kR5uoIvO3Ghw8RbVOMCVVbQP7Dc23Z3E7ShUPhpqf
         qS4g==
X-Gm-Message-State: APzg51DOD0nn59zrrOV0e2LYG9Ieu/mLisPM8JTH42nvzmbaH0xeOnV8
        UPVhfsXleH53MPZAQPFtEj4OgelY
X-Google-Smtp-Source: ANB0VdZtsFuvnp9frazMW80sOFk8uAAa1zERWUN1vcWbcH15SZOW6gCVpK5RGTiNyYflF1ju8WYdvQ==
X-Received: by 2002:a50:d4d5:: with SMTP id e21-v6mr4046053edj.127.1535482551525;
        Tue, 28 Aug 2018 11:55:51 -0700 (PDT)
Received: from localhost.localdomain ([109.79.175.209])
        by smtp.gmail.com with ESMTPSA id o24-v6sm742975edr.64.2018.08.28.11.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 11:55:50 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 2/4] staging:rtl8192u: Add required SPDX-License-Identifier - Style
Date:   Tue, 28 Aug 2018 19:55:33 +0100
Message-Id: <20180828185535.28808-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828185535.28808-1-johnfwhitmore@gmail.com>
References: <20180828185535.28808-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required SPDX-License-Identifier to the file r8180_93cx6.h,
this clears a checkpatch issue.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8180_93cx6.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192u/r8180_93cx6.h b/drivers/staging/rtl8192u/r8180_93cx6.h
index bfbef1a16159..0cdd00a4f7b8 100644
--- a/drivers/staging/rtl8192u/r8180_93cx6.h
+++ b/drivers/staging/rtl8192u/r8180_93cx6.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *	This is part of rtl8187 OpenSource driver
  *	Copyright (C) Andrea Merello 2004-2005  <andrea.merello@gmail.com>
-- 
2.18.0

