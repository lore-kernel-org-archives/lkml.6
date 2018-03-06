Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeCFOCB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:02:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbeCFOCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:02:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B5520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Mar 2018 11:01:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com
Subject: Re: [PATCH 7/7] perf tools: Refine perf_mmap__read_init
Message-ID: <20180306140158.GC10176@kernel.org>
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
 <1520277059-32749-7-git-send-email-kan.liang@linux.intel.com>
 <20180305222502.GA7403@krava>
 <cf790e3f-9ced-2654-3c05-1ea33ee301e1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf790e3f-9ced-2654-3c05-1ea33ee301e1@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 06, 2018 at 08:29:03AM -0500, Liang, Kan escreveu:
> 
> 
> On 3/5/2018 5:25 PM, Jiri Olsa wrote:
> > On Mon, Mar 05, 2018 at 02:10:59PM -0500, kan.liang@linux.intel.com wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> > > index e3921ed..403c5e6 100644
> > > --- a/tools/perf/util/mmap.c
> > > +++ b/tools/perf/util/mmap.c
> > > @@ -235,16 +235,13 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u6
> > >   /*
> > >    * Report the start and end of the available data in ringbuffer
> > >    */
> > > -int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
> > > -			 u64 *startp, u64 *endp)
> > > +int perf_mmap__read_init(struct perf_mmap *md, bool overwrite)
> > >   {
> > >   	u64 head = perf_mmap__read_head(md);
> > >   	u64 old = md->prev;
> > >   	unsigned char *data = md->base + page_size;
> > >   	unsigned long size;
> > > -	*startp = overwrite ? head : old;
> > > -	*endp = overwrite ? old : head;
> > >   	md->overwrite = overwrite;
> > 
> > hum, can't we set 'overwrite' at the moment we create struct perf_mmap?
> > 
> > it's not changing during the mmap's lifetime.. maybe we could do it in
> > perf_evlist__alloc_mmap function
> 
> Yes, we know that the __alloc_mmap() is for mmap or overwrite_mmap.
> I think we can set the 'overwrite' there.
> I will do the change in V2.

That is even better!

- Arnaldo
