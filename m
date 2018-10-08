Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC1CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8E42075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8E42075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeJHTRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:17:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:46344 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeJHTRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:17:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 05:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="263835401"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 08 Oct 2018 05:05:51 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id 2FD3E580034;
        Mon,  8 Oct 2018 05:05:48 -0700 (PDT)
Subject: Re: [PATCH v11 1/3]: perf util: map data buffer for preserving
 collected data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
 <20181008105102.GE17270@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1371c609-503f-f778-3ab0-b5a61965981c@linux.intel.com>
Date:   Mon, 8 Oct 2018 15:05:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008105102.GE17270@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.10.2018 13:51, Jiri Olsa wrote:
> On Mon, Oct 08, 2018 at 09:14:29AM +0300, Alexey Budankov wrote:
<SNIP>
> 
> could you please separate those in struct, maybe anonymous like:
> 
> 	...
> 	struct {
> 		void 		 *data;
> 		struct aiocb	 cblock;
> 		int		 nr_cblocks;
> 	} aio;
> 	...
> 

Accepted.

> 
>>  };
>>  
>>  /*
>> @@ -59,6 +67,9 @@ enum bkw_mmap_state {
>>  struct mmap_params {
>>  	int			    prot, mask;
>>  	struct auxtrace_mmap_params auxtrace_mp;
>> +#ifdef HAVE_AIO_SUPPORT
>> +	int			    nr_cblocks;
>> +#endif
> 
> I dont think we need the ifdef here.. IMO one extra int is not
> worth of the ifdef endif confusion

Accepted.

Thanks,
Alexey

> 
> jirka
> 
