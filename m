Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527155112-2-249446521564700108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155111; b=VJ1fxln9NUfKV6HBFEMG6HGqsGlaZCTAhPwRgq3fKEZY6dzvx2
    OL3SNrJJrRAEw7lND2bOrxn+8aIlP27sjkjI+MH7s+FjFm0ix8S/uB9jYfWCIbRH
    7FXLgmr1f8V6anlmU2VJI8w+bxJxFo5O5ywegWWvv6/fuI+yqF2CCRclVpqqQZbZ
    SlAvkmyxXu98qX2cRhrmEHIO6VP0iPBnJ/XOsvSMMPEZx0vDedAEqAj/XjD+z96O
    wyAJpyVhZmUF8Pm0FYAee9Wmzg5HCRI3V+YSNpQFTs1M1xcouHw/BbUtyvGrmAih
    8JEC/aixGXEjuUmfprSjocJVWTG0YyKKTgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155111; bh=3H+/DvZRpUKFx57SpA2yIsCriNdH8W
    5HtReENNvtb7Y=; b=WEAhQ183ntxRcY1XHgrAZbD7/3YEPW/cXmNQZ2Wra3Wp+w
    AMdp09l9spowctrTDOgIlKOfjqSZIRp0Fc7BzFvZu/0AyMP0Ep5QbT8W6lQLyTOb
    s3M2pauH7ops45GruV/bzhb5LqsJcPixyJ0ejfU8V5G7MyeXD714w2TQjoX8RHM3
    T9R2LcwlAnbv4MpBDFw8F/QlM4Qcnak0Qg+JYsT6GhAiCiCgZnJiWkgJeI3Wsanv
    fTYmuCqGFSEJ99R09zqYnZz+mEJj2DozkGNYrZYtjPkFFDrk9G08tTduLMavZa1T
    X/+7dSQgDdQJXwA+OznGtI6fD/gSOkMcvLzd7gMQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=yh/G2J9D x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=yh/G2J9D x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFqWer0L0H0l6Sx9cX1boDvKwITgRzoLwVDYTEJNw0TKaRu5VKviI53svcx1BYCxwPrTaMKlV/Ed/kxAFb3nzFhY0qbHNRcF0e9ALNx2+i+CstwnJUIx
    mpvqngdEX8s4XxfE/WoMunexIPseRCzsKs4jLnpd8RBZoStagImzieOwccy9Af4468c9LdDA+ctgKsYUhY/HehCykqtoTH4qk4otl71+NJZRjkmaMa+gN7LO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=iox4zFpeAAAA:8
    a=Z4Rwk6OoAAAA:8 a=R_Myd5XaAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=xHgKhLCoyhETZ0cQsJcA:9 a=6qjBRtzbQOt08Xfq:21 a=noLK5J0dL9QVwQ0f:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=L2g4Dz8VuBQ37YGmWQah:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966733AbeEXJpH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966710AbeEXJpF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 57/92] mm: dont allow deferred pages with NEED_PER_CPU_KM
Date: Thu, 24 May 2018 11:38:34 +0200
Message-Id: <20180524093204.769111897@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tatashin <pasha.tatashin@oracle.com>

commit ab1e8d8960b68f54af42b6484b5950bd13a4054b upstream.

It is unsafe to do virtual to physical translations before mm_init() is
called if struct page is needed in order to determine the memory section
number (see SECTION_IN_PAGE_FLAGS).  This is because only in mm_init()
we initialize struct pages for all the allocated memory when deferred
struct pages are used.

My recent fix in commit c9e97a1997 ("mm: initialize pages on demand
during boot") exposed this problem, because it greatly reduced number of
pages that are initialized before mm_init(), but the problem existed
even before my fix, as Fengguang Wu found.

Below is a more detailed explanation of the problem.

We initialize struct pages in four places:

1. Early in boot a small set of struct pages is initialized to fill the
   first section, and lower zones.

2. During mm_init() we initialize "struct pages" for all the memory that
   is allocated, i.e reserved in memblock.

3. Using on-demand logic when pages are allocated after mm_init call
   (when memblock is finished)

4. After smp_init() when the rest free deferred pages are initialized.

The problem occurs if we try to do va to phys translation of a memory
between steps 1 and 2.  Because we have not yet initialized struct pages
for all the reserved pages, it is inherently unsafe to do va to phys if
the translation itself requires access of "struct page" as in case of
this combination: CONFIG_SPARSE && !CONFIG_SPARSE_VMEMMAP

The following path exposes the problem:

  start_kernel()
   trap_init()
    setup_cpu_entry_areas()
     setup_cpu_entry_area(cpu)
      get_cpu_gdt_paddr(cpu)
       per_cpu_ptr_to_phys(addr)
        pcpu_addr_to_page(addr)
         virt_to_page(addr)
          pfn_to_page(__pa(addr) >> PAGE_SHIFT)

We disable this path by not allowing NEED_PER_CPU_KM with deferred
struct pages feature.

The problems are discussed in these threads:
  http://lkml.kernel.org/r/20180418135300.inazvpxjxowogyge@wfg-t540p.sh.intel.com
  http://lkml.kernel.org/r/20180419013128.iurzouiqxvcnpbvz@wfg-t540p.sh.intel.com
  http://lkml.kernel.org/r/20180426202619.2768-1-pasha.tatashin@oracle.com

Link: http://lkml.kernel.org/r/20180515175124.1770-1-pasha.tatashin@oracle.com
Fixes: 3a80a7fa7989 ("mm: meminit: initialise a subset of struct pages if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Dennis Zhou <dennisszhou@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -628,6 +628,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 	default n
 	depends on ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
 	depends on MEMORY_HOTPLUG
+	depends on !NEED_PER_CPU_KM
 	help
 	  Ordinarily all struct pages are initialised during early boot in a
 	  single thread. On very large machines this can take a considerable
