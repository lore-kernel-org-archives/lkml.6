Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeC2LUj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:20:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54273 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751908AbeC2LUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:20:38 -0400
Date: Thu, 29 Mar 2018 13:20:34 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2 06/14] mm/page_alloc: Propagate encryption KeyID
 through page allocator
Message-ID: <20180329112034.GE31039@dhcp22.suse.cz>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
 <20180328165540.648-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328165540.648-7-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-03-18 19:55:32, Kirill A. Shutemov wrote:
> Modify several page allocation routines to pass down encryption KeyID to
> be used for the allocated page.
> 
> There are two basic use cases:
> 
>  - alloc_page_vma() use VMA's KeyID to allocate the page.
> 
>  - Page migration and NUMA balancing path use KeyID of original page as
>    KeyID for newly allocated page.

I am sorry but I am out of time to look closer but this just raised my
eyebrows. This looks like a no-go. The basic allocator has no business
in fancy stuff like a encryption key. If you need something like that
then just build a special allocator API on top. This looks like a no-go
to me.
-- 
Michal Hocko
SUSE Labs
