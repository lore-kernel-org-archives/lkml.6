Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbeCEWZf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:25:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753621AbeCEWZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:25:06 -0500
Date: Mon, 5 Mar 2018 23:25:02 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com
Subject: Re: [PATCH 7/7] perf tools: Refine perf_mmap__read_init
Message-ID: <20180305222502.GA7403@krava>
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
 <1520277059-32749-7-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520277059-32749-7-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 02:10:59PM -0500, kan.liang@linux.intel.com wrote:

SNIP

> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index e3921ed..403c5e6 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -235,16 +235,13 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u6
>  /*
>   * Report the start and end of the available data in ringbuffer
>   */
> -int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
> -			 u64 *startp, u64 *endp)
> +int perf_mmap__read_init(struct perf_mmap *md, bool overwrite)
>  {
>  	u64 head = perf_mmap__read_head(md);
>  	u64 old = md->prev;
>  	unsigned char *data = md->base + page_size;
>  	unsigned long size;
>  
> -	*startp = overwrite ? head : old;
> -	*endp = overwrite ? old : head;
>  	md->overwrite = overwrite;

hum, can't we set 'overwrite' at the moment we create struct perf_mmap?

it's not changing during the mmap's lifetime.. maybe we could do it in
perf_evlist__alloc_mmap function

really nice cleanup!

thanks,
jirka
