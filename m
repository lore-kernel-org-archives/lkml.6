Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E60C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7920921736
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115278;
	bh=4MP2XCG3H0jxOasSELBd4wiJJ7yDbp3urMml6O4/uQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xeiDJ8EX7JW6cc+JyMTdgySLRW7QxzB5Z656XeSXjoFJfCc68t3DNlH4wMnsmsgp6
	 4HyX34VozO5FtHIeb/HOiyIl/YnzJVCKAFR/emLXpTwLwjDCuR8utsUImMYt+nESL2
	 CHsWsE7XcyDy/lRRDvLWrqfs43Ue0A9Slzzj5S9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfAVABQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:01:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:32900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfAVABQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:01:16 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2546821721;
        Tue, 22 Jan 2019 00:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115275;
        bh=4MP2XCG3H0jxOasSELBd4wiJJ7yDbp3urMml6O4/uQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HV+ayXf9tOEVGJHJ/sy8T8u923hy5QoKmX27a7ZPYU/1KuD+IOGsfxbFOcVqhUsyR
         2rRVmbaGJ290HKe0+2yfh9nO98GUXOQdDbDmoRj9ETExJQvZvWa0iwt+0mU/xMpcsh
         pixTIgDAtbW2rBYhoun2Ld+/f4En2UhLtryCJzcs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DDFD540355; Mon, 21 Jan 2019 21:01:11 -0300 (-03)
Date:   Mon, 21 Jan 2019 21:01:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
Message-ID: <20190122000111.GE20269@kernel.org>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org>
 <20190120181814.GB8591@krava>
 <20190121131336.GC3852@krava>
 <20190121141748.GC15707@kernel.org>
 <20190121183437.GB11396@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121183437.GB11396@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 21, 2019 at 07:34:37PM +0100, Jiri Olsa escreveu:
> On Mon, Jan 21, 2019 at 11:17:48AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jan 21, 2019 at 02:13:36PM +0100, Jiri Olsa escreveu:
> > > On Sun, Jan 20, 2019 at 07:18:14PM +0100, Jiri Olsa wrote:
> > > > On Thu, Jan 17, 2019 at 11:00:53AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > 
> > > > SNIP
> > > > 
> > > > > --- a/tools/perf/util/python-ext-sources
> > > > > +++ b/tools/perf/util/python-ext-sources
> > > > > @@ -25,6 +25,7 @@ util/parse-branch-options.c
> > > > >  util/rblist.c
> > > > >  util/counts.c
> > > > >  util/print_binary.c
> > > > > +util/s390-sample-raw.c
> > > > >  util/strlist.c
> > > > >  util/trace-event.c
> > > > >  ../lib/rbtree.c
> > > > 
> > > > hi,
> > > > this change breaks the python module:
> > > > 
> > > >   >>> import perf
> > > >   Traceback (most recent call last):
> > > >     File "<stdin>", line 1, in <module>
> > > >   ImportError: ./perf.so: undefined symbol: color_fprintf
> > > > 
> > > > changelog doesn't say anything about python related change
> > > 
> > > I made some chenages and movedthat raw sample code
> > > under s390.. which cured the python module, but
> > > I haven't tested it on s390.
> > 
> > Nope, I explicitely asked him to build that code for all arches, as we
> > want to process s390 perf.data files on a x86 or arm or any other arch.
> > 
> 
> aah, so this actualy works over the s390 perf archive data on x86 host?
> 
> I missed that in the original conversation, sry for noise

np, I fixed my mistake by making this be done on perf_session__new(),
right after creating the evlist, this way these arch specific bits,
needed only for dumping the raw sample, do not get dragged via evlist.c
into the perf binding :-)

- Arnaldo
 
> jirka
> 
> > I stumbled on this as well, I think the way to go is to get the
> > color_fprintf bits in a separate object to avoid dragging more stuff to
> > the perf binding set of objects and then add that to the python binding.
> >  
> > > Could you please check if code in here works for you:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   perf/s390
> > > 
> > > if it works, I'll post it
> > > 
> > > thanks,
> > > jirka
> > 
> > -- 
> > 
> > - Arnaldo

-- 

- Arnaldo
