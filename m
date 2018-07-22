Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715ECC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A67320874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCf1rMXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A67320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeGVNzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 09:55:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38158 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbeGVNza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 09:55:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so10285710pgq.5;
        Sun, 22 Jul 2018 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aBYC/tIKEetmeW/Dn/s50aQwVeDIFD8XqHy3dyztV/M=;
        b=PCf1rMXvo2A76lbJn+l14LwbYTbeUkRNKAqgMERMtCIAKZLtGb8flV17KtT6bRbfQG
         v7UtRxoHiSXA3xrKLrRfO27VMIv+xhfBUEiUeu/oICtGLZSX+7r6JDQXDqUPZTyDKuDn
         EnogDBcCMNVMcPHivkDEOceqwy/pYuVUtWKtACDFsZsiS5zGMZEGtiDMkWNRytyJ9KqN
         DWlOoheH8XlvNEogu+h82UaSNUXlKfgCgENeCMB5JTK72W/1yOCgPiFnbAr2uL7I8k4g
         r06SOKhIOYXlxAJq6GlkInGNbv9WVxh0+4JXYHntWFOXNphXprwppfd7GYAu8W2Q11jZ
         tegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aBYC/tIKEetmeW/Dn/s50aQwVeDIFD8XqHy3dyztV/M=;
        b=A9chzttAqgbb7CCpBta/+U0w7sR0sDW894QPH1wr0cJheeJS6vzaAXoefuJ8ApFaYD
         aSN2ZUaGDaUViee+KL0YOtbBH9C4X5Y/kgMBBb0RPxfxGstZL8MEa6Ut5Y80wWC+fK8l
         6E41bfz8EdC+71khaTi6Wy3FyuE9FI4w5qYqcMX/sSbO8RabrHHelozgaxi/FR2PD/A9
         CrWYor9ag2gCNOTcNBcJO78YUEGe5mNBZ6YtjZc4kOequehYfML5SHqqCgwhfg7bvg/C
         OGYwpQl6gQsIezx2P79qsDXT2MbLMsr3ucNO1nxh0ygxCIxqZH7Ir+6fxWHw92WDuPGa
         hllA==
X-Gm-Message-State: AOUpUlG7kMRmIDAjAELx0hqKcf3b+zFa/5NmwdnyiqkvqLWzQgosYz+e
        bb+k8Y2NXGiRV/6/IApt4N8=
X-Google-Smtp-Source: AAOMgpdk60WZHsS6lqZOQLILIN2Xegb9+9zGqi5DJtIFTi7r7JJchh2CgvSOwgVDVcVGWiVAfm5qzA==
X-Received: by 2002:a63:ae02:: with SMTP id q2-v6mr8456247pgf.189.1532264334244;
        Sun, 22 Jul 2018 05:58:54 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.185])
        by smtp.gmail.com with ESMTPSA id b73-v6sm12976004pfl.152.2018.07.22.05.58.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 05:58:52 -0700 (PDT)
Date:   Sun, 22 Jul 2018 18:31:34 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, corbet@lwn.net, darrick.wong@oracle.com,
        gregkh@linuxfoundation.org, mszeredi@redhat.com,
        viro@zeniv.linux.org.uk, seanga2@gmail.com, jrdr.linux@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ajitn.linux@gmail.com, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: [PATCH] mm: Introduce new type vm_fault_t
Message-ID: <20180722130134.GA31321@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have introduce a new return type vm_fault_t for
fault, page_mkwrite and pfn_mkwrite handlers. Update
the document for the same

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 Documentation/filesystems/Locking | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 2c39133..233413b 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -537,9 +537,9 @@ More details about quota locking can be found in fs/dquot.c.
 prototypes:
 	void (*open)(struct vm_area_struct*);
 	void (*close)(struct vm_area_struct*);
-	int (*fault)(struct vm_area_struct*, struct vm_fault *);
-	int (*page_mkwrite)(struct vm_area_struct *, struct vm_fault *);
-	int (*pfn_mkwrite)(struct vm_area_struct *, struct vm_fault *);
+	vm_fault_t (*fault)(struct vm_area_struct*, struct vm_fault *);
+	vm_fault_t (*page_mkwrite)(struct vm_area_struct *, struct vm_fault *);
+	vm_fault_t (*pfn_mkwrite)(struct vm_area_struct *, struct vm_fault *);
 	int (*access)(struct vm_area_struct *, unsigned long, void*, int, int);
 
 locking rules:
-- 
1.9.1

