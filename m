Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeDPJqK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:46:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:24654 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754042AbeDPJqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:46:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,459,1517904000";
   d="scan'208";a="43642434"
Date: Mon, 16 Apr 2018 12:46:03 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/mm: vmemmap and vmalloc base addressess are usngined
 longs
Message-ID: <20180416094603.fj3wevho5j7wy7s6@black.fi.intel.com>
References: <nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm>
 <20180412142801.oi7bzju3frgkdskp@node.shutemov.name>
 <nycvar.YFH.7.76.1804161133500.28129@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1804161133500.28129@cbobk.fhfr.pm>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 09:43:02AM +0000, Jiri Kosina wrote:
> On Thu, 12 Apr 2018, Kirill A. Shutemov wrote:
> 
> > > Commits 9b46a051e4 ("x86/mm: Initialize vmemmap_base at boot-time") and 
> > > a7412546d8 ("x86/mm: Adjust vmalloc base and size at boot-time") lost the 
> > > type information for __VMALLOC_BASE_L4, __VMALLOC_BASE_L5, 
> > > __VMEMMAP_BASE_L4 and __VMEMMAP_BASE_L5 constants.
> > > 
> > > Let's declare them explicitly unsigned long again.
> > 
> > It is just cosmetics, right? I mean these literals are 'unsigned long'
> > anyway.
> 
> Yeah, I can't imagine this particular case leading to any overflow 
> scenario, as the literal is big enough to be automatically treated as 
> unsigned long by the compiler, but it shuts up sparse which treats this as 
> a generic case (where the missing UL might be a problem), and totally 
> pollutes the build output.
> 
> Either we put the 'UL' there, or teach sparse about figuring out the 
> 'closer bigger fitting type' for hexadecimal literals, which might be more 
> tricky.

I don't have a problem with the patch:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
