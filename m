Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99330ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A99D208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpyjhNJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A99D208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeGNGQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43042 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbeGNGQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:50 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so23747624pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/lG11//XbutELu2W303oCQpO6Mf0CqnCNtEX6wPXWzw=;
        b=fpyjhNJHI2MeiMCQSCzjkCvpJ6XX7EhYtxTbC4XiZsyyjPApHuBaHLZYWhSW4jD5PH
         k/FDI7vtvObjXdU3kClrhNZZTFOgSgJEXFfsY3/J9Ud3JHEifK8XMXm/QjU2M3x47KYA
         /i1i16SnSVQdakHrLdq8wgV5TZI5CUxCHRwOcxyUh7pMfddEGP/BZVndvPOwMUbkfGFf
         Yer5P/jz4TMmorIyi51iKKWXmjupDdxyJxe9tCjVuVjb8/q0fd7ZyuQMQjcuRhLLwWej
         DoHQBquO3eGXq4qLx1xILF1kgd9x1Y09672ZIBGFMb8Kr4jsDNp29vmTcJhW3bVRlnPp
         219g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/lG11//XbutELu2W303oCQpO6Mf0CqnCNtEX6wPXWzw=;
        b=e/4/pq/gW4ZzXxDsBUFXjuWxyrazu06KgcSV9JZXFnp2Z9bhW5gl0xcids9eTIQExL
         0pU+WzkntdAHofOV0oOTrfifRn6G/QiLNkQBhoDcT6AL7VHzS6rIwiZEA9ebRJdlwhgD
         7ML0c+ycq7+SElzoTyEbUTlqyxHOk0vTGpzA1n94eRw0aL9Xob0m7inmrWugwHZHN0A2
         QXC0r4IfcUQm5ATfV8+Ka1e1BJmma9WZCK+zW/M4L8bwM3RB+f6fSdHfIwsenYvqv4GC
         aVV7VMvlfeogxV9lreI8AtYac0BnmrJHzHM4lIlhFvH4y4izfn+NI3AM9qvOj0K+Pdgl
         FdsQ==
X-Gm-Message-State: AOUpUlEk0Pc3ZjjkrrRvXI7H1pUupOKZp2LXJIW5CilRX7mOjkgVNAQL
        h7vsbdITS9s1HrkKME50NBw=
X-Google-Smtp-Source: AAOMgpc9OzXfTpMgvNNGpP23O1171D1WiUArQxu/2J9RYVv4pfVqwXacHYrn7SYxZGEJkZrvkZZJTw==
X-Received: by 2002:a62:3cd7:: with SMTP id b84-v6mr9997137pfk.183.1531547941112;
        Fri, 13 Jul 2018 22:59:01 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:59:00 -0700 (PDT)
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
Subject: [PATCH 17/18] staging: gasket: don't release coherent mappings
Date:   Fri, 13 Jul 2018 22:58:15 -0700
Message-Id: <20180714055816.223754-18-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

coherent address mappings aren't backed by a struct page, don't need to
be released, and don't count as an active page in the page table
bookkeeping.

Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index d7600d8e385f..9a4a81c010f9 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1248,7 +1248,7 @@ static void gasket_perform_unmapping(
 				dma_unmap_page(pg_tbl->device, ptes[i].dma_addr,
 					       PAGE_SIZE, DMA_FROM_DEVICE);
 			}
-			if (gasket_release_page(ptes[i].page))
+			if (ptes[i].page && gasket_release_page(ptes[i].page))
 				--pg_tbl->num_active_pages;
 		}
 		ptes[i].status = PTE_FREE;
-- 
2.18.0.203.gfac676dfb9-goog

