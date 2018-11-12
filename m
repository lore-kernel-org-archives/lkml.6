Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0511C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F82521582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F82521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeKLRpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:45:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:59604 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeKLRpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:45:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 23:53:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,494,1534834800"; 
   d="scan'208";a="107493833"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2018 23:53:28 -0800
Subject: Re: [RFC PATCH v1 2/2] proc: add /proc/<pid>/thread_state
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
 <1541528590-30296-2-git-send-email-aubrey.li@intel.com>
 <20181108063246.GA13233@gmail.com>
 <20181108101729.GP9761@hirez.programming.kicks-ass.net>
 <20181112053147.GA78520@gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <a9da1af4-a71a-1188-9806-f3832359d07f@linux.intel.com>
Date:   Mon, 12 Nov 2018 15:53:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20181112053147.GA78520@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/12 13:31, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Thu, Nov 08, 2018 at 07:32:46AM +0100, Ingo Molnar wrote:
>>>
>>> * Aubrey Li <aubrey.li@intel.com> wrote:
>>>
>>>> Expose the per-task cpu specific thread state value, it's helpful
>>>> for userland to classify and schedule the tasks by different policies
>>>
>>> That's pretty vague - what exactly would use this information? I'm sure 
>>> you have a usecase in mind - could you please describe it?
>>
>> Yeah, "thread_state" is a pretty terrible name for this. The use-case is
>> detectoring which tasks use AVX3 such that a userspace component (think
>> job scheduler) can cluster them together.
> 
> I'd prefer the kernel to do such clustering...
> 
Some userland application projects like Kubernetes request an interface of 
such information, we could do the clustering either in the kernel or from
userland, does it make sense we expose the information via the proposed 
interface first?

Thanks,
-Aubrey
