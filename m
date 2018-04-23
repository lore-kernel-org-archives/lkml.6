Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbeDWNwd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754981AbeDWNw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:52:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ACB217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 23 Apr 2018 10:52:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-ID: <20180423135221.GC3254@kernel.org>
References: <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
 <20180416165800.GD3202@kernel.org>
 <20180416122407.0d90863b69fed80166384850@arm.com>
 <20180416174811.1aca9106364effe435f363c8@arm.com>
 <20180417022726.GA31947@sejong>
 <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com>
 <20180419023712.GB13370@sejong>
 <20180419182024.5d3bc71deef99551cc19fc55@arm.com>
 <20180419235915.GA19067@sejong>
 <20180420182358.c3dad0f06100d41aa16a2104@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420182358.c3dad0f06100d41aa16a2104@arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 20, 2018 at 06:23:58PM -0500, Kim Phillips escreveu:
> On Fri, 20 Apr 2018 08:59:15 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > The map_groups__fixup_end() was called to set end addresses of kernel
> > map and module maps.  But now machine__create_modules() is set the end
> > address of modules properly, the only remaining piece is the kernel map.
> > We can set it with adjacent module's address directly instead of calling
> > the map_groups__fixup_end().  If there's no module after the kernel map,
> > the end address will be ~0ULL.
> > 
> > Since it also changes the start address of the kernel map, it needs to
> > re-insert the map to the kmaps in order to keep a correct ordering.  Kim
> > reported that it caused problems on ARM64.
> > 
> > Reported-by: Kim Phillips <kim.phillips@arm.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> 
> Acked-by: Kim Phillips <kim.phillips@arm.com>

So as you actually seem to have tested this, I'm taking this as a
Tested-by instead, to better reflect what you did, ok?

- Arnaldo
