Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeBUCtO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 21:49:14 -0500
Received: from exmail.andestech.com ([59.124.169.137]:28923 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBUCtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 21:49:12 -0500
Date: Wed, 21 Feb 2018 10:45:39 +0800
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        "patches@groups.riscv.org" <patches@groups.riscv.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?="
        <greentime@andestech.com>
Subject: Re: [PATCH v4 0/6] Add dynamic ftrace support for RISC-V platforms
Message-ID: <20180221024539.GA3735@andestech.com>
References: <1518498801-677-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518498801-677-1-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w1L2kqgT073710
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 01:13:15PM +0800, Alan Quey-Liang Kao(高魁良) wrote:
> This patch set includes the building blocks of dynamic ftrace features
> for RISC-V machines.
> 
> Changes in v4:
>  - Organize code structure according to changes in v3
>  - Rebase onto the riscv-linux-4.15 branch at github's 
>    riscv/riscv-linux repo.  Note that this set is based on the previous
>    ftrace patch, which provided basic support.
> 
> Changes in v3:
>  - Replace the nops at the tracer call sites into "call ftrace_stub"
>    instructions for better understanding (1/6, 2/6 and 5/6)
> 
> Changes in v2:
>  - Fix the return value as writing to kernel text goes wrong (2/6)
>  - Replace manual comparisons by calling memcmp (2/6)
>  - Simplify the conditional assignment in the Makefile (1/6)
> 
> Alan Kao (6):
>   riscv/ftrace: Add RECORD_MCOUNT support
>   riscv/ftrace: Add dynamic function tracer support
>   riscv/ftrace: Add dynamic function graph tracer support
>   riscv/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS support
>   riscv/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
>   riscv/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
> 
>  arch/riscv/Kconfig              |   3 +
>  arch/riscv/Makefile             |   3 +
>  arch/riscv/include/asm/ftrace.h |  56 ++++++++++
>  arch/riscv/kernel/Makefile      |   5 +-
>  arch/riscv/kernel/ftrace.c      | 175 ++++++++++++++++++++++++++++-
>  arch/riscv/kernel/mcount-dyn.S  | 239 ++++++++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/mcount.S      |  22 ++--
>  arch/riscv/kernel/stacktrace.c  |   6 +
>  scripts/recordmcount.pl         |   5 +
>  9 files changed, 501 insertions(+), 13 deletions(-)
>  create mode 100644 arch/riscv/kernel/mcount-dyn.S
> 
> -- 
> 2.15.1
>

Any comments? 
