Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E3C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CF325A32
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEkJ2jw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CF325A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965051AbeGASbk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:31:40 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33306 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933532AbeGASbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:31:33 -0400
Received: by mail-lf0-f66.google.com with SMTP id u14-v6so5279470lfu.0;
        Sun, 01 Jul 2018 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=U19HPJasvGAtPde9Dd1eGkdksCSq78pD5o4LpKfbEHo=;
        b=NEkJ2jw6EmVH7KAFPxJTf9Z2Ulx7aaeRkyIidG89tUEvLaYWgR714mKJDxfAZoG84e
         W9j9QkZAhNaZSeVUJojhFoQmeX4UDCLdIvfXK6ihMiP86anp5nvpe6fAO4jOBl7eXvrp
         tT9z16TBZ/g6c7TyBQI0+viijL+YAvhdhL4s4LoMRjNP8HdhoyxneNp9YhYmO3qh35WB
         fT1C51P3jEsUhE5f4ANazo8tClJeCZsoGLM0o7CKyjhd8+kejaHgSLmNwlNFK9MkVCRv
         snGoF2SwYKgdl4BMOiv72ScjYeNN0bI7CLxlU52/A2E4OQxoWMZbN2tQrtUTvh62dDJ0
         4jIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=U19HPJasvGAtPde9Dd1eGkdksCSq78pD5o4LpKfbEHo=;
        b=rkffRrJ7nu5Kx01dmcEoO1QGTGGSu2aY9West07fSVMDq7dLc7FFppeDSAyZs2bJPA
         ELmpMUZcbfN1W+lk7gesXrJp7mAp+rwirbvhvOzWky4UVOTJsNR9Wcyga+Nnm37jAhy6
         IrWq9qP3lyCoMoERbHL7FXiGSKJaxv+kLkioTyK1Uqyd/+6LfFl0NTURz+18qa6ltDmi
         ECC/tEPhKQK4LKBmKg5kU/TokjrTYKej3RvDs4oFju02HbWItOD7lvt9hT4PmRRl+6KV
         eKe+/sqOjdv54jN1lHvthKGXKuoN9ylr/kU39yhPxoV7O+apQc+auxTs2n2wY9exLeaS
         5/2w==
X-Gm-Message-State: APt69E1YLk+mzufnjZQ60D3aBl1hu3KyXbHwvhztcxQLVTPp5c6tvJPV
        5cvN1E0vfLuB/wuydA/Crb5/TQ==
X-Google-Smtp-Source: AAOMgpfYHwJyV0gAuIpv4+wqYpJvJCxK0MzWP+nvGV1VWvNHtOGWm9B8JfvMx3NdO5WficY3Tvuqig==
X-Received: by 2002:a19:4c57:: with SMTP id z84-v6mr12542934lfa.67.1530469891804;
        Sun, 01 Jul 2018 11:31:31 -0700 (PDT)
Received: from [84.217.175.60] (c-3cafd954.501502050104-0-757473696b74.bbcust.telenor.se. [84.217.175.60])
        by smtp.gmail.com with ESMTPSA id x19-v6sm1178721lff.36.2018.07.01.11.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 11:31:31 -0700 (PDT)
To:     dancol@google.com
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: [REGRESSION] "Locked" and "Pss" in /proc/*/smaps are the same
Message-ID: <69eb77f7-c8cc-fdee-b44f-ad7e522b8467@gmail.com>
Date:   Sun, 1 Jul 2018 20:31:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking around in /proc on my v4.14.52 system I noticed that
all processes got a lot of "Locked" memory in /proc/*/smaps. A lot
more memory than a regular user can usually lock with mlock().

commit 493b0e9d945fa9dfe96be93ae41b4ca4b6fdb317 (v4.14-rc1) seems
to have changed the behavior of "Locked".

commit 493b0e9d945fa9dfe96be93ae41b4ca4b6fdb317
Author: Daniel Colascione <dancol@google.com>
Date:   Wed Sep 6 16:25:08 2017 -0700

    mm: add /proc/pid/smaps_rollup

Before that commit the code was like this. Notice the VM_LOCKED
check.

seq_printf(m,
           "Size:           %8lu kB\n"
           "Rss:            %8lu kB\n"
           "Pss:            %8lu kB\n"
           "Shared_Clean:   %8lu kB\n"
           "Shared_Dirty:   %8lu kB\n"
           "Private_Clean:  %8lu kB\n"
           "Private_Dirty:  %8lu kB\n"
           "Referenced:     %8lu kB\n"
           "Anonymous:      %8lu kB\n"
           "LazyFree:       %8lu kB\n"
           "AnonHugePages:  %8lu kB\n"
           "ShmemPmdMapped: %8lu kB\n"
           "Shared_Hugetlb: %8lu kB\n"
           "Private_Hugetlb: %7lu kB\n"
           "Swap:           %8lu kB\n"
           "SwapPss:        %8lu kB\n"
           "KernelPageSize: %8lu kB\n"
           "MMUPageSize:    %8lu kB\n"
           "Locked:         %8lu kB\n",
           (vma->vm_end - vma->vm_start) >> 10,
           mss.resident >> 10,
           (unsigned long)(mss.pss >> (10 + PSS_SHIFT)),
           mss.shared_clean  >> 10,
           mss.shared_dirty  >> 10,
           mss.private_clean >> 10,
           mss.private_dirty >> 10,
           mss.referenced >> 10,
           mss.anonymous >> 10,
           mss.lazyfree >> 10,
           mss.anonymous_thp >> 10,
           mss.shmem_thp >> 10,
           mss.shared_hugetlb >> 10,
           mss.private_hugetlb >> 10,
           mss.swap >> 10,
           (unsigned long)(mss.swap_pss >> (10 + PSS_SHIFT)),
           vma_kernel_pagesize(vma) >> 10,
           vma_mmu_pagesize(vma) >> 10,
           (vma->vm_flags & VM_LOCKED) ?
                (unsigned long)(mss.pss >> (10 + PSS_SHIFT)) : 0);

After that commit Locked is now the same as Pss. This looks like a
mistake.

seq_printf(m,
           "Rss:            %8lu kB\n"
           "Pss:            %8lu kB\n"
           "Shared_Clean:   %8lu kB\n"
           "Shared_Dirty:   %8lu kB\n"
           "Private_Clean:  %8lu kB\n"
           "Private_Dirty:  %8lu kB\n"
           "Referenced:     %8lu kB\n"
           "Anonymous:      %8lu kB\n"
           "LazyFree:       %8lu kB\n"
           "AnonHugePages:  %8lu kB\n"
           "ShmemPmdMapped: %8lu kB\n"
           "Shared_Hugetlb: %8lu kB\n"
           "Private_Hugetlb: %7lu kB\n"
           "Swap:           %8lu kB\n"
           "SwapPss:        %8lu kB\n"
           "Locked:         %8lu kB\n",
           mss->resident >> 10,
           (unsigned long)(mss->pss >> (10 + PSS_SHIFT)),
           mss->shared_clean  >> 10,
           mss->shared_dirty  >> 10,
           mss->private_clean >> 10,
           mss->private_dirty >> 10,
           mss->referenced >> 10,
           mss->anonymous >> 10,
           mss->lazyfree >> 10,
           mss->anonymous_thp >> 10,
           mss->shmem_thp >> 10,
           mss->shared_hugetlb >> 10,
           mss->private_hugetlb >> 10,
           mss->swap >> 10,
           (unsigned long)(mss->swap_pss >> (10 + PSS_SHIFT)),
           (unsigned long)(mss->pss >> (10 + PSS_SHIFT)));

The latest git has changed a bit but the functionality is the
same.
