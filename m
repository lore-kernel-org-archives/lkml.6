Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71801C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2884221566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij7ZomAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2884221566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeI0XaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:30:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35226 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeI0XaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:30:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so2370973pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1VrnHCnILd5gFvjDOCvByF+TX90ebeQzsgY3LJkvNfs=;
        b=ij7ZomAWzkOSTPH70o/9t/7Xv33kQAH+upCcdBV/iqZqVyvdaxOnMOnZ6ouSOtTDPz
         JmswDJLwyxhCvYmy8ZZKqexf0IKuOkwnknKgJg1oBha1aaIoGor2b01lKBBDso8DxcGV
         cU1QaVW5nRfDtSQbeqRdcYKLCYGKagf9UQvi/ugHN2RO7nGF22LKUjNciXZYsZ8mk+3Z
         EjxF7HJJaDo8sQbY6n+lTWpp3xSzSD4hi7FvRhS5i8ExLDMZsSOyXBTi3i50YVMPGvMC
         GD74YTFS5n+LJ4aB/CxYER242Ro6jAl2iehru/ilK7J/qPygzpc4aQXuj3krb5U4Cwtz
         /yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1VrnHCnILd5gFvjDOCvByF+TX90ebeQzsgY3LJkvNfs=;
        b=NUGzgNkxb4J+IY4qlZXzvnxnD5PH0ohjPL8MB/qpD1JrWAHKL9ElV4Ptt/jIwN2Lbc
         kWofNxt30m7zsv2vhpbFytw9nw4MMt4PAYcG5mX6wU+EgmLKmYTDFmXpgZESQ66wKwTU
         moWMemRgVx2dr6iGFkngyEy36XeGlC7bE6p2FRFdW1eirGiel7NnO5/LSDQxGH6Gjfrq
         iMkYf8X3uo51RPEATkDf6F6HKC1qIl1lZTsnOnRfjCa+LuXRBpscXez9eckt5hwELLbI
         hkpemtIvpAdmtQ2J5uRjX1t9aYR3ZyDvvr/8CRIjyWA0rzNYBxzsGSbeO9Pnu/Rr/G6R
         +JxA==
X-Gm-Message-State: ABuFfoh7Fep2t6dQa0D4vfnLVVYYeeg6JWryP3lca08RqDIN4dOpuviH
        utKmf8Oee4n1vOmSgfbNm5tzkAJA
X-Google-Smtp-Source: ACcGV60LJia+8/UeIOf96JXEHYEBNH2jIZiVQw6G0162szjFW+6nzRp6xh+661Fmo1L83kE8J99PMA==
X-Received: by 2002:a63:7b09:: with SMTP id w9-v6mr11430317pgc.385.1538068258639;
        Thu, 27 Sep 2018 10:10:58 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.219.124])
        by smtp.gmail.com with ESMTPSA id y4-v6sm3554134pfl.188.2018.09.27.10.10.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 10:10:57 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:44:12 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
        mgorman@techsingularity.net, ak@linux.intel.com, jlayton@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/filemap.c: Use vmf_error()
Message-ID: <20180927171411.GA23331@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These codes can be replaced with new inline vmf_error().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/filemap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 52517f2..7d04d7c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2581,9 +2581,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * system is low on memory, or a problem occurs while trying
 	 * to schedule I/O.
 	 */
-	if (error == -ENOMEM)
-		return VM_FAULT_OOM;
-	return VM_FAULT_SIGBUS;
+	return vmf_error(error);
 
 page_not_uptodate:
 	/*
-- 
1.9.1

