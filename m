Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B412D20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfB0LR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:17:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36701 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfB0LR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:17:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AA582DA9AB;
        Wed, 27 Feb 2019 11:17:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7050D601A9;
        Wed, 27 Feb 2019 11:17:54 +0000 (UTC)
Date:   Wed, 27 Feb 2019 12:17:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] perf report: support record trace file
 decompression
Message-ID: <20190227111752.GC22793@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <4f45c930-cf39-76b0-5c56-ee4fb0705fa3@linux.intel.com>
 <20190212130914.GK775@krava>
 <92aa09eb-6679-c4d6-5d5d-2fa0cf0af8a1@linux.intel.com>
 <0132ec08-e28b-4102-5053-8f8e21e7fd44@linux.intel.com>
 <1b857d94-60f1-eeae-6014-0265860d382c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b857d94-60f1-eeae-6014-0265860d382c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 27 Feb 2019 11:17:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 01:56:09PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 25.02.2019 19:04, Alexey Budankov wrote:
> > 
> > On 20.02.2019 17:48, Alexey Budankov wrote:
> >>
> >> On 12.02.2019 16:09, Jiri Olsa wrote:
> >>> On Mon, Feb 11, 2019 at 11:25:00PM +0300, Alexey Budankov wrote:
> >>>>
> >>>> PERF_RECORD_COMPRESSED records are decompressed from trace file into
> >>>> a linked list of mmaped memory regions using streaming Zstandard API.
> >>>> After that the regions are loaded fetching uncompressed events. When
> >>>> dumping raw trace (e.g., perf report -D --header) file offsets of
> >>>> events from compressed records are set to zero.
> >>>>
> >>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >>>> ---
> >>>> Changes in v2:
> >>>> - moved compression/decompression code to session layer
> >>>
> >>> could you please add some automated test for this?
> >>>
> >>> I think it could be part of the sample synthesize test 
> 
> Do you mean this one?
> 
> tools/perf/tests/sample-parsing.c

yea, but on second look it does not look suitable,
more likely new shell test under tests/shell?

besically any test that would test that compression
and decompression of events

thanks,
jirka
