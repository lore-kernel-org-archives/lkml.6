Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45572C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B016520866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B016520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeIKSBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:01:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:28748 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbeIKSBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:01:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 06:02:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="gz'50?scan'50,208,50";a="90714585"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 11 Sep 2018 06:00:07 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fziH0-0007YL-LL; Tue, 11 Sep 2018 21:00:06 +0800
Date:   Tue, 11 Sep 2018 20:59:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH net-next v3 17/17] net: WireGuard secure network tunnel
Message-ID: <201809112045.A5D7cAAW%fengguang.wu@intel.com>
References: <20180911010838.8818-19-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20180911010838.8818-19-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jason,

I love your patch! Yet something to improve:

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Jason-A-Donenfeld/WireGuard-Secure-Network-Tunnel/20180911-185037
config: um-i386_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=i386

All error/warnings (new ones prefixed by >>):

   In file included from lib/zinc/chacha20/chacha20-x86_64-glue.h:8:0,
                    from <command-line>:0:
>> arch/x86/include/asm/cpufeature.h:134:34: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
    extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
                                     ^~~~~~~~~~~
   In file included from include/linux/compiler_types.h:64:0,
                    from <command-line>:0:
   arch/x86/include/asm/cpufeature.h: In function '_static_cpu_has':
>> arch/x86/include/asm/cpufeature.h:198:52: error: 'struct cpuinfo_um' has no member named 'x86_capability'
           [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
                                                       ^
   include/linux/compiler-gcc.h:182:47: note: in definition of macro 'asm_volatile_goto'
    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                                  ^
   In file included from lib/zinc/chacha20/chacha20-x86_64-glue.h:8:0,
                    from <command-line>:0:
   lib/zinc/chacha20/chacha20-x86_64-glue.h: In function 'chacha20_fpu_init':
>> arch/x86/include/asm/cpufeature.h:65:28: error: 'REQUIRED_MASK0' undeclared (first use in this function); did you mean 'DISABLED_MASK0'?
      ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/chacha20/chacha20-x86_64-glue.h:36:23: note: in expansion of macro 'boot_cpu_has'
     chacha20_use_ssse3 = boot_cpu_has(X86_FEATURE_SSSE3);
                          ^~~~~~~~~~~~
   arch/x86/include/asm/cpufeature.h:65:28: note: each undeclared identifier is reported only once for each function it appears in
      ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/chacha20/chacha20-x86_64-glue.h:36:23: note: in expansion of macro 'boot_cpu_has'
     chacha20_use_ssse3 = boot_cpu_has(X86_FEATURE_SSSE3);
                          ^~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:66:28: error: 'REQUIRED_MASK1' undeclared (first use in this function); did you mean 'REQUIRED_MASK0'?
        CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  1, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/chacha20/chacha20-x86_64-glue.h:36:23: note: in expansion of macro 'boot_cpu_has'
     chacha20_use_ssse3 = boot_cpu_has(X86_FEATURE_SSSE3);
                          ^~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:67:28: error: 'REQUIRED_MASK2' undeclared (first use in this function); did you mean 'REQUIRED_MASK1'?
        CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  2, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/chacha20/chacha20-x86_64-glue.h:36:23: note: in expansion of macro 'boot_cpu_has'
     chacha20_use_ssse3 = boot_cpu_has(X86_FEATURE_SSSE3);
                          ^~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:68:28: error: 'REQUIRED_MASK3' undeclared (first use in this function); did you mean 'REQUIRED_MASK2'?
        CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  3, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
--
   In file included from lib/zinc/poly1305/poly1305-x86_64-glue.h:7:0,
                    from <command-line>:0:
>> arch/x86/include/asm/cpufeature.h:134:34: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
    extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
                                     ^~~~~~~~~~~
   In file included from include/linux/compiler_types.h:64:0,
                    from <command-line>:0:
   arch/x86/include/asm/cpufeature.h: In function '_static_cpu_has':
>> arch/x86/include/asm/cpufeature.h:198:52: error: 'struct cpuinfo_um' has no member named 'x86_capability'
           [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
                                                       ^
   include/linux/compiler-gcc.h:182:47: note: in definition of macro 'asm_volatile_goto'
    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                                  ^
   In file included from lib/zinc/poly1305/poly1305-x86_64-glue.h:7:0,
                    from <command-line>:0:
   lib/zinc/poly1305/poly1305-x86_64-glue.h: In function 'poly1305_fpu_init':
>> arch/x86/include/asm/cpufeature.h:65:28: error: 'REQUIRED_MASK0' undeclared (first use in this function); did you mean 'DISABLED_MASK0'?
      ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/poly1305/poly1305-x86_64-glue.h:39:3: note: in expansion of macro 'boot_cpu_has'
      boot_cpu_has(X86_FEATURE_AVX) &&
      ^~~~~~~~~~~~
   arch/x86/include/asm/cpufeature.h:65:28: note: each undeclared identifier is reported only once for each function it appears in
      ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/poly1305/poly1305-x86_64-glue.h:39:3: note: in expansion of macro 'boot_cpu_has'
      boot_cpu_has(X86_FEATURE_AVX) &&
      ^~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:66:28: error: 'REQUIRED_MASK1' undeclared (first use in this function); did you mean 'REQUIRED_MASK0'?
        CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  1, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/poly1305/poly1305-x86_64-glue.h:39:3: note: in expansion of macro 'boot_cpu_has'
      boot_cpu_has(X86_FEATURE_AVX) &&
      ^~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:67:28: error: 'REQUIRED_MASK2' undeclared (first use in this function); did you mean 'REQUIRED_MASK1'?
        CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  2, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/poly1305/poly1305-x86_64-glue.h:39:3: note: in expansion of macro 'boot_cpu_has'
      boot_cpu_has(X86_FEATURE_AVX) &&
      ^~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:68:28: error: 'REQUIRED_MASK3' undeclared (first use in this function); did you mean 'REQUIRED_MASK2'?
        CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  3, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
--
   lib/zinc/poly1305/poly1305-x86_64.S: Assembler messages:
>> lib/zinc/poly1305/poly1305-x86_64.S:25: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:26: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:27: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:28: Error: bad register name `%rax'
>> lib/zinc/poly1305/poly1305-x86_64.S:30: Error: bad register name `%rsi'
   lib/zinc/poly1305/poly1305-x86_64.S:33: Error: bad register name `%rax'
>> lib/zinc/poly1305/poly1305-x86_64.S:34: Error: bad register name `%rcx'
>> lib/zinc/poly1305/poly1305-x86_64.S:35: Error: bad register name `%rsi)'
   lib/zinc/poly1305/poly1305-x86_64.S:36: Error: bad register name `%rsi)'
   lib/zinc/poly1305/poly1305-x86_64.S:37: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:38: Error: bad register name `%rcx'
>> lib/zinc/poly1305/poly1305-x86_64.S:47: Error: bad register name `%rdx'
>> lib/zinc/poly1305/poly1305-x86_64.S:50: Error: bad register name `%rbx'
>> lib/zinc/poly1305/poly1305-x86_64.S:51: Error: bad register name `%r12'
>> lib/zinc/poly1305/poly1305-x86_64.S:52: Error: bad register name `%r13'
>> lib/zinc/poly1305/poly1305-x86_64.S:53: Error: bad register name `%r14'
>> lib/zinc/poly1305/poly1305-x86_64.S:54: Error: bad register name `%r15'
>> lib/zinc/poly1305/poly1305-x86_64.S:55: Error: bad register name `%rdi'
   lib/zinc/poly1305/poly1305-x86_64.S:59: Error: bad register name `%rdx'
>> lib/zinc/poly1305/poly1305-x86_64.S:61: Error: bad register name `%rdi)'
   lib/zinc/poly1305/poly1305-x86_64.S:62: Error: bad register name `%rdi)'
   lib/zinc/poly1305/poly1305-x86_64.S:64: Error: bad register name `%rdi)'
   lib/zinc/poly1305/poly1305-x86_64.S:65: Error: bad register name `%rdi)'
   lib/zinc/poly1305/poly1305-x86_64.S:66: Error: bad register name `%rdi)'
   lib/zinc/poly1305/poly1305-x86_64.S:68: Error: bad register name `%r13'
   lib/zinc/poly1305/poly1305-x86_64.S:69: Error: bad register name `%r13'
   lib/zinc/poly1305/poly1305-x86_64.S:70: Error: bad register name `%r12'
   lib/zinc/poly1305/poly1305-x86_64.S:71: Error: bad register name `%r12'
   lib/zinc/poly1305/poly1305-x86_64.S:77: Error: bad register name `%rsi)'
   lib/zinc/poly1305/poly1305-x86_64.S:78: Error: bad register name `%rsi)'
   lib/zinc/poly1305/poly1305-x86_64.S:79: Error: bad register name `%rsi)'
   lib/zinc/poly1305/poly1305-x86_64.S:80: Error: bad register name `%rcx'
   lib/zinc/poly1305/poly1305-x86_64.S:81: Error: bad register name `%r14'
   lib/zinc/poly1305/poly1305-x86_64.S:82: Error: bad register name `%rax'
>> lib/zinc/poly1305/poly1305-x86_64.S:83: Error: bad register name `%r11'
   lib/zinc/poly1305/poly1305-x86_64.S:84: Error: bad register name `%rdx'
   lib/zinc/poly1305/poly1305-x86_64.S:86: Error: bad register name `%r14'
   lib/zinc/poly1305/poly1305-x86_64.S:87: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:88: Error: bad register name `%r11'
   lib/zinc/poly1305/poly1305-x86_64.S:89: Error: bad register name `%rdx'
   lib/zinc/poly1305/poly1305-x86_64.S:91: Error: bad register name `%rbx'
   lib/zinc/poly1305/poly1305-x86_64.S:92: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:93: Error: bad register name `%r13'
   lib/zinc/poly1305/poly1305-x86_64.S:94: Error: bad register name `%rdx'
   lib/zinc/poly1305/poly1305-x86_64.S:96: Error: bad register name `%rbx'
>> lib/zinc/poly1305/poly1305-x86_64.S:97: Error: bad register name `%r10'
   lib/zinc/poly1305/poly1305-x86_64.S:98: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:99: Error: bad register name `%rdx'
   lib/zinc/poly1305/poly1305-x86_64.S:101: Error: bad register name `%r13'
   lib/zinc/poly1305/poly1305-x86_64.S:102: Error: bad register name `%rbx'
>> lib/zinc/poly1305/poly1305-x86_64.S:103: Error: bad register name `%r8'
   lib/zinc/poly1305/poly1305-x86_64.S:104: Error: bad register name `%rdi'
   lib/zinc/poly1305/poly1305-x86_64.S:106: Error: bad register name `%r11'
>> lib/zinc/poly1305/poly1305-x86_64.S:107: Error: bad register name `%r9'
   lib/zinc/poly1305/poly1305-x86_64.S:108: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:109: Error: bad register name `%r10'
   lib/zinc/poly1305/poly1305-x86_64.S:111: Error: bad register name `%rdi'
   lib/zinc/poly1305/poly1305-x86_64.S:112: Error: bad register name `%rdi'
   lib/zinc/poly1305/poly1305-x86_64.S:113: Error: bad register name `%rdi'
   lib/zinc/poly1305/poly1305-x86_64.S:114: Error: bad register name `%r10'
   lib/zinc/poly1305/poly1305-x86_64.S:115: Error: bad register name `%rdi'
   lib/zinc/poly1305/poly1305-x86_64.S:116: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:117: Error: bad register name `%rbx'
   lib/zinc/poly1305/poly1305-x86_64.S:118: Error: bad register name `%r10'
   lib/zinc/poly1305/poly1305-x86_64.S:120: Error: bad register name `%r12'
   lib/zinc/poly1305/poly1305-x86_64.S:121: Error: bad register name `%r15'
>> lib/zinc/poly1305/poly1305-x86_64.S:124: Error: bad register name `%rsp)'
   lib/zinc/poly1305/poly1305-x86_64.S:126: Error: bad register name `%r14'
   lib/zinc/poly1305/poly1305-x86_64.S:127: Error: bad register name `%rbx'
   lib/zinc/poly1305/poly1305-x86_64.S:128: Error: bad register name `%r10'
   lib/zinc/poly1305/poly1305-x86_64.S:130: Error: bad register name `%rsp)'
   lib/zinc/poly1305/poly1305-x86_64.S:131: Error: bad register name `%rsp)'
   lib/zinc/poly1305/poly1305-x86_64.S:132: Error: bad register name `%rsp)'
   lib/zinc/poly1305/poly1305-x86_64.S:133: Error: bad register name `%rsp)'
   lib/zinc/poly1305/poly1305-x86_64.S:134: Error: bad register name `%rsp)'
   lib/zinc/poly1305/poly1305-x86_64.S:135: Error: bad register name `%rsp)'
   lib/zinc/poly1305/poly1305-x86_64.S:144: Error: bad register name `%rdi)'
   lib/zinc/poly1305/poly1305-x86_64.S:145: Error: bad register name `%rdi)'
   lib/zinc/poly1305/poly1305-x86_64.S:146: Error: bad register name `%rdi)'
   lib/zinc/poly1305/poly1305-x86_64.S:148: Error: bad register name `%r8'
   lib/zinc/poly1305/poly1305-x86_64.S:149: Error: bad register name `%r8'
   lib/zinc/poly1305/poly1305-x86_64.S:150: Error: bad register name `%r9'
   lib/zinc/poly1305/poly1305-x86_64.S:151: Error: bad register name `%r9'
   lib/zinc/poly1305/poly1305-x86_64.S:152: Error: bad register name `%r10'
   lib/zinc/poly1305/poly1305-x86_64.S:153: Error: bad register name `%r10'
   lib/zinc/poly1305/poly1305-x86_64.S:154: Error: bad register name `%r8'
   lib/zinc/poly1305/poly1305-x86_64.S:155: Error: bad register name `%r9'
>> lib/zinc/poly1305/poly1305-x86_64.S:157: Error: bad register name `%rdx)'
   lib/zinc/poly1305/poly1305-x86_64.S:158: Error: bad register name `%rdx)'
   lib/zinc/poly1305/poly1305-x86_64.S:159: Error: bad register name `%rax'
   lib/zinc/poly1305/poly1305-x86_64.S:160: Error: bad register name `%rcx'
--
   In file included from lib/zinc/curve25519/curve25519-x86_64-glue.h:8:0,
                    from <command-line>:0:
>> arch/x86/include/asm/cpufeature.h:134:34: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
    extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
                                     ^~~~~~~~~~~
   In file included from include/linux/compiler_types.h:64:0,
                    from <command-line>:0:
   arch/x86/include/asm/cpufeature.h: In function '_static_cpu_has':
>> arch/x86/include/asm/cpufeature.h:198:52: error: 'struct cpuinfo_um' has no member named 'x86_capability'
           [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
                                                       ^
   include/linux/compiler-gcc.h:182:47: note: in definition of macro 'asm_volatile_goto'
    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                                  ^
   In file included from lib/zinc/curve25519/curve25519-x86_64-glue.h:8:0,
                    from <command-line>:0:
   lib/zinc/curve25519/curve25519-x86_64-glue.h: In function 'curve25519_fpu_init':
>> arch/x86/include/asm/cpufeature.h:65:28: error: 'REQUIRED_MASK0' undeclared (first use in this function); did you mean 'DISABLED_MASK0'?
      ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/curve25519/curve25519-x86_64-glue.h:18:24: note: in expansion of macro 'boot_cpu_has'
     curve25519_use_bmi2 = boot_cpu_has(X86_FEATURE_BMI2);
                           ^~~~~~~~~~~~
   arch/x86/include/asm/cpufeature.h:65:28: note: each undeclared identifier is reported only once for each function it appears in
      ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/curve25519/curve25519-x86_64-glue.h:18:24: note: in expansion of macro 'boot_cpu_has'
     curve25519_use_bmi2 = boot_cpu_has(X86_FEATURE_BMI2);
                           ^~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:66:28: error: 'REQUIRED_MASK1' undeclared (first use in this function); did you mean 'REQUIRED_MASK0'?
        CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  1, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/curve25519/curve25519-x86_64-glue.h:18:24: note: in expansion of macro 'boot_cpu_has'
     curve25519_use_bmi2 = boot_cpu_has(X86_FEATURE_BMI2);
                           ^~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:67:28: error: 'REQUIRED_MASK2' undeclared (first use in this function); did you mean 'REQUIRED_MASK1'?
        CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  2, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
>> lib/zinc/curve25519/curve25519-x86_64-glue.h:18:24: note: in expansion of macro 'boot_cpu_has'
     curve25519_use_bmi2 = boot_cpu_has(X86_FEATURE_BMI2);
                           ^~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:68:28: error: 'REQUIRED_MASK3' undeclared (first use in this function); did you mean 'REQUIRED_MASK2'?
        CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  3, feature_bit) || \
                               ^
   arch/x86/include/asm/cpufeature.h:62:44: note: in definition of macro 'CHECK_BIT_IN_MASK_WORD'
     (((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
                                               ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:111:32: note: in expansion of macro 'REQUIRED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cpufeature.h:129:27: note: in expansion of macro 'cpu_has'
    #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                              ^~~~~~~
..

vim +198 arch/x86/include/asm/cpufeature.h

80a208bd arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-06-24   50  
0f8d2b92 include/asm-x86/cpufeature.h      Ingo Molnar         2008-02-26   51  #define test_cpu_cap(c, bit)						\
0f8d2b92 include/asm-x86/cpufeature.h      Ingo Molnar         2008-02-26  @52  	 test_bit(bit, (unsigned long *)((c)->x86_capability))
0f8d2b92 include/asm-x86/cpufeature.h      Ingo Molnar         2008-02-26   53  
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   54  /*
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   55   * There are 32 bits/features in each mask word.  The high bits
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   56   * (selected with (bit>>5) give us the word number and the low 5
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   57   * bits give us the bit/feature number inside the word.
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   58   * (1UL<<((bit)&31) gives us a mask for the feature_bit so we can
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   59   * see if it is set in the mask word.
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   60   */
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   61  #define CHECK_BIT_IN_MASK_WORD(maskname, word, bit)	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   62  	(((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   63  
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   64  #define REQUIRED_MASK_BIT_SET(feature_bit)		\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @65  	 ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @66  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  1, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @67  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  2, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @68  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  3, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @69  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  4, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @70  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  5, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @71  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  6, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @72  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  7, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @73  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  8, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @74  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  9, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @75  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 10, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @76  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 11, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @77  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 12, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @78  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 13, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @79  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 14, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @80  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 15, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @81  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 16, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @82  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||	\
95ca0ee8 arch/x86/include/asm/cpufeature.h David Woodhouse     2018-01-25  @83  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
1e61f78b arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  @84  	   REQUIRED_MASK_CHECK					  ||	\
95ca0ee8 arch/x86/include/asm/cpufeature.h David Woodhouse     2018-01-25   85  	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
349c004e arch/x86/include/asm/cpufeature.h Christoph Lameter   2011-03-12   86  
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   87  #define DISABLED_MASK_BIT_SET(feature_bit)				\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   88  	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   89  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  1, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   90  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  2, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   91  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  3, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   92  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  4, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   93  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  5, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   94  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  6, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   95  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  7, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   96  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  8, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   97  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  9, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   98  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 10, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29   99  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 11, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  100  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 12, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  101  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 13, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  102  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 14, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  103  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 15, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  104  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 16, feature_bit) ||	\
8eda072e arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  105  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||	\
95ca0ee8 arch/x86/include/asm/cpufeature.h David Woodhouse     2018-01-25  106  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
1e61f78b arch/x86/include/asm/cpufeature.h Dave Hansen         2016-06-29  107  	   DISABLED_MASK_CHECK					  ||	\
95ca0ee8 arch/x86/include/asm/cpufeature.h David Woodhouse     2018-01-25  108  	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  109  
349c004e arch/x86/include/asm/cpufeature.h Christoph Lameter   2011-03-12  110  #define cpu_has(c, bit)							\
349c004e arch/x86/include/asm/cpufeature.h Christoph Lameter   2011-03-12 @111  	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
0f8d2b92 include/asm-x86/cpufeature.h      Ingo Molnar         2008-02-26 @112  	 test_cpu_cap(c, bit))
0f8d2b92 include/asm-x86/cpufeature.h      Ingo Molnar         2008-02-26  113  
349c004e arch/x86/include/asm/cpufeature.h Christoph Lameter   2011-03-12  114  #define this_cpu_has(bit)						\
349c004e arch/x86/include/asm/cpufeature.h Christoph Lameter   2011-03-12  115  	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : 	\
349c004e arch/x86/include/asm/cpufeature.h Christoph Lameter   2011-03-12  116  	 x86_this_cpu_test_bit(bit, (unsigned long *)&cpu_info.x86_capability))
349c004e arch/x86/include/asm/cpufeature.h Christoph Lameter   2011-03-12  117  
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  118  /*
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  119   * This macro is for detection of features which need kernel
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  120   * infrastructure to be used.  It may *not* directly test the CPU
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  121   * itself.  Use the cpu_has() family if you want true runtime
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  122   * testing of CPU features, like in hypervisor code where you are
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  123   * supporting a possible guest feature where host support for it
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  124   * is not relevant.
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  125   */
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  126  #define cpu_feature_enabled(bit)	\
f2cc8e07 arch/x86/include/asm/cpufeature.h Borislav Petkov     2016-02-16  127  	(__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
381aa07a arch/x86/include/asm/cpufeature.h Dave Hansen         2014-09-11  128  
7b11fb51 include/asm-x86/cpufeature.h      H. Peter Anvin      2008-01-30 @129  #define boot_cpu_has(bit)	cpu_has(&boot_cpu_data, bit)
7b11fb51 include/asm-x86/cpufeature.h      H. Peter Anvin      2008-01-30  130  
53756d37 include/asm-x86/cpufeature.h      Jeremy Fitzhardinge 2008-01-30  131  #define set_cpu_cap(c, bit)	set_bit(bit, (unsigned long *)((c)->x86_capability))
0b00de85 arch/x86/include/asm/cpufeature.h Andi Kleen          2017-10-13  132  
0b00de85 arch/x86/include/asm/cpufeature.h Andi Kleen          2017-10-13  133  extern void setup_clear_cpu_cap(unsigned int bit);
0b00de85 arch/x86/include/asm/cpufeature.h Andi Kleen          2017-10-13 @134  extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
0b00de85 arch/x86/include/asm/cpufeature.h Andi Kleen          2017-10-13  135  
404ee5b1 include/asm-x86/cpufeature.h      Andi Kleen          2008-01-30  136  #define setup_force_cpu_cap(bit) do { \
404ee5b1 include/asm-x86/cpufeature.h      Andi Kleen          2008-01-30  137  	set_cpu_cap(&boot_cpu_data, bit);	\
3e0c3737 arch/x86/include/asm/cpufeature.h Yinghai Lu          2009-05-09  138  	set_bit(bit, (unsigned long *)cpu_caps_set);	\
404ee5b1 include/asm-x86/cpufeature.h      Andi Kleen          2008-01-30  139  } while (0)
53756d37 include/asm-x86/cpufeature.h      Jeremy Fitzhardinge 2008-01-30  140  
6cbd2171 arch/x86/include/asm/cpufeature.h Thomas Gleixner     2017-12-04  141  #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
6cbd2171 arch/x86/include/asm/cpufeature.h Thomas Gleixner     2017-12-04  142  
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  143  #if defined(__clang__) && !defined(CC_HAVE_ASM_GOTO)
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  144  
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  145  /*
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  146   * Workaround for the sake of BPF compilation which utilizes kernel
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  147   * headers, but clang does not support ASM GOTO and fails the build.
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  148   */
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  149  #ifndef __BPF_TRACING__
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  150  #warning "Compiler lacks ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  151  #endif
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  152  
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  153  #define static_cpu_has(bit)            boot_cpu_has(bit)
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  154  
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  155  #else
b1ae32db arch/x86/include/asm/cpufeature.h Alexei Starovoitov  2018-05-13  156  
a3c8acd0 arch/x86/include/asm/cpufeature.h H. Peter Anvin      2010-05-11  157  /*
a3c8acd0 arch/x86/include/asm/cpufeature.h H. Peter Anvin      2010-05-11  158   * Static testing of CPU features.  Used the same as boot_cpu_has().
a362bf9f arch/x86/include/asm/cpufeature.h Borislav Petkov     2016-01-27  159   * These will statically patch the target code for additional
a362bf9f arch/x86/include/asm/cpufeature.h Borislav Petkov     2016-01-27  160   * performance.
a3c8acd0 arch/x86/include/asm/cpufeature.h H. Peter Anvin      2010-05-11  161   */
bc696ca0 arch/x86/include/asm/cpufeature.h Borislav Petkov     2016-01-26  162  static __always_inline __pure bool _static_cpu_has(u16 bit)
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  163  {
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  164  	asm_volatile_goto("1: jmp 6f\n"
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  165  		 "2:\n"
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  166  		 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  167  			 "((5f-4f) - (2b-1b)),0x90\n"
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  168  		 "3:\n"
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  169  		 ".section .altinstructions,\"a\"\n"
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  170  		 " .long 1b - .\n"		/* src offset */
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  171  		 " .long 4f - .\n"		/* repl offset */
3197b04b arch/x86/include/asm/cpufeature.h Peter Zijlstra      2018-01-16  172  		 " .word %P[always]\n"		/* always replace */
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  173  		 " .byte 3b - 1b\n"		/* src len */
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  174  		 " .byte 5f - 4f\n"		/* repl len */
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  175  		 " .byte 3b - 2b\n"		/* pad len */
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  176  		 ".previous\n"
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  177  		 ".section .altinstr_replacement,\"ax\"\n"
48c7a250 arch/x86/include/asm/cpufeature.h Borislav Petkov     2015-01-05  178  		 "4: jmp %l[t_no]\n"
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  179  		 "5:\n"
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  180  		 ".previous\n"
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  181  		 ".section .altinstructions,\"a\"\n"
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  182  		 " .long 1b - .\n"		/* src offset */
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  183  		 " .long 0\n"			/* no replacement */
3197b04b arch/x86/include/asm/cpufeature.h Peter Zijlstra      2018-01-16  184  		 " .word %P[feature]\n"		/* feature bit */
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  185  		 " .byte 3b - 1b\n"		/* src len */
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  186  		 " .byte 0\n"			/* repl len */
4332195c arch/x86/include/asm/cpufeature.h Borislav Petkov     2014-12-27  187  		 " .byte 0\n"			/* pad len */
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  188  		 ".previous\n"
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  189  		 ".section .altinstr_aux,\"ax\"\n"
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  190  		 "6:\n"
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  191  		 " testb %[bitnum],%[cap_byte]\n"
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  192  		 " jnz %l[t_yes]\n"
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  193  		 " jmp %l[t_no]\n"
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  194  		 ".previous\n"
3197b04b arch/x86/include/asm/cpufeature.h Peter Zijlstra      2018-01-16  195  		 : : [feature]  "i" (bit),
3197b04b arch/x86/include/asm/cpufeature.h Peter Zijlstra      2018-01-16  196  		     [always]   "i" (X86_FEATURE_ALWAYS),
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  197  		     [bitnum]   "i" (1 << (bit & 7)),
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27 @198  		     [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  199  		 : : t_yes, t_no);
2476f2fa arch/x86/include/asm/cpufeature.h Brian Gerst         2016-01-27  200  t_yes:
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  201  	return true;
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  202  t_no:
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  203  	return false;
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  204  }
4a90a99c arch/x86/include/asm/cpufeature.h Borislav Petkov     2013-06-09  205  

:::::: The code at line 198 was first introduced by commit
:::::: 2476f2fa20568bd5d9e09cd35bcd73e99a6f4cc6 x86/alternatives: Discard dynamic check after init

:::::: TO: Brian Gerst <brgerst@gmail.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AAA=

--45Z9DzgjV8m4Oswq--
