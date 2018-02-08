Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeBHI5B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 03:57:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751123AbeBHI5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 03:57:00 -0500
Date: Thu, 8 Feb 2018 09:56:57 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCH 06/10] perf tools: Use machine__set_kernel_mmap instead
 of map_groups__fixup_end
Message-ID: <20180208085657.GA303@krava>
References: <20180207144838.16823-1-jolsa@kernel.org>
 <20180207144838.16823-7-jolsa@kernel.org>
 <20180208003418.GA24686@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208003418.GA24686@sejong>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 09:34:18AM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Wed, Feb 07, 2018 at 03:48:34PM +0100, Jiri Olsa wrote:
> > The machine__set_kernel_mmap does the same job as map_groups__fixup_end
> > when used on kernel maps within machine__create_kernel_maps call.
> 
> I'm not sure.  Modules have end address after machine__create_module()
> but vmlinux_maps is not.  So map_groups__fixup() will set the end of
> vmlinux_maps but with this change it will have ~0ULL.

ugh, I missed the machine__create_modules call in there,
I'll rework and repost the patchset

thanks,
jirka
