Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749A3222D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550254854;
	bh=JKzKHbJHo02DoCYjbXvPTJtPRrs9NPF3mxMa8hEUyY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KgX1mysQOks8RMn0SqP4zk2p3RE8fZjpve3BFH/gSsGzwP5dquADyi+F+8/8Vi9YB
	 0OnYUeUA3Qkk9CLbPw6auhKPC8yRaCOwExt1lAGVCb5b67PGHQA+/V+dcmd6d75vae
	 /aP6HFGvU8GNOdsfl75AsRsi4cKfES09IZnBqW3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbfBOSUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:20:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388282AbfBOSUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:20:52 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960F52192C;
        Fri, 15 Feb 2019 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550254850;
        bh=JKzKHbJHo02DoCYjbXvPTJtPRrs9NPF3mxMa8hEUyY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhSDRrbxtSPNA+XOz9Jf+Nsy82AS7QdzrLzm2xpKMXG0FtBU7cm6jl3PnP25QBrWJ
         yn4sF2WGjzAdLRaVQk529WiklnjUcQayirztvcZJWpsqx8wRu/B/MsbU1BslSH9o9j
         1dWvqqC3P9JsC01bSacTHCSdOlRn0fQVfYLPZOvM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A04F410D5; Fri, 15 Feb 2019 15:20:47 -0300 (-03)
Date:   Fri, 15 Feb 2019 15:20:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190215182047.GL31177@kernel.org>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-7-songliubraving@fb.com>
 <20190215142643.GC5784@redhat.com>
 <164D19ED-EA72-4A56-8259-FCF13894B183@fb.com>
 <20190215174022.GF31177@kernel.org>
 <847940EC-6E2A-4985-AE19-27758C301B5D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847940EC-6E2A-4985-AE19-27758C301B5D@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 15, 2019 at 05:47:58PM +0000, Song Liu escreveu:
> 
> 
> > On Feb 15, 2019, at 9:40 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Fri, Feb 15, 2019 at 05:25:01PM +0000, Song Liu escreveu:
> >>> On Feb 15, 2019, at 6:26 AM, Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> >>> Em Thu, Feb 14, 2019 at 04:00:09PM -0800, Song Liu escreveu:
> >>>> This patch enables perf-record to save btf information as headers to
> >>>> perf.data A new header type HEADER_BTF is introduced for this data.
> > 
> >>> 	Wouldn't it be better for this HEADER_BTF to be introduced
> >>> already as an user space event, Song, see:
> > 
> >>> tools/perf/util/event.h
> > 
> >>> and:
> > 
> >>> tools/perf/util/event.c
> > 
> >>> perf_event__synthesize_cpu_map()
> > 
> >> BTF would be short living for short living BPF programs. I guess 
> >> saving them as header is easier than merging them with samples. 
> > 
> >> What's the benefit of saving them as user space events?
> > 
> > When we work with pipe mode, i.e.:
> > 
> > 	perf record -o - | perf report -i -
> > 
> > and other combinations (with 'perf script', 'perf inject', etc), we need
> > a way to pass the headers to the other side, and the way was via user
> > space events.
> > 
> > This is something Stephane and Jiri have been discussing recently,
> > probably they have more justifications, Stephane, Jiri?
> > 
> > - Arnaldo
> 
> I see. In this case, we will need some synchronization between main
> thread and the polling thread, as they are both writing to the same
> pipe. 

So, the whole context is that we need to have 'perf record' to start a
thread per CPU and then read the already per-cpu mmap buffers in the
matching thread, with the right affinity, numa settings to have the
record phase not cause contention, etc, so it ends up dumping one stream
per CPU in a separate file in a 'perf.data' directory instead of a
perf.data file.

Jiri is working on that, so, if you dump one more stream into that
directory, it would, at post processing time, be ordered together with
the other stream, the per-cpu ones.

- Arnaldo
