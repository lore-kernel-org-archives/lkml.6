Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeBAOXj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:23:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:31375 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBAOXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:23:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="28036595"
Subject: Re: [PATCH 2/2] mm/sparse.c: Add nr_present_sections to change the
 mem_map allocation
To: Baoquan He <bhe@redhat.com>
References: <20180201071956.14365-1-bhe@redhat.com>
 <20180201071956.14365-3-bhe@redhat.com>
 <20180201101641.icoxv2sp6ckrjfxd@node.shutemov.name>
 <6def8374-2de2-a30c-69ff-2a49fb57dc9a@linux.intel.com>
 <20180201141934.GC1770@localhost.localdomain>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, tglx@linutronix.de, douly.fnst@cn.fujitsu.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <7494fba4-a769-67d4-4121-508bd26da4ba@linux.intel.com>
Date: Thu, 1 Feb 2018 06:23:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180201141934.GC1770@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 06:19 AM, Baoquan He wrote:
> 
> I suppose these functions changed here are only called during system
> bootup, namely in paging_init(). Hot-add memory goes in a different
> path, __add_section() -> sparse_add_one_section(), different called
> functions.

But does this keep those sections that were not present on boot from
being added later?
