Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeDTXYB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 19:24:01 -0400
Received: from foss.arm.com ([217.140.101.70]:54300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752288AbeDTXYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 19:24:00 -0400
Date: Fri, 20 Apr 2018 18:23:58 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@lge.com>
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-Id: <20180420182358.c3dad0f06100d41aa16a2104@arm.com>
In-Reply-To: <20180419235915.GA19067@sejong>
References: <20180416092345.GA23274@krava>
        <20180416135125.GA23802@kernel.org>
        <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
        <20180416165800.GD3202@kernel.org>
        <20180416122407.0d90863b69fed80166384850@arm.com>
        <20180416174811.1aca9106364effe435f363c8@arm.com>
        <20180417022726.GA31947@sejong>
        <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com>
        <20180419023712.GB13370@sejong>
        <20180419182024.5d3bc71deef99551cc19fc55@arm.com>
        <20180419235915.GA19067@sejong>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 08:59:15 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> The map_groups__fixup_end() was called to set end addresses of kernel
> map and module maps.  But now machine__create_modules() is set the end
> address of modules properly, the only remaining piece is the kernel map.
> We can set it with adjacent module's address directly instead of calling
> the map_groups__fixup_end().  If there's no module after the kernel map,
> the end address will be ~0ULL.
> 
> Since it also changes the start address of the kernel map, it needs to
> re-insert the map to the kmaps in order to keep a correct ordering.  Kim
> reported that it caused problems on ARM64.
> 
> Reported-by: Kim Phillips <kim.phillips@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

Acked-by: Kim Phillips <kim.phillips@arm.com>

Thanks,

Kim
