Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3944332-1519938937-2-13108926380470232202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519938936; b=LtmfoUfBO6KaH7gB33sWywUPXS1yfIBR/BvJDPcCFi/Sjli
    ROTP8blAZPfZpLeBXqgx6oHAX/21Y7A/dTUBFybYIyiH46+CsMOtDe/vwa5Qy7CX
    yOuvoWODp7Q7JV/FNLiVcx/dTD1JIxELR+pWOCKZJfWg/SXwqdBZSScYeB2xYX41
    n1NsNDJla/LDfzmkVEg1zUcxrEhkmjU+PjLUL5GdEEE8pehD3z3DN6ErRW6ie5FI
    snb/BIJ1+1/w3RIL6k+Pw/XVoG6UZ9sC9A7zfJjuquv9j3WAj1xguviraLkHme8Y
    qZ+YgXlLWXOVycAzSCVHxMaHk72kR7GQxYIpOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519938936; bh=1ZB+4bFKY9gKWl521JP0MI7J84
    G+7INlpTyO/d0wgzc=; b=HNEchOQgB+6+cNfe6bFXgq82nIfdh0jEMtC4DEdgAz
    ifh7/0dgiLzhbjgLUQTYyIFMxAhkVIBe4Wfi14rOGuFzjCmXZq70hKHpwbAGOe5o
    F/F8ji7dnBdzKbYUTYeAnmgiOg3r3iBPlE1hhXPE9Rb3WVZMpxZQoM9jZFi6JyiO
    zT9TlWo8m0riBGDsdCLqzMyRo0c9RFATH4DCm3lUThftaQTKS20qDUeoMij2PqoF
    Fd3VLMeZmNzI94kSsIBtKwGDCdVzX8duHkzGiWkhKi2bsVGrv+S/aQmCMisii6P7
    /9uZRMzyknLeuP5zSpKoT/lqg4jXsn+O65fyLNsf7qtQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NCxLdhBW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NCxLdhBW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034158AbeCAVPd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 16:15:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034165AbeCAVPb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Mar 2018 16:15:31 -0500
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v4 0/4] Record additional page allocation reasons
Date: Thu,  1 Mar 2018 13:15:19 -0800
Message-Id: <20180301211523.21104-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Rework how the _map_count field in struct page is used to record why
the page was allocated.  We now have about twenty bits available, and
I've taken two of them to mark pages allocated for page tables and
through vmalloc.  They are reported by the page-types tool as g and
V respectively.

Changes since v3:
 - Ack from Martin on s390 changes
 - Fix up some comments
 - Removed check for PageType from fs/proc/page.c; page_mapped() handles
   this just fine.
 - Added KPF_VMALLOC and KPF_PGTABLE (hence cc'ing linux-api)
 - Set KPF_VMALLOC and KPF_PGTABLE in fs/proc/page.c
 - Interpret KPF_VMALLOC and KPF_PGTABLE in tools/vm/page-flags.c
 - Set PageTable on tile's extra pages

Matthew Wilcox (4):
  s390: Use _refcount for pgtables
  mm: Split page_type out from _map_count
  mm: Mark pages allocated through vmalloc
  mm: Mark pages in use for page tables

 arch/s390/mm/pgalloc.c                 | 21 +++++++------
 arch/tile/mm/pgtable.c                 |  3 ++
 fs/proc/page.c                         |  4 +++
 include/linux/mm.h                     |  2 ++
 include/linux/mm_types.h               | 13 +++++---
 include/linux/page-flags.h             | 57 ++++++++++++++++++++++------------
 include/uapi/linux/kernel-page-flags.h |  3 +-
 kernel/crash_core.c                    |  1 +
 mm/page_alloc.c                        | 13 +++-----
 mm/vmalloc.c                           |  2 ++
 scripts/tags.sh                        |  6 ++--
 tools/vm/page-types.c                  |  2 ++
 12 files changed, 82 insertions(+), 45 deletions(-)

-- 
2.16.1

