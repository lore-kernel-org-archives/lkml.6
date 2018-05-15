Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeEOVMn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:12:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbeEOVMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:12:42 -0400
Date: Tue, 15 May 2018 14:12:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mhocko@suse.com,
        linux-mm@kvack.org, mgorman@techsingularity.net, mingo@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, fengguang.wu@intel.com,
        dennisszhou@gmail.com
Subject: Re: [PATCH v5] mm: don't allow deferred pages with NEED_PER_CPU_KM
Message-Id: <20180515141240.c7587ed53a0ff32ff984e3d2@linux-foundation.org>
In-Reply-To: <20180515175124.1770-1-pasha.tatashin@oracle.com>
References: <20180515175124.1770-1-pasha.tatashin@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018 13:51:24 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> It is unsafe to do virtual to physical translations before mm_init() is
> called if struct page is needed in order to determine the memory section
> number (see SECTION_IN_PAGE_FLAGS). This is because only in mm_init() we
> initialize struct pages for all the allocated memory when deferred struct
> pages are used.
> 
> My recent fix exposed this problem,

"my recent fix" isn't very useful.  I changed this to identify
c9e97a1997 ("mm: initialize pages on demand during boot"), yes?

> 
> Fixes: 3a80a7fa7989 ("mm: meminit: initialise a subset of struct pages if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set")
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

And I added cc:stable.
