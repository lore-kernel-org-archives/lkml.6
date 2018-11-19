Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5748FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BCC20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BCC20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbeKTBnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:43:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:62708 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbeKTBnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:43:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 07:19:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="109370299"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2018 07:19:08 -0800
Received: from [10.252.27.191] (abudanko-mobl.ccr.corp.intel.com [10.252.27.191])
        by linux.intel.com (Postfix) with ESMTP id 5740D580032;
        Mon, 19 Nov 2018 07:19:04 -0800 (PST)
Subject: Re: [PATCH v1 2/2]: Documentation/admin-guide: introduce
 perf-security.rst file
To:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jonatan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <0ac97cd0-4773-fff6-7d4e-74c4a1f076c4@linux.intel.com>
 <a44df303-d962-c1a4-4fe0-6bad887ebcdc@linux.intel.com>
 <aDN4nC6p93nK7ILVP3EH-Y4RcKK4KH0ppQKFkIgxTVxkfbOHWjAYJXdTeuq39nbPkySKItZ_8VHN2PfQS_T08GBzeooD5cvc2Xd8oZxSp9s=@protonmail.ch>
 <20181119104646.GB9761@hirez.programming.kicks-ass.net>
 <n06wPuXrWqZEywcNe2BID7GP8dShJlE4L4oLpxO9__duA3noKJO_maOemZwZGC7EHCW7Ur14war-RqLo5pco9uruYaGJMCPOyRVzPJrZyz4=@protonmail.ch>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fa11032d-5260-651a-0d39-a1353ae898ad@linux.intel.com>
Date:   Mon, 19 Nov 2018 18:19:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <n06wPuXrWqZEywcNe2BID7GP8dShJlE4L4oLpxO9__duA3noKJO_maOemZwZGC7EHCW7Ur14war-RqLo5pco9uruYaGJMCPOyRVzPJrZyz4=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19.11.2018 13:49, Jordan Glover wrote:
> On Monday, November 19, 2018 11:46 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Mon, Nov 19, 2018 at 10:35:59AM +0000, Jordan Glover wrote:
>>
>>> On Monday, November 19, 2018 6:42 AM, Alexey Budankov alexey.budankov@linux.intel.com wrote:
>>>
>>>> +>=3:
>>>>
>>>> -         Restrict *access* to PCL performance monitoring for unprivileged processes.
>>>>
>>>>
>>>> -         This is the default on Debian and Android [7]_ , [8]_ .
>>>>
>>>>
>>>
>>> AFAIK there is no support for '+>=3' in mainline kernel[1].
>>> Debian and Android use out-of-tree patch for that[2].
>>> Maybe someone should upstream it?
>>
>> NAK still stands on that. Alternative's have been proposed but so far
>> nobody that cared seems to care enough to implement those.
> 
> So, I guess we can't document NAKed patches :)

Please stay tuned for v2.

Thanks,
Alexey

> 
> Jordan
> 
> 
