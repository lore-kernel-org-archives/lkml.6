Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A3E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A3E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbeGWQpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:45:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:1385 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388499AbeGWQpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:45:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 08:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="56522071"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jul 2018 08:43:58 -0700
Received: from [10.252.208.45] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 919C0580032;
        Mon, 23 Jul 2018 08:43:57 -0700 (PDT)
Subject: Re: [PATCH 1/4] x86/perf/intel: Introduce PMU flag for Extended PEBS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        vincent.weaver@maine.edu, jolsa@redhat.com, ak@linux.intel.com
References: <20180309021542.11374-1-kan.liang@linux.intel.com>
 <20180723151603.GC2458@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8e17eba6-6fed-f283-ee33-47db333398e2@linux.intel.com>
Date:   Mon, 23 Jul 2018 11:43:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723151603.GC2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/2018 11:16 AM, Peter Zijlstra wrote:
> On Thu, Mar 08, 2018 at 06:15:39PM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The Extended PEBS feature, introduced in Goldmont Plus
>> microarchitecture, supports all events as "Extended PEBS".
>>
>> Introduce flag PMU_FL_PEBS_ALL to indicate the platforms which support
>> extended PEBS.
>> To support all events, it needs to support all constraints for PEBS. To
>> avoid duplicating all the constraints in the PEBS table, making the PEBS
>> code search the normal constraints too.
>>
> 
> So I like PEBS_ALL.. what I don't like is that it seems to be mutually
> exclusive with PEBS Load Latency.

Right, MSR_PEBS_ENABLE:32-35 is model specific.
For Atom,
   Goldmont and earlier platform, they are reserved.
   Goldmont Plus, 32-34 are for fixed counter, 35 is reserved.
For Core,
   from Nehalem to latest 8th, 32-35 are for Load Latency.

> Took the patches.
Thanks.

Kan


