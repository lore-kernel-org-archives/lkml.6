Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeDPQ6E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeDPQ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:58:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC73F21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 16 Apr 2018 13:58:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-ID: <20180416165800.GD3202@kernel.org>
References: <20180416042240.21528-1-namhyung@kernel.org>
 <20180416092345.GA23274@krava>
 <20180416135125.GA23802@kernel.org>
 <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 16, 2018 at 11:07:30AM -0500, Kim Phillips escreveu:
> On Mon, 16 Apr 2018 10:51:25 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Mon, Apr 16, 2018 at 11:23:45AM +0200, Jiri Olsa escreveu:
> > > On Mon, Apr 16, 2018 at 01:22:40PM +0900, Namhyung Kim wrote:
> > > > The map_groups__fixup_end() was called to set end addresses of kernel
> > > > map and module maps.  But now machine__create_modules() is set the end
> > > > address of modules properly so the only remaining piece is the kernel
> > > > map.  We can set it with adjacent module's address directly instead of
> > > > calling the map_groups__fixup_end().  If there's no module after the
> > > > kernel map, the end address will be ~0ULL.
> > 
> > I wonder if it wouldn't be better to have it as last symbol + PAGE_SIZE
> > or something like that...
> > 
> > But, anyway, Kim, does this fix things for you? Can I have your
> > Tested-by?
> 
> No, perf test 1 still fails:
> 
> vmlinux symtab matches kallsyms: FAILED!

Ok, -vv please

- Arnaldo
