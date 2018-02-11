Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeBKTnL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 14:43:11 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38992 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753584AbeBKTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 14:43:09 -0500
X-Google-Smtp-Source: AH8x226128nSEIyFuFc+0fApuNmIi4p5720iH+Yo93Bj8HvQbouaQ+v0lZkkS319l1Kk8WAfFMfEAg==
Date: Sun, 11 Feb 2018 20:43:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        karahmed@amazon.de, sironi@amazon.de, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH] x86/speculation: Clean up various Spectre related details
Message-ID: <20180211194305.zg7tq3x3cxjuphyo@gmail.com>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
 <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <20180211185057.rest4bf2ydx7slrk@gmail.com>
 <1518377119.6606.2.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518377119.6606.2.camel@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

> 
> 
> On Sun, 2018-02-11 at 19:50 +0100, Ingo Molnar wrote:
> > 
> > From 82c2b2f29691143a05181333f387e786646aa28b Mon Sep 17 00:00:00 2001
> > From: Ingo Molnar <mingo@kernel.org>
> > Date: Sat, 10 Feb 2018 11:51:57 +0100
> > Subject: [PATCH] x86/speculation: Clean up various Spectre related details
> > 
> > Harmonize all the Spectre messages so that a:
> > 
> >     dmesg | grep -i spectre
> > 
> > ... gives us most Spectre related kernel boot messages.
> > 
> > Also fix a few other details:
> > 
> >  - clarify a comment about firmware speculation control
> > 
> >  - s/KPTI/PTI
> > 
> >  - remove various line-breaks that made the code uglier
> > 
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Arjan van de Ven <arjan@linux.intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> 
> 
> Acked-by: David Woodhouse <dwmw@amazon.co.uk>

Thanks, added.

> with a couple of comments:
> 
> 
> -        * If neither SMEP or KPTI are available, there is a risk of
> +        * If neither SMEP or PTI are available, there is a risk of
> 
> Make that 'neither SMEP nor PTI' while you're at it though please;
> that's bugged me a couple of times in passing.

Ok, fixed that too.

> 
> And should these say 'Spectre v2' not just 'Spectre'?

Yeah, you are probably right, but I didn't want to make the messages too specific 
- do we really know that this is the end of Spectre-style speculation holes?

Thanks,

	Ingo
