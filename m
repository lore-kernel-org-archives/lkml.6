Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B4CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519222087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM4QQkfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfADTUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:20:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38249 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfADTUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:20:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so17871873pgc.5;
        Fri, 04 Jan 2019 11:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xA/cWPMCOgUpJyRRvPpDyTw/PWzyeClgpj9SwOIddGo=;
        b=NM4QQkfF13okOwjCVpE6YfbGOwxKZ7GDhbs14YiL6JzUV7XFJK8/au5uU6ksUuBDMC
         ZZWQKRvnH3jE80ys9M+arSQOR2jE+YI38SeVJj9nFqZYb72iN/l3R56e0a8yG49QUxvn
         MPVO+WQpmCzWrHM+QuOGRU5j5AwkxLxVSVUq3fkTrpSScB/Ds1JxPCIa4NLVEED9X6Sf
         pwTXzhrRpaxu4vKEn7pPLmPx5KwLD9X+k3WUjBK9vxqcsrR4Ej8ElIOtk7U91kLLmFhV
         oifUWMefGPWk9g5mhy6kBcDBBCERrU+NcozPOvl4G5GPujmlqRT5mTS9C9uARv49oHkD
         OX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xA/cWPMCOgUpJyRRvPpDyTw/PWzyeClgpj9SwOIddGo=;
        b=UN8i+QDEnWSC68dtI/ndCryCQf1UKSz/umSZ7PV69wJj/PKA9mf+DixtvmQlKFgjxW
         v8nJAMaZXnGSeqLle0tvgUsAzG5mhl7jHbvAJUgHiH9fGbB1+sxV8m2lKIxtMYB4+YZ4
         LO5Mng8LV/Qnk9zkSth+RFLObRYylSlrB+vYYIKjnYSQoG7Lu7Wd3Qtzg4Jox9oX1owu
         /LGaUGYsQBsyCo5lOraEvWdADhlTVX0YAZ5YzV3/M/8QyBqD28/GHlIGqAfC3H7Robr4
         3r5SsAgFPifYSkP22N3NbhLXbCjRUFrGzMyyBxb/7NPuirA4+ZdwIlAbJgvGwXc8qOct
         xyOw==
X-Gm-Message-State: AA+aEWZtesxO9hznb8iwk1sOdKCEquSVU4kE9aD26aYqDAFyUu1FWPN6
        5yBjx4+Q7GDkeMJT/aR9uSu75B9B
X-Google-Smtp-Source: AFSGD/VLrhgql/kTHZmmkT+n0gqsuhFFGdVqPhWYKnLZppc7OiNLfAAk6ejRTcphXGwc/gqzm8bEzA==
X-Received: by 2002:a62:1112:: with SMTP id z18mr53074916pfi.173.1546629611752;
        Fri, 04 Jan 2019 11:20:11 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.173])
        by smtp.gmail.com with ESMTPSA id q1sm97267210pgs.14.2019.01.04.11.20.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 11:20:10 -0800 (PST)
Date:   Sat, 5 Jan 2019 00:54:11 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, zwisler@kernel.org, jack@suse.cz,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/dax: Convert to use vmf_error()
Message-ID: <20190104192410.GA11084@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is converted to use vmf_error().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/dax.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 48132ec..ed39161 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1220,9 +1220,7 @@ static vm_fault_t dax_fault_return(int error)
 {
 	if (error == 0)
 		return VM_FAULT_NOPAGE;
-	if (error == -ENOMEM)
-		return VM_FAULT_OOM;
-	return VM_FAULT_SIGBUS;
+	return vmf_error(error);
 }
 
 /*
-- 
1.9.1

