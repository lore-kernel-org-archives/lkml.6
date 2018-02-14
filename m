Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966823AbeBNEV0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 23:21:26 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52852 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966705AbeBNEVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 23:21:24 -0500
X-Google-Smtp-Source: AH8x224W5UK5NEiiDWQ8M4NzxdB2LBACTD4GniI9fJa6fofyJKOul6iPjaMlQNDxnovVJOclxvoRkg==
Date: Wed, 14 Feb 2018 07:21:21 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
Message-ID: <20180214042121.tza3cpvrnpztjeme@node.shutemov.name>
References: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
 <5199949d-6795-aa55-888c-7ba8abd406e2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5199949d-6795-aa55-888c-7ba8abd406e2@amd.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:10:22PM -0600, Tom Lendacky wrote:
> On 2/8/2018 6:55 AM, Kirill A. Shutemov wrote:
> > AMD SME claims one bit from physical address to indicate whether the
> > page is encrypted or not. To achieve that we clear out the bit from
> > __PHYSICAL_MASK.
> 
> I was actually working on a suggestion by Linus to use one of the software
> page table bits to indicate encryption and translate that to the hardware
> bit when writing the actual page table entry.  With that, __PHYSICAL_MASK
> would go back to its original definition.

But you would need to mask it on reading of pfn from page table entry,
right? I expect it to have more overhead than this one.

And software bits are valuable. Do we still have a spare one for this?

-- 
 Kirill A. Shutemov
