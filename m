Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F71C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998612087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbfA3Rsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:48:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58938 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfA3Rsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:48:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E0CE80D;
        Wed, 30 Jan 2019 09:48:42 -0800 (PST)
Received: from [10.37.12.221] (unknown [10.37.12.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF72C3F557;
        Wed, 30 Jan 2019 09:48:37 -0800 (PST)
Subject: Re: [PATCH v2 4/7] perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU
 header file
To:     mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
 <20190122181144.26645-5-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fe640760-89b8-7ae7-f742-a9f81642d0e4@arm.com>
Date:   Wed, 30 Jan 2019 17:50:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190122181144.26645-5-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/22/2019 06:11 PM, Mathieu Poirier wrote:
> Moving definition of EVENT_SOURCE_DEVICE_PATH to pmu.h so that it can be
> used by other files than pmu.c
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   tools/perf/util/pmu.c | 2 --
>   tools/perf/util/pmu.h | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 11a234740632..51d437f55d18 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -29,8 +29,6 @@ struct perf_pmu_format {
>   	struct list_head list;
>   };
>   
> -#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
> -
>   int perf_pmu_parse(struct list_head *list, char *name);
>   extern FILE *perf_pmu_in;
>   
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 76fecec7b3f9..350c54e0bd3d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -16,6 +16,7 @@ enum {
>   };
>   
>   #define PERF_PMU_FORMAT_BITS 64
> +#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>   
>   struct perf_event_attr;
>   
> 

FWIW:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

