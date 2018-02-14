Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeBNHaY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 02:30:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:18211 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754489AbeBNHaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 02:30:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,511,1511856000";
   d="scan'208";a="174921668"
Message-ID: <1518593420.13066.11.camel@linux.intel.com>
Subject: Re: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
From: Kai Huang <kai.huang@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Date: Wed, 14 Feb 2018 20:30:20 +1300
In-Reply-To: <37cf20a3-653b-1ad7-1e65-6bed935cf325@amd.com>
References: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
         <5199949d-6795-aa55-888c-7ba8abd406e2@amd.com>
         <20180214042121.tza3cpvrnpztjeme@node.shutemov.name>
         <37cf20a3-653b-1ad7-1e65-6bed935cf325@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-13 at 22:57 -0600, Tom Lendacky wrote:
> On 2/13/2018 10:21 PM, Kirill A. Shutemov wrote:
> > On Tue, Feb 13, 2018 at 10:10:22PM -0600, Tom Lendacky wrote:
> > > On 2/8/2018 6:55 AM, Kirill A. Shutemov wrote:
> > > > AMD SME claims one bit from physical address to indicate
> > > > whether the
> > > > page is encrypted or not. To achieve that we clear out the bit
> > > > from
> > > > __PHYSICAL_MASK.
> > > 
> > > I was actually working on a suggestion by Linus to use one of the
> > > software
> > > page table bits to indicate encryption and translate that to the
> > > hardware
> > > bit when writing the actual page table entry.  With that,
> > > __PHYSICAL_MASK
> > > would go back to its original definition.
> > 
> > But you would need to mask it on reading of pfn from page table
> > entry,
> > right? I expect it to have more overhead than this one.
> 
> When reading back an entry it would translate the hardware bit
> position
> back to the software bit position.  The suggestion for changing it
> was
> to make _PAGE_ENC a constant and not tied to the sme_me_mask.
> 
> See https://marc.info/?l=linux-kernel&m=151017622615894&w=2
> 
> > 
> > And software bits are valuable. Do we still have a spare one for
> > this?
> 
> I was looking at possibly using bit 57 (_PAGE_BIT_SOFTW5).

But MK-TME supports upto 15 bits (architectually) as keyID. How is this
supposed to work with MK-TME?

Thanks,
-Kai
> 
> Thanks,
> Tom
> 
> > 
