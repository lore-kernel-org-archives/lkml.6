Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B46C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE73218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbeLTXFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:05:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33459 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbeLTXFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 18:05:15 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ga7NN-0004W3-Qj; Fri, 21 Dec 2018 00:05:09 +0100
Date:   Fri, 21 Dec 2018 00:05:09 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andrea.parri@amarulasolutions.com, longman@redhat.com,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 29/72] locking/qspinlock, x86: Provide liveness
 guarantee
Message-ID: <20181220230509.2lwlz2w46iqac2px@linutronix.de>
References: <20181220085922.332225035@linuxfoundation.org>
 <20181220085923.488666294@linuxfoundation.org>
 <CADVatmPEbBoEeVvAOMkcrsge19ceAkDT5fzEZbMAdTnD5wg6eA@mail.gmail.com>
 <20181220154030.GA9962@kroah.com>
 <20181220184941.ykfjubbo3nj2mnpm@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181220184941.ykfjubbo3nj2mnpm@debian>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-20 18:49:41 [+0000], Sudip Mukherjee wrote:
> On Thu, Dec 20, 2018 at 04:40:30PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 20, 2018 at 12:14:00PM +0000, Sudip Mukherjee wrote:
> > > Hi Greg,
> > > 
> > > On Thu, Dec 20, 2018 at 9:28 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > >
> > > > ------------------
> > > >
> > > > commit 7aa54be2976550f17c11a1c3e3630002dea39303 upstream.
> > > 
> > > Another upstream commit fixes this.
> > > b987ffc18fb3 ("x86/qspinlock: Fix compile error")
> > 
> > Maybe, but that commit doesn't apply to any of these stable trees :(
> > 
> > Care to provide a backport?
> 
> Attached now.

Are you sure that it fails to compile without that patch? I have here
Debian's gcc version 8.2.0 which probably isn't affected and I can
compile kernel/locking/ in v4.19 + 4.14.

I'm asking because in my backport the GEN_BINARY_RMWcc macro is used
like in all the other functions which use it - unlike like in the
original commit where the macro is used directly in the if condition. So
it  might not be affected by the problem.

Therefore I would prefer not to try to patch something that isn't
required.

> --
> Regards
> Sudip

Sebastian
