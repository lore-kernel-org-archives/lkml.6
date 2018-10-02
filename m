Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BDEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255A8206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255A8206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeJBS2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:28:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:37717 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJBS2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:28:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 04:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,331,1534834800"; 
   d="scan'208";a="88480239"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2018 04:44:10 -0700
Received: from [10.125.252.11] (abudanko-mobl.ccr.corp.intel.com [10.125.252.11])
        by linux.intel.com (Postfix) with ESMTP id 216895802A4;
        Tue,  2 Oct 2018 04:44:05 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jann Horn <jannh@google.com>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andi Kleen <ak@linux.intel.com>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com>
 <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
 <20180928204930.GC32651@tassilo.jf.intel.com>
 <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
 <20180928205907.GD32651@tassilo.jf.intel.com>
 <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
 <20180928212757.GE32651@tassilo.jf.intel.com>
 <22155f49-2f57-73b8-6e89-ddd8a127967b@linux.intel.com>
 <alpine.DEB.2.21.1810011741070.32062@nanos.tec.linutronix.de>
 <905796f8-4704-66a8-ee0a-ac8aba90b179@linux.intel.com>
 <alpine.DEB.2.21.1810020832430.32062@nanos.tec.linutronix.de>
Organization: Intel Corp.
Message-ID: <47c60dc1-47ed-ca31-cc3d-d26a1b00d19a@linux.intel.com>
Date:   Tue, 2 Oct 2018 14:44:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810020832430.32062@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On 02.10.2018 9:40, Thomas Gleixner wrote:

<SNIP>

> 
> Not only the user group, it really should do the full security checks which
> are done on open().

I expect it is already implemented by some internal kernel API so that 
it could be reused.

> 
>>    b) then traditional checks against perf_event_pranoid content are applied;
> 
> Hmm, not sure about that because that might be conflicting.

Well, possible contradictions could be converged to some reasonable point 
during technical review stage.

Current perf_event_paranoid semantics is still required for PMUs 
that are governed by global setting at /proc/sys/kernel/perf_event_paranoid.

<SNIP>

>> 4. Documentation/admin-guide/perf-security.rst file is introduced that:
> 
>      0) Better documentation of /proc/sys/kernel/perf_even_paranoid

Exactly. perf_event_open man7 [1] requires update as well, however 
this is not a part of kernel source tree so these docs changes are 
to be mailed TO: mtk.manpages@gmail.com and CC: linux-api@vger.kernel.org.

Thanks,
Alexey

[1] http://man7.org/linux/man-pages/man2/perf_event_open.2.html
