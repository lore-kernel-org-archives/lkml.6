Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938437AbeBUQFP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:05:15 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32779 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbeBUQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:05:13 -0500
X-Google-Smtp-Source: AH8x225XQOkDUHtpEDJNuUiHVuE0YMeroyzbepBFe7reX4FD/vNvSHFnso32Y22DvShPdBdSspipQA==
Date: Wed, 21 Feb 2018 08:05:11 -0800 (PST)
X-Google-Original-Date: Wed, 21 Feb 2018 08:04:54 PST (-0800)
Subject: Re: [patches] [PATCH v4 0/6] Add dynamic ftrace support for RISC-V platforms
In-Reply-To: <1518498801-677-1-git-send-email-alankao@andestech.com>
CC: albert@sifive.com, rostedt@goodmis.org, mingo@redhat.com,
        patches@groups.riscv.org, linux-kernel@vger.kernel.org,
        greentime@andestech.com, alankao@andestech.com
From: Palmer Dabbelt <palmer@sifive.com>
To: alankao@andestech.com
Message-ID: <mhng-aa0ffadc-431b-4889-bc70-3f84d675d80e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018 21:13:15 PST (-0800), alankao@andestech.com wrote:
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

Thanks!  I've added this to our for-next tree, it should be good to go for 
4.17.  Sorry this took a while, I'm still a bit behind from FOSDEM.
