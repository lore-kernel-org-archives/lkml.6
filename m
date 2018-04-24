Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeDXMuN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:50:13 -0400
Received: from foss.arm.com ([217.140.101.70]:52714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932995AbeDXMuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:50:06 -0400
Date: Tue, 24 Apr 2018 07:50:03 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-Id: <20180424075003.48ab0015efc0892832343546@arm.com>
In-Reply-To: <CAKv+Gu-u1E9gH7=p5sbiA4k_9mQ13y+056nYKnr2D9BPENNyMg@mail.gmail.com>
References: <20180416042240.21528-1-namhyung@kernel.org>
        <20180416092345.GA23274@krava>
        <20180416135125.GA23802@kernel.org>
        <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
        <20180416165800.GD3202@kernel.org>
        <20180416122407.0d90863b69fed80166384850@arm.com>
        <20180416174811.1aca9106364effe435f363c8@arm.com>
        <20180417022726.GA31947@sejong>
        <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com>
        <20180419025424.GC13370@sejong>
        <20180419183313.db3e3a105191a7f30b7650b2@arm.com>
        <CAKv+Gu_sY+Q+kqO1hp6f30WSGNPY1cnW5VJYj9cuVA0hU5YDVw@mail.gmail.com>
        <20180423164317.5a47f3dd9842d533413a1d4b@arm.com>
        <CAKv+Gu-u1E9gH7=p5sbiA4k_9mQ13y+056nYKnr2D9BPENNyMg@mail.gmail.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 08:13:57 +0200
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 23 April 2018 at 23:43, Kim Phillips <kim.phillips@arm.com> wrote:
> > arch__normalize_symbol_name() is a place where architecture code can
> > clean up symbol names in perf, and I thought module_emit_adrp_veneer()
> > was a veneer itself, but it seems that's not the case, so the
> > literal string check for it shouldn't be needed.  The test is still
> > failing though because it doesn't show up in kallsyms...
> 
> This turns out to be an unintended side effect of the fact that we
> (I?) taught kallsyms to disregard symbols ending in "_veneer"
> 
> So we should probably rename the function, and everything will be fine.

ok so what should we rename module_emit_adrp_veneer to?:

module_emit_adrp_veneer_
module_emit_adrp_veneer_fn
module_emit_adrp_veneer_nokallsyms

or..?

Kim
