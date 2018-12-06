Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4A3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DA821527
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbLh52nP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DA821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLFShy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:37:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34431 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLFShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:37:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so569476plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=fbLh52nPpkqcT1Z9V3ynz6uiPBZF5qfoJ7/hPEZvBCMX9CeGjmuiaMJt+rxLafnLa7
         f/xYhIOsoC0o/ferMj/eZvUp5HVv4NMCx/xUGLT4rts1Z7F6Ekp43794GO6SxyUjq41C
         62Wr6dgG7VRi3tjWvD2US+JF0DTPRcxDbkHYRfJ0H+SUa5FM6wr3LYGbjxxPgweg7mGO
         sZE9GdYGcKvIWQseAlW5idOnudxqMDkBFLSpmuI7zJ1qNdogSjACVAFOtRLMxidohXSa
         ScDcjF5aHzGL/JZZHC+dhbQx4sQctZ2rE77G+oqhq1rYOkSTTueCdoOBKkz4sBuPsw0/
         wcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=XwW6+uBIWIYvlxnzqKXTckJnkxM3TLIizi4dVYFzQX8B6ZXIrqfbZ/vZt1swJsI/JS
         LFiDnDAQCuaeCp0hM9EhoNHSh5lmihy1XlbeL37iRfVZEh1Q/Np7nLTUYHOcnXXOsU/U
         +UHM8j3yhPPem2KPKHecZNJ395d8SjqguoVIJRDrM86GtfzD8wgejksv4bWO14ZIUKBJ
         n1jLaujecDjv0mJ00mUo7ipcSvMvoWA4IwVeGRKSrO1FyXVvbxlZvRDpvrfYypEeO4LA
         chBlTs0cgsGseKIyk5D94rMhWzjkx23jOlRrfQnudoRO4pTVl9DiWJDz7UEFSG2ZfZir
         yCEA==
X-Gm-Message-State: AA+aEWaUiMWOaMJwuXrPogtWCIVYqppU3kqkJHM9ApcMP3GV49oEa2z8
        bZ1EXYCJN0G2CZQdpOZxQ2SToWjj
X-Google-Smtp-Source: AFSGD/UDqrBQcxC59f83l1Xagr3hCTLl/ORxA4W+x1FMEYcVxWh5JAcv00gbvM11R+DxMrDXnFwY2A==
X-Received: by 2002:a17:902:9a41:: with SMTP id x1mr2169801plv.126.1544121473041;
        Thu, 06 Dec 2018 10:37:53 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.39])
        by smtp.gmail.com with ESMTPSA id o1sm1621229pgn.63.2018.12.06.10.37.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:37:51 -0800 (PST)
Date:   Fri, 7 Dec 2018 00:11:39 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH v3 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181206184139.GA27514@jordon-HP-15-Notebook-PC>
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

