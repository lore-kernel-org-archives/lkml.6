Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CE1F60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeFFNIe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:08:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50145 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeFFNId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:08:33 -0400
Date: Wed, 6 Jun 2018 15:08:25 +0200 (CEST)
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 0/4] enable early printing of hashed pointers
In-Reply-To: <alpine.DEB.2.20.1806051621070.2789@hypnos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.20.1806061504130.2718@hypnos.tec.linutronix.de>
References: <1527472002-11571-1-git-send-email-me@tobin.cc> <20180531145253.02daa5d4@vmware.local.home> <alpine.DEB.2.20.1806051621070.2789@hypnos.tec.linutronix.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018, Anna-Maria Gleixner wrote:

> On Thu, 31 May 2018, Steven Rostedt wrote:
> 
> > On Mon, 28 May 2018 11:46:38 +1000
> > "Tobin C. Harding" <me@tobin.cc> wrote:
> > 
> > > Steve,
> > 
> > Hi Tobin,
> > 
> > Sorry for the late reply, I'm currently at a conference and have had
> > little time to read email.
> > 
> > > 
> > > Could you please take a quick squiz at the final 2 patches if you get a
> > > chance.  I assumed we are in preemptible context during early_init based
> > > on your code (and code comment) and called static_branch_disable()
> > > directly if hw RNG returned keying material.  It's a pretty simple
> > > change but I'd love to get someone else to check I've not noob'ed it.
> > 
> > I can take a look, and perhaps do some tests. But it was Anna-Maria
> > that originally triggered the issue. She's on Cc, perhaps she can try
> > this and see if it works.
> 
> I'll test it today - sorry for the delay.
> 

I tested it with command line option enabled. This works early enough
because it works right after early_trace_init().

Thanks,

	Anna-Maria
