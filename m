Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBDC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAC620894
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAC620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeG1Rsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 13:48:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:28198 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbeG1Rsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 13:48:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jul 2018 09:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,414,1526367600"; 
   d="gz'50?scan'50,208,50";a="61479300"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2018 09:21:21 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fjRy4-0003aq-Kb; Sun, 29 Jul 2018 00:21:20 +0800
Date:   Sun, 29 Jul 2018 00:20:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     kbuild-all@01.org, Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Convert uses of REG_FMT to %p
Message-ID: <201807290050.A99Vnu5d%fengguang.wu@intel.com>
References: <db0636b3290bbc72084f170a28e4dee5a22a622d.1532714999.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <db0636b3290bbc72084f170a28e4dee5a22a622d.1532714999.git.joe@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joe,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc6 next-20180727]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joe-Perches/riscv-Convert-uses-of-REG_FMT-to-p/20180728-104236
config: riscv-defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:14,
                    from include/asm-generic/bug.h:18,
                    from arch/riscv/include/asm/bug.h:75,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from arch/riscv/mm/fault.c:23:
   arch/riscv/mm/fault.c: In function 'do_page_fault':
>> arch/riscv/mm/fault.c:197:60: error: expected ')' before 'REG_FMT'
     pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n",
                                                               ^~~~~~~
   include/linux/printk.h:288:21: note: in definition of macro 'pr_fmt'
    #define pr_fmt(fmt) fmt
                        ^~~
   arch/riscv/mm/fault.c:197:2: note: in expansion of macro 'pr_alert'
     pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n",
     ^~~~~~~~
   In file included from include/linux/printk.h:7,
                    from include/linux/kernel.h:14,
                    from include/asm-generic/bug.h:18,
                    from arch/riscv/include/asm/bug.h:75,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from arch/riscv/mm/fault.c:23:
>> include/linux/kern_levels.h:5:18: warning: format '%s' expects a matching 'char *' argument [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^~~~~~
   include/linux/kern_levels.h:9:20: note: in expansion of macro 'KERN_SOH'
    #define KERN_ALERT KERN_SOH "1" /* action must be taken immediately */
                       ^~~~~~~~
   include/linux/printk.h:300:9: note: in expansion of macro 'KERN_ALERT'
     printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~
   arch/riscv/mm/fault.c:197:2: note: in expansion of macro 'pr_alert'
     pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n",
     ^~~~~~~~
   arch/riscv/mm/fault.c:197:37: note: format string is defined here
     pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n",
                                       ~^

vim +197 arch/riscv/mm/fault.c

07037db5 Palmer Dabbelt    2017-07-10  @23  #include <linux/mm.h>
07037db5 Palmer Dabbelt    2017-07-10   24  #include <linux/kernel.h>
07037db5 Palmer Dabbelt    2017-07-10   25  #include <linux/interrupt.h>
07037db5 Palmer Dabbelt    2017-07-10   26  #include <linux/perf_event.h>
07037db5 Palmer Dabbelt    2017-07-10   27  #include <linux/signal.h>
07037db5 Palmer Dabbelt    2017-07-10   28  #include <linux/uaccess.h>
07037db5 Palmer Dabbelt    2017-07-10   29  
07037db5 Palmer Dabbelt    2017-07-10   30  #include <asm/pgalloc.h>
07037db5 Palmer Dabbelt    2017-07-10   31  #include <asm/ptrace.h>
07037db5 Palmer Dabbelt    2017-07-10   32  
07037db5 Palmer Dabbelt    2017-07-10   33  /*
07037db5 Palmer Dabbelt    2017-07-10   34   * This routine handles page faults.  It determines the address and the
07037db5 Palmer Dabbelt    2017-07-10   35   * problem, and then passes it off to one of the appropriate routines.
07037db5 Palmer Dabbelt    2017-07-10   36   */
07037db5 Palmer Dabbelt    2017-07-10   37  asmlinkage void do_page_fault(struct pt_regs *regs)
07037db5 Palmer Dabbelt    2017-07-10   38  {
07037db5 Palmer Dabbelt    2017-07-10   39  	struct task_struct *tsk;
07037db5 Palmer Dabbelt    2017-07-10   40  	struct vm_area_struct *vma;
07037db5 Palmer Dabbelt    2017-07-10   41  	struct mm_struct *mm;
07037db5 Palmer Dabbelt    2017-07-10   42  	unsigned long addr, cause;
07037db5 Palmer Dabbelt    2017-07-10   43  	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
07037db5 Palmer Dabbelt    2017-07-10   44  	int fault, code = SEGV_MAPERR;
07037db5 Palmer Dabbelt    2017-07-10   45  
07037db5 Palmer Dabbelt    2017-07-10   46  	cause = regs->scause;
07037db5 Palmer Dabbelt    2017-07-10   47  	addr = regs->sbadaddr;
07037db5 Palmer Dabbelt    2017-07-10   48  
07037db5 Palmer Dabbelt    2017-07-10   49  	tsk = current;
07037db5 Palmer Dabbelt    2017-07-10   50  	mm = tsk->mm;
07037db5 Palmer Dabbelt    2017-07-10   51  
07037db5 Palmer Dabbelt    2017-07-10   52  	/*
07037db5 Palmer Dabbelt    2017-07-10   53  	 * Fault-in kernel-space virtual memory on-demand.
07037db5 Palmer Dabbelt    2017-07-10   54  	 * The 'reference' page table is init_mm.pgd.
07037db5 Palmer Dabbelt    2017-07-10   55  	 *
07037db5 Palmer Dabbelt    2017-07-10   56  	 * NOTE! We MUST NOT take any locks for this case. We may
07037db5 Palmer Dabbelt    2017-07-10   57  	 * be in an interrupt or a critical region, and should
07037db5 Palmer Dabbelt    2017-07-10   58  	 * only copy the information from the master page table,
07037db5 Palmer Dabbelt    2017-07-10   59  	 * nothing more.
07037db5 Palmer Dabbelt    2017-07-10   60  	 */
07037db5 Palmer Dabbelt    2017-07-10   61  	if (unlikely((addr >= VMALLOC_START) && (addr <= VMALLOC_END)))
07037db5 Palmer Dabbelt    2017-07-10   62  		goto vmalloc_fault;
07037db5 Palmer Dabbelt    2017-07-10   63  
07037db5 Palmer Dabbelt    2017-07-10   64  	/* Enable interrupts if they were enabled in the parent context. */
1125203c Christoph Hellwig 2018-01-04   65  	if (likely(regs->sstatus & SR_SPIE))
07037db5 Palmer Dabbelt    2017-07-10   66  		local_irq_enable();
07037db5 Palmer Dabbelt    2017-07-10   67  
07037db5 Palmer Dabbelt    2017-07-10   68  	/*
07037db5 Palmer Dabbelt    2017-07-10   69  	 * If we're in an interrupt, have no user context, or are running
07037db5 Palmer Dabbelt    2017-07-10   70  	 * in an atomic region, then we must not take the fault.
07037db5 Palmer Dabbelt    2017-07-10   71  	 */
07037db5 Palmer Dabbelt    2017-07-10   72  	if (unlikely(faulthandler_disabled() || !mm))
07037db5 Palmer Dabbelt    2017-07-10   73  		goto no_context;
07037db5 Palmer Dabbelt    2017-07-10   74  
07037db5 Palmer Dabbelt    2017-07-10   75  	if (user_mode(regs))
07037db5 Palmer Dabbelt    2017-07-10   76  		flags |= FAULT_FLAG_USER;
07037db5 Palmer Dabbelt    2017-07-10   77  
07037db5 Palmer Dabbelt    2017-07-10   78  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
07037db5 Palmer Dabbelt    2017-07-10   79  
07037db5 Palmer Dabbelt    2017-07-10   80  retry:
07037db5 Palmer Dabbelt    2017-07-10   81  	down_read(&mm->mmap_sem);
07037db5 Palmer Dabbelt    2017-07-10   82  	vma = find_vma(mm, addr);
07037db5 Palmer Dabbelt    2017-07-10   83  	if (unlikely(!vma))
07037db5 Palmer Dabbelt    2017-07-10   84  		goto bad_area;
07037db5 Palmer Dabbelt    2017-07-10   85  	if (likely(vma->vm_start <= addr))
07037db5 Palmer Dabbelt    2017-07-10   86  		goto good_area;
07037db5 Palmer Dabbelt    2017-07-10   87  	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
07037db5 Palmer Dabbelt    2017-07-10   88  		goto bad_area;
07037db5 Palmer Dabbelt    2017-07-10   89  	if (unlikely(expand_stack(vma, addr)))
07037db5 Palmer Dabbelt    2017-07-10   90  		goto bad_area;
07037db5 Palmer Dabbelt    2017-07-10   91  
07037db5 Palmer Dabbelt    2017-07-10   92  	/*
07037db5 Palmer Dabbelt    2017-07-10   93  	 * Ok, we have a good vm_area for this memory access, so
07037db5 Palmer Dabbelt    2017-07-10   94  	 * we can handle it.
07037db5 Palmer Dabbelt    2017-07-10   95  	 */
07037db5 Palmer Dabbelt    2017-07-10   96  good_area:
07037db5 Palmer Dabbelt    2017-07-10   97  	code = SEGV_ACCERR;
07037db5 Palmer Dabbelt    2017-07-10   98  
07037db5 Palmer Dabbelt    2017-07-10   99  	switch (cause) {
07037db5 Palmer Dabbelt    2017-07-10  100  	case EXC_INST_PAGE_FAULT:
07037db5 Palmer Dabbelt    2017-07-10  101  		if (!(vma->vm_flags & VM_EXEC))
07037db5 Palmer Dabbelt    2017-07-10  102  			goto bad_area;
07037db5 Palmer Dabbelt    2017-07-10  103  		break;
07037db5 Palmer Dabbelt    2017-07-10  104  	case EXC_LOAD_PAGE_FAULT:
07037db5 Palmer Dabbelt    2017-07-10  105  		if (!(vma->vm_flags & VM_READ))
07037db5 Palmer Dabbelt    2017-07-10  106  			goto bad_area;
07037db5 Palmer Dabbelt    2017-07-10  107  		break;
07037db5 Palmer Dabbelt    2017-07-10  108  	case EXC_STORE_PAGE_FAULT:
07037db5 Palmer Dabbelt    2017-07-10  109  		if (!(vma->vm_flags & VM_WRITE))
07037db5 Palmer Dabbelt    2017-07-10  110  			goto bad_area;
07037db5 Palmer Dabbelt    2017-07-10  111  		flags |= FAULT_FLAG_WRITE;
07037db5 Palmer Dabbelt    2017-07-10  112  		break;
07037db5 Palmer Dabbelt    2017-07-10  113  	default:
07037db5 Palmer Dabbelt    2017-07-10  114  		panic("%s: unhandled cause %lu", __func__, cause);
07037db5 Palmer Dabbelt    2017-07-10  115  	}
07037db5 Palmer Dabbelt    2017-07-10  116  
07037db5 Palmer Dabbelt    2017-07-10  117  	/*
07037db5 Palmer Dabbelt    2017-07-10  118  	 * If for any reason at all we could not handle the fault,
07037db5 Palmer Dabbelt    2017-07-10  119  	 * make sure we exit gracefully rather than endlessly redo
07037db5 Palmer Dabbelt    2017-07-10  120  	 * the fault.
07037db5 Palmer Dabbelt    2017-07-10  121  	 */
07037db5 Palmer Dabbelt    2017-07-10  122  	fault = handle_mm_fault(vma, addr, flags);
07037db5 Palmer Dabbelt    2017-07-10  123  
07037db5 Palmer Dabbelt    2017-07-10  124  	/*
07037db5 Palmer Dabbelt    2017-07-10  125  	 * If we need to retry but a fatal signal is pending, handle the
07037db5 Palmer Dabbelt    2017-07-10  126  	 * signal first. We do not need to release the mmap_sem because it
07037db5 Palmer Dabbelt    2017-07-10  127  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
07037db5 Palmer Dabbelt    2017-07-10  128  	 */
07037db5 Palmer Dabbelt    2017-07-10  129  	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
07037db5 Palmer Dabbelt    2017-07-10  130  		return;
07037db5 Palmer Dabbelt    2017-07-10  131  
07037db5 Palmer Dabbelt    2017-07-10  132  	if (unlikely(fault & VM_FAULT_ERROR)) {
07037db5 Palmer Dabbelt    2017-07-10  133  		if (fault & VM_FAULT_OOM)
07037db5 Palmer Dabbelt    2017-07-10  134  			goto out_of_memory;
07037db5 Palmer Dabbelt    2017-07-10  135  		else if (fault & VM_FAULT_SIGBUS)
07037db5 Palmer Dabbelt    2017-07-10  136  			goto do_sigbus;
07037db5 Palmer Dabbelt    2017-07-10  137  		BUG();
07037db5 Palmer Dabbelt    2017-07-10  138  	}
07037db5 Palmer Dabbelt    2017-07-10  139  
07037db5 Palmer Dabbelt    2017-07-10  140  	/*
07037db5 Palmer Dabbelt    2017-07-10  141  	 * Major/minor page fault accounting is only done on the
07037db5 Palmer Dabbelt    2017-07-10  142  	 * initial attempt. If we go through a retry, it is extremely
07037db5 Palmer Dabbelt    2017-07-10  143  	 * likely that the page will be found in page cache at that point.
07037db5 Palmer Dabbelt    2017-07-10  144  	 */
07037db5 Palmer Dabbelt    2017-07-10  145  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
07037db5 Palmer Dabbelt    2017-07-10  146  		if (fault & VM_FAULT_MAJOR) {
07037db5 Palmer Dabbelt    2017-07-10  147  			tsk->maj_flt++;
07037db5 Palmer Dabbelt    2017-07-10  148  			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
07037db5 Palmer Dabbelt    2017-07-10  149  				      1, regs, addr);
07037db5 Palmer Dabbelt    2017-07-10  150  		} else {
07037db5 Palmer Dabbelt    2017-07-10  151  			tsk->min_flt++;
07037db5 Palmer Dabbelt    2017-07-10  152  			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
07037db5 Palmer Dabbelt    2017-07-10  153  				      1, regs, addr);
07037db5 Palmer Dabbelt    2017-07-10  154  		}
07037db5 Palmer Dabbelt    2017-07-10  155  		if (fault & VM_FAULT_RETRY) {
07037db5 Palmer Dabbelt    2017-07-10  156  			/*
07037db5 Palmer Dabbelt    2017-07-10  157  			 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
07037db5 Palmer Dabbelt    2017-07-10  158  			 * of starvation.
07037db5 Palmer Dabbelt    2017-07-10  159  			 */
07037db5 Palmer Dabbelt    2017-07-10  160  			flags &= ~(FAULT_FLAG_ALLOW_RETRY);
07037db5 Palmer Dabbelt    2017-07-10  161  			flags |= FAULT_FLAG_TRIED;
07037db5 Palmer Dabbelt    2017-07-10  162  
07037db5 Palmer Dabbelt    2017-07-10  163  			/*
07037db5 Palmer Dabbelt    2017-07-10  164  			 * No need to up_read(&mm->mmap_sem) as we would
07037db5 Palmer Dabbelt    2017-07-10  165  			 * have already released it in __lock_page_or_retry
07037db5 Palmer Dabbelt    2017-07-10  166  			 * in mm/filemap.c.
07037db5 Palmer Dabbelt    2017-07-10  167  			 */
07037db5 Palmer Dabbelt    2017-07-10  168  			goto retry;
07037db5 Palmer Dabbelt    2017-07-10  169  		}
07037db5 Palmer Dabbelt    2017-07-10  170  	}
07037db5 Palmer Dabbelt    2017-07-10  171  
07037db5 Palmer Dabbelt    2017-07-10  172  	up_read(&mm->mmap_sem);
07037db5 Palmer Dabbelt    2017-07-10  173  	return;
07037db5 Palmer Dabbelt    2017-07-10  174  
07037db5 Palmer Dabbelt    2017-07-10  175  	/*
07037db5 Palmer Dabbelt    2017-07-10  176  	 * Something tried to access memory that isn't in our memory map.
07037db5 Palmer Dabbelt    2017-07-10  177  	 * Fix it, but check if it's kernel or user first.
07037db5 Palmer Dabbelt    2017-07-10  178  	 */
07037db5 Palmer Dabbelt    2017-07-10  179  bad_area:
07037db5 Palmer Dabbelt    2017-07-10  180  	up_read(&mm->mmap_sem);
07037db5 Palmer Dabbelt    2017-07-10  181  	/* User mode accesses just cause a SIGSEGV */
07037db5 Palmer Dabbelt    2017-07-10  182  	if (user_mode(regs)) {
07037db5 Palmer Dabbelt    2017-07-10  183  		do_trap(regs, SIGSEGV, code, addr, tsk);
07037db5 Palmer Dabbelt    2017-07-10  184  		return;
07037db5 Palmer Dabbelt    2017-07-10  185  	}
07037db5 Palmer Dabbelt    2017-07-10  186  
07037db5 Palmer Dabbelt    2017-07-10  187  no_context:
07037db5 Palmer Dabbelt    2017-07-10  188  	/* Are we prepared to handle this kernel fault? */
07037db5 Palmer Dabbelt    2017-07-10  189  	if (fixup_exception(regs))
07037db5 Palmer Dabbelt    2017-07-10  190  		return;
07037db5 Palmer Dabbelt    2017-07-10  191  
07037db5 Palmer Dabbelt    2017-07-10  192  	/*
07037db5 Palmer Dabbelt    2017-07-10  193  	 * Oops. The kernel tried to access some bad page. We'll have to
07037db5 Palmer Dabbelt    2017-07-10  194  	 * terminate things with extreme prejudice.
07037db5 Palmer Dabbelt    2017-07-10  195  	 */
07037db5 Palmer Dabbelt    2017-07-10  196  	bust_spinlocks(1);
07037db5 Palmer Dabbelt    2017-07-10 @197  	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n",

:::::: The code at line 197 was first introduced by commit
:::::: 07037db5d479f90377c998259a4f9a469c404edf RISC-V: Paging and MMU

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--bg08WKrSYDhXBjb5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
gpWeboiR6fg66P8myO/dEAwBAA==

--bg08WKrSYDhXBjb5--
