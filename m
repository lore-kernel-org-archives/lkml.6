Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864AFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414182152A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414182152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeI1PUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:20:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:28612 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbeI1PUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:20:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 01:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,314,1534834800"; 
   d="scan'208";a="266712420"
Received: from tursulin-mobl.ger.corp.intel.com (HELO [10.252.0.58]) ([10.252.0.58])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2018 01:57:39 -0700
Subject: Re: [RFC 3/5] perf: Allow per PMU access control
To:     Andi Kleen <ak@linux.intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>
Cc:     linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <20180919122751.12439-4-tvrtko.ursulin@linux.intel.com>
 <20180927201559.GH28040@tassilo.jf.intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Message-ID: <38a45f2b-b47a-fccd-2c87-3a46502202a4@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:57:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927201559.GH28040@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/09/2018 21:15, Andi Kleen wrote:
>> +	mutex_lock(&pmus_lock);
>> +	list_for_each_entry(pmu, &pmus, entry)
>> +		pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
>> +	mutex_unlock(&pmus_lock);
> 
> What happens to pmus that got added later?

There is a hunk a bit lower in the patch where in perf_pmu_register the 
initial setting is assigned from the global sysctl.

> The rest looks good.
> 
> Can you post a non RFC version?

Sure!

Regards,

Tvrtko
