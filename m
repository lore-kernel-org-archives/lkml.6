Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A982C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB952146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epRwUqy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB952146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbeKPBwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:52:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33348 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388571AbeKPBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:52:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id w22-v6so9674565plk.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 07:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=epRwUqy7htlLmwiI24Igzw3C2oNh3YVt5/KrBuU7kZgm/q5KyELQgGneXGQT7KYl56
         a3RPp7G+9jGSYocoRz61BXFqCxjj5kjQ3gfSEKVVQLgHz/flWOteAimfOtCvbbgEYkG8
         CcSujgQPd2yZZI23W0wET8wDeoaj8n3Nf2JZsVNdKJhDeJv6vb3FP/jiMdHqHt2CJln6
         mAZJudFpETbCbNZLF7yseNL0Tskx0lPoRljbm4WuBW6I61un7FVqA0Tgcq3pBkkrXTrA
         xkOW8ZMIMv2ZW/Lf/Exdd1gaUYmfX8+qHWP7IGSrnJsyltqvS2md833QBVWTLl2eXkdi
         kXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=b8EYpiX8SHxnrC2EoQEYwdqRiLnSApTqQtywQ4TXPTnZgf2KHUXIZFJAB6BGY8lgex
         4Hdwv4l1/f3RQ5rLcGJbRtMMKZj5BivWrfO/zf4FCRh+vI3lA2bnBKP4nKPcyEOln82V
         CMVlZjpT3TFZsn2boLp1hLYhHBtYQ2yQHG4OWgnGvrPOGRKHkjj8itUNaHQiNKOGCB0Z
         6ibUM1Nc0jGvZ0JJKcNlyuZC9VJtz610mbO98/1Tb5woQEHu8oF70Ztf/kSB0re1PoEY
         2eammlp8VMo1dCDD5+yZvUTLcMnRZmUbWB9UIk+2H7maaQE0ByLYzD7zUgokVF8hKjo5
         D54Q==
X-Gm-Message-State: AGRZ1gIUNPy5vufbOTF5G92/EdIeikOZWvrOakCcldJAY1ObR5gMN742
        elxK+gG5XR4s7q++6PBaihI=
X-Google-Smtp-Source: AJdET5e2nV1ILwV25QmCQEcQZKLe372AfAKrda1ioGmmzBYIfWQwY2V+kpm1Wxo55YOkrsox1AToPQ==
X-Received: by 2002:a17:902:560f:: with SMTP id h15-v6mr6963057pli.160.1542296642414;
        Thu, 15 Nov 2018 07:44:02 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id x23-v6sm27487376pfm.126.2018.11.15.07.44.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:44:01 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:17:38 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181115154738.GA27932@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range to map range of kernel memory
to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..7bf28bb 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
 int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
 			  struct vm_area_struct *vma)
 {
-	unsigned long uaddr;
-	int i, err;
-
-	uaddr = vma->vm_start;
-	for (i = 0; i < buffer->page_count; i++) {
-		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
-		if (err)
-			return err;
-
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_insert_range(vma, vma->vm_start, buffer->pages,
+				buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1

