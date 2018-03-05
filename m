Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeCERNB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:13:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeCERM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:12:57 -0500
Date: Mon, 5 Mar 2018 18:12:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Sven Joachim <svenjoac@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.16-rc4
Message-ID: <20180305171251.GW25201@hirez.programming.kicks-ass.net>
References: <CA+55aFxXg8hi+T_DNCG_OrAotqSheyREw-Njf9XgUD1vXqAyHQ@mail.gmail.com>
 <878tb7eyf8.fsf@turtle.gmx.de>
 <20180305101748.GL25201@hirez.programming.kicks-ass.net>
 <20180305133849.moxovwol5nek2fvh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305133849.moxovwol5nek2fvh@treble>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 07:38:49AM -0600, Josh Poimboeuf wrote:
> It looks like read_retpoline_hints() is "special" compared to the other
> annotation reading functions.

I copied the pattern from read_unwind_hints.. which might not have been
the best choice it appears ;-)

> The easiest fix would be to convert it to
> be like the others.

So instead of actually reading the section, it iterates the relocation
records for the section, yes that should work nicely.

Thanks!
