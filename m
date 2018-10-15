Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C1C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C59620652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyNOeV2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C59620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeJOMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40898 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeJOMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id 1-v6so8663288plv.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yW7igPwEjpTC+CrL++x85aD4YuqF+jPbM6yhsz4afy4=;
        b=GyNOeV2o+TFHfRnMIVMaotjGTnsxsgNsCjZJbO43etslqMCJeQqcY/ROjGq1+qkQxU
         hljb/1eHNWevzKOfy4tjXjBsg90nGr3t+mndiin1gaJqBP9LYUrENcKrpXRrcH1qpl1L
         khR1Cohde2kRmPI8PPSpVbsU3677Vc//db6wuGx7tJvtt6t+EoYOtqflXgu/MkFX/WfB
         NeVVzXSTD5fNwOKLRRyMblNvrEzUG5nelWL6HOPYm4R0KE9LIIS4lGJYHEfYgEBLiXbj
         hAxDDkhnJAIJmCtCdjWnySQoMmQ9s0+H5z8Lj3Q9YfyBHC5nHkdZCZ3ahl2SCemdx9py
         L42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yW7igPwEjpTC+CrL++x85aD4YuqF+jPbM6yhsz4afy4=;
        b=FzZuQfSzxtj5O6PeOIP+27VW8G/J8cieVLcNX8dez4nbJ2hNdfiZAD0JSPOCHICv+Q
         29xloq3fm+GPFoq3d/rOl/FIoNuJsi8RVxINGScNz37J1kY7561fNUSC7eTSO/2xI5OK
         3VUwr3viDw0/rhLPIxCDCrAqqJfc5YXieym3GU0jG0IoXczCWyrwHI+cd6NTyUalhZPy
         QcCmo5yUcbBx51G7SUbz8DvTGm+V4U0OjxDGeHJ9zt9y00NfwEn/hJBC/6Zx40B6r1Dp
         4WfYW9OAkzVyKp0EOUKY7IqHDI5IqDkbEX9Q3xi1XzPd7xclGbXq+N2tMe4QJPiw2rV+
         yYTg==
X-Gm-Message-State: ABuFfoilaw5zmcUpkQb7zXNk+oOCQqti+uMrbhvgiYWTVNWWwDDggxPG
        DjEQsWBk+XPLmxgVamy6fW2BjPeh
X-Google-Smtp-Source: ACcGV601/MmwUyXJ5Pmx6PtkZ8sUY/QkbpHyT3H+l3gFI2qxx7c20oNShj5zlr+HgK8j7sJ14DcyIw==
X-Received: by 2002:a17:902:43a4:: with SMTP id j33-v6mr3929814pld.131.1539579601379;
        Sun, 14 Oct 2018 22:00:01 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.22.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 22:00:00 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/11] staging: gasket: page_table: fix comment in components_to_dev_address
Date:   Sun, 14 Oct 2018 21:59:23 -0700
Message-Id: <20181015045927.156790-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Comments in components_to_dev_address() describing examples are
inconsistent, fix these to be accurate.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index a88f2ae0cee8b..ec9359576ea7c 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -687,13 +687,13 @@ static inline bool gasket_addr_is_simple(struct gasket_page_table *pg_tbl,
  * Convert (simple, page, offset) into a device address.
  * Examples:
  * Simple page 0, offset 32:
- *  Input (0, 0, 32), Output 0x20
+ *  Input (1, 0, 32), Output 0x20
  * Simple page 1000, offset 511:
- *  Input (0, 1000, 512), Output 0x3E81FF
+ *  Input (1, 1000, 511), Output 0x3E81FF
  * Extended page 0, offset 32:
  *  Input (0, 0, 32), Output 0x8000000020
  * Extended page 1000, offset 511:
- *  Input (1, 1000, 512), Output 0x8003E81FF
+ *  Input (0, 1000, 511), Output 0x8003E81FF
  */
 static ulong gasket_components_to_dev_address(struct gasket_page_table *pg_tbl,
 					      int is_simple, uint page_index,
-- 
2.19.0.605.g01d371f741-goog

