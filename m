Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbeDZN5P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:57:15 -0400
Received: from omr-a010e.mx.aol.com ([204.29.186.54]:34101 "EHLO
        omr-a010e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755974AbeDZN5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:57:12 -0400
Subject: Re: [PATCH] perf test: Adapt test case record+probe_libc_inet_pton.sh
 for s390
To: Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180412081959.85193-1-tmricht@linux.ibm.com>
 <20180412131012.GC9818@kernel.org>
 <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
 <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
From: Martin Vuille <jpmv27@aim.com>
Message-ID: <daaa4338-0e78-d11c-8699-5b432db6993e@aim.com>
Date: Thu, 26 Apr 2018 09:57:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1b02615ae1dab62e87
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/26/18 04:09, Thomas-Mich Richter wrote:
>
> Martin,
>
> there is no need to revert the patch. I have adopted the test case for s390 and it
> now stops at main, which is identical to x86.
>
> The --symfs option was not used, however the debug file selected for dwarf examination
> was different. With you patch it changed from /usr/lib64/libc.so (old) to
> /usr/lib/debug/lib64/libc-2.26.so.debug (new)
> and I think that this file has not all the info (at least on s390).
>
Thomas,

Thanks for the additional information. My change was intended to only affect
the case where a --symfs option is used, so your finding is surprising.

I'll take a look to see why this is happening.

Regards,
MV
