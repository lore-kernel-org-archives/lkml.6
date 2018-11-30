Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D94C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6950720673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6950720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLAKhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:37:05 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:51374 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLAKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:37:05 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992919AbeK3XZJgjDI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:25:09 +0100
Date:   Fri, 30 Nov 2018 23:25:09 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Subject: Re: Cleaning up numbering for new x86 syscalls?
In-Reply-To: <87cbf7b4-9e77-adc1-8e18-14dd206f0b79@petrovitsch.priv.at>
Message-ID: <alpine.LFD.2.21.1811302309530.25979@eddie.linux-mips.org>
References: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com> <20181120073352.GA79825@gmail.com> <87cbf7b4-9e77-adc1-8e18-14dd206f0b79@petrovitsch.priv.at>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Bernd Petrovitsch wrote:

> And yes, lots of stuff will not compile out of the box (especially if
> one uses a somewhat sane set of gcc options - not only -Wall -Wextra
> -Werror) but if one gets software to compile for i386 and x86_64,
> getting it to compile for x32 is a Friday afternoon job (more or less).
> And yes, there is enough hardware/systems out there that uses 64bit CPUs
> (for whatever reason - if only that one can't get a 32bit CPU for that
> board) but will never ever need more than 2-3 GB RAM .....

 The functionally equivalent 64-bit ILP32 MIPS n32 ABI has been around 
supported by Linux and the GNU toolchain for some 17 years now and people 
have been using it, so by now any sane piece of software that does not use 
handcoded assembly should work out of the box for the x86-64 x32 ABI as 
well.

 NB the important advantage of an LP64 ABI over an ILP32 ABI is the 
ability to mmap(2) files that exceed 4GiB in size (and in reality even 
smaller ones, as some user VM space is surely needed for other stuff), 
regardless of how much physical RAM is actually supported or has been 
installed.

 And these days even a web browser can easily overrun a 4GiB VM space. :(

 FWIW,

  Maciej
