Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990E320869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0zCjUAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990E320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeH1Vlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:41:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33870 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1Vlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:41:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so1054579plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Y89RT5RnFdgrye4tLJgA+W6LvpY53Ng+T0eneSDYVus=;
        b=P0zCjUAQhom6iQ6XkiRdVcWkdSkQAgBQk1BLxRODbTkK1Onb+N2tLoVC5rqBB309EM
         5GJSjazrcbRXv+Z61glaqDliV3nEUazCiwJoNxo7QLGae/AF9y5Be3+8ENZP8/glDn1M
         vRBhmF4nV0wBC/eoYMEtMIVHiV+5nG6QEx060/bAJCoQbdkG/FNboLSVmbMyozvHWar9
         QAhHlcQLKDznfZLs78pmM1uD20Ulu7Wqd3GJ+snDdGMifEH1o+pKEnUcbkv9UFdJecDn
         Jgz3Ex1CPRwpfetwHrs5U8Iva1YECAx2ZTmq+9XNk+qkG4BXgLaEa+CHDaSdioCL1CUQ
         +drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y89RT5RnFdgrye4tLJgA+W6LvpY53Ng+T0eneSDYVus=;
        b=rwfXlm5v5YkrDIpoL7XcQWeFk8Xo9xoXdMkJNtIgZp0vGmUrK30cuWUrdvKIqVXu6d
         u5ts00nycPrfsI1Ge/LkD1U0liyOY+SvKOosKa7rZcIKzi1UBCFXqP1skAL8L9Gv3JN1
         jq8p2MfD3p/fFFr4YCoyxCLSf6YQ9xuZ8Dp8/Atr821p1s+TzkrBGXXiqEAv6pFVEIqk
         bkuxgs7ci2TPe+FLP7LUUH2K6oTE8CtmPckDM1/ysaxmGlnujP+2NgFkY1d+vsX2tw2U
         R3hQzUS57ROhhTHACKpqc2o8bVKyqFKn+gEFI8f2rPrq/5C/5TDb79OuvNa3pQTTsNly
         7H5g==
X-Gm-Message-State: APzg51CbmJedbD7onJtJdvM0sdmtRNl7lfprX/WV6u7ill6477y3j2Kd
        n43OKn56s8IbTgwm/insDs/kY19h
X-Google-Smtp-Source: ANB0Vdb2SqAkTycW01aclb0z/q9gh4M1iRc4gH9arO9xXt4IuL2NjZaJo5jsP82P0rEGXLXn59iZuQ==
X-Received: by 2002:a17:902:5a02:: with SMTP id q2-v6mr2508676pli.253.1535478534592;
        Tue, 28 Aug 2018 10:48:54 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([2405:204:560d:9e3:a1d1:bce6:673e:c4b3])
        by smtp.gmail.com with ESMTPSA id f184-v6sm3553808pfc.88.2018.08.28.10.48.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 10:48:53 -0700 (PDT)
Date:   Tue, 28 Aug 2018 23:21:54 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, jack@suse.cz,
        mgorman@techsingularity.net, ak@linux.intel.com,
        mawilcox@microsoft.com, tim.c.chen@linux.intel.com,
        ross.zwisler@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Conveted to use vm_fault_t
Message-ID: <20180828174952.GA29229@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of vm_fault_t conversion filemap_page_mkwrite()
for NOMMU case was missed. Now converted.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 52517f2..de6fed2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2748,9 +2748,9 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_mmap(file, vma);
 }
 #else
-int filemap_page_mkwrite(struct vm_fault *vmf)
+vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 {
-	return -ENOSYS;
+	return VM_FAULT_SIGBUS;
 }
 int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
 {
-- 
1.9.1

