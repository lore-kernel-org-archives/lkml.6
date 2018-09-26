Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87041C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CB72154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CB72154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeI0EDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:03:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbeI0EDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:03:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7A64307D913;
        Wed, 26 Sep 2018 21:48:47 +0000 (UTC)
Received: from krava (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4A59E103BAB2;
        Wed, 26 Sep 2018 21:48:38 +0000 (UTC)
Date:   Wed, 26 Sep 2018 23:48:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Andi Kleen <andi@firstfloor.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC 00/10] perf: Add cputime events/metrics
Message-ID: <20180926214837.GB15357@krava>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606231016.o3u3u3nduoq7227e@two.firstfloor.org>
 <6856997.NognPVqETE@milian-kdab2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6856997.NognPVqETE@milian-kdab2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 26 Sep 2018 21:48:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 04:44:08PM +0200, Milian Wolff wrote:
> On Thursday, June 7, 2018 1:10:18 AM CEST Andi Kleen wrote:
> > > I had some issues with IDLE counter being miscounted due to stopping
> > > of the idle tick. I tried to solve it in this patch (it's part of the
> > > 
> > > patchset):
> > >   perf/cputime: Don't stop idle tick if there's live cputime event
> > > 
> > > but I'm pretty sure it's wrong and there's better solution.
> > 
> > At least on intel we already have hardware counters for different idle
> > states. You just would need to add them and convert to the same
> > unit.
> > 
> > But of course it's still useful when this is not available.
> > 
> > > My current plan is now to read those counters in perf top/record/report
> > > to show (at least) the idle percentage for the current profile.
> > 
> > It's useful. Thanks for working on it. I was thinking about doing
> > something similar for some time.
> 
> Hey Jiri,
> 
> what happened to this patch series? I also believe it's super useful, even 
> when it's not yet perfect.

heya,
got sidetracked.. thanks for feedback, will refresh
and repost sane version

thanks,
jirka
