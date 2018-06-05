Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeFEFrr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:47:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:54943 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeFEFrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:47:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,477,1520924400";
   d="gz'50?scan'50,208,50";a="47344990"
Date: Tue, 5 Jun 2018 22:07:53 +0800
From: kbuild test robot <lkp@intel.com>
To: Nadav Amit <namit@vmware.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 4/9] x86: alternatives: macrofy locks for better
 inlining
Message-ID: <201806052251.9Yk7coy8%fengguang.wu@intel.com>
References: <20180604112131.59100-5-namit@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180604112131.59100-5-namit@vmware.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Nadav,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17 next-20180604]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nadav-Amit/x86-macrofying-inline-asm-for-better-compilation/20180605-124313
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

All errors (new ones prefixed by >>):

   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:220: Error: no such instruction: `lock_prefix btsq $0,(%rax)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 28(%r12)'
--
   arch/x86/include/asm/atomic64_64.h: Assembler messages:
>> arch/x86/include/asm/atomic64_64.h:87: Error: no such instruction: `lock_prefix incq 1000(%rcx,%rdx)'
>> arch/x86/include/asm/atomic64_64.h:87: Error: no such instruction: `lock_prefix incq 64(%rdx)'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:267: Error: no such instruction: `lock_prefix btrq $8,8(%rax)'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $2,8(%rax)'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,120(%rax)'
>> arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,120(%rax)'
>> arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,120(%rdx)'
>> arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,120(%rdx)'
   arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,120(%rax)'
>> arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,120(%rax)'
--
   arch/x86/include/asm/atomic.h: Assembler messages:
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 16(%r12)'
   arch/x86/include/asm/atomic.h:108: Error: no such instruction: `lock_prefix decl 16(%r12)'
--
   arch/x86/include/asm/atomic.h: Assembler messages:
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl (%rdx)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl (%rdx)'
--
   arch/x86/include/asm/atomic64_64.h: Assembler messages:
>> arch/x86/include/asm/atomic64_64.h:46: Error: no such instruction: `lock_prefix addq %rsi,1008(%rdx,%rax)'
>> arch/x86/include/asm/atomic64_64.h:46: Error: no such instruction: `lock_prefix addq %rsi,72(%rax)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 72(%rax)'
>> arch/x86/include/asm/atomic64_64.h:183: Error: no such instruction: `lock_prefix cmpxchgq %rcx,56(%rdx)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 76(%rdi)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl (%r12)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 72(%rdi)'
>> arch/x86/include/asm/atomic64_64.h:87: Error: no such instruction: `lock_prefix incq 56(%rsi)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 72(%rdi)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 76(%rbx)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl -868(%rbx)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl (%rdi)'
   arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-5,8(%rax)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl (%rdi)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl (%rax)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 72(%rbx)'
>> arch/x86/include/asm/atomic64_64.h:87: Error: no such instruction: `lock_prefix incq 56(%rax)'
>> arch/x86/include/asm/atomic.h:108: Error: no such instruction: `lock_prefix decl 296(%rcx)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 24(%rdx)'
>> arch/x86/include/asm/atomic64_64.h:87: Error: no such instruction: `lock_prefix incq (%rbx)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 8(%rbx)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 12(%rbx)'
   arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,8(%rax)'
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,600(%r15)'
   arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $2,9(%rax)'
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $2,8(%rax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 4(%rax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 4(%rax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl (%rax)'
>> arch/x86/include/asm/atomic.h:108: Error: no such instruction: `lock_prefix decl 4(%rax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 16(%rbx)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 16(%rbx)'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:81: Error: no such instruction: `lock_prefix btsq %rbx,(%rax)'
>> arch/x86/include/asm/atomic.h:191: Error: no such instruction: `lock_prefix cmpxchgl %ecx,(%rdx)'
>> arch/x86/include/asm/atomic.h:191: Error: no such instruction: `lock_prefix cmpxchgl %ecx,(%rdx)'
--
   arch/x86/include/asm/atomic.h: Assembler messages:
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl -1408(%rdi)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl (%r15)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 76(%rbx)'
>> arch/x86/include/asm/atomic.h:108: Error: no such instruction: `lock_prefix decl 4(%rax)'
>> arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-3,8(%rcx)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 4(%rax)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 28(%rdi)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 16(%r14)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 16(%r14)'
>> include/asm-generic/atomic-instrumented.h:362: Error: no such instruction: `lock_prefix cmpxchgl %r8d,560(%r14)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 16(%r14)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 16(%r14)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 16(%r14)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 16(%r14)'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:220: Error: no such instruction: `lock_prefix btsq $0,8(%rbx)'
   arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,(%rax)'
>> arch/x86/include/asm/bitops.h:220: Error: no such instruction: `lock_prefix btsq $0,72(%rdi)'
>> arch/x86/include/asm/bitops.h:267: Error: no such instruction: `lock_prefix btrq $0,8(%r15)'
..

vim +220 arch/x86/include/asm/bitops.h

1a750e0cd include/asm-x86/bitops.h      Linus Torvalds       2008-06-18   56  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   57  /**
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   58   * set_bit - Atomically set a bit in memory
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   59   * @nr: the bit to set
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   60   * @addr: the address to start counting from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   61   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   62   * This function is atomic and may not be reordered.  See __set_bit()
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   63   * if you do not require the atomic guarantees.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   64   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   65   * Note: there are no guarantees that this function will not be reordered
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   66   * on non x86 architectures, so if you are writing portable code,
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   67   * make sure not to rely on its reordering guarantees.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   68   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   69   * Note that @nr may be almost arbitrarily large; this function is not
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   70   * restricted to acting on a single-word quantity.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   71   */
c8399943b arch/x86/include/asm/bitops.h Andi Kleen           2009-01-12   72  static __always_inline void
9b710506a arch/x86/include/asm/bitops.h H. Peter Anvin       2013-07-16   73  set_bit(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   74  {
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20   75  	if (IS_IMMEDIATE(nr)) {
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20  @76  		asm volatile(LOCK_PREFIX "orb %1,%0"
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20   77  			: CONST_MASK_ADDR(nr, addr)
437a0a54e include/asm-x86/bitops.h      Ingo Molnar          2008-06-20   78  			: "iq" ((u8)CONST_MASK(nr))
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20   79  			: "memory");
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20   80  	} else {
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26  @81  		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20   82  			: BITOP_ADDR(addr) : "Ir" (nr) : "memory");
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20   83  	}
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   84  }
1a750e0cd include/asm-x86/bitops.h      Linus Torvalds       2008-06-18   85  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   86  /**
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   87   * __set_bit - Set a bit in memory
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   88   * @nr: the bit to set
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   89   * @addr: the address to start counting from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   90   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   91   * Unlike set_bit(), this function is non-atomic and may be reordered.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   92   * If it's called on the same region of memory simultaneously, the effect
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   93   * may be that only one operation succeeds.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   94   */
8dd5032d9 arch/x86/include/asm/bitops.h Denys Vlasenko       2016-02-07   95  static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   96  {
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26   97  	asm volatile(__ASM_SIZE(bts) " %1,%0" : ADDR : "Ir" (nr) : "memory");
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   98  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30   99  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  100  /**
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  101   * clear_bit - Clears a bit in memory
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  102   * @nr: Bit to clear
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  103   * @addr: Address to start counting from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  104   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  105   * clear_bit() is atomic and may not be reordered.  However, it does
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  106   * not contain a memory barrier, so if it is used for locking purposes,
d00a56928 arch/x86/include/asm/bitops.h Peter Zijlstra       2014-03-13  107   * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  108   * in order to ensure changes are visible on other processors.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  109   */
c8399943b arch/x86/include/asm/bitops.h Andi Kleen           2009-01-12  110  static __always_inline void
9b710506a arch/x86/include/asm/bitops.h H. Peter Anvin       2013-07-16  111  clear_bit(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  112  {
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20  113  	if (IS_IMMEDIATE(nr)) {
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20 @114  		asm volatile(LOCK_PREFIX "andb %1,%0"
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20  115  			: CONST_MASK_ADDR(nr, addr)
437a0a54e include/asm-x86/bitops.h      Ingo Molnar          2008-06-20  116  			: "iq" ((u8)~CONST_MASK(nr)));
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20  117  	} else {
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26 @118  		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20  119  			: BITOP_ADDR(addr)
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20  120  			: "Ir" (nr));
7dbceaf9b include/asm-x86/bitops.h      Ingo Molnar          2008-06-20  121  	}
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  122  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  123  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  124  /*
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  125   * clear_bit_unlock - Clears a bit in memory
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  126   * @nr: Bit to clear
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  127   * @addr: Address to start counting from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  128   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  129   * clear_bit() is atomic and implies release semantics before the memory
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  130   * operation. It can be used for an unlock.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  131   */
8dd5032d9 arch/x86/include/asm/bitops.h Denys Vlasenko       2016-02-07  132  static __always_inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  133  {
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  134  	barrier();
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  135  	clear_bit(nr, addr);
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  136  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  137  
8dd5032d9 arch/x86/include/asm/bitops.h Denys Vlasenko       2016-02-07  138  static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  139  {
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26  140  	asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr));
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  141  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  142  
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  143  static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  144  {
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  145  	bool negative;
3c52b5c64 arch/x86/include/asm/bitops.h Uros Bizjak          2017-09-06 @146  	asm volatile(LOCK_PREFIX "andb %2,%1"
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  147  		CC_SET(s)
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  148  		: CC_OUT(s) (negative), ADDR
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  149  		: "ir" ((char) ~(1 << nr)) : "memory");
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  150  	return negative;
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  151  }
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  152  
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  153  // Let everybody know we have it
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  154  #define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
b91e1302a arch/x86/include/asm/bitops.h Linus Torvalds       2016-12-27  155  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  156  /*
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  157   * __clear_bit_unlock - Clears a bit in memory
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  158   * @nr: Bit to clear
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  159   * @addr: Address to start counting from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  160   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  161   * __clear_bit() is non-atomic and implies release semantics before the memory
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  162   * operation. It can be used for an unlock if no other CPUs can concurrently
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  163   * modify other bits in the word.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  164   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  165   * No memory barrier is required here, because x86 cannot reorder stores past
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  166   * older loads. Same principle as spin_unlock.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  167   */
8dd5032d9 arch/x86/include/asm/bitops.h Denys Vlasenko       2016-02-07  168  static __always_inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  169  {
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  170  	barrier();
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  171  	__clear_bit(nr, addr);
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  172  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  173  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  174  /**
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  175   * __change_bit - Toggle a bit in memory
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  176   * @nr: the bit to change
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  177   * @addr: the address to start counting from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  178   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  179   * Unlike change_bit(), this function is non-atomic and may be reordered.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  180   * If it's called on the same region of memory simultaneously, the effect
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  181   * may be that only one operation succeeds.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  182   */
8dd5032d9 arch/x86/include/asm/bitops.h Denys Vlasenko       2016-02-07  183  static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  184  {
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26  185  	asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr));
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  186  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  187  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  188  /**
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  189   * change_bit - Toggle a bit in memory
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  190   * @nr: Bit to change
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  191   * @addr: Address to start counting from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  192   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  193   * change_bit() is atomic and may not be reordered.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  194   * Note that @nr may be almost arbitrarily large; this function is not
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  195   * restricted to acting on a single-word quantity.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  196   */
8dd5032d9 arch/x86/include/asm/bitops.h Denys Vlasenko       2016-02-07  197  static __always_inline void change_bit(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  198  {
838e8bb71 arch/x86/include/asm/bitops.h Uros Bizjak          2008-10-24  199  	if (IS_IMMEDIATE(nr)) {
838e8bb71 arch/x86/include/asm/bitops.h Uros Bizjak          2008-10-24  200  		asm volatile(LOCK_PREFIX "xorb %1,%0"
838e8bb71 arch/x86/include/asm/bitops.h Uros Bizjak          2008-10-24  201  			: CONST_MASK_ADDR(nr, addr)
838e8bb71 arch/x86/include/asm/bitops.h Uros Bizjak          2008-10-24  202  			: "iq" ((u8)CONST_MASK(nr)));
838e8bb71 arch/x86/include/asm/bitops.h Uros Bizjak          2008-10-24  203  	} else {
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26  204  		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
838e8bb71 arch/x86/include/asm/bitops.h Uros Bizjak          2008-10-24  205  			: BITOP_ADDR(addr)
838e8bb71 arch/x86/include/asm/bitops.h Uros Bizjak          2008-10-24  206  			: "Ir" (nr));
838e8bb71 arch/x86/include/asm/bitops.h Uros Bizjak          2008-10-24  207  	}
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  208  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  209  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  210  /**
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  211   * test_and_set_bit - Set a bit and return its old value
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  212   * @nr: Bit to set
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  213   * @addr: Address to count from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  214   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  215   * This operation is atomic and cannot be reordered.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  216   * It also implies a memory barrier.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  217   */
117780eef arch/x86/include/asm/bitops.h H. Peter Anvin       2016-06-08  218  static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  219  {
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26 @220  	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts),
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26  221  	                 *addr, "Ir", nr, "%0", c);
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  222  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  223  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  224  /**
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  225   * test_and_set_bit_lock - Set a bit and return its old value for lock
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  226   * @nr: Bit to set
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  227   * @addr: Address to count from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  228   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  229   * This is the same as test_and_set_bit on x86.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  230   */
117780eef arch/x86/include/asm/bitops.h H. Peter Anvin       2016-06-08  231  static __always_inline bool
9b710506a arch/x86/include/asm/bitops.h H. Peter Anvin       2013-07-16  232  test_and_set_bit_lock(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  233  {
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  234  	return test_and_set_bit(nr, addr);
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  235  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  236  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  237  /**
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  238   * __test_and_set_bit - Set a bit and return its old value
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  239   * @nr: Bit to set
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  240   * @addr: Address to count from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  241   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  242   * This operation is non-atomic and can be reordered.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  243   * If two examples of this operation race, one can appear to succeed
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  244   * but actually fail.  You must protect multiple accesses with a lock.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  245   */
117780eef arch/x86/include/asm/bitops.h H. Peter Anvin       2016-06-08  246  static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  247  {
117780eef arch/x86/include/asm/bitops.h H. Peter Anvin       2016-06-08  248  	bool oldbit;
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  249  
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26  250  	asm(__ASM_SIZE(bts) " %2,%1"
86b61240d arch/x86/include/asm/bitops.h H. Peter Anvin       2016-06-08  251  	    CC_SET(c)
86b61240d arch/x86/include/asm/bitops.h H. Peter Anvin       2016-06-08  252  	    : CC_OUT(c) (oldbit), ADDR
eb2b4e682 include/asm-x86/bitops.h      Simon Holm Thøgersen 2008-05-05  253  	    : "Ir" (nr));
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  254  	return oldbit;
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  255  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  256  
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  257  /**
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  258   * test_and_clear_bit - Clear a bit and return its old value
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  259   * @nr: Bit to clear
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  260   * @addr: Address to count from
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  261   *
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  262   * This operation is atomic and cannot be reordered.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  263   * It also implies a memory barrier.
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  264   */
117780eef arch/x86/include/asm/bitops.h H. Peter Anvin       2016-06-08  265  static __always_inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  266  {
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26 @267  	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btr),
22636f8c9 arch/x86/include/asm/bitops.h Jan Beulich          2018-02-26  268  	                 *addr, "Ir", nr, "%0", c);
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  269  }
1c54d7707 include/asm-x86/bitops.h      Jeremy Fitzhardinge  2008-01-30  270  

:::::: The code at line 220 was first introduced by commit
:::::: 22636f8c9511245cb3c8412039f1dd95afb3aa59 x86/asm: Add instruction suffixes to bitops

:::::: TO: Jan Beulich <JBeulich@suse.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--a8Wt8u1KmwUX3Y2C
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zANXzK8KdPLYvi/gfxZfkAfGbgAA

--a8Wt8u1KmwUX3Y2C--
