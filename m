Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeFEFom (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:44:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:20075 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751538AbeFEFol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:44:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,477,1520924400";
   d="gz'50?scan'50,208,50";a="61847096"
Date: Tue, 5 Jun 2018 13:36:26 +0800
From: kbuild test robot <lkp@intel.com>
To: Nadav Amit <namit@vmware.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 4/9] x86: alternatives: macrofy locks for better
 inlining
Message-ID: <201806051354.qBopbQOy%fengguang.wu@intel.com>
References: <20180604112131.59100-5-namit@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
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


--gBBFr7Ir9EOA20Yy
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
config: um-i386_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=i386

All errors (new ones prefixed by >>):

   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:220: Error: no such instruction: `lock_prefix btsl $0,once.63562'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 16(%esi)'
--
   arch/x86/include/asm/atomic.h: Assembler messages:
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl contig_page_data+500(%edx)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl vm_zone_stat+32'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:267: Error: no such instruction: `lock_prefix btrl $8,4(%eax)'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $2,4(%eax)'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,64(%eax)'
>> arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,64(%eax)'
>> arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,64(%edx)'
>> arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,64(%edx)'
   arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,64(%eax)'
>> arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,64(%eax)'
--
   arch/x86/include/asm/atomic.h: Assembler messages:
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 8(%esi)'
   arch/x86/include/asm/atomic.h:108: Error: no such instruction: `lock_prefix decl 8(%esi)'
--
   arch/x86/include/asm/atomic.h: Assembler messages:
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl host_sleep_count'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl host_sleep_count'
--
   arch/x86/include/asm/atomic.h: Assembler messages:
>> arch/x86/include/asm/atomic.h:55: Error: no such instruction: `lock_prefix addl %edx,contig_page_data+504(%eax)'
>> arch/x86/include/asm/atomic.h:55: Error: no such instruction: `lock_prefix addl %edx,vm_zone_stat+36'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 36(%eax)'
>> arch/x86/include/asm/atomic.h:197: Error: no such instruction: `lock_prefix cmpxchgl %ecx,28(%edx)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 40(%eax)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl (%esi)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 36(%eax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 28(%eax)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 36(%ebx)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 40(%ebx)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl -444(%ebx)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl (%ebx)'
   arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-5,4(%eax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl (%eax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl (%eax)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 36(%eax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 28(%eax)'
>> arch/x86/include/asm/atomic.h:108: Error: no such instruction: `lock_prefix decl 184(%ecx)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 12(%edi)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl (%esi)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 4(%esi)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 8(%esi)'
   arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-2,4(%eax)'
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,404(%ebx)'
   arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $2,5(%eax)'
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $2,4(%eax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 4(%eax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 4(%eax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl (%eax)'
   arch/x86/include/asm/atomic.h:108: Error: no such instruction: `lock_prefix decl 4(%eax)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 8(%esi)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 8(%esi)'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:81: Error: no such instruction: `lock_prefix btsl %eax,tainted_mask'
>> arch/x86/include/asm/atomic.h:191: Error: no such instruction: `lock_prefix cmpxchgl %edx,panic_cpu'
>> arch/x86/include/asm/atomic.h:191: Error: no such instruction: `lock_prefix cmpxchgl %edx,panic_cpu'
--
   arch/x86/include/asm/bitops.h: Assembler messages:
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,__cpu_online_mask'
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,__cpu_active_mask'
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,__cpu_present_mask'
>> arch/x86/include/asm/bitops.h:76: Error: no such instruction: `lock_prefix orb $1,__cpu_possible_mask'
--
   arch/x86/include/asm/atomic.h: Assembler messages:
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl -888(%eax)'
>> arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl (%edi)'
>> arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 40(%ebx)'
   arch/x86/include/asm/atomic.h:108: Error: no such instruction: `lock_prefix decl 4(%eax)'
   arch/x86/include/asm/bitops.h:114: Error: no such instruction: `lock_prefix andb $-3,4(%eax)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 4(%eax)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 16(%eax)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 8(%edi)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 8(%edi)'
>> include/asm-generic/atomic-instrumented.h:362: Error: no such instruction: `lock_prefix cmpxchgl %ecx,372(%edi)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 8(%edi)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 8(%edi)'
   arch/x86/include/asm/atomic.h:96: Error: no such instruction: `lock_prefix incl 8(%edi)'
   arch/x86/include/asm/atomic.h:122: Error: no such instruction: `lock_prefix decl 8(%edi)'
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
3c52b5c64 arch/x86/include/asm/bitops.h Uros Bizjak          2017-09-06  146  	asm volatile(LOCK_PREFIX "andb %2,%1"
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

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
QYbsEH6Qfu7ZXH2Zx+Nl8+zA/ycd9IS/cQAA

--gBBFr7Ir9EOA20Yy--
