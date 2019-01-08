Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B18C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F162070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfAHUxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:53:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:52389 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbfAHUxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:53:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 12:53:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,455,1539673200"; 
   d="scan'208";a="115214557"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jan 2019 12:53:41 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 18DC6301BEF; Tue,  8 Jan 2019 12:53:41 -0800 (PST)
Date:   Tue, 8 Jan 2019 12:53:41 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
Message-ID: <20190108205341.GO6118@tassilo.jf.intel.com>
References: <87zhshe66w.fsf@linux.intel.com>
 <20190107163227.GH14122@hirez.programming.kicks-ass.net>
 <c4e836e8-1949-27f5-f6a0-ed860f590ec5@intel.com>
 <20190108092559.GA6808@hirez.programming.kicks-ass.net>
 <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
 <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
 <20190108190104.GC1900@hirez.programming.kicks-ass.net>
 <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW: I am not sure that static-keys are much better. Their change also
> affects the control flow, and they do affect the control flow.

Static keys have the same problem, but they only change infrequently so usually
it's not too big a problem if you dump the kernel close to the tracing 
sessions.

simple-pt doesn't have a similar mechanism, so it suffers more from it.

-Andi
