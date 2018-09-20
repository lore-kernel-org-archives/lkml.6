Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CF1ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA8421523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdwVdyVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA8421523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbeIUAym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:54:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34102 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIUAym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:54:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so4883211pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bDxtVvCzGA1olgR92bFOB2piyzW2pgVNpwtZTyI+/go=;
        b=XdwVdyVpOvO0KJosdvEakcjah8WmbDkC+bL2b66F3zTTMMdVlGmUNraPXPmrGrs4wO
         UvLZH96GiOgh9FBPHEaNp1zqm/HRJhA7M1xv+zej92DpTNFq0KdZqJ88gGadqb3GZpwB
         anYq4KVC+DUPysGl3p0QOhlQJFIz5QUX0yDFoh8oUEtP400V1l0jpwljKMF3yVRtEZdr
         gIhDUoM6oBTG3Yq/3WtyGqL6VUsHfDZ0ittVjpXm1WqxZgZpII3boAL/uJ0TIbZFpyKv
         oZiBsJdvU1mJTyQz3mcvDMGecHr4qhIeXFlS8KhtThINCLqY0EFbdJAhD/oIBJM0s9Jj
         VvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bDxtVvCzGA1olgR92bFOB2piyzW2pgVNpwtZTyI+/go=;
        b=A315uH03KGX7Uun4cwNKK0pxGD9jk6a8lFcuGR+PkxJowafeKbx62YmKWuGOUUszli
         awXdo8AMRwgWIccMNaXpmiiQt8t2bpjTQeUIUeSDK0DtSZ3ZtKqXZQmuIYOKIS46KfRw
         JBZhmQueaoiWZcAXl0UtCxcpbLU+kI1eIX6f90oNz52C46XiB29Jtg2NxyxV4ZsaIeqM
         HIazduY/6kEcMedGqyZCie1DuW8kaOEVSEzz2O94ZormfcFsEgCwiOPKfC3NFpYEJTuu
         xQWMdcpAZYs2V2yIW0s/mf4srRleGVs/bbToaL1nhbmOJxTgH0QvdafWJkBGxv476Gv3
         O+5Q==
X-Gm-Message-State: APzg51C2F5xas0XGYjsUCKZI6Rq2QulnOkVtZxSEhZC+7n9knUYgOOoR
        JrfXl/slDttni/obenL7UnT+JQBn
X-Google-Smtp-Source: ANB0VdYS8yD/mgZnRLg/kHHnCadlXtjsQWKM8mN5EN4FE3E9GLdojfwgqXdAfMWRQfU08CP7ZFP9QQ==
X-Received: by 2002:a62:6283:: with SMTP id w125-v6mr42564533pfb.108.1537470585052;
        Thu, 20 Sep 2018 12:09:45 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.19.247])
        by smtp.gmail.com with ESMTPSA id r17-v6sm40220586pff.50.2018.09.20.12.09.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:09:43 -0700 (PDT)
Date:   Fri, 21 Sep 2018 00:42:54 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, aryabinin@virtuozzo.com, dvyukov@google.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org, tchibo@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/kcov: Replace vm_insert_page with vmf_insert_page
Message-ID: <20180920191254.GA22764@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to replace vm_insert_page with new API
vmf_insert_page. As part of it, converting vm_insert_page
to use vmf_insert_page.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 kernel/kcov.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 3ebd09e..8900d8e 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -293,8 +293,9 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 		spin_unlock(&kcov->lock);
 		for (off = 0; off < size; off += PAGE_SIZE) {
 			page = vmalloc_to_page(kcov->area + off);
-			if (vm_insert_page(vma, vma->vm_start + off, page))
-				WARN_ONCE(1, "vm_insert_page() failed");
+			if (vmf_insert_page(vma, vma->vm_start + off, page)
+					!= VM_FAULT_NOPAGE)
+				WARN_ONCE(1, "vmf_insert_page() failed");
 		}
 		return 0;
 	}
-- 
1.9.1

