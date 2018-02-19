Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeBSMSW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752686AbeBSMSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:18:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D385A21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 19 Feb 2018 09:18:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCH 6/9] perf tools: Don't search for active kernel start in
 __machine__create_kernel_maps
Message-ID: <20180219121817.GC14978@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org>
 <20180215122635.24029-7-jolsa@kernel.org>
 <20180219022036.GB1583@sejong>
 <20180219100140.GA17630@krava>
 <20180219101936.GD1583@sejong>
 <20180219104917.GA19365@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219104917.GA19365@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 19, 2018 at 11:49:44AM +0100, Jiri Olsa escreveu:
> On Mon, Feb 19, 2018 at 07:19:36PM +0900, Namhyung Kim wrote:
> 
> SNIP
> 
> > From b736729e83b62f97d716a011ccf4e430b614fecd Mon Sep 17 00:00:00 2001
> > From: Namhyung Kim <namhyung@kernel.org>
> > Date: Mon, 19 Feb 2018 19:00:46 +0900
> > Subject: [PATCH] perf tools: Fix paranoid check in machine__set_kernel_mmap()
> > 
> > The machine__set_kernel_mmap() is to setup addresses of the kernel map
> > using external info.  But it has a check when the address is given
> > from an incorrect input which should have the start and end address of
> > 0 (i.e. machine__process_kernel_mmap_event).
> > 
> > But we also use the end address of 0 for a valid input so change it to
> > check both start and end addresses.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
