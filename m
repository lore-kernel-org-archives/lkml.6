Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54515C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F2B20685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F2B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeKDC6x convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:58:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:27679 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbeKDC6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:58:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2018 10:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,461,1534834800"; 
   d="scan'208";a="103173181"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2018 10:46:55 -0700
Received: from irsmsx112.ger.corp.intel.com (10.108.20.5) by
 irsmsx110.ger.corp.intel.com (163.33.3.25) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 3 Nov 2018 17:46:54 +0000
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.163]) by
 irsmsx112.ger.corp.intel.com ([169.254.1.93]) with mapi id 14.03.0415.000;
 Sat, 3 Nov 2018 17:46:54 +0000
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: RE: [PATCH 2/5] perf tools: Use fallback for
 sample_addr_correlates_sym() cases
Thread-Topic: [PATCH 2/5] perf tools: Use fallback for
 sample_addr_correlates_sym() cases
Thread-Index: AQHUcPnw+49AqFyHuUOcrz5CPxGcZaU+WDdA
Date:   Sat, 3 Nov 2018 17:46:54 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C312BEC@IRSMSX106.ger.corp.intel.com>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-3-adrian.hunter@intel.com>
In-Reply-To: <20181031091043.23465-3-adrian.hunter@intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjQ0OGVmZTktYjNmZC00YzEyLTg2MjktZWMyYWI1NjIwOGQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibHVwWmJXTkZrVExmSFFzRUFQSE1jQk1DZHkySUc1S2VDWTFHS29wZDlMZG5aalg3amQzUXZwcndsUHRRM294USJ9
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hunter, Adrian
> Sent: Wednesday, October 31, 2018 11:11 AM
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Jiri Olsa <jolsa@redhat.com>; Andi Kleen <ak@linux.intel.com>; linux-
> kernel@vger.kernel.org; leo.yan@linaro.org; David Miller
> <davem@davemloft.net>; Mathieu Poirier <mathieu.poirier@linaro.org>
> Subject: [PATCH 2/5] perf tools: Use fallback for
> sample_addr_correlates_sym() cases
> 
> thread__resolve() is used in the sample_addr_correlates_sym() cases where
> 'addr' is a destination of a branch which does not necessarily have the
> same cpumode as the 'ip'. Use the fallback function in that case.
> 
> This patch depends on patch "perf tools: Add fallback functions for cases
> where cpumode is insufficient".
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # 4.19

Any comments?

> ---
>  tools/perf/util/event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 52b24b8ce29e..316f62ffa27b 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1705,7 +1705,7 @@ bool sample_addr_correlates_sym(struct
> perf_event_attr *attr)
>  void thread__resolve(struct thread *thread, struct addr_location *al,
>  		     struct perf_sample *sample)
>  {
> -	thread__find_map(thread, sample->cpumode, sample->addr, al);
> +	thread__find_map_fallback(thread, sample->cpumode, sample-
> >addr, al);
> 
>  	al->cpu = sample->cpu;
>  	al->sym = NULL;
> --
> 2.17.1

