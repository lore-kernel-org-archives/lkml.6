Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDQKoH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:44:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54126 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeDQKoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:44:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA1EB603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: vbabka@suse.cz, labbott@redhat.com, catalin.marinas@arm.com,
        hannes@cmpxchg.org, f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        khandual@linux.vnet.ibm.com, mhocko@kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 0/2] vunmap and debug objects
Date: Tue, 17 Apr 2018 16:13:46 +0530
Message-Id: <1523961828-9485-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not entirely sure, how debug objects are really
useful in vmalloc framework.

I'm assuming they are useful in some ways. So, there
are 2 issues in that. First patch is avoiding possible
race scenario and second patch passes _proper_ args
in debug object APIs. Both these patches can help
debug objects to be in consistent state.

We've observed some list corruptions in debug objects.
However, no claims that these patches will be fixing
them.

If one has an opinion that debug object has no use in
vmalloc framework, I would raise a patch to remove
them from the vunmap leg.

Below 2 patches are rebased over tip + my other patch in
review "[PATCH v2] mm: vmalloc: Clean up vunmap to avoid
pgtable ops twice"

Chintan Pandya (2):
  mm: vmalloc: Avoid racy handling of debugobjects in vunmap
  mm: vmalloc: Pass proper vm_start into debugobjects

>From V1->V2:
 - Incorporated Anshuman's comment about missing corrections
   in vm_unmap_ram()

 mm/vmalloc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
