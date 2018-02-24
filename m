Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeBXA4l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:56:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeBXA4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:56:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5ABFB6030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A90B845.3030504@codeaurora.org>
Date: Fri, 23 Feb 2018 16:56:37 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Saravana Kannan <skannan@codeaurora.org>
CC: mark.rutland@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        avilaj@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf/core: Add support for PMUs that can be read
 from any CPU
References: <1519431578-11995-1-git-send-email-skannan@codeaurora.org> <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
In-Reply-To: <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 04:19 PM, Saravana Kannan wrote:
> Some PMUs events can be read from any CPU. So allow the PMU to mark
> events as such. For these events, we don't need to reject reads or
> make smp calls to the event's CPU and cause unnecessary wake ups.
>
> Good examples of such events would be events from caches shared across
> all CPUs.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>   include/linux/perf_event.h |  3 +++
>   kernel/events/core.c       | 10 ++++++++--
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
>

Ugh! Didn't mean to chain these two emails. This one is independent of 
the other email.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
