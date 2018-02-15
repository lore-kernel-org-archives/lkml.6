Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033628AbeBOPBe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033445AbeBOPBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:01:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE6F217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 12:01:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Sangwon Hong <qpakzk@gmail.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Taeung Song <treeze.taeung@gmail.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 1/2] perf kmem: Document a missing option & an argument
Message-ID: <20180215150130.GH30974@kernel.org>
References: <1518381517-30766-1-git-send-email-qpakzk@gmail.com>
 <20180212015128.GC31513@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212015128.GC31513@sejong>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 12, 2018 at 10:51:28AM +0900, Namhyung Kim escreveu:
> On Mon, Feb 12, 2018 at 05:38:36AM +0900, Sangwon Hong wrote:
> > First, perf kmem has --force option, but didn't document it on the man
> > page. So add missing --force option.
> > 
> > Second, --time option has to get a value, but didn't specify it on the
> > man page. So describe --time option's argument.
> > 
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Taeung Song <treeze.taeung@gmail.com>
> > Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> A nit below though..
> 
> 
> > ---
> >  tools/perf/Documentation/perf-kmem.txt | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-kmem.txt b/tools/perf/Documentation/perf-kmem.txt
> > index 479fc32..c4aa843 100644
> > --- a/tools/perf/Documentation/perf-kmem.txt
> > +++ b/tools/perf/Documentation/perf-kmem.txt
> > @@ -25,6 +25,9 @@ OPTIONS
> >  --input=<file>::
> >  	Select the input file (default: perf.data unless stdin is a fifo)
> >  
> > +-f::
> > +--force::
> > +	Don't do ownership validation
> 
> Please add a blank line here

Done
 
> Thanks,
> Namhyung
> 
> 
> >  -v::
> >  --verbose::
> >          Be more verbose. (show symbol address, etc)
> > @@ -61,7 +64,7 @@ OPTIONS
> >  	default, but this option shows live (currently allocated) pages
> >  	instead.  (This option works with --page option only)
> >  
> > ---time::
> > +--time=<start>,<stop>::
> >  	Only analyze samples within given time window: <start>,<stop>. Times
> >  	have the format seconds.microseconds. If start is not given (i.e., time
> >  	string is ',x.y') then analysis starts at the beginning of the file. If
> > -- 
> > 2.7.4
> > 
