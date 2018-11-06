Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AF2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7115F2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp/akpEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7115F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbeKGC7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:59:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36784 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389511AbeKGC7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:59:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id j22-v6so6440016pfh.3;
        Tue, 06 Nov 2018 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p6YAtqHsFGgofHBb9vkoVeDlZQj+6PsuEvkqGA9ef+4=;
        b=hp/akpELh3OiApLA30tGzezwxeP0WUgDaPIW8kGPUbgyL61H3EkTuCW501AAPFrxWX
         5f1lRXhB4Iyx8cf35G2QbkV0sFmuliMDDziDsNOMPaKr8mImX1+5g0vxdnYOnCb+F+6P
         XNRUf4gns0RDlOOeYVOVwwG/fX4IYFdQd1UbVQH4pTtb6FxH8336dmlma3MPGz8kDmT4
         a/qFcXhTy4MybKXug4eQS/HH6r87+RQ8fyHA7qMEhJO21cr8JNie0lrxgp0Y0I/KNktu
         zld9on4SNhDwAkIKueybqXKIGOSk6HwKC3nPHIqG8JPvy+4ZCCxxgP6+fT8L+8zGbd1h
         VBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p6YAtqHsFGgofHBb9vkoVeDlZQj+6PsuEvkqGA9ef+4=;
        b=UGU5MpEY2s+grBiXx/6N9cOzIoQvqpFB70q4VKHUXp56RvtIog9Km2vcVpEQycFHeX
         aXXobpNXYHh5XAtyNSLKvx2Zsdn+iRQtLE11zPbsY0SN+GSva43ghG/LhpNZH03VJa/V
         OCWfH8Kyby8sq6uDbzNlSvB5W6O/NErbzBz/ry0Od4AkI5jgur/d2K0L4If+atOe2pLm
         J4Bxfv+3G739L9XW7NdjqcexJ3qI1EyW8ztnvD5EKTnrcfuC6P69YZ2oFPINmq/F7cCu
         HG0i3R8zLH4V8IW+79fWsSP3jrXtNYZJIPzySGqZR8OX1Skz7sVz2kJJxvcI71BUjpN8
         D2sQ==
X-Gm-Message-State: AGRZ1gK/XQvfU7c16NSRD4mrHXqTR+ehBr3QngOTCXyXsoFbc0Ds8Aqo
        DxHLokHlNI9+VsoSfo/FzXwRjt1H
X-Google-Smtp-Source: AJdET5cLcdBUbbfeSu8wX7iMmJinpQloKJV40WYu3EFZRaGXKFTs3Lv4KOkp5ylhOj56w4fVbZm0Fw==
X-Received: by 2002:a62:1e83:: with SMTP id e125-v6mr26825959pfe.231.1541525578868;
        Tue, 06 Nov 2018 09:32:58 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.34])
        by smtp.gmail.com with ESMTPSA id w2-v6sm17297512pfn.89.2018.11.06.09.32.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 09:32:57 -0800 (PST)
Date:   Tue, 6 Nov 2018 23:06:29 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     kraxel@redhat.com, sumit.semwal@linaro.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] udmabuf: Convert to use vm_fault_t
Message-ID: <20181106173628.GA12989@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/dma-buf/udmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 5b44ef2..699b6b7 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -20,7 +20,7 @@ struct udmabuf {
 	struct page **pages;
 };
 
-static int udmabuf_vm_fault(struct vm_fault *vmf)
+static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct udmabuf *ubuf = vma->vm_private_data;
-- 
1.9.1

