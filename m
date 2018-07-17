Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F57ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2C920693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0l7e8ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2C920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbeGQVjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44360 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbeGQVju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:50 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so982838pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f3oOo1doapcIZekf40WAQZzHIDySlunaMke9oi9rAUs=;
        b=g0l7e8apFYeb5cCU0Eh1KROwrwZeaFd8V5orm3ZRWuvnSfNm3JBvN2IfpRM7+Rjo1z
         0i+6rCIU6VBBr+/IlhboIeUjpY6gjlRMNKAtISJEjH7oHziuMNeewcYCWkQojXNOcAvP
         783vzkSOoCB0s8hFuse21GTZ4KvTLGpEu+NVBzRV5RXMBTKXDAsfoBdMs/Ey7coRb+wX
         rWbovBZkzBKkgYZmy7S7DFthTC8lFdZuLu5d6Lui42oI/qU4pPjt4mDjrLz008qhCh9M
         qfQl7ZsaQQiTC3B35amNDjXzVm8SokXiL44XnEy50n0Ld6sllcNs/FM4WbeebA1wgRmu
         c6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f3oOo1doapcIZekf40WAQZzHIDySlunaMke9oi9rAUs=;
        b=t/CwnF82WnBHqAXKiT/Ou8x3WuACaY4p1XlL3mnY6cngecQjvREU1ccfi2LB4Yz6Ec
         PaAepVGHpdOu+Va+q/6ygsSflTgCunbFK6qVjLUEsq4bULs3zTdpx+7AuW69ks32d4uV
         ZlFSiiRLcpG+oSVSOI5A8qMR3BROBGm1KJIhZvx+EC0g2rc/5jX1fYbGgs9e0LM2oYfj
         izEuOug2mknL8OBckyjKoad2Crw2ziJEs1x3g6TkOt4zNReXZgvZWe+omYXM5498C/c3
         oN+KlIg+OGV3wBQXsVIF8PQTDhdiF0DPMCYNnTL4OczEIMwAbxmYOevCa6yN1TH1VFz1
         /FAw==
X-Gm-Message-State: AOUpUlHOgaPCF8tfqn+O+gS6sbcQ2Glv0c7GyojyROObxyYWiK678ZxI
        PpXI9sORJvcniUPrLIZWbFE=
X-Google-Smtp-Source: AAOMgpfsxBNolzLP0HbHjtY0wRBX0EIyGIgkeLZYQZ+yhn3h4RntmDhX9RlbEXlu9Jx5xFcXE1Z1rg==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91-v6mr3088957pld.27.1531861522839;
        Tue, 17 Jul 2018 14:05:22 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:21 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 27/32] staging: gasket: remove else clause after return in if clause
Date:   Tue, 17 Jul 2018 13:57:07 -0700
Message-Id: <20180717205712.29495-28-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Else after return is unnecessary and may cause static code checkers to
complain.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 2a27db658a4e4..617d602b8b447 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -598,9 +598,7 @@ bool gasket_page_table_is_dev_addr_bad(
 	if (gasket_addr_is_simple(pg_tbl, dev_addr))
 		return gasket_is_simple_dev_addr_bad(
 			pg_tbl, dev_addr, num_pages);
-	else
-		return gasket_is_extended_dev_addr_bad(
-			pg_tbl, dev_addr, num_pages);
+	return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages);
 }
 EXPORT_SYMBOL(gasket_page_table_is_dev_addr_bad);
 
-- 
2.18.0.203.gfac676dfb9-goog

