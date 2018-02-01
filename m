Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBAHUJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 02:20:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbeBAHUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 02:20:06 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, tglx@linutronix.de,
        douly.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] Optimize the code of mem_map allocation in
Date: Thu,  1 Feb 2018 15:19:54 +0800
Message-Id: <20180201071956.14365-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 5-level paging mode, allocating memory with the size of NR_MEM_SECTIONS
is a bad idea. So in this patchset, trying to optimize to save memory.
Othersise kdump kernel can't boot up with normal crashkernel reservation
setting. And for normal kernel, the 512M consumption is not also not
wise, though it's a temporary allocation. 

Baoquan He (2):
  mm/sparsemem: Defer the ms->section_mem_map clearing a little later
  mm/sparse.c: Add nr_present_sections to change the mem_map allocation

 mm/sparse-vmemmap.c |  9 +++++----
 mm/sparse.c         | 54 ++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 42 insertions(+), 21 deletions(-)

-- 
2.13.6
