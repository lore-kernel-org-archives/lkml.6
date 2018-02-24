Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeBXBCo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:02:44 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45833 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeBXBCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:02:42 -0500
X-Google-Smtp-Source: AH8x224UrMI1wolkG+Tu9v1PTmZvs8yKsnsagJkvBMFxzPUozTAaDXoCfEf5INbsaXWvU72CGgX6ow==
Date: Fri, 23 Feb 2018 17:02:41 -0800 (PST)
X-Google-Original-Date: Fri, 23 Feb 2018 16:57:50 PST (-0800)
Subject: Re: [patches] Re: [PATCH v4 0/6] Add dynamic ftrace support for RISC-V platforms
In-Reply-To: <20180221024539.GA3735@andestech.com>
CC: albert@sifive.com, rostedt@goodmis.org, mingo@redhat.com,
        patches@groups.riscv.org, linux-kernel@vger.kernel.org,
        greentime@andestech.com
From: Palmer Dabbelt <palmer@sifive.com>
To: alankao@andestech.com
Message-ID: <mhng-8be751e6-f51b-433f-8e08-0aff87034ac2@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018 18:45:39 PST (-0800), alankao@andestech.com wrote:
> On Tue, Feb 13, 2018 at 01:13:15PM +0800, Alan Quey-Liang Kao(高魁良) wrote:
>> This patch set includes the building blocks of dynamic ftrace features
>> for RISC-V machines.
>> 
>> Changes in v4:
>>  - Organize code structure according to changes in v3
>>  - Rebase onto the riscv-linux-4.15 branch at github's 
>>    riscv/riscv-linux repo.  Note that this set is based on the previous
>>    ftrace patch, which provided basic support.
>> 
>> Changes in v3:
>>  - Replace the nops at the tracer call sites into "call ftrace_stub"
>>    instructions for better understanding (1/6, 2/6 and 5/6)
>> 
>> Changes in v2:
>>  - Fix the return value as writing to kernel text goes wrong (2/6)
>>  - Replace manual comparisons by calling memcmp (2/6)
>>  - Simplify the conditional assignment in the Makefile (1/6)
>> 
>> Alan Kao (6):
>>   riscv/ftrace: Add RECORD_MCOUNT support
>>   riscv/ftrace: Add dynamic function tracer support
>>   riscv/ftrace: Add dynamic function graph tracer support
>>   riscv/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS support
>>   riscv/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
>>   riscv/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
>> 
>>  arch/riscv/Kconfig              |   3 +
>>  arch/riscv/Makefile             |   3 +
>>  arch/riscv/include/asm/ftrace.h |  56 ++++++++++
>>  arch/riscv/kernel/Makefile      |   5 +-
>>  arch/riscv/kernel/ftrace.c      | 175 ++++++++++++++++++++++++++++-
>>  arch/riscv/kernel/mcount-dyn.S  | 239 ++++++++++++++++++++++++++++++++++++++++
>>  arch/riscv/kernel/mcount.S      |  22 ++--
>>  arch/riscv/kernel/stacktrace.c  |   6 +
>>  scripts/recordmcount.pl         |   5 +
>>  9 files changed, 501 insertions(+), 13 deletions(-)
>>  create mode 100644 arch/riscv/kernel/mcount-dyn.S
>> 
>> -- 
>> 2.15.1
>>
>
> Any comments? 

Sorry, my email latency is a bit long now as I'm still backed up from FOSDEM.  
This looks good, it should already be in our for-next branch.
