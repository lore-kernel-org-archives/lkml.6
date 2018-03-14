Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-620268-1520999442-3-9359112395090509224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520999441; b=fob7HrwES+5hTvH3LamCVonKL0XQp8Qe80ekwtRUhHAPyDj
    oEbm7cBMp/9Fbm34LTIAP1tb05YdX/Z3mg7nNb4b6ESRhVp9MDj8/xbYdLvyJnZB
    J986Wkc9zYrLlrjbheZ7rYWO+8Nr5pB+CWMwRkdD4XPV3TI0lNHFS+YCZbA7W/B4
    Dwz2ZrCboTtAXYVPMBoW+9X4JnLLnRiitoEPDiY9qS2gkfIdh061VBF6RSNwANZb
    nuzxGybNWZcLUkQFSKEfP0k2Ap9PtnZXJ+28LadWTaZL4dM4Srq0zZBQ+OLB1uwv
    Q2iTtPKfu1MlaxaefcEfmY/BSvrtA2vqvyPq3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520999441; bh=W
    Pxqa34jObrbj2awXX0gz6VqRd3GXdhtBEs0O+fg2Ag=; b=bdUcuC01+Yn2cR7FJ
    rWSgzovmsm7AHo2pz92MtI1HLbHGF/b9DfpX8oMSg50j5gh5C9eKiYb9oqepkAYL
    STNn6ENld+0a8sA/a4h+IggCWW3m0RVjxbSbpXsV0sVecaaPHXtXOvH17pagDYTM
    pR/0riJyWD4K7lki1pGdqQzGNrw1t5Yrq+uYYUQvSHZxS0KMj1ZMVQg6aP6kwp9P
    BshId0sVZqpLMzh/PjkDFw0XUesqvTHnF3cVQ4/calogHQydlp3+0HznKEOqbdUA
    3KpMAlftCjkNxMummLNaXxeBhGVuIK4th7ZfjPsJA2iW2USqVebRTenHupzrNRzU
    1+oJg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TEe9ZxQp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ApY2WHnI;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TEe9ZxQp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ApY2WHnI;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtg9hbQcTHkof7QB2e4EfQ2Gepf+5Sudoc7FGMsUJrFTCKEOxYqR7vVxUNTda3fQCMxn6rdfq3AhkDQLfRgE8k=
MIME-Version: 1.0
In-Reply-To: <201803132313.a4R8Y434%fengguang.wu@intel.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
 <201803132313.a4R8Y434%fengguang.wu@intel.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 13 Mar 2018 20:50:31 -0700
Message-ID: <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v4 02/10] include: Move compat_timespec/ timeval
 to compat_time.h
To: kbuild test robot <lkp@intel.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Will Deacon <will.deacon@arm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 oprofile-list@lists.sf.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Julian Wiedmann <jwi@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ursula Braun <ubraun@linux.vnet.ibm.com>, gerald.schaefer@de.ibm.com,
 Parisc List <linux-parisc@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, cohuck@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
 kbuild-all@01.org, Stefan Haberland <sth@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The file arch/arm64/kernel/process.c needs asm/compat.h also to be
included directly since this is included conditionally from
include/compat.h. This does seem to be typical of arm64 as I was not
completely able to get rid of asm/compat.h includes for arm64 in this
series. My plan is to have separate patches to get rid of asm/compat.h
includes for the architectures that are not straight forward to keep
this series simple.
I will fix this and update the series.

-Deepa


On Tue, Mar 13, 2018 at 8:22 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Deepa,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on ]
>
> url:    https://github.com/0day-ci/linux/commits/Deepa-Dinamani/posix_clocks-Prepare-syscalls-for-64-bit-time_t-conversion/20180313-203305
> base:
> config: arm64-allnoconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):
>
>    arch/arm64/kernel/process.c: In function 'copy_thread':
>>> arch/arm64/kernel/process.c:342:8: error: implicit declaration of function 'is_compat_thread'; did you mean 'is_compat_task'? [-Werror=implicit-function-declaration]
>        if (is_compat_thread(task_thread_info(p)))
>            ^~~~~~~~~~~~~~~~
>            is_compat_task
>    cc1: some warnings being treated as errors
>
> vim +342 arch/arm64/kernel/process.c
>
> b3901d54d Catalin Marinas  2012-03-05  307
> b3901d54d Catalin Marinas  2012-03-05  308  int copy_thread(unsigned long clone_flags, unsigned long stack_start,
> afa86fc42 Al Viro          2012-10-22  309              unsigned long stk_sz, struct task_struct *p)
> b3901d54d Catalin Marinas  2012-03-05  310  {
> b3901d54d Catalin Marinas  2012-03-05  311      struct pt_regs *childregs = task_pt_regs(p);
> b3901d54d Catalin Marinas  2012-03-05  312
> c34501d21 Catalin Marinas  2012-10-05  313      memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
> c34501d21 Catalin Marinas  2012-10-05  314
> bc0ee4760 Dave Martin      2017-10-31  315      /*
> bc0ee4760 Dave Martin      2017-10-31  316       * Unalias p->thread.sve_state (if any) from the parent task
> bc0ee4760 Dave Martin      2017-10-31  317       * and disable discard SVE state for p:
> bc0ee4760 Dave Martin      2017-10-31  318       */
> bc0ee4760 Dave Martin      2017-10-31  319      clear_tsk_thread_flag(p, TIF_SVE);
> bc0ee4760 Dave Martin      2017-10-31  320      p->thread.sve_state = NULL;
> bc0ee4760 Dave Martin      2017-10-31  321
> 071b6d4a5 Dave Martin      2017-12-05  322      /*
> 071b6d4a5 Dave Martin      2017-12-05  323       * In case p was allocated the same task_struct pointer as some
> 071b6d4a5 Dave Martin      2017-12-05  324       * other recently-exited task, make sure p is disassociated from
> 071b6d4a5 Dave Martin      2017-12-05  325       * any cpu that may have run that now-exited task recently.
> 071b6d4a5 Dave Martin      2017-12-05  326       * Otherwise we could erroneously skip reloading the FPSIMD
> 071b6d4a5 Dave Martin      2017-12-05  327       * registers for p.
> 071b6d4a5 Dave Martin      2017-12-05  328       */
> 071b6d4a5 Dave Martin      2017-12-05  329      fpsimd_flush_task_state(p);
> 071b6d4a5 Dave Martin      2017-12-05  330
> 9ac080021 Al Viro          2012-10-21  331      if (likely(!(p->flags & PF_KTHREAD))) {
> 9ac080021 Al Viro          2012-10-21  332              *childregs = *current_pt_regs();
> b3901d54d Catalin Marinas  2012-03-05  333              childregs->regs[0] = 0;
> d00a3810c Will Deacon      2015-05-27  334
> b3901d54d Catalin Marinas  2012-03-05  335              /*
> b3901d54d Catalin Marinas  2012-03-05  336               * Read the current TLS pointer from tpidr_el0 as it may be
> b3901d54d Catalin Marinas  2012-03-05  337               * out-of-sync with the saved value.
> b3901d54d Catalin Marinas  2012-03-05  338               */
> adf758999 Mark Rutland     2016-09-08  339              *task_user_tls(p) = read_sysreg(tpidr_el0);
> d00a3810c Will Deacon      2015-05-27  340
> e0fd18ce1 Al Viro          2012-10-18  341              if (stack_start) {
> d00a3810c Will Deacon      2015-05-27 @342                      if (is_compat_thread(task_thread_info(p)))
> d00a3810c Will Deacon      2015-05-27  343                              childregs->compat_sp = stack_start;
> d00a3810c Will Deacon      2015-05-27  344                      else
> b3901d54d Catalin Marinas  2012-03-05  345                              childregs->sp = stack_start;
> b3901d54d Catalin Marinas  2012-03-05  346              }
> d00a3810c Will Deacon      2015-05-27  347
> c34501d21 Catalin Marinas  2012-10-05  348              /*
> c34501d21 Catalin Marinas  2012-10-05  349               * If a TLS pointer was passed to clone (4th argument), use it
> c34501d21 Catalin Marinas  2012-10-05  350               * for the new thread.
> c34501d21 Catalin Marinas  2012-10-05  351               */
> b3901d54d Catalin Marinas  2012-03-05  352              if (clone_flags & CLONE_SETTLS)
> d00a3810c Will Deacon      2015-05-27  353                      p->thread.tp_value = childregs->regs[3];
> c34501d21 Catalin Marinas  2012-10-05  354      } else {
> c34501d21 Catalin Marinas  2012-10-05  355              memset(childregs, 0, sizeof(struct pt_regs));
> c34501d21 Catalin Marinas  2012-10-05  356              childregs->pstate = PSR_MODE_EL1h;
> 57f4959ba James Morse      2016-02-05  357              if (IS_ENABLED(CONFIG_ARM64_UAO) &&
> a4023f682 Suzuki K Poulose 2016-11-08  358                  cpus_have_const_cap(ARM64_HAS_UAO))
> 57f4959ba James Morse      2016-02-05  359                      childregs->pstate |= PSR_UAO_BIT;
> c34501d21 Catalin Marinas  2012-10-05  360              p->thread.cpu_context.x19 = stack_start;
> c34501d21 Catalin Marinas  2012-10-05  361              p->thread.cpu_context.x20 = stk_sz;
> c34501d21 Catalin Marinas  2012-10-05  362      }
> c34501d21 Catalin Marinas  2012-10-05  363      p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
> c34501d21 Catalin Marinas  2012-10-05  364      p->thread.cpu_context.sp = (unsigned long)childregs;
> b3901d54d Catalin Marinas  2012-03-05  365
> b3901d54d Catalin Marinas  2012-03-05  366      ptrace_hw_copy_thread(p);
> b3901d54d Catalin Marinas  2012-03-05  367
> b3901d54d Catalin Marinas  2012-03-05  368      return 0;
> b3901d54d Catalin Marinas  2012-03-05  369  }
> b3901d54d Catalin Marinas  2012-03-05  370
>
> :::::: The code at line 342 was first introduced by commit
> :::::: d00a3810c16207d2541b7796a73cca5a24ea3742 arm64: context-switch user tls register tpidr_el0 for compat tasks
>
> :::::: TO: Will Deacon <will.deacon@arm.com>
> :::::: CC: Catalin Marinas <catalin.marinas@arm.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> _______________________________________________
> Y2038 mailing list
> Y2038@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/y2038
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
