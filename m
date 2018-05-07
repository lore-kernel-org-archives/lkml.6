Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeEGEzH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 00:55:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751908AbeEGEy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 00:54:56 -0400
Date: Sun, 6 May 2018 23:54:53 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: damian <damian.tometzki@icloud.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel build with gcc 8 a lot of warnings
Message-ID: <20180507045453.leou4zypnlcck4vr@treble>
References: <20180505192112.GA18728@zrhn9910b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180505192112.GA18728@zrhn9910b>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 09:21:12PM +0200, damian wrote:
> Helllo together,
> 
> Hello everybody,
> 
> is something special to note when kernel build with gcc 8? I receive various warnings from the objtool:
> With GCC 7 works all fine.
> 
> kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x40: sibling call from callable instruction with modified stack frame
> kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x2a3: sibling call from callable instruction with modified stack frame
> kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x20b: sibling call from callable instruction with modified stack frame
> kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x296: sibling call from callable instruction with modified stack frame
> kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable()+0x10: sibling call from callable instruction with modified stack frame
> kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags.cold.45()+0xa: call without frame pointer save/setup
> kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files.cold.46()+0x17: call without frame pointer save/setup
> kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable.cold.47()+0x24: call without frame pointer save/setup
> kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems.cold.48()+0x10: call without frame pointer save/setup
> kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable.cold.49()+0x7: call without frame pointer save/setup
>   CC      kernel/cgroup/stat.o
>   CC [M]  arch/x86/kvm/../../../virt/kvm/kvm_main.o
> arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic()+0x10: sibling call from callable instruction with modified stack frame
> arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu()+0x2c: sibling call from callable instruction with modified stack frame
> arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic.cold.6()+0x7: call without frame pointer save/setup
> arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu.cold.7()+0x7: call without frame pointer save/setup

Thanks, this is a known issue with GCC 8 that I haven't gotten a chance
to fix yet.  They're related to the fact that GCC 8 is splitting out
'unlikely' code into 'cold' subfunctions in .text.unlikely.

I've got some old patches that fix it.  Now that GCC 8 is out, I'll need
get the patches dusted off and cleaned up for merging.

-- 
Josh
