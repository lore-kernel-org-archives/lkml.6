Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4920C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898ED2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfBULaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:30:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:64118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727766AbfBULaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:30:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 03:30:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="135232563"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2019 03:30:13 -0800
Received: from [10.125.252.152] (abudanko-mobl.ccr.corp.intel.com [10.125.252.152])
        by linux.intel.com (Postfix) with ESMTP id 10AB758028E;
        Thu, 21 Feb 2019 03:30:10 -0800 (PST)
Subject: Re: [PATCH v2 3/4] perf record: enable runtime trace compression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
 <20190212130844.GF775@krava>
 <f4bc3e05-734a-0053-1f23-684446a351d0@linux.intel.com>
 <20190221094327.GA10990@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9184656d-e47c-b003-cbb4-1c37d97c6fcd@linux.intel.com>
Date:   Thu, 21 Feb 2019 14:30:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221094327.GA10990@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21.02.2019 12:43, Jiri Olsa wrote:
> On Wed, Feb 20, 2019 at 06:13:02PM +0300, Alexey Budankov wrote:
>>
>> On 12.02.2019 16:08, Jiri Olsa wrote:
>>> On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>>> index 18fb9c8cbf9c..5d406eebd058 100644
>>>> --- a/tools/perf/util/session.c
>>>> +++ b/tools/perf/util/session.c
>>>> @@ -29,6 +29,112 @@
>>>>  #include "stat.h"
>>>>  #include "arch/common.h"
>>>>  
>>>
>>> I think this should not be in session.c but separated in new object
>>
>> Do you mean the new file?
> 
> yes

tools/perf/util/compress.{c,h}

Thanks,
Alexey

> 
> jirka
> 
