Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeAaJWV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:22:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbeAaJWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:22:19 -0500
Date: Wed, 31 Jan 2018 10:22:16 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf cgroup: simplify arguments if track multiple
 events for a cgroup
Message-ID: <20180131092216.GB3313@krava>
References: <20180129154805.GA6284@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129154805.GA6284@localhost.didichuxing.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 11:48:09PM +0800, weiping zhang wrote:
> if use -G with one cgroup and -e with multiple events, only the first
> event has correct cgroup setting, all events from the second will track
> system-wide events.
> 
> if user want track multiple events for a specific cgroup, user must give
> parameters like follow:
> $ perf stat -e e1 -e e2 -e e3 -G test,test,test
> this patch simplify this case, just type one cgroup, like following:
> $ perf stat -e e1 -e e2 -e e3 -G test
> 
> $ mkdir -p /sys/fs/cgroup/perf_event/test
> $ perf stat -e cycles -e cache-misses  -a -I 1000 -G test
> 
> before:
>      1.001007226      <not counted>      cycles                    test
>      1.001007226              7,506      cache-misses
> 
> after:
>      1.000834097      <not counted>      cycles                    test
>      1.000834097      <not counted>      cache-misses              test
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
