Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeC2Mhu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:37:50 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39264 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeC2Mht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:37:49 -0400
X-Google-Smtp-Source: AIpwx48jUqp1KNVhphfIGsp47thIs72giHupSRy79L/sKxmjmOgxa4dXnSWhY3oGQiHyjErc4m2Tcw==
Date: Thu, 29 Mar 2018 15:37:12 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Michal Hocko <mhocko@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2 06/14] mm/page_alloc: Propagate encryption KeyID
 through page allocator
Message-ID: <20180329123712.zlo6qmstj3zm5v27@node.shutemov.name>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
 <20180328165540.648-7-kirill.shutemov@linux.intel.com>
 <20180329112034.GE31039@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329112034.GE31039@dhcp22.suse.cz>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 01:20:34PM +0200, Michal Hocko wrote:
> On Wed 28-03-18 19:55:32, Kirill A. Shutemov wrote:
> > Modify several page allocation routines to pass down encryption KeyID to
> > be used for the allocated page.
> > 
> > There are two basic use cases:
> > 
> >  - alloc_page_vma() use VMA's KeyID to allocate the page.
> > 
> >  - Page migration and NUMA balancing path use KeyID of original page as
> >    KeyID for newly allocated page.
> 
> I am sorry but I am out of time to look closer but this just raised my
> eyebrows. This looks like a no-go. The basic allocator has no business
> in fancy stuff like a encryption key. If you need something like that
> then just build a special allocator API on top. This looks like a no-go
> to me.

The goal is to make memory encryption first class citizen in memory
management and not to invent parallel subsysustem (as we did with hugetlb).

Making memory encryption integral part of Linux VM would involve handing
encrypted page everywhere we expect anonymous page to appear.

We can deal with encrypted page allocation with wrappers but it doesn't
make sense if we going to use them instead of original API everywhere.

-- 
 Kirill A. Shutemov
