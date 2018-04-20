Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDTITp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:19:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46900 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753905AbeDTITn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:19:43 -0400
Date: Fri, 20 Apr 2018 10:19:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yonghong Song <yhs@fb.com>
Cc: mingo@kernel.org, ast@fb.com, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] x86/cpufeature: guard asm_volatile_goto usage with
 NO_BPF_WORKAROUND
Message-ID: <20180420081936.GD4064@hirez.programming.kicks-ass.net>
References: <20180415042738.1788215-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415042738.1788215-1-yhs@fb.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 09:27:38PM -0700, Yonghong Song wrote:

> This patch adds a preprocessor guard NO_BPF_WORKAROUND around the
> asm_volatile_goto based static_cpu_has(). NO_BPF_WORKAROUND is set
> at toplevel Makefile when compiler supports asm-goto. That is,
> if the compiler supports asm-goto, the kernel build will use
> asm-goto version of static_cpu_has().

Hurm, so adding __BPF__ for BPF compiles isn't an option? It seems to me
having a CPP flag to identify BPF compile context might be useful in
general.
