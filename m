Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08935C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42EA21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeLQX7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:59:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:22794 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbeLQX7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:59:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 15:59:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="119624247"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2018 15:59:50 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A6E53300B49; Mon, 17 Dec 2018 15:59:50 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:59:50 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181217235950.GZ25620@tassilo.jf.intel.com>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217205535.GT25620@tassilo.jf.intel.com>
 <20181217223524.GH2218@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217223524.GH2218@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:35:24PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 17, 2018 at 12:55:35PM -0800, Andi Kleen wrote:
> > On Mon, Dec 17, 2018 at 08:29:38PM +0100, Peter Zijlstra wrote:
> > > When/if we get the LTO trainwreck sorted -- which very much includes
> > > getting that memory-order-consume fixed -- we can revisit all that.
> > 
> > What do you mean? I'm not aware of any LTO problems with memory-order-consume?
> 
> The compiler is basically allowed to break RCU (and anything else that
> depends on read-read dependencies). LTO makes it _far_ more likely this
> happens.
> 
> We need guarantees (and possible switches) from the compiler folks that
> this will not happen before I'll retract my NAK from any LTO enabling.

Are you really saying that the current RCU code depends on cross file inlining
not happening?

If that is true it's quite bad. Of course it would be a untolerable
situation because all kinds of changes can break it, and there would
be likely already plenty of broken code in tree.

I have a hard time believing it though. Do you have a concrete
example or is this just FUD?

BTW I have a user base for LTO and so far noone has reported any issues
like this.

-Andi
