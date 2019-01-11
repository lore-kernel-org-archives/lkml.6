Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCC9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17F62084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxEgSbhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfAKDko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:40:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39028 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfAKDkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:40:40 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so1253990itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 19:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZnGDXsUQbwyjh5UWj+6dF6AsWEY4vPnZvvvUR0vmyo=;
        b=LxEgSbhWieOrJRL7WdJReUC/jQ/8NbBZM2fGYvsWjwXICsBs2o2VjL2+FIzMLar8Xp
         LL4Gmn3TCZinoCZVY94UV+JxVWfGOQTdpHxkOSodQ3FNcDtkgPC8AI3bEVyP5QBEODAC
         u2bYZ8zF/EXhy5RSQo2EOp1iRZPMdrXCvktBqNZJo6uDL9YZDnQPi18YZkRz7+n/Gwsn
         FKcKxVjLUewR4YPaRPxvWqxEQddD+MzINe8Dq9ybv+rTq/Txstke2sKaqkEOxtqXqQbX
         lCPNrJPX2dWbyLwH3IhHbyMIxduOJVyAIEhRD39OsFE2US0QZmhLVis30V0Ax402DtVj
         hB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZnGDXsUQbwyjh5UWj+6dF6AsWEY4vPnZvvvUR0vmyo=;
        b=ICzrzryuexWXXvvzTsY85qKgjpPrQdbtFdwbXeTwfVT2juTZw97rAR7Rb11AVuiR0u
         sJO+EAzas/HEFIqie+O+Nm3rqPbP2Zy9mAt7j2rirOXq2fXBilhuVexo3Zc4xRFBNu0j
         6rlXpcAL+5gOZctFf4pttFPNcuUqZ1CLcELW5WJvHmurAepDYdydStI3LWAg8s0jdKDY
         lWMJnLqB9MbiNdL8MWmJWFbUm2gMVvF2s7a1aG1wI1hwSJz3e7PjTUmCl+ezoFOcj/gl
         UnGUHIKDGWnOPDziN4DOXsM3I+Rb2A1CfhtQdmO3JSw0wRUOynAeZFyLI5e7OWqMphZj
         9Bmw==
X-Gm-Message-State: AJcUukeVbijjyb0oM/YZ+EOvD7bvhSukhM4JfYQniMNLapcaqI3Dw/xy
        +GDYR+QQAnzf9XUTV3cs7N5iMg==
X-Google-Smtp-Source: ALg8bN7sio0Vo33V1lV3U3ZiGgUQ2Ue5bsmHsk2cFVEHLdOlS5SQl9yOrOG96DLmyuIN+sR+Wkn2Zg==
X-Received: by 2002:a02:1a0a:: with SMTP id 10mr8930908jai.50.1547178038583;
        Thu, 10 Jan 2019 19:40:38 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id x99sm165095ita.23.2019.01.10.19.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 19:40:37 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm/gup: fix gup_pmd_range() for dax
Date:   Thu, 10 Jan 2019 20:40:33 -0700
Message-Id: <20190111034033.601-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For dax pmd, pmd_trans_huge() returns false but pmd_huge() returns
true on x86. So the function works as long as hugetlb is configured.
However, dax doesn't depend on hugetlb.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 05acd7e2eb22..75029649baca 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1674,7 +1674,8 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		if (!pmd_present(pmd))
 			return 0;
 
-		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd))) {
+		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
+			     pmd_devmap(pmd))) {
 			/*
 			 * NUMA hinting faults need to be handled in the GUP
 			 * slowpath for accounting purposes and so that they
-- 
2.20.1.97.g81188d93c3-goog

