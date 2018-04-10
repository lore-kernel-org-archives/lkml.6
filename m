Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeDJVHZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:07:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:07:24 -0400
Date: Tue, 10 Apr 2018 23:07:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yonghong Song <yhs@fb.com>
Cc: mingo@kernel.org, ast@fb.com, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/cpufeature: guard asm_volatile_goto usage with
 CC_HAVE_ASM_GOTO
Message-ID: <20180410210716.GI4082@hirez.programming.kicks-ass.net>
References: <20180410204259.3981586-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410204259.3981586-1-yhs@fb.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 01:42:59PM -0700, Yonghong Song wrote:
> Commit d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
> removed X86_FAST_FEATURE_TESTS and make macro static_cpu_has() always
> use __always_inline function _static_cpu_has() funciton.
> The static_cpu_has() uses gcc feature asm_volatile_goto construct,
> which is not supported by clang.

There will be more unconditional asm-goto usage, clang is in the process
of growing asm-goto.
