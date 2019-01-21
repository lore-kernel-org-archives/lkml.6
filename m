Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D6DC2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314F120879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080277;
	bh=8SyuWC8oJf5BXiU6Q48/Qx8jAC8TqHgmtHO25XDx5m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tp2FmY9yZjSZcTWYQNKxbzyypSvAAklrb4Hzy6R3heA7ZLd4BNKWl3MDA9qeBvUDr
	 yCJyLNytenhHi0FLjH/jhoPOOidXVIC4hlF+p1B1NpUiTqrqNhrEHq0rvljM0/zFA7
	 +laT7/s+W25wdDs2x7jIVkn0zenFSARQgDH/nRTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfAUORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:32998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbfAUORv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:17:51 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8824820861;
        Mon, 21 Jan 2019 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548080270;
        bh=8SyuWC8oJf5BXiU6Q48/Qx8jAC8TqHgmtHO25XDx5m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMOkBlKBi3XumpSiqUtMaS2ofoK6I0XUjbiZw9mBUdvyQnVzcdkaGlSM8N0C58h3f
         V43lDXtETAD5XB73cokyXOFLMw1aqv9OrV6AF+TeE5R//9sLRt9ALLPqD1SvkTN5CI
         w9NpfGDkw7w+xPtmGIwaLKTdYAu4eyDTIcFwxy5k=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 767244049A; Mon, 21 Jan 2019 11:17:48 -0300 (-03)
Date:   Mon, 21 Jan 2019 11:17:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
Message-ID: <20190121141748.GC15707@kernel.org>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org>
 <20190120181814.GB8591@krava>
 <20190121131336.GC3852@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121131336.GC3852@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 21, 2019 at 02:13:36PM +0100, Jiri Olsa escreveu:
> On Sun, Jan 20, 2019 at 07:18:14PM +0100, Jiri Olsa wrote:
> > On Thu, Jan 17, 2019 at 11:00:53AM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > SNIP
> > 
> > > --- a/tools/perf/util/python-ext-sources
> > > +++ b/tools/perf/util/python-ext-sources
> > > @@ -25,6 +25,7 @@ util/parse-branch-options.c
> > >  util/rblist.c
> > >  util/counts.c
> > >  util/print_binary.c
> > > +util/s390-sample-raw.c
> > >  util/strlist.c
> > >  util/trace-event.c
> > >  ../lib/rbtree.c
> > 
> > hi,
> > this change breaks the python module:
> > 
> >   >>> import perf
> >   Traceback (most recent call last):
> >     File "<stdin>", line 1, in <module>
> >   ImportError: ./perf.so: undefined symbol: color_fprintf
> > 
> > changelog doesn't say anything about python related change
> 
> I made some chenages and movedthat raw sample code
> under s390.. which cured the python module, but
> I haven't tested it on s390.

Nope, I explicitely asked him to build that code for all arches, as we
want to process s390 perf.data files on a x86 or arm or any other arch.

I stumbled on this as well, I think the way to go is to get the
color_fprintf bits in a separate object to avoid dragging more stuff to
the perf binding set of objects and then add that to the python binding.
 
> Could you please check if code in here works for you:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/s390
> 
> if it works, I'll post it
> 
> thanks,
> jirka

-- 

- Arnaldo
