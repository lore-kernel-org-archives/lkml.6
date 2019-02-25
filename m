Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9E7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB37D213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfBYOT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:19:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfBYOT0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:19:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93F9881DE2;
        Mon, 25 Feb 2019 14:19:26 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5502B60857;
        Mon, 25 Feb 2019 14:19:24 +0000 (UTC)
Date:   Mon, 25 Feb 2019 15:19:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/3] perf diff: Support --time filter option
Message-ID: <20190225141923.GF14757@krava>
References: <1551102164-3443-1-git-send-email-yao.jin@linux.intel.com>
 <1551102164-3443-2-git-send-email-yao.jin@linux.intel.com>
 <20190225133854.GB29870@krava>
 <3aeba79c-b729-6c89-6ef3-22a565653d73@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aeba79c-b729-6c89-6ef3-22a565653d73@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 25 Feb 2019 14:19:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:12:08PM +0800, Jin, Yao wrote:
> 
> 
> On 2/25/2019 9:38 PM, Jiri Olsa wrote:
> > On Mon, Feb 25, 2019 at 09:42:42PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > >   COMPARISON
> > >   ----------
> > >   The comparison is governed by the baseline file. The baseline perf.data
> > > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > > index 751e197..ddc41e7 100644
> > > --- a/tools/perf/builtin-diff.c
> > > +++ b/tools/perf/builtin-diff.c
> > > @@ -19,12 +19,21 @@
> > >   #include "util/util.h"
> > >   #include "util/data.h"
> > >   #include "util/config.h"
> > > +#include "util/time-utils.h"
> > >   #include <errno.h>
> > >   #include <inttypes.h>
> > >   #include <stdlib.h>
> > >   #include <math.h>
> > > +struct perf_diff {
> > > +	struct perf_tool	tool;
> > > +	const char		*time_str;
> > > +	struct perf_time_interval *ptime_range;
> > > +	int			range_size;
> > > +	int			range_num;
> > 
> > please align the members
> > 
> 
> Not aligned? Sorry, could you give me an example?

one extra tab before the name:

	struct perf_tool		 tool;
	const char			*time_str;
	struct perf_time_interval	*ptime_range;
	int				 range_size;
	int				 range_num;

jirka
