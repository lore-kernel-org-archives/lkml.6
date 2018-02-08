Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBHAwz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 19:52:55 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45481 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeBHAwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 19:52:53 -0500
X-Google-Smtp-Source: AH8x225olh19xeJ9HuVzO0hLjxUQ+Vyv1t8zpkYDff/NLz2poJPtoHyfQBXEPHbx4q4KB+f1nO5mAA==
Date: Thu, 8 Feb 2018 08:52:47 +0800
From: Alan Kao <nonerkao@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: albert@sifive.com, rostedt@goodmis.org, mingo@redhat.com,
        yamada.masahiro@socionext.com, n54@gmx.com, akpm@linux-foundation.org,
        patches@groups.riscv.org, linux-kernel@vger.kernel.org,
        sorear2@gmail.com, alankao@andestech.com, greentime@andestech.com
Subject: Re: [patches] [PATCH v3 0/6] Add dynamic ftrace support for RISC-V
 platforms
Message-ID: <20180208005245.GA26140@75c3b24ef355>
References: <20180118154545.17987-1-alankao@andestech.com>
 <mhng-375db8f6-17f2-41d6-922f-33b0c7fc9e1c@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-375db8f6-17f2-41d6-922f-33b0c7fc9e1c@palmer-si-x1c4>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 04:37:10PM -0800, Palmer Dabbelt wrote:
> On Thu, 18 Jan 2018 07:45:39 PST (-0800), nonerkao@gmail.com wrote:
> > This patch set includes the building blocks of dynamic ftrace features
> > for RISC-V machines.
> > 
> > Changes in v3:
> >  - Replace the nops at the tracer call sites into a "call ftrace_stub"
> >    instruction for better understanding (1/6 and 2/6)
> > 
> > Changes in v2:
> >  - Fix the return value as writing to kernel text goes wrong (2/6)
> >  - Replace manual comparisons by calling memcmp (2/6)
> >  - Simplify the conditional assignment in the Makefile (1/6)
> > 
> > Alan Kao (6):
> >   riscv/ftrace: Add RECORD_MCOUNT support
> >   riscv/ftrace: Add dynamic function tracer support
> >   riscv/ftrace: Add dynamic function graph tracer support
> >   riscv/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS support
> >   riscv/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
> >   riscv/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
> > 
> >  arch/riscv/Kconfig              |   3 +
> >  arch/riscv/Makefile             |   3 +
> >  arch/riscv/include/asm/ftrace.h |  47 ++++++++
> >  arch/riscv/kernel/Makefile      |   5 +-
> >  arch/riscv/kernel/ftrace.c      | 142 ++++++++++++++++++++++-
> >  arch/riscv/kernel/mcount-dyn.S  | 241 ++++++++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/mcount.S      |  22 ++--
> >  arch/riscv/kernel/stacktrace.c  |   6 +
> >  scripts/recordmcount.pl         |   5 +
> >  9 files changed, 461 insertions(+), 13 deletions(-)
> >  create mode 100644 arch/riscv/kernel/mcount-dyn.S
> 
> Sorry it took me a while to get around to these.  Do you mind submitting a
> v4 that's based on linux-4.15?  I'm getting all sorts of merge errors trying
> to "git am" these.

Sure.  But do you mean the riscv-linux-4.15 at the github repo or
Linus's linux-4.15-rc......,says, rc8?

Also, we have fixed our internal email server issue, so I will send this
v4 set using alankao@andestech.com, by which I signed off all previous
ftrace patches, instead of the current gmail one.  I hope this won't be
confusing to you.

Thanks,
Alan
