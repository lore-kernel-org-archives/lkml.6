Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1FAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64C42175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfBFRQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:16:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731572AbfBFRQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B69B2175B;
        Wed,  6 Feb 2019 17:16:40 +0000 (UTC)
Date:   Wed, 6 Feb 2019 12:16:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: libelf-0.175 breaks objtool
Message-ID: <20190206121638.3d2230c1@gandalf.local.home>
In-Reply-To: <20190206021611.2nsqomt6a7wuaket@treble>
References: <20190205133821.1a243836@gandalf.local.home>
        <20190206021611.2nsqomt6a7wuaket@treble>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019 20:16:11 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Tue, Feb 05, 2019 at 01:38:21PM -0500, Steven Rostedt wrote:
> > Just a FYI.
> > 
> > After a recent upgrade in debian testing, I was not able to build the
> > kernel. I have a custom build of gcc, so I thought it was strange that
> > I was getting something like this (took this from the web, as I don't
> > have the error anymore with the work around, and currently doing a full
> > build):
> > 
> > objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info                       
> > objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info                       
> > objdump: kernel/.tmp_signal.o: file format not recognized                                                           
> >   CC      arch/x86/kernel/platform-quirks.o                                                                         
> > objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info                
> > objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info                
> > objdump: arch/x86/kernel/.tmp_ebda.o: file format not recognized                                                    
> > objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info                       
> > objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info                       
> > objdump: mm/.tmp_swap_slots.o: file format not recognized                                     
> 
> I installed debian testing on a VM, which has libelf 0.175-2, but I

Hmm, I only have libelf-0.175 (no -2)

> can't recreate.  Can you share your config?
> 

It's just a distro config. Ah, I think it's because I'm compiling my
own home built gcc. There seems to be an incompatibility with the
binutils that I used and with libelf-0.175. If I build with just the
distro gcc, it works.

Bah, this means I need to recreate my gcc that I use to build my
kernels with :-p As I like to control which gcc I use.

-- Steve
