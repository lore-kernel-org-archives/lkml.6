Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEOWfF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:35:05 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36512 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752024AbeEOWfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:35:04 -0400
X-Originating-IP: 134.134.139.76
Date: Tue, 15 May 2018 14:55:41 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [RFC 1/8] x86: objtool: use asm macro for better compiler
 decisions
Message-ID: <20180515215540.GB7298@localhost>
References: <20180515141124.84254-1-namit@vmware.com>
 <20180515141124.84254-2-namit@vmware.com>
 <20180515213713.GA7298@localhost>
 <4E72C06C-7A4B-4E18-83DA-8E0C9F701854@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E72C06C-7A4B-4E18-83DA-8E0C9F701854@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 02:53:52PM -0700, Nadav Amit wrote:
> Josh Triplett <josh@joshtriplett.org> wrote:
> 
> > On Tue, May 15, 2018 at 07:11:08AM -0700, Nadav Amit wrote:
> >> GCC considers the number of statements in inlined assembly blocks,
> >> according to new-lines and semicolons, as an indication to the cost of
> >> the block in time and space. This data is distorted by the kernel code,
> >> which puts information in alternative sections. As a result, the
> >> compiler may perform incorrect inlining and branch optimizations.
> >> 
> >> In the case of objtool, this distortion is extreme, since anyhow the
> >> annotations of objtool are discarded during linkage.
> >> 
> >> The solution is to set an assembly macro and call it from the inlinedv
> >> assembly block. As a result GCC considers the inline assembly block as
> >> a single instruction.
> >> 
> >> This patch slightly increases the kernel size.
> >> 
> >>   text    data     bss     dec     hex filename
> >> 18126699 10066728 2936832 31130259 1db0293 ./vmlinux before
> >> 18126824 10067268 2936832 31130924 1db052c ./vmlinux after (+665)
> > 
> > With what kernel config? What's the text size change for an allnoconfig?
> 
> I use my custom config and to include the drivers in the image. Other
> configs were not too appropriate: defconfig does not enable paravirt and
> allyesconfig is too heavy.
> 
> There is no effect with allnoconfig on size:
> 
>    text	   data	    bss	    dec	    hex	filename
> 1018441	 230148	1215604	2464193	 2599c1	./vmlinux
> 1018441	 230148	1215604	2464193	 2599c1	./vmlinux
> 
> I think it is expected since CONFIG_STACK_VALIDATION is off. No?

Thanks for checking; fine by me then. :)
