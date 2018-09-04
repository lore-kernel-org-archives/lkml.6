Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F55C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DE8206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DE8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIDWQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:16:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:38710 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDWQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:16:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 10:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="77922670"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2018 10:50:33 -0700
Received: from [10.252.10.78] (abudanko-mobl.ccr.corp.intel.com [10.252.10.78])
        by linux.intel.com (Postfix) with ESMTP id DB4ED5803E2;
        Tue,  4 Sep 2018 10:50:30 -0700 (PDT)
Subject: Re: [PATCH v6 1/2]: perf util: map data buffer for preserving
 collected data
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <01963930-68b3-ff33-6e05-acaff3efc083@linux.intel.com>
 <2325f44b-d9bf-d8da-2fdb-8b8e87a255fc@linux.intel.com>
 <20180904173431.GJ27886@tassilo.jf.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3ac920f7-d8b1-fb90-ab6b-ba75bc8b5b2a@linux.intel.com>
Date:   Tue, 4 Sep 2018 20:50:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904173431.GJ27886@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04.09.2018 20:34, Andi Kleen wrote:
>>  		.sample		= process_sample_event,
>> @@ -1678,6 +1680,8 @@ static struct option __record_options[] = {
>>  			  "signal"),
>>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>>  		    "Parse options then exit"),
>> +	OPT_INTEGER(0, "aio", &record.opts.nr_cblocks,
>> +		    "asynchronous trace write operations (min: 1, max: 32, default: 2)"),
> 
> would need to be documented in the manpage. But I would rather make it an
> ~/.perfconfig option

Yep, make sense, it requires to be configurable w/o recompilation and 
at the same time its meaning is not obvious to be on the command line for a user.

> 
> 
> -Andi
> 
