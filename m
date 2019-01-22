Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160E2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F0221721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169091;
	bh=QfQKaNsMjOXaYnkw/5gWxspUMectnW8nKcVStxMz8QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OPghuYcRNPLh/aEuPN1YP4w6CU6LUXgNjOPXG7XvpA6wDIKkNaSeIO/oXkE6WyrzX
	 zulN8STYLmM0y1hN/mulOcXapP+lVBjmgM7rmIy2JL6kATj+jgOlNDgET7hYtCsSCM
	 +HoNFNpktBDmKJOHqBb8vEi+crZ9vuA8c1AfnlQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfAVO6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbfAVO6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:58:09 -0500
Received: from quaco.ghostprotocols.net (unknown [189.16.122.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C4120870;
        Tue, 22 Jan 2019 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169088;
        bh=QfQKaNsMjOXaYnkw/5gWxspUMectnW8nKcVStxMz8QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POcyP7uKI1S/m6wK7M04erXA0Sz0U8DknDUHO5iotC627aKzjdoZe8oCMbNRKS7g/
         yqcd8FLGiKrfwUKs2Jn+6een062fOzk3hsD1ac3JWfFHYyTCLaYNIP+jl9m53flCh0
         6G2K8NjaUb66W295zrwmRTbJk7zQJU4dJtPSJ8yA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A6D540355; Tue, 22 Jan 2019 12:58:05 -0200 (-02)
Date:   Tue, 22 Jan 2019 12:58:05 -0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v11 perf, bpf-next 7/9] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Message-ID: <20190122145805.GI14973@kernel.org>
References: <20190117161521.1341602-1-songliubraving@fb.com>
 <20190117161521.1341602-8-songliubraving@fb.com>
 <20190118144655.GM5823@kernel.org>
 <20190122141320.GF14973@kernel.org>
 <20190122143117.GG14973@kernel.org>
 <20190122145119.GF27625@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122145119.GF27625@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 22, 2019 at 03:51:19PM +0100, Jiri Olsa escreveu:
> On Tue, Jan 22, 2019 at 12:31:17PM -0200, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jan 22, 2019 at 12:13:20PM -0200, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Jan 18, 2019 at 11:46:55AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Thu, Jan 17, 2019 at 08:15:19AM -0800, Song Liu escreveu:
> > > > > This patch synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for
> > > > > BPF programs loaded before perf-record. This is achieved by gathering
> > > > > information about all BPF programs via sys_bpf.
> > > > 
> > > > Ditto
> > > 
> > > This is breaking 'perf sched', see below, the fix seems trivial:
> > > 
> > > [root@quaco ~]# perf sched record -a sleep 2
> > > [ perf record: Woken up 1 times to write data ]
> > > 0x5b60 [0x138]: failed to process type: 17
> > > [ perf record: Captured and wrote 1.539 MB perf.data ]
> > > [root@quaco ~]# perf sched lat
> > > 0x5b60 [0x138]: failed to process type: 17
> > > Failed to process events, error -22
> > > [root@quaco ~]#
> > 
> > So:
> > 
> >    perf_session__process_event (event->header.type = 17 (PERF_RECORD_KSYMBOL)
> >      if (tool->ordered_events)
> >        ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
> >        if (ret && ret != -1)
> >             return ret;
> > 
> > So it returns here with -EFAULT, i.e. this is failing:
> > 
> > int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
> >                                         union perf_event *event,
> >                                         u64 *timestamp)
> > {
> >         struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
> > 
> >         if (!evsel)
> >                 return -EFAULT;
> >         return perf_evsel__parse_sample_timestamp(evsel, event, timestamp);
> > }
> > 
> > It isn't mapping the event ID it finds back to an evsel.. Jiri, ideas?
> > 
> > This is happening so far only for 'perf sched', perf record with two
> > events works.
> 
> I saw also perf mem failing because of this.. will check

Right, seems something with the synthesizing of existing bpf progs,
which always there are some nowadays, for instance, on this fedora29
system:

[root@quaco tmp]# bpftool prog
13: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-21T13:30:27-0200  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
14: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-21T13:30:27-0200  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
15: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-21T13:30:27-0200  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
16: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-21T13:30:27-0200  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
17: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-21T13:30:29-0200  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
18: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-21T13:30:29-0200  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
21: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-21T13:30:29-0200  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
22: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-21T13:30:29-0200  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
[root@quaco tmp]#

When with a bunch of tracepoints, that is what 'perf mem', 'perf kmem',
'perf sched', etc does, it ends up failing here:

                    ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);

So it is not passed to 

                   ret = perf_session__queue_event(session, event, timestamp, file_offset);

in perf_session__process_event, this happens right when processing
buildids in 'perf record', and also in 'perf report', so that is
something badly synthesized that hits perf.data for PERF_RECORD_KSYMBOL.

- Arnaldo
