Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB9FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DCE208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfAJSH6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:07:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730851AbfAJSH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:07:57 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghekC-0002gY-NI; Thu, 10 Jan 2019 19:07:52 +0100
Date:   Thu, 10 Jan 2019 19:07:52 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Hutter, Tony" <hutter2@llnl.gov>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190110180752.f4cnunadzzkev24m@linutronix.de>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
 <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-10 17:32:58 [+0000], Hutter, Tony wrote:
> > But since when did out-of-tree modules use __kernel_fpu_begin?  It's an
> > x86-only thing, and shouldn't really be used by anyone, right?
> 
> ZFS on Linux uses it for checksums.  Its removal is currently breaking ZFS builds against 5.0:

So btrfs uses crc32c() / kernel's crypto API for that and ZFS can't?
Well the crypto API is GPL only exported so that won't work. crc32c() is
EXPORT_SYMBOL() so it would work.
On the other hand it does not look right to provide a EXPORT_SYMBOL
wrapper around a GPL only interface…

Sebastian
