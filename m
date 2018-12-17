Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A90C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B256217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbeLQVDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:03:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:55417 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388589AbeLQVDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:03:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 13:03:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="302953560"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2018 13:03:34 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 30335300B49; Mon, 17 Dec 2018 13:03:34 -0800 (PST)
Date:   Mon, 17 Dec 2018 13:03:34 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181217210334.GW25620@tassilo.jf.intel.com>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217181638.dfexg6mkmbfyzfli@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > That seems weird. 
> > 
> > Are you sure it's not just because they are empty? AFAIK
> > gcc doesn't necessarily generate frame pointers for empty functions.
> 
> I suspected that it was because they're empty, however I didn't see this
> warning for other leaf functions.  The sancov plugin is presumably
> taking care of adding frame pointers where needed.  Also, adding

That would surprise me. 

> -mno-omit-leaf-frame-pointer didn't fix it.
> 
> And anyway I confirmed that it was fixed by removing __noclone.

So this is with a plugin?

Maybe the plugin does something wrong?

I thought this was just a standard build.

I'm not sure the problem is well enough understood yet
to really do anything.

Do you have a simple standalone test case to show the compiler behavior?


-Andi
