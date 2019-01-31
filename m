Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F996C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD972084C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfAaTD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:03:56 -0500
Received: from foss.arm.com ([217.140.101.70]:50010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfAaTD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:03:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC34E80D;
        Thu, 31 Jan 2019 11:03:55 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 277C43F59C;
        Thu, 31 Jan 2019 11:03:49 -0800 (PST)
Subject: Re: [PATCH v3 7/7] perf tools: Remove PMU::set_drv_config API
To:     mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
 <20190131184714.20388-8-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <695e25a7-d1f0-d764-493e-4c64310ef16b@arm.com>
Date:   Thu, 31 Jan 2019 19:03:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131184714.20388-8-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2019 18:47, Mathieu Poirier wrote:
> CoreSight was the only client of the PMU's set_drv_config() API.  Now
> that it is no longer needed by CoreSight remove it from the code base.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   tools/perf/builtin-record.c   | 10 -----
>   tools/perf/builtin-stat.c     |  9 ----
>   tools/perf/builtin-top.c      | 13 ------
>   tools/perf/util/Build         |  1 -
>   tools/perf/util/drv_configs.c | 78 -----------------------------------
>   tools/perf/util/drv_configs.h | 26 ------------
>   tools/perf/util/pmu.h         |  1 -
>   7 files changed, 138 deletions(-)
>   delete mode 100644 tools/perf/util/drv_configs.c
>   delete mode 100644 tools/perf/util/drv_configs.h

Nice !

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
