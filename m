Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDAB217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbeLRWNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:13:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:17399 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbeLRWNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:13:39 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="284746829"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2018 14:13:38 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C08A7300B49; Tue, 18 Dec 2018 14:13:38 -0800 (PST)
Date:   Tue, 18 Dec 2018 14:13:38 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Martin Jambor <mjambor@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218221338.GK25620@tassilo.jf.intel.com>
References: <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217213126.lsqhyszoulel6uq6@treble>
 <20181217173644.391c2070@gandalf.local.home>
 <20181218000618.GA25620@tassilo.jf.intel.com>
 <20181218024916.vmfnyqzouhfxhyvc@treble>
 <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
 <ri6h8fbqbdf.fsf@suse.cz>
 <20181218211501.GD25620@tassilo.jf.intel.com>
 <20181218165713.4309797a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218165713.4309797a@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 04:57:13PM -0500, Steven Rostedt wrote:
> Hmm, how does that work? When does LTO do its linker magic? Because the
> fentry/mcounts are added when the object is created. Are they removed
> if the compiler sees that it can be inlined? Or does LTO just compile
> everything in one go?

LTO compiles everything in one go at link time. The objects
just contain immediate code.

Also in principle it should track command line options from the command
line and apply them by function, but there were bugs regarding
this in older gcc versions so it may not always work. 

> Again, that's not the ftrace case. It doesn't care about more than one
> out of line instance. Thus, for this particular use, "used" should be
> good enough.

You mean noinline used? 

Inlining would certainly break the test.

-Andi
