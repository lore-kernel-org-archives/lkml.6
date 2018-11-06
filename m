Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D6CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0542085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0542085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbeKGCNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:13:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:58706 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389262AbeKGCNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:13:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 08:47:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="89891379"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2018 08:47:40 -0800
Received: from [10.252.131.165] (kliang2-mobl1.ccr.corp.intel.com [10.252.131.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C7191580213;
        Tue,  6 Nov 2018 08:47:39 -0800 (PST)
Subject: Re: [PATCH 1/2] perf: Add munmap callback
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
 <c7356e5d-71e2-1562-1a0b-2ca0d985d4cb@linux.intel.com>
 <CABPqkBRT678TYMbPMwsUjmazQij_qFDgu2nS7dm619ukni5EGQ@mail.gmail.com>
 <abe1cbab-d010-0899-acb1-32b1f9bf17df@linux.intel.com>
 <CABPqkBQAJXeUmNZLyT_ihShPucO2OpqKBKmKaUMeZt02jHb3OA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <46719ae1-7095-f3de-02fe-bc30a36ac523@linux.intel.com>
Date:   Tue, 6 Nov 2018 11:47:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBQAJXeUmNZLyT_ihShPucO2OpqKBKmKaUMeZt02jHb3OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/2018 10:00 AM, Stephane Eranian wrote:
>>> /*
>>> * mmap 1 page at the location of the unmap page (should reuse virtual space)
>>> * This creates a continuous region built from two mmaps and
>>> potentially two different sources
>>> * especially with jitted runtimes
>>> */
>> The two mmaps are both anon. As my understanding, we cannot symbolize
>> from the anonymous address, can we?
> Can't we build the same test case using an actual file mapping (both
> mmap from the same file)?
> 

If they are from same file, both mmap have same symbolization name.
We don't need to distinguish them either.

I thought the symbolization issue can only happen when two mmaps are 
from different sources. Right?

Thanks,
Kan
