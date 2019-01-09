Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D90DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142B220660
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfAILTz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:19:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729933AbfAILTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:19:54 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghBto-00066B-B1; Wed, 09 Jan 2019 12:19:52 +0100
Date:   Wed, 9 Jan 2019 12:19:52 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marc Dionne <marc.c.dionne@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-07 18:08:26 [-0400], Marc Dionne wrote:
> On Thu, Dec 27, 2018 at 11:20 AM Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
> >
> > Commit:     12209993e98c5fa1855c467f22a24e3d5b8be205
> >     x86/fpu: Don't export __kernel_fpu_{begin,end}()
> >
…
> >     With EFI gone as the last user of __kernel_fpu_{begin|end}(), both can
> >     be made static and not exported anymore.
> >
> This commit removes an exported function pair that is currently used
> by out of tree modules, while the replacement pair
> (kernel_fpu_begin/end) is EXPORT_SYMBOL_GPL.  So this is making
> existing functionality GPL only, which will probably be an issue for
> several out of tree modules that use the fpu.
> 
> Could kernel_fpu_begin/end be made plain EXPORT_SYMBOL?

It can be used by OOT modules as long as they are not under a
proprietary license. The change here is not for me to decide, I added
the x86 maintainers to make their decision. I can make a patch if they
say so.

On the other hand could we just drop EXPORT_SYMBOL_GPL? I doubt this
helps in any way yet please correct me if I am wrong. 
The kernel is GPL and everything links to it should be GPL compatible. People
that don't specify a GPL compatible license either use wrapper around their
binary blob or use EXPORT_SYMBOL functions. The latter group complains each
time a function is not available anymore and we end up changing it to
EXPORT_SYMBOL.
So what do we gain from that EXPORT_SYMBOL_GPL?

> Marc

Sebastian
