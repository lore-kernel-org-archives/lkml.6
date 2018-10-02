Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62BDC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDC42082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDC42082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeJCE1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeJCE1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38871300549F;
        Tue,  2 Oct 2018 21:42:00 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id B3834607AB;
        Tue,  2 Oct 2018 21:41:57 +0000 (UTC)
Date:   Tue, 2 Oct 2018 23:41:56 +0200
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
Message-ID: <20181002214156.GA31554@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914082653.GG24224@krava>
 <20180914082858.GH24224@krava>
 <71153c79-f0b9-4bf7-7491-202f46c6b5ed@linux.intel.com>
 <4f63c3d5-2a33-28ed-4e45-086045e9ab50@linux.intel.com>
 <b2f205a9-2d8d-7cf2-0ed7-b6b1ecff990b@linux.intel.com>
 <961c875a-5a63-b6fa-4711-7bc7795e511f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961c875a-5a63-b6fa-4711-7bc7795e511f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 02 Oct 2018 21:42:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:23:37PM +0300, Alexey Budankov wrote:

SNIP

> > Workload: matrix multiplication in 128 threads
> > 
> > 	P (period, ms)       : 3
> >  	runtime overhead (%) : 1.8x ~ 12.58 / 6.81
> >  	data loss (%)        : 9
> >  	LOST events          : 147
> >  	SAMPLE events        : 673299
> >         perf.data size (GiB) : 0.8
> 
> Please see more comparable data by P (period, ms), 
> runtime overhead and data loss metrics at the same time.
> 
> It start from serial implementation as the baseline and 
> then demonstrates possible improvement applying configurable 
> --aio(=N) and --threads(=T) implementations.
> 
> Smaller P values, with data loss and runtime overhead values
> equal or in small vicinity of the ones from serial implementation,
> might mean possible gain.

sry for delay.. ok, so it's not so bad afterall ;-)
thanks a lot for running the test

I need to rewrite some parts of it for the next post,
but I'd hate to lose your aio implementation and the
possibility to easily compare it against threaded
implementation

I think we are able to keep it along under --aio option
together with current (sync) write implementation and
future threads implementation.. could you make it available
only under --aio option (or such) and repost?

thanks,
jirka
