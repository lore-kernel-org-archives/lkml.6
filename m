Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeBFKsn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:48:43 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35973 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFKsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:48:37 -0500
X-Google-Smtp-Source: AH8x225+hLZVS/6YIHoBdFVXr/MQUE6RryteTpoALXBLvXCIO3Gx4chXdI5bXCzFjjn0mEXsn/LZEA==
Date: Tue, 6 Feb 2018 11:48:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        Andi Kleen <ak@linux.intel.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH v3 2/3] x86/entry: Clear registers for 64bit
 exceptions/interrupts
Message-ID: <20180206104834.h34mme4m5p6c5jcr@gmail.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206090455.GA15925@isilmar-4.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206090455.GA15925@isilmar-4.linta.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> On Mon, Feb 05, 2018 at 05:18:11PM -0800, Dan Williams wrote:
> > @@ -1178,6 +1180,7 @@ ENTRY(paranoid_entry)
> >  	cld
> >  	SAVE_C_REGS 8
> >  	SAVE_EXTRA_REGS 8
> > +	CLEAR_REGS_NOSPEC
> >  	ENCODE_FRAME_POINTER 8
> >  	movl	$1, %ebx
> >  	movl	$MSR_GS_BASE, %ecx
> > @@ -1185,7 +1188,6 @@ ENTRY(paranoid_entry)
> >  	testl	%edx, %edx
> >  	js	1f				/* negative -> in kernel */
> >  	SWAPGS
> > -	xorl	%ebx, %ebx
> 
> Here, %ebx will be filled with $1 (see code snipped above) *after* the
> call to CLEAR_REGS_NOSPEC. That's what this line has been clearing in the
> past. So I'm not sure whether this line should be removed.

Good point - I have fixed this bug in the tip:x86/pti version of the patch.

Thanks,

	Ingo
