Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeCOXE4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:04:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbeCOXEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:04:55 -0400
Date: Thu, 15 Mar 2018 16:04:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: Convert VM_BUG_ON() to collapse fail
Message-Id: <20180315160453.dff17cfe3dca056dabc98b9e@linux-foundation.org>
In-Reply-To: <20180315152353.27989-1-kirill.shutemov@linux.intel.com>
References: <20180315152353.27989-1-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 18:23:53 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> khugepaged is not yet able to convert PTE-mapped huge pages back to PMD
> mapped. We do not collapse such pages. See check khugepaged_scan_pmd().
> 
> But if between khugepaged_scan_pmd() and __collapse_huge_page_isolate()
> somebody managed to instantiate THP in the range and then split the PMD
> back to PTEs we would have a problem -- VM_BUG_ON_PAGE(PageCompound(page))
> will get triggered.
> 
> It's possible since we drop mmap_sem during collapse to re-take for
> write.
> 
> Replace the VM_BUG_ON() with graceful collapse fail.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: b1caa957ae6d ("khugepaged: ignore pmd tables with THP mapped with ptes")

Jan 2016.  Do we need a cc:stable?
