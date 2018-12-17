Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84289C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A99206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN3LRotB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbeLQUSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:18:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32852 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeLQUSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:18:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so6656628pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=UN3LRotBmLU7g4NYrRKgWGuyzje0zXTtKnRBRlwk5Lu8DyWMsl6VlJf+28+6Wu8jUv
         3dt9zpCCKdA9JZTazgv5TcRWxgSUlsSdzevpGdqJpv8WVOO3IRZnrSkvKb6ubnohoV8m
         WBQRSZHxdT7S6ZEvQ/j1SuVSrVP7sby5mirPqSgW8uKaLKcjTIMx1gE8n8BCn7uBbM6E
         qNvm3sByxZ+GjVVz9M+zYJANQIHyzWVDgrbqWLHcnolk6INBvFGBnZnm5I3oFH71QBCO
         ra+TEojmKZjUaj3uSfaUG0YtsVnRJmnJwN0YlCBULNR12n8Uynxq3FKnsXpN7gHm1RBp
         29tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=uAtRWShx7hMHTlg+OaxyrY4S6KAS2aqdhKK0ojlyj+erl6mrGWV1HaGyPDmwgbpc9x
         6ZOOcaOIlqNTAXyaHwzdi8J4eip0y4zXfANAZz2btHpTxCHNi1YxSLpR7IzecPtymJsC
         KFIu90/Nqa17zBchxPrxkRyvSZGLDdPNB6P46yVc78GCpJX/TZztxZ1MEQTh5Sy8axGo
         Kp2O4+8s4w6IShO8+MJ482OlgW6HobMpFZb6mQb9lpusD3bH4K+00TPvpdvw7rn1MSva
         IcWDjwTQIYv2xiREGj3WYn/VpuCtImfmc6uFTCUDRH5yiB2htpoO0T3j880WBfwU9uX0
         e5gA==
X-Gm-Message-State: AA+aEWbfK0m7trwSVUPdSUvpxjKX89QbI6p42khndfyuO9qodinFOLwN
        ye4BmijKzAhbmUeppeBnhhQ=
X-Google-Smtp-Source: AFSGD/VZpPr1vEyhblYwvkUoYGzeXCeGHGsoaWXD+5TdUu/r2E6BL4B7uDKXBU7K9UAg8FWdanGGog==
X-Received: by 2002:a62:8949:: with SMTP id v70mr13708541pfd.85.1545077934004;
        Mon, 17 Dec 2018 12:18:54 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
        by smtp.gmail.com with ESMTPSA id f67sm18955733pfc.141.2018.12.17.12.18.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 12:18:53 -0800 (PST)
Date:   Tue, 18 Dec 2018 01:52:46 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH v4 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181217202246.GA10500@jordon-HP-15-Notebook-PC>
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

