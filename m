Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FAAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E4B218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfBHUAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:00:36 -0500
Received: from ms.lwn.net ([45.79.88.28]:56278 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfBHUAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:00:36 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E5A692CD;
        Fri,  8 Feb 2019 20:00:35 +0000 (UTC)
Date:   Fri, 8 Feb 2019 13:00:34 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Start conversion of PowerPC docs
Message-ID: <20190208130034.6bccffbd@lwn.net>
In-Reply-To: <87ef8jj6c3.fsf@concordia.ellerman.id.au>
References: <20190207060316.3221-1-tobin@kernel.org>
        <20190207170131.1fd2bb03@lwn.net>
        <87ef8jj6c3.fsf@concordia.ellerman.id.au>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Feb 2019 14:40:28 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> > - I don't think this should be a top-level directory full of docs; the top
> >   level is already rather overpopulated.  At worst, we should create an
> >   arch/ directory for architecture-specific docs.  
> 
> We currently have arch specific directories for arm, arm64, ia64, m68k,
> nios2, openrisc, parisc, powerpc, s390, sh, sparc, x86, xtensa.
> 
> Do you mean they should all be moved to Documentation/arch ?

Over time I'm really trying to bring some organization to Documentation/,
and to have that reflected in an RST tree that looks like somebody actually
thought about it.  So yes, I would eventually like to see something like
Documentation/arch, just like we have arch/ in the top-level directory.

> >   I kind of think that
> >   this should be thought through a bit more, though, with an eye toward
> >   who the audience is.  Some of it is clearly developer documentation, and
> >   some of it is aimed at admins; ptrace.rst is user-space API stuff.
> >   Nobody ever welcomes me saying this, but we should really split things
> >   into the appropriate manuals according to audience.  
> 
> I don't think any of it's aimed at admins, but I haven't read every
> word. I see it as aimed at kernel devs or people writing directly to the
> kernel API, eg. gdb developers reading ptrace.rst.
> 
> If Documentation/ wants to be more user focused and nicely curated
> perhaps we need arch/foo/docs/ for these developer centric docs?

Stuff for GDB developers is best placed in the userspace-api docbook; we're
trying to concentrate that there.  Stuff for kernel developers is a bit
more diffuse still; arch/foo/docs may end up being the best place for it in
the end, yes.

> > - It would be good to know how much of this stuff is still relevant.
> >   bootwrapper.txt hasn't been modified since it was added in 2008.  
> 
> It hasn't been modified but AFAIK it's still pretty much accurate and
> definitely something we want to have documented.

That's fine for this (and all the others); I'm just hoping that somebody
has thought about it.  We're carrying a *lot* of dusty old stuff that, IMO,
can only serve to confuse those who read it.  If these files don't fall
into that category, that's great.

> We support some hardware that is ~25 years old, so we have some old
> documentation too, and I'd rather we didn't drop things just because
> they're old.

I agree, as long as they remain correct and relevant.

> > - I'm glad you're adding SPDX lines, but do you know that the license is
> >   correct in each case?  It's best to be careful with such things.  
> 
> None of the files have licenses so I think we just fall back to COPYING
> don't we? In which case GPL-2.0 is correct for all files.

That's often the best choice, though some people have resorted to some
rather more in-depth archeology to try to figure out what the original
author actually intended.  Again, I'm just asking so that we're sure it's
the best choice.

Thanks,

jon
