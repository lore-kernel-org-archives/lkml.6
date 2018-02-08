Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBHAhN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 19:37:13 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35269 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeBHAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 19:37:12 -0500
X-Google-Smtp-Source: AH8x225Nv/W+qBiBNTqmmGfQoPQG0uoV2iO7/XzhJV48B041ydl0nH2tXnSW7QQdKQegaCACxZa8yQ==
Date: Wed, 07 Feb 2018 16:37:10 -0800 (PST)
X-Google-Original-Date: Wed, 07 Feb 2018 16:37:08 PST (-0800)
Subject: Re: [patches] [PATCH v3 0/6] Add dynamic ftrace support for RISC-V platforms
In-Reply-To: <20180118154545.17987-1-alankao@andestech.com>
CC: albert@sifive.com, rostedt@goodmis.org, mingo@redhat.com,
        yamada.masahiro@socionext.com, n54@gmx.com, akpm@linux-foundation.org,
        patches@groups.riscv.org, linux-kernel@vger.kernel.org,
        sorear2@gmail.com, alankao@andestech.com, greentime@andestech.com
From: Palmer Dabbelt <palmer@sifive.com>
To: nonerkao@gmail.com
Message-ID: <mhng-375db8f6-17f2-41d6-922f-33b0c7fc9e1c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2018 07:45:39 PST (-0800), nonerkao@gmail.com wrote:
> This patch set includes the building blocks of dynamic ftrace features
> for RISC-V machines.
>
> Changes in v3:
>  - Replace the nops at the tracer call sites into a "call ftrace_stub"
>    instruction for better understanding (1/6 and 2/6)
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
>  arch/riscv/include/asm/ftrace.h |  47 ++++++++
>  arch/riscv/kernel/Makefile      |   5 +-
>  arch/riscv/kernel/ftrace.c      | 142 ++++++++++++++++++++++-
>  arch/riscv/kernel/mcount-dyn.S  | 241 ++++++++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/mcount.S      |  22 ++--
>  arch/riscv/kernel/stacktrace.c  |   6 +
>  scripts/recordmcount.pl         |   5 +
>  9 files changed, 461 insertions(+), 13 deletions(-)
>  create mode 100644 arch/riscv/kernel/mcount-dyn.S

Sorry it took me a while to get around to these.  Do you mind submitting a v4 
that's based on linux-4.15?  I'm getting all sorts of merge errors trying to 
"git am" these.
