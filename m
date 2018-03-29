Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeC2NNq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:13:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54178 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeC2NNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:13:45 -0400
X-Google-Smtp-Source: AIpwx4/QdJgl6ukkWgNHQdKEV3SSUtWfGtWQvIqbn1NQwk43mkZOOTPtKff5M6D15dOSaIMC3CTmHw==
Date: Thu, 29 Mar 2018 16:13:08 +0300
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
Message-ID: <20180329131308.cq64n3dvnre2wcz5@node.shutemov.name>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
 <20180328165540.648-7-kirill.shutemov@linux.intel.com>
 <20180329112034.GE31039@dhcp22.suse.cz>
 <20180329123712.zlo6qmstj3zm5v27@node.shutemov.name>
 <20180329125227.GF31039@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329125227.GF31039@dhcp22.suse.cz>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 02:52:27PM +0200, Michal Hocko wrote:
> On Thu 29-03-18 15:37:12, Kirill A. Shutemov wrote:
> > On Thu, Mar 29, 2018 at 01:20:34PM +0200, Michal Hocko wrote:
> > > On Wed 28-03-18 19:55:32, Kirill A. Shutemov wrote:
> > > > Modify several page allocation routines to pass down encryption KeyID to
> > > > be used for the allocated page.
> > > > 
> > > > There are two basic use cases:
> > > > 
> > > >  - alloc_page_vma() use VMA's KeyID to allocate the page.
> > > > 
> > > >  - Page migration and NUMA balancing path use KeyID of original page as
> > > >    KeyID for newly allocated page.
> > > 
> > > I am sorry but I am out of time to look closer but this just raised my
> > > eyebrows. This looks like a no-go. The basic allocator has no business
> > > in fancy stuff like a encryption key. If you need something like that
> > > then just build a special allocator API on top. This looks like a no-go
> > > to me.
> > 
> > The goal is to make memory encryption first class citizen in memory
> > management and not to invent parallel subsysustem (as we did with hugetlb).
> 
> How do you get a page_keyid for random kernel allocation?

Initial feature enabling only targets userspace anonymous memory, but we
can definately use the same technology in the future for kernel hardening
if we would choose so.

For anonymous memory, we can get KeyID from VMA or from other page
(migration case).

> > Making memory encryption integral part of Linux VM would involve handing
> > encrypted page everywhere we expect anonymous page to appear.
> 
> How many architectures will implement this feature?

I can't read the future.

I'm only aware about one architecture so far.

-- 
 Kirill A. Shutemov
