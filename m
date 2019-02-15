Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6241C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8476E218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfBOSMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:12:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfBOSMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:12:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59CECA0634;
        Fri, 15 Feb 2019 18:12:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE7BC5D6A9;
        Fri, 15 Feb 2019 18:12:46 +0000 (UTC)
Date:   Fri, 15 Feb 2019 19:12:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 06/10] perf header: Fix wrong node write in NUMA_TOPOLOGY
 feature
Message-ID: <20190215181245.GB8393@krava>
References: <20190213123246.4015-1-jolsa@kernel.org>
 <20190213123246.4015-7-jolsa@kernel.org>
 <20190213210943.GF1904@kernel.org>
 <20190213211428.GG1904@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213211428.GG1904@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 15 Feb 2019 18:12:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 06:14:28PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 13, 2019 at 06:09:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Feb 13, 2019 at 01:32:42PM +0100, Jiri Olsa escreveu:
> > > We are currently passing the node index instead of the
> > > real node number.
> > 
> > Next time please add a Fixes: so that the stables guys get this thing...
> > /me looking for that now.
> 
> So this comes from:
> 
> Fixes: fbe96f29ce4b ("perf tools: Make perf.data more self-descriptive (v8)"
> 
> Right?

right, thanks

jirka

> 
> - Arnaldo
>  
> > - Arnaldo
> >  
> > > Link: http://lkml.kernel.org/n/tip-rbtlsr9ts23c89rki7d4s5sm@git.kernel.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/header.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index dec6d218c31c..7bebf9a34edd 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -881,7 +881,7 @@ static int write_numa_topology(struct feat_fd *ff,
> > >  		if (ret < 0)
> > >  			break;
> > >  
> > > -		ret = write_topo_node(ff, i);
> > > +		ret = write_topo_node(ff, j);
> > >  		if (ret < 0)
> > >  			break;
> > >  	}
> > > -- 
> > > 2.17.2
> > 
> > -- 
> > 
> > - Arnaldo
> 
> -- 
> 
> - Arnaldo
