Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BB3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EE3213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfBYMzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:55:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfBYMzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:55:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E45123003AFB;
        Mon, 25 Feb 2019 12:55:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B84A19C7B;
        Mon, 25 Feb 2019 12:55:46 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:55:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 04/11] perf tools report: Parse time quantum
Message-ID: <20190225125544.GE19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-5-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-5-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 25 Feb 2019 12:55:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:15AM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 669f961316f0..d25ca5bb91e6 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -20,6 +20,8 @@
>  #include <inttypes.h>
>  #include <sys/param.h>
>  
> +unsigned long time_quantum = 100000000;

could you please put this into symbol_conf? it's not ideal,
but at least we have all the global configs in one place

thanks,
jirka

> +
>  static bool hists__filter_entry_by_dso(struct hists *hists,
>  				       struct hist_entry *he);
>  static bool hists__filter_entry_by_thread(struct hists *hists,
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 4af27fbab24f..8e602b486c5c 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -531,4 +531,6 @@ static inline int hists__scnprintf_title(struct hists *hists, char *bf, size_t s
>  	return __hists__scnprintf_title(hists, bf, size, true);
>  }
>  
> +extern unsigned long time_quantum;
> +
>  #endif	/* __PERF_HIST_H */
> -- 
> 2.17.2
> 
