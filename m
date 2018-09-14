Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA6FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD5520866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD5520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeINNmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:42:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbeINNmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02DDCC047B94;
        Fri, 14 Sep 2018 08:29:02 +0000 (UTC)
Received: from krava (unknown [10.40.205.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id AB7F84F80;
        Fri, 14 Sep 2018 08:28:59 +0000 (UTC)
Date:   Fri, 14 Sep 2018 10:28:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914082858.GH24224@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914082653.GG24224@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914082653.GG24224@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 14 Sep 2018 08:29:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:26:53AM +0200, Jiri Olsa wrote:

SNIP

> > > The threaded monitoring currently can't monitor backward maps
> > > and there are probably more limitations which I haven't spotted
> > > yet.
> > > 
> > > So far I tested on laptop:
> > >   http://people.redhat.com/~jolsa/record_threads/test-4CPU.txt
> > > 
> > > and a one bigger server:
> > >   http://people.redhat.com/~jolsa/record_threads/test-208CPU.txt
> > > 
> > > I can see decrease in recorded LOST events, but both the benchmark
> > > and the monitoring must be carefully configured wrt:
> > >   - number of events (frequency)
> > >   - size of the memory maps
> > >   - size of events (callchains)
> > >   - final perf.data size
> > > 
> > > It's also available in:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   perf/record_threads
> > > 
> > > thoughts? ;-) thanks
> > > jirka
> > 
> > It is preferable to split into smaller pieces that bring 
> > some improvement proved by metrics numbers and ready for 
> > merging and upstream. Do we have more metrics than the 
> > data loss from trace AIO patches?
> 
> well the primary focus is to get more events in,
> so the LOST metric is the main one

actualy I was hoping, could you please run it through the same
tests as you do for AIO code on some huge server? 

thanks,
jirka
