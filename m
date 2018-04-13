Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeDMSTe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 14:19:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbeDMSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 14:19:33 -0400
Date: Fri, 13 Apr 2018 20:19:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <ast@fb.com>
Cc: Yonghong Song <yhs@fb.com>, mingo@kernel.org, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/cpufeature: guard asm_volatile_goto usage with
 CC_HAVE_ASM_GOTO
Message-ID: <20180413181924.GT4064@hirez.programming.kicks-ass.net>
References: <20180410204259.3981586-1-yhs@fb.com>
 <20180410210716.GI4082@hirez.programming.kicks-ass.net>
 <552d5866-912e-afde-f25a-77ae8390816d@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552d5866-912e-afde-f25a-77ae8390816d@fb.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 02:28:04PM -0700, Alexei Starovoitov wrote:
> Instead of
> #ifdef CC_HAVE_ASM_GOTO
> we can replace it with
> #ifndef __BPF__
> or some other name,

I would prefer the BPF specific hack; otherwise we might be encouraging
people to build the kernel proper without asm-goto.
