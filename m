Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754286AbeDPJnG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:43:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:55219 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752876AbeDPJnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:43:04 -0400
Date: Mon, 16 Apr 2018 11:43:02 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/mm: vmemmap and vmalloc base addressess are usngined
 longs
In-Reply-To: <20180412142801.oi7bzju3frgkdskp@node.shutemov.name>
Message-ID: <nycvar.YFH.7.76.1804161133500.28129@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm> <20180412142801.oi7bzju3frgkdskp@node.shutemov.name>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018, Kirill A. Shutemov wrote:

> > Commits 9b46a051e4 ("x86/mm: Initialize vmemmap_base at boot-time") and 
> > a7412546d8 ("x86/mm: Adjust vmalloc base and size at boot-time") lost the 
> > type information for __VMALLOC_BASE_L4, __VMALLOC_BASE_L5, 
> > __VMEMMAP_BASE_L4 and __VMEMMAP_BASE_L5 constants.
> > 
> > Let's declare them explicitly unsigned long again.
> 
> It is just cosmetics, right? I mean these literals are 'unsigned long'
> anyway.

Yeah, I can't imagine this particular case leading to any overflow 
scenario, as the literal is big enough to be automatically treated as 
unsigned long by the compiler, but it shuts up sparse which treats this as 
a generic case (where the missing UL might be a problem), and totally 
pollutes the build output.

Either we put the 'UL' there, or teach sparse about figuring out the 
'closer bigger fitting type' for hexadecimal literals, which might be more 
tricky.

Thanks,

-- 
Jiri Kosina
SUSE Labs
