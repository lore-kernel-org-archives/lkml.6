Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D86C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D694F206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D694F206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeI2DZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:25:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:39204 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeI2DZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:25:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 13:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="95884402"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga002.jf.intel.com with ESMTP; 28 Sep 2018 13:59:07 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 33B69300B51; Fri, 28 Sep 2018 13:59:07 -0700 (PDT)
Date:   Fri, 28 Sep 2018 13:59:07 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com,
        alexey.budankov@linux.intel.com, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
Message-ID: <20180928205907.GD32651@tassilo.jf.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com>
 <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
 <20180928204930.GC32651@tassilo.jf.intel.com>
 <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This new file descriptor argument doesn't exist today so it would
> > need to create a new system call with more arguments
> 
> Is that true? The first argument is a pointer to a struct that
> contains its own size, so it can be expanded without an ABI break. I
> don't see any reason why you couldn't cram more stuff in there.

You're right we could put the fd into the perf_event, but the following is
still true:

> > Obviously we would need to keep the old system call around
> > for compability, so you would need to worry about this
> > interaction in any case!
> >
> > So tying it together doesn't make any sense, because
> > the problem has to be solved separately anyways.


-Andi
