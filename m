Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9388C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DCF2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfA2RXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:23:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:26060 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfA2RXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:23:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 09:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="110757598"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 29 Jan 2019 09:23:48 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AF18A3011E7; Tue, 29 Jan 2019 09:23:48 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:23:48 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     William Cohen <wcohen@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH] perf vendor events intel: Fix Load_Miss_Real_Latency on
 CLX
Message-ID: <20190129172348.GS6118@tassilo.jf.intel.com>
References: <20190129170536.22510-1-wcohen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129170536.22510-1-wcohen@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:05:36PM -0500, William Cohen wrote:
> Fix incorrect event names for the Load_Miss_Real_Latency metric for
> Cascadelake server in the same manner as commit 91b2b97025 for SKL/SKX.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

> 
> Signed-off-by: William Cohen <wcohen@redhat.com>
> ---
>  tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> index 36c903faed0b..71e9737f4614 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> @@ -73,7 +73,7 @@
>      },
>      {
>          "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
> -        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS_PS + MEM_LOAD_RETIRED.FB_HIT_PS )",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
>          "MetricGroup": "Memory_Bound;Memory_Lat",
>          "MetricName": "Load_Miss_Real_Latency"
>      },
> -- 
> 2.20.1
> 
