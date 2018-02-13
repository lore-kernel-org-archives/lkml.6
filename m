Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964966AbeBMQOt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:14:49 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:39039 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbeBMQOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:14:47 -0500
From: Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To: James Hogan <jhogan@kernel.org>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>
CC: Paul Burton <Paul.Burton@mips.com>,
        Maciej Rozycki <Maciej.Rozycki@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        DengCheng Zhu <DengCheng.Zhu@mips.com>,
        "Ding Tianhong" <dingtianhong@huawei.com>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>, Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Redfearn <Matt.Redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: RE: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
Thread-Topic: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
Thread-Index: AQHTYtCG2PpJE/Fo0Ui3SV1RppsO3aMf1f6AgA1nQ4CAAAn5gIAAMXCAgAm9VQCAAAlBAIABH7iAgGMJFICAB5Tqww==
Date: Tue, 13 Feb 2018 16:06:22 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEE298ED6CE@MIPSMAIL01.mipstec.com>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>
 <20171130100957.GG5027@jhogan-linux.mipstec.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
 <alpine.DEB.2.00.1712061657520.4584@tp.orcam.me.uk>
 <20171206182400.6va3pqdmgisbino7@pburton-laptop>
 <48924BBB91ABDE4D9335632A6B179DD6A8E6B2@MIPSMAIL01.mipstec.com>,<20180208115559.GA31316@saruman>
In-Reply-To: <20180208115559.GA31316@saruman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1518538372-321459-5008-230-9
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189981
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
        0.20 PR0N_SUBJECT           META: Subject has letters around special characters (pr0n)
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, PR0N_SUBJECT
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> ________________________________________
> From: James Hogan [jhogan@kernel.org]
> Sent: Thursday, February 8, 2018 12:55 PM
> 
> Hi,
> 
> On Thu, Dec 07, 2017 at 11:33:47AM +0000, Miodrag Dinic wrote:
> > > On Wed, Dec 06, 2017 at 05:50:52PM +0000, Maciej W. Rozycki wrote:
> > > >  What problem are you trying to solve anyway?  Is it not something that
> > > > can be handled with the `execstack' utility?
> > >
> > > The commit message states that for Android "non-exec stack is required".
> > > Is Android checking that then Aleksandar? If so, how?
> >
> > Android is using SELinux configured to disallow NX mappings by handling
> > the following sepolicy rules :
> > * Executable stack (execstack)
> > * Executable heap (execheap)
> > * File-based executable code which has been modified (execmod)
> > * All other executable memory (execmem)
> 
> ...
> 
> > The effect of not having some workaround like this in the kernel, would
> > be to run Android only in SELinux permissive mode.
> 
> So you want to override the lack of RIXI so that SELinux sees an
> RX->RW->RX transition as execmod instead of execmem (since without RIXI
> its effectively RX->RWX->RX which is execmem)?
> 

That is correct.

> 
> Looking at file_map_prot_check(), it does the execmem check on this
> condition:
> 
> if (default_noexec &&
>     (prot & PROT_EXEC) && (!file || IS_PRIVATE(file_inode(file)) ||
>                            (!shared && (prot & PROT_WRITE)))) {
>         /*
>          * We are making executable an anonymous mapping or a
>          * private file mapping that will also be writable.
>          * This has an additional check.
>          */
> 
> default_noexec is set if VM_DATA_DEFAULT_FLAGS doesn't have the exec
> flag set, and that flag depends on current->personality &
> READ_IMPLIES_EXEC, which depends on elf_read_implies_exec(), i.e.
> mips_elf_read_implies_exec(), and that should already return 1 if RIXI
> is unavailable.
> 
> I.e.
> 
> mips_elf_read_implies_exec() == 1
> 
> elf_read_implies_exec() == 1
> 
> READ_IMPLIES_EXEC will be set in current->personality
> 
> VM_DATA_DEFAULT_FLAGS will have VM_EXEC set
> 
> default_noexec will be set to 0 in selinux_init()
> 
> none of the execmem, execheap, execstack, execmod permission
> checks should take place.
> 
> So whats the problem exactly? Perhaps I misinterpreted something.

Thanks, James, for the analysis of this scenario! Hope the additional
info below will be useful for clarifying this matter.

-------------------

Let me rephrase the scenario (for configurations where cpu_has_rixi
equals to 0) that you described: (line numbers may be approximate)


1. mips_elf_read_implies_exec() will return 1
    (arch/mips/kernel/elf.c:336)

2. elf_read_implies_exec() will return 1
    (arch/mips/include/asm/elf.h:513)

3. READ_IMPLIES_EXEC will be set in current->personality
    (fs/binfmt_elf_fdpic.c:357)

4. VM_DATA_DEFAULT_FLAGS will have VM_EXEC set
    (while execiting selinux_init() in security/selinux/hooks.c:6644)

5. default_noexec will be set to 0 in selinux_init()
    (security/selinux/hooks.c:6644)

6. none of the execmem, execstack permission checks should take place.

-------------------

However, in reality, these steps are not executed in this order, but in the following one:


4a. VM_DATA_DEFAULT_FLAGS will *NOT* have VM_EXEC set
    (while execiting selinux_init() in security/selinux/hooks.c:6644)

5a. default_noexec will be set to *1* in selinux_init()
    (security/selinux/hooks.c:6644)

1. mips_elf_read_implies_exec() will return 1
    (arch/mips/kernel/elf.c:336)

2. elf_read_implies_exec() will return 1
    (arch/mips/include/asm/elf.h:513)

3. READ_IMPLIES_EXEC will be set in current->personality
    (fs/binfmt_elf_fdpic.c:357)

6a. both the execmem, execstack permission checks *do* take place.

------------------

The proposed change does affect the kernel in the sense that it indeed
hides the executable vulnerability of the system without RIXI support.
But we have made it unambiguous in the comments what are the
consequences of using this option.

------------------


Regards,

Aleksandar

> 
> Cheers
> James
