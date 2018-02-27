Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeB0IOt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 03:14:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35399 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeB0IOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 03:14:47 -0500
X-Google-Smtp-Source: AG47ELuFBnuW1/bBZ+Qe7WM/R7hBFwJXkBz62Ke74OCKaFIQItXtzQLd6HUO/Qzomd4UxXWOuHfbQg==
Date: Tue, 27 Feb 2018 11:14:37 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Borislav Petkov <bp@suse.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] x86/boot/compressed/64: Find a place for 32-bit
 trampoline
Message-ID: <20180227081437.epg5tmhg7gfzunwp@node.shutemov.name>
References: <20180226180451.86788-1-kirill.shutemov@linux.intel.com>
 <20180226180451.86788-3-kirill.shutemov@linux.intel.com>
 <20180226223038.GI14140@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226223038.GI14140@pd.tnic>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 11:30:38PM +0100, Borislav Petkov wrote:
> On Mon, Feb 26, 2018 at 09:04:48PM +0300, Kirill A. Shutemov wrote:
> > +++ b/arch/x86/boot/compressed/pgtable.h
> > @@ -0,0 +1,11 @@
> > +#ifndef BOOT_COMPRESSED_PAGETABLE_H
> > +#define BOOT_COMPRESSED_PAGETABLE_H
> > +
> > +#define TRAMPOLINE_32BIT_SIZE		(2 * PAGE_SIZE)
> > +
> > +#ifndef __ASSEMBLER__
> 
> x86 uses __ASSEMBLY__ everywhere and I see
> 
> arch/x86/boot/compressed/Makefile:41:KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> 
> so it should work here too.
> 
> Even though __ASSEMBLER__ is gcc predefined.

Okay, I'll fix this.

-- 
 Kirill A. Shutemov
