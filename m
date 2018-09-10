Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1979C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772F720865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772F720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeIJPCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:02:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727635AbeIJPCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE2FE40201BC;
        Mon, 10 Sep 2018 10:08:43 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 663A310B7C93;
        Mon, 10 Sep 2018 10:08:42 +0000 (UTC)
Date:   Mon, 10 Sep 2018 12:08:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180910100841.GB15548@krava>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <20180910095909.GA15548@krava>
 <20180910100303.GA101776@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910100303.GA101776@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 10:08:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 10:08:43 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:03:03PM +0200, Ingo Molnar wrote:
> 
> * Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > Per-CPU threading the record session would have so many other advantages as well (scalability, 
> > > etc.).
> > > 
> > > Jiri did per-CPU recording patches a couple of months ago, not sure how usable they are at the 
> > > moment?
> > 
> > it's still usable, I can rebase it and post a branch pointer,
> > the problem is I haven't been able to find a case with a real
> > performance benefit yet.. ;-)
> > 
> > perhaps because I haven't tried on server with really big cpu
> > numbers
> 
> Maybe Alexey could pick up from there? Your concept looked fairly mature to me
> and I tried it on a big-CPU box back then and there were real improvements.

too bad u did not share your results, it could have been already in ;-)

let me rebase/repost once more and let's see

I think we could benefit from both multiple threads event reading
and AIO writing for perf.data.. it could be merged together

jirka
