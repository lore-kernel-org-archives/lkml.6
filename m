Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC64C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2550320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbeLQUzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:55:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:6935 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727157AbeLQUzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:55:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 12:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="101404045"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2018 12:55:35 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D82AF300B49; Mon, 17 Dec 2018 12:55:35 -0800 (PST)
Date:   Mon, 17 Dec 2018 12:55:35 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181217205535.GT25620@tassilo.jf.intel.com>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217192938.GF2218@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 08:29:38PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 17, 2018 at 12:16:38PM -0600, Josh Poimboeuf wrote:
> 
> > > Yes LTO causes the to be treated like static functions.
> > > 
> > > I guess noclone is unlikely to be really needed here because these
> > > functions are unlikely to be cloned.
> > > 
> > > So as a workaround it could be removed.
> > > 
> > > But note we have other noclone functions in the tree (like in KVM)
> > > which actually need it.
> > 
> > How about we just use the __used attribute then?  It seems to have the
> > same result of preventing IPA optimizations (without the weird side
> > effect of missing frame pointers).
> 
> AFAIK we don't have any in-tree LTO, so it can all go in the bin.

I have patches for 4.20, and I was actually thinking about resending
soon. It will need a few changes, but not too bad.

FWIW there's also a user base who used the out of tree patches
for some time.

> 
> When/if we get the LTO trainwreck sorted -- which very much includes
> getting that memory-order-consume fixed -- we can revisit all that.

What do you mean? I'm not aware of any LTO problems with memory-order-consume?

-Andi
