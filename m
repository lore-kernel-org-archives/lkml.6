Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937830-2-12120405377280792004
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937829; b=Ik9yJBaipvDYl5eioQccZnAqBxxeuhQy/sc9XBeQQM/BTxWFXS
    jFZPA8LSrzC4iTSwpbxI7gWdHrhFoSpwlWWadOIHUJm+AyCC4ktxyw+gs2bR5EM7
    tlb1c8ZzcdmnFo9H2t0f8KixAXNavlgdUv6gOpIjYljGNNlAAT96XCt35IzS6vPK
    aAj02A64eN/18hZdnzEnB+7SGDQ8L+WmROMSjdLis0UFZrIrWHs6YG3Rg2b9PYjB
    c4WRszEqLFfQQBLqE7/XHN/gazTXabfgIaqwRG1sygT/Gm8WXqgnTB/TVAdiw2/z
    K7+jTkvneyqqoIxxTwCNIUa5iVsMYu9R7d0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937829; bh=n/FZbBKjge0osJuVpTmORqbreB1jIY
    klAniZg+cQnjo=; b=jtTyHxN291FJbZdzXluIkb0k7xp5cxY/6a870RPof6OlDl
    E/bTRvnIBmbF0Ve1jlNPfA1fBdttkkMc+OeylI+ld8MrxIkUT4z5Zo0zK7sZXHAs
    t4jkyJTp0eBXs3ub0CkPFu4sBR+E1FJETti6jUVs24CEAPH1++TC7d3M9dl83dWt
    DgIBzd51jhPGtm3kp8LMP2AAnD9Al6nm4xygVrvIRB65Xodtov4lpivNb5ke1SN3
    DP526YNoO+kXi5Bp3UjD+kTZIhP5XmUdeg8JLFlALenOn3ZOHWc+/sCUpyfAAuMc
    rmlsi8UdS82aquiVQ/9b66yNRx7jedFgFGGmEIng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=W0S9xrDF x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=W0S9xrDF x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfD1gBz6f9vY+8MYb7uJq2GbdTKj0GD8ze3xLxcGRYBnhNiauz8YO1smH3qQ+O4mdiJHzK+/3Hxuwz7hBCjd4oYfZAT7oUL/d8+AdUcfGuoODYkSmqqJS
    j1Wq9E/ewxvW0TTLs8okZy9kgH59k66sSNB97prMMyTGARws4E7woV+3znRMuxV00Kk5VoEPhGkOj79A3pTFH4oRZlIbvcKzcBaj157dA8tAMCqI6+sghmWf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=iox4zFpeAAAA:8
    a=Z4Rwk6OoAAAA:8 a=R_Myd5XaAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=xHgKhLCoyhETZ0cQsJcA:9 a=phLPpX9aZRDPyI6O:21 a=kLrLtPfyZfhS22hT:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=L2g4Dz8VuBQ37YGmWQah:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEUVXp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932170AbeEUVXl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:23:41 -0400
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
Subject: [PATCH 4.16 038/110] mm: dont allow deferred pages with NEED_PER_CPU_KM
Date: Mon, 21 May 2018 23:11:35 +0200
Message-Id: <20180521210507.196316358@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -644,6 +644,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 	default n
 	depends on NO_BOOTMEM
 	depends on !FLATMEM
+	depends on !NEED_PER_CPU_KM
 	help
 	  Ordinarily all struct pages are initialised during early boot in a
 	  single thread. On very large machines this can take a considerable
