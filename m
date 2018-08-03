Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FBDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81AB216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81AB216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbeHCPLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:11:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39785 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbeHCPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:11:08 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flZuZ-0000Tc-Ig; Fri, 03 Aug 2018 15:14:31 +0200
Date:   Fri, 3 Aug 2018 15:14:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Souptick Joarder <jrdr.linux@gmail.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] x86: Convert vdso to use vm_fault_t
In-Reply-To: <CAFqt6zbgoTgw1HNp+anOYY8CiU1BPoNeeddsnGGXWY_hVOd5iQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808031503370.1745@nanos.tec.linutronix.de>
References: <20180703123910.2180-1-willy@infradead.org> <20180703123910.2180-2-willy@infradead.org> <alpine.DEB.2.21.1807161116590.2644@nanos.tec.linutronix.de> <CAFqt6zbgoTgw1HNp+anOYY8CiU1BPoNeeddsnGGXWY_hVOd5iQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018, Souptick Joarder wrote:
> On Mon, Jul 16, 2018 at 2:47 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 3 Jul 2018, Matthew Wilcox wrote:
> >
> >> Return vm_fault_t codes directly from the appropriate mm routines instead
> >> of converting from errnos ourselves.  Fixes a minor bug where we'd return
> >> SIGBUS instead of the correct OOM code if we ran out of memory allocating
> >> page tables.
> >>
> >> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> >
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> >
> 
> Thomas, are these 3 patches part of this series will be queued
> for 4.19 ?

I don't know. I expected that these go through the mm tree, but if nobody
feels responsible, I could pick up the whole lot. But I'd like to see acks
from the mm folks for [1/3] and [3/3]

  https://lkml.kernel.org/r/20180703123910.2180-1-willy@infradead.org

Thanks,

	tglx

