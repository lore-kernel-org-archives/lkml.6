Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E85C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713C62146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfBYOyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:54:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:61193 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbfBYOyH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:54:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 06:54:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="127076074"
Received: from yzheng1-mobl.ccr.corp.intel.com (HELO [10.254.212.76]) ([10.254.212.76])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2019 06:54:02 -0800
Subject: Re: [PATCH v1 1/3] perf diff: Support --time filter option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1551102164-3443-1-git-send-email-yao.jin@linux.intel.com>
 <1551102164-3443-2-git-send-email-yao.jin@linux.intel.com>
 <20190225133854.GB29870@krava>
 <3aeba79c-b729-6c89-6ef3-22a565653d73@linux.intel.com>
 <20190225141923.GF14757@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1f349deb-815f-ad7f-b02f-928d4aa3df6c@linux.intel.com>
Date:   Mon, 25 Feb 2019 22:54:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190225141923.GF14757@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/2019 10:19 PM, Jiri Olsa wrote:
> On Mon, Feb 25, 2019 at 10:12:08PM +0800, Jin, Yao wrote:
>>
>>
>> On 2/25/2019 9:38 PM, Jiri Olsa wrote:
>>> On Mon, Feb 25, 2019 at 09:42:42PM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>>    COMPARISON
>>>>    ----------
>>>>    The comparison is governed by the baseline file. The baseline perf.data
>>>> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
>>>> index 751e197..ddc41e7 100644
>>>> --- a/tools/perf/builtin-diff.c
>>>> +++ b/tools/perf/builtin-diff.c
>>>> @@ -19,12 +19,21 @@
>>>>    #include "util/util.h"
>>>>    #include "util/data.h"
>>>>    #include "util/config.h"
>>>> +#include "util/time-utils.h"
>>>>    #include <errno.h>
>>>>    #include <inttypes.h>
>>>>    #include <stdlib.h>
>>>>    #include <math.h>
>>>> +struct perf_diff {
>>>> +	struct perf_tool	tool;
>>>> +	const char		*time_str;
>>>> +	struct perf_time_interval *ptime_range;
>>>> +	int			range_size;
>>>> +	int			range_num;
>>>
>>> please align the members
>>>
>>
>> Not aligned? Sorry, could you give me an example?
> 
> one extra tab before the name:
> 
> 	struct perf_tool		 tool;
> 	const char			*time_str;
> 	struct perf_time_interval	*ptime_range;
> 	int				 range_size;
> 	int				 range_num;
> 
> jirka
> 

Oh, I see, thanks so much!

Thanks
Jin Yao
