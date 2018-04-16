Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755039AbeDPL5T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:57:19 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34204 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754617AbeDPL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:57:17 -0400
X-Google-Smtp-Source: AIpwx4+4ae3D+w8GBDh/6i4muhFEZeVboEsWbZMpNgfl8F9iNT33QY1F1qy2LWSb7wkiZi+G4ZAPgg==
Date: Mon, 16 Apr 2018 13:57:14 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/mm: vmemmap and vmalloc base addressess are usngined
 longs
Message-ID: <20180416115712.74pnfyr5hwfd4btd@ltop.local>
References: <nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm>
 <20180412142801.oi7bzju3frgkdskp@node.shutemov.name>
 <nycvar.YFH.7.76.1804161133500.28129@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1804161133500.28129@cbobk.fhfr.pm>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 11:43:02AM +0200, Jiri Kosina wrote:
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

Hi,

If you're talking about sparse's 'constant ... is so big it is ...',
there is nothing to teach sparse about as it knows perfectly the
(correct) type of the constant (which is printed at the end).
The warning is there on purpose.

Cheers,
-- Luc Van Oostenryck
