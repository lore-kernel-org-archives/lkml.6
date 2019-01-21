Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B17C2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717DD2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfAUNNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:13:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfAUNNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:13:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4C352CD811;
        Mon, 21 Jan 2019 13:13:39 +0000 (UTC)
Received: from krava (unknown [10.40.205.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0011D19936;
        Mon, 21 Jan 2019 13:13:37 +0000 (UTC)
Date:   Mon, 21 Jan 2019 14:13:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
Message-ID: <20190121131336.GC3852@krava>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org>
 <20190120181814.GB8591@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120181814.GB8591@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 21 Jan 2019 13:13:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 07:18:14PM +0100, Jiri Olsa wrote:
> On Thu, Jan 17, 2019 at 11:00:53AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > --- a/tools/perf/util/python-ext-sources
> > +++ b/tools/perf/util/python-ext-sources
> > @@ -25,6 +25,7 @@ util/parse-branch-options.c
> >  util/rblist.c
> >  util/counts.c
> >  util/print_binary.c
> > +util/s390-sample-raw.c
> >  util/strlist.c
> >  util/trace-event.c
> >  ../lib/rbtree.c
> 
> hi,
> this change breaks the python module:
> 
>   >>> import perf
>   Traceback (most recent call last):
>     File "<stdin>", line 1, in <module>
>   ImportError: ./perf.so: undefined symbol: color_fprintf
> 
> changelog doesn't say anything about python related change

I made some chenages and movedthat raw sample code
under s390.. which cured the python module, but
I haven't tested it on s390.

Could you please check if code in here works for you:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/s390

if it works, I'll post it

thanks,
jirka
