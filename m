Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeCUBk3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:40:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:37074 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbeCUBk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:40:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,338,1517904000";
   d="gz'50?scan'50,208,50";a="43867013"
Date: Wed, 21 Mar 2018 09:39:20 +0800
From: kbuild test robot <lkp@intel.com>
To: NIIBE Yutaka <gniibe@fsij.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, gniibe@fsij.org
Subject: Re: [PATCH 3/4] signal/x86: Move nosig handling at the end of
 exit_to_usermode_loop.
Message-ID: <201803210929.40dSEA4q%fengguang.wu@intel.com>
References: <20180320023857.1885-4-gniibe@fsij.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180320023857.1885-4-gniibe@fsij.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi NIIBE,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.16-rc4]
[also build test ERROR on next-20180320]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/NIIBE-Yutaka/Unblocked-by-fake_signal_wake_up-then-real-signal/20180321-051147
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

All errors (new ones prefixed by >>):

   In file included from arch/um/kernel/irq.c:17:0:
>> arch/um/include/shared/kern_util.h:26:13: error: conflicting types for 'do_signal'
    extern void do_signal(struct pt_regs *regs);
                ^~~~~~~~~
   In file included from include/uapi/linux/signal.h:5:0,
                    from include/linux/signal_types.h:10,
                    from include/linux/sched.h:27,
                    from include/linux/kernel_stat.h:10,
                    from arch/um/kernel/irq.c:11:
   arch/x86/include/asm/signal.h:38:12: note: previous declaration of 'do_signal' was here
    extern int do_signal(struct pt_regs *regs);
               ^~~~~~~~~
--
   In file included from arch/um/kernel/signal.c:13:0:
>> arch/um/include/shared/kern_util.h:26:13: error: conflicting types for 'do_signal'
    extern void do_signal(struct pt_regs *regs);
                ^~~~~~~~~
   In file included from include/uapi/linux/signal.h:5:0,
                    from include/linux/signal_types.h:10,
                    from include/linux/sched.h:27,
                    from include/linux/ptrace.h:6,
                    from arch/um/kernel/signal.c:7:
   arch/x86/include/asm/signal.h:38:12: note: previous declaration of 'do_signal' was here
    extern int do_signal(struct pt_regs *regs);
               ^~~~~~~~~
>> arch/um/kernel/signal.c:67:6: error: conflicting types for 'do_signal'
    void do_signal(struct pt_regs *regs)
         ^~~~~~~~~
   In file included from include/uapi/linux/signal.h:5:0,
                    from include/linux/signal_types.h:10,
                    from include/linux/sched.h:27,
                    from include/linux/ptrace.h:6,
                    from arch/um/kernel/signal.c:7:
   arch/x86/include/asm/signal.h:38:12: note: previous declaration of 'do_signal' was here
    extern int do_signal(struct pt_regs *regs);
               ^~~~~~~~~

vim +/do_signal +26 arch/um/include/shared/kern_util.h

edea13858 arch/um/include/kern_util.h        Jeff Dike     2008-02-04  24  
ccaee5f85 arch/um/include/shared/kern_util.h Ingo Molnar   2015-07-03  25  struct pt_regs;
ccaee5f85 arch/um/include/shared/kern_util.h Ingo Molnar   2015-07-03 @26  extern void do_signal(struct pt_regs *regs);
edea13858 arch/um/include/kern_util.h        Jeff Dike     2008-02-04  27  extern void interrupt_end(void);
d3c1cfcdb arch/um/include/shared/kern_util.h Martin Pärtel 2012-08-02  28  extern void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs);
edea13858 arch/um/include/kern_util.h        Jeff Dike     2008-02-04  29  

:::::: The code at line 26 was first introduced by commit
:::::: ccaee5f851470dec6894a6835b6fadffc2bb7514 um: Fix do_signal() prototype

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4nUTO+p/WcSwOb56AAA=

--LQksG6bCIzRHxTLp--
