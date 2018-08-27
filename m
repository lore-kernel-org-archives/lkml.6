Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E5EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D12F208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D12F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeH0Qjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:39:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:28788 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeH0Qjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:39:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 05:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="gz'50?scan'50,208,50";a="83728780"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2018 05:53:00 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fuH0m-0008t5-2p; Mon, 27 Aug 2018 20:52:52 +0800
Date:   Mon, 27 Aug 2018 20:52:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 17/17] net: WireGuard secure network tunnel
Message-ID: <201808272027.eXC6MLgJ%fengguang.wu@intel.com>
References: <20180824213849.23647-18-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20180824213849.23647-18-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jason,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc1 next-20180827]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jason-A-Donenfeld/WireGuard-Secure-Network-Tunnel/20180827-073051
config: um-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

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
   In file included from <command-line>:0:0:
   At top level:
   lib/zinc/chacha20/chacha20-x86_64-glue.h:27:13: warning: 'chacha20_use_avx512vl' defined but not used [-Wunused-variable]
    static bool chacha20_use_avx512vl __ro_after_init;
                ^~~~~~~~~~~~~~~~~~~~~
   lib/zinc/chacha20/chacha20-x86_64-glue.h:26:13: warning: 'chacha20_use_avx512' defined but not used [-Wunused-variable]
    static bool chacha20_use_avx512 __ro_after_init;
                ^~~~~~~~~~~~~~~~~~~
   lib/zinc/chacha20/chacha20-x86_64-glue.h:25:13: warning: 'chacha20_use_avx2' defined but not used [-Wunused-variable]
    static bool chacha20_use_avx2 __ro_after_init;
                ^~~~~~~~~~~~~~~~~
   lib/zinc/chacha20/chacha20-x86_64-glue.h:24:13: warning: 'chacha20_use_ssse3' defined but not used [-Wunused-variable]
    static bool chacha20_use_ssse3 __ro_after_init;
                ^~~~~~~~~~~~~~~~~~
--
   In file included from lib/zinc/poly1305/poly1305-x86_64-glue.h:8:0,
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
   In file included from <command-line>:0:0:
   At top level:
   lib/zinc/poly1305/poly1305-x86_64-glue.h:28:13: warning: 'poly1305_use_avx512' defined but not used [-Wunused-variable]
    static bool poly1305_use_avx512 __ro_after_init;
                ^~~~~~~~~~~~~~~~~~~
   lib/zinc/poly1305/poly1305-x86_64-glue.h:27:13: warning: 'poly1305_use_avx2' defined but not used [-Wunused-variable]
    static bool poly1305_use_avx2 __ro_after_init;
                ^~~~~~~~~~~~~~~~~
   lib/zinc/poly1305/poly1305-x86_64-glue.h:26:13: warning: 'poly1305_use_avx' defined but not used [-Wunused-variable]
    static bool poly1305_use_avx __ro_after_init;
                ^~~~~~~~~~~~~~~~
--
   In file included from lib/zinc/curve25519/curve25519-x86_64-glue.h:7:0,
                    from <command-line>:0:
>> arch/x86/include/asm/cpufeature.h:49:41: error: 'NBUGINTS' undeclared here (not in a function)
    extern const char * const x86_bug_flags[NBUGINTS*32];
                                            ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:134:34: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
    extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
                                     ^~~~~~~~~~~
   In file included from include/linux/compiler_types.h:64:0,
                    from <command-line>:0:
   arch/x86/include/asm/cpufeature.h: In function '_static_cpu_has':
>> arch/x86/include/asm/cpufeature.h:196:24: error: 'X86_FEATURE_ALWAYS' undeclared (first use in this function)
           [always]   "i" (X86_FEATURE_ALWAYS),
                           ^
   include/linux/compiler-gcc.h:182:47: note: in definition of macro 'asm_volatile_goto'
    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                                  ^
   arch/x86/include/asm/cpufeature.h:196:24: note: each undeclared identifier is reported only once for each function it appears in
           [always]   "i" (X86_FEATURE_ALWAYS),
                           ^
   include/linux/compiler-gcc.h:182:47: note: in definition of macro 'asm_volatile_goto'
    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                                  ^
>> arch/x86/include/asm/cpufeature.h:198:52: error: 'struct cpuinfo_um' has no member named 'x86_capability'
           [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
                                                       ^
   include/linux/compiler-gcc.h:182:47: note: in definition of macro 'asm_volatile_goto'
    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                                  ^
   In file included from lib/zinc/curve25519/curve25519-x86_64-glue.h:10:0,
                    from <command-line>:0:
   lib/zinc/curve25519/curve25519-x86_64.h: In function 'inv_eltfp25519_1w_adx':
>> lib/zinc/curve25519/curve25519-x86_64.h:1543:2: error: implicit declaration of function 'memzero_explicit' [-Werror=implicit-function-declaration]
     memzero_explicit(&m, sizeof(m));
     ^~~~~~~~~~~~~~~~
   In file included from lib/zinc/curve25519/curve25519-x86_64-glue.h:10:0,
                    from <command-line>:0:
   lib/zinc/curve25519/curve25519-x86_64.h: In function 'curve25519_adx':
>> lib/zinc/curve25519/curve25519-x86_64.h:1706:2: error: implicit declaration of function 'memcpy'; did you mean 'pte_copy'? [-Werror=implicit-function-declaration]
     memcpy(m.private, private_key, sizeof(m.private));
     ^~~~~~
     pte_copy
   In file included from <command-line>:0:0:
   lib/zinc/curve25519/curve25519-x86_64-glue.h: At top level:
>> lib/zinc/curve25519/curve25519-x86_64-glue.h:12:33: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ro_after_init'
    static bool curve25519_use_bmi2 __ro_after_init;
                                    ^~~~~~~~~~~~~~~
   lib/zinc/curve25519/curve25519-x86_64-glue.h:13:32: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ro_after_init'
    static bool curve25519_use_adx __ro_after_init;
                                   ^~~~~~~~~~~~~~~
>> lib/zinc/curve25519/curve25519-x86_64-glue.h:15:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'curve25519_fpu_init'
    void __init curve25519_fpu_init(void)
                ^~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   lib/zinc/curve25519/curve25519-x86_64-glue.h: In function 'curve25519_arch':
>> lib/zinc/curve25519/curve25519-x86_64-glue.h:23:6: error: 'curve25519_use_adx' undeclared (first use in this function); did you mean 'curve25519_adx'?
     if (curve25519_use_adx) {
         ^~~~~~~~~~~~~~~~~~
         curve25519_adx
>> lib/zinc/curve25519/curve25519-x86_64-glue.h:26:13: error: 'curve25519_use_bmi2' undeclared (first use in this function); did you mean 'curve25519_use_adx'?
     } else if (curve25519_use_bmi2) {
                ^~~~~~~~~~~~~~~~~~~
                curve25519_use_adx
   lib/zinc/curve25519/curve25519-x86_64-glue.h: In function 'curve25519_base_arch':
   lib/zinc/curve25519/curve25519-x86_64-glue.h:35:6: error: 'curve25519_use_adx' undeclared (first use in this function); did you mean 'curve25519_adx'?
     if (curve25519_use_adx) {
         ^~~~~~~~~~~~~~~~~~
         curve25519_adx
   lib/zinc/curve25519/curve25519-x86_64-glue.h:38:13: error: 'curve25519_use_bmi2' undeclared (first use in this function); did you mean 'curve25519_use_adx'?
     } else if (curve25519_use_bmi2) {
                ^~~~~~~~~~~~~~~~~~~
                curve25519_use_adx
   In file included from arch/x86/include/asm/string.h:5:0,
                    from include/linux/string.h:20,
                    from lib/zinc/curve25519/curve25519.c:9:
   arch/x86/include/asm/string_64.h: At top level:
>> arch/x86/include/asm/string_64.h:32:14: error: conflicting types for 'memcpy'
    extern void *memcpy(void *to, const void *from, size_t len);
                 ^~~~~~
   In file included from lib/zinc/curve25519/curve25519-x86_64-glue.h:10:0,
                    from <command-line>:0:
   lib/zinc/curve25519/curve25519-x86_64.h:1706:2: note: previous implicit declaration of 'memcpy' was here
     memcpy(m.private, private_key, sizeof(m.private));
     ^~~~~~
   In file included from lib/zinc/curve25519/curve25519.c:9:0:
>> include/linux/string.h:216:6: warning: conflicting types for 'memzero_explicit'
    void memzero_explicit(void *s, size_t count);
         ^~~~~~~~~~~~~~~~
   In file included from lib/zinc/curve25519/curve25519-x86_64-glue.h:10:0,
                    from <command-line>:0:
   lib/zinc/curve25519/curve25519-x86_64.h:1543:2: note: previous implicit declaration of 'memzero_explicit' was here
     memzero_explicit(&m, sizeof(m));
     ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from lib/zinc/blake2s/blake2s-x86_64-glue.h:7:0,
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
   In file included from <command-line>:0:0:
   At top level:
   lib/zinc/blake2s/blake2s-x86_64-glue.h:20:13: warning: 'blake2s_use_avx512' defined but not used [-Wunused-variable]
    static bool blake2s_use_avx512 __ro_after_init;
                ^~~~~~~~~~~~~~~~~~
   lib/zinc/blake2s/blake2s-x86_64-glue.h:19:13: warning: 'blake2s_use_avx' defined but not used [-Wunused-variable]
    static bool blake2s_use_avx __ro_after_init;
                ^~~~~~~~~~~~~~~
--
   In file included from lib//zinc/chacha20/chacha20-x86_64-glue.h:8:0,
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
   In file included from <command-line>:0:0:
   At top level:
   lib//zinc/chacha20/chacha20-x86_64-glue.h:27:13: warning: 'chacha20_use_avx512vl' defined but not used [-Wunused-variable]
    static bool chacha20_use_avx512vl __ro_after_init;
                ^~~~~~~~~~~~~~~~~~~~~
   lib//zinc/chacha20/chacha20-x86_64-glue.h:26:13: warning: 'chacha20_use_avx512' defined but not used [-Wunused-variable]
    static bool chacha20_use_avx512 __ro_after_init;
                ^~~~~~~~~~~~~~~~~~~
   lib//zinc/chacha20/chacha20-x86_64-glue.h:25:13: warning: 'chacha20_use_avx2' defined but not used [-Wunused-variable]
    static bool chacha20_use_avx2 __ro_after_init;
                ^~~~~~~~~~~~~~~~~
   lib//zinc/chacha20/chacha20-x86_64-glue.h:24:13: warning: 'chacha20_use_ssse3' defined but not used [-Wunused-variable]
    static bool chacha20_use_ssse3 __ro_after_init;
                ^~~~~~~~~~~~~~~~~~
--
   In file included from lib//zinc/poly1305/poly1305-x86_64-glue.h:8:0,
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
   In file included from <command-line>:0:0:
   At top level:
   lib//zinc/poly1305/poly1305-x86_64-glue.h:28:13: warning: 'poly1305_use_avx512' defined but not used [-Wunused-variable]
    static bool poly1305_use_avx512 __ro_after_init;
                ^~~~~~~~~~~~~~~~~~~
   lib//zinc/poly1305/poly1305-x86_64-glue.h:27:13: warning: 'poly1305_use_avx2' defined but not used [-Wunused-variable]
    static bool poly1305_use_avx2 __ro_after_init;
                ^~~~~~~~~~~~~~~~~
   lib//zinc/poly1305/poly1305-x86_64-glue.h:26:13: warning: 'poly1305_use_avx' defined but not used [-Wunused-variable]
    static bool poly1305_use_avx __ro_after_init;
                ^~~~~~~~~~~~~~~~
--
   In file included from lib//zinc/curve25519/curve25519-x86_64-glue.h:7:0,
                    from <command-line>:0:
>> arch/x86/include/asm/cpufeature.h:49:41: error: 'NBUGINTS' undeclared here (not in a function)
    extern const char * const x86_bug_flags[NBUGINTS*32];
                                            ^~~~~~~~
>> arch/x86/include/asm/cpufeature.h:134:34: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
    extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
                                     ^~~~~~~~~~~
   In file included from include/linux/compiler_types.h:64:0,
                    from <command-line>:0:
   arch/x86/include/asm/cpufeature.h: In function '_static_cpu_has':
>> arch/x86/include/asm/cpufeature.h:196:24: error: 'X86_FEATURE_ALWAYS' undeclared (first use in this function)
           [always]   "i" (X86_FEATURE_ALWAYS),
                           ^
   include/linux/compiler-gcc.h:182:47: note: in definition of macro 'asm_volatile_goto'
    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                                  ^
   arch/x86/include/asm/cpufeature.h:196:24: note: each undeclared identifier is reported only once for each function it appears in
           [always]   "i" (X86_FEATURE_ALWAYS),
                           ^
   include/linux/compiler-gcc.h:182:47: note: in definition of macro 'asm_volatile_goto'
    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                                  ^
>> arch/x86/include/asm/cpufeature.h:198:52: error: 'struct cpuinfo_um' has no member named 'x86_capability'
           [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
                                                       ^
   include/linux/compiler-gcc.h:182:47: note: in definition of macro 'asm_volatile_goto'
    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                                  ^
   In file included from lib//zinc/curve25519/curve25519-x86_64-glue.h:10:0,
                    from <command-line>:0:
   lib//zinc/curve25519/curve25519-x86_64.h: In function 'inv_eltfp25519_1w_adx':
   lib//zinc/curve25519/curve25519-x86_64.h:1543:2: error: implicit declaration of function 'memzero_explicit' [-Werror=implicit-function-declaration]
     memzero_explicit(&m, sizeof(m));
     ^~~~~~~~~~~~~~~~
   In file included from lib//zinc/curve25519/curve25519-x86_64-glue.h:10:0,
                    from <command-line>:0:
   lib//zinc/curve25519/curve25519-x86_64.h: In function 'curve25519_adx':
   lib//zinc/curve25519/curve25519-x86_64.h:1706:2: error: implicit declaration of function 'memcpy'; did you mean 'pte_copy'? [-Werror=implicit-function-declaration]
     memcpy(m.private, private_key, sizeof(m.private));
     ^~~~~~
     pte_copy
   In file included from <command-line>:0:0:
   lib//zinc/curve25519/curve25519-x86_64-glue.h: At top level:
   lib//zinc/curve25519/curve25519-x86_64-glue.h:12:33: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ro_after_init'
    static bool curve25519_use_bmi2 __ro_after_init;
                                    ^~~~~~~~~~~~~~~
   lib//zinc/curve25519/curve25519-x86_64-glue.h:13:32: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ro_after_init'
    static bool curve25519_use_adx __ro_after_init;
                                   ^~~~~~~~~~~~~~~
   lib//zinc/curve25519/curve25519-x86_64-glue.h:15:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'curve25519_fpu_init'
    void __init curve25519_fpu_init(void)
                ^~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   lib//zinc/curve25519/curve25519-x86_64-glue.h: In function 'curve25519_arch':
   lib//zinc/curve25519/curve25519-x86_64-glue.h:23:6: error: 'curve25519_use_adx' undeclared (first use in this function); did you mean 'curve25519_adx'?
     if (curve25519_use_adx) {
         ^~~~~~~~~~~~~~~~~~
         curve25519_adx
   lib//zinc/curve25519/curve25519-x86_64-glue.h:26:13: error: 'curve25519_use_bmi2' undeclared (first use in this function); did you mean 'curve25519_use_adx'?
     } else if (curve25519_use_bmi2) {
                ^~~~~~~~~~~~~~~~~~~
                curve25519_use_adx
   lib//zinc/curve25519/curve25519-x86_64-glue.h: In function 'curve25519_base_arch':
   lib//zinc/curve25519/curve25519-x86_64-glue.h:35:6: error: 'curve25519_use_adx' undeclared (first use in this function); did you mean 'curve25519_adx'?
     if (curve25519_use_adx) {
         ^~~~~~~~~~~~~~~~~~
         curve25519_adx
   lib//zinc/curve25519/curve25519-x86_64-glue.h:38:13: error: 'curve25519_use_bmi2' undeclared (first use in this function); did you mean 'curve25519_use_adx'?
     } else if (curve25519_use_bmi2) {
                ^~~~~~~~~~~~~~~~~~~
                curve25519_use_adx
   In file included from arch/x86/include/asm/string.h:5:0,
                    from include/linux/string.h:20,
                    from lib//zinc/curve25519/curve25519.c:9:
   arch/x86/include/asm/string_64.h: At top level:
>> arch/x86/include/asm/string_64.h:32:14: error: conflicting types for 'memcpy'
    extern void *memcpy(void *to, const void *from, size_t len);
                 ^~~~~~
   In file included from lib//zinc/curve25519/curve25519-x86_64-glue.h:10:0,
                    from <command-line>:0:
   lib//zinc/curve25519/curve25519-x86_64.h:1706:2: note: previous implicit declaration of 'memcpy' was here
     memcpy(m.private, private_key, sizeof(m.private));
     ^~~~~~
   In file included from lib//zinc/curve25519/curve25519.c:9:0:
>> include/linux/string.h:216:6: warning: conflicting types for 'memzero_explicit'
    void memzero_explicit(void *s, size_t count);
         ^~~~~~~~~~~~~~~~
   In file included from lib//zinc/curve25519/curve25519-x86_64-glue.h:10:0,
                    from <command-line>:0:
   lib//zinc/curve25519/curve25519-x86_64.h:1543:2: note: previous implicit declaration of 'memzero_explicit' was here
     memzero_explicit(&m, sizeof(m));
     ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..

vim +/memzero_explicit +1543 lib/zinc/curve25519/curve25519-x86_64.h

468c57c7 Jason A. Donenfeld 2018-08-24  1498  
468c57c7 Jason A. Donenfeld 2018-08-24  1499  static void inv_eltfp25519_1w_adx(u64 *const c, const u64 *const a)
468c57c7 Jason A. Donenfeld 2018-08-24  1500  {
468c57c7 Jason A. Donenfeld 2018-08-24  1501  	struct {
468c57c7 Jason A. Donenfeld 2018-08-24  1502  		eltfp25519_1w_buffer buffer;
468c57c7 Jason A. Donenfeld 2018-08-24  1503  		eltfp25519_1w x0, x1, x2;
468c57c7 Jason A. Donenfeld 2018-08-24  1504  	} __aligned(32) m;
468c57c7 Jason A. Donenfeld 2018-08-24  1505  	u64 *T[4];
468c57c7 Jason A. Donenfeld 2018-08-24  1506  
468c57c7 Jason A. Donenfeld 2018-08-24  1507  	T[0] = m.x0;
468c57c7 Jason A. Donenfeld 2018-08-24  1508  	T[1] = c; /* x^(-1) */
468c57c7 Jason A. Donenfeld 2018-08-24  1509  	T[2] = m.x1;
468c57c7 Jason A. Donenfeld 2018-08-24  1510  	T[3] = m.x2;
468c57c7 Jason A. Donenfeld 2018-08-24  1511  
468c57c7 Jason A. Donenfeld 2018-08-24  1512  	copy_eltfp25519_1w(T[1], a);
468c57c7 Jason A. Donenfeld 2018-08-24  1513  	sqrn_eltfp25519_1w_adx(T[1], 1);
468c57c7 Jason A. Donenfeld 2018-08-24  1514  	copy_eltfp25519_1w(T[2], T[1]);
468c57c7 Jason A. Donenfeld 2018-08-24  1515  	sqrn_eltfp25519_1w_adx(T[2], 2);
468c57c7 Jason A. Donenfeld 2018-08-24  1516  	mul_eltfp25519_1w_adx(T[0], a, T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1517  	mul_eltfp25519_1w_adx(T[1], T[1], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1518  	copy_eltfp25519_1w(T[2], T[1]);
468c57c7 Jason A. Donenfeld 2018-08-24  1519  	sqrn_eltfp25519_1w_adx(T[2], 1);
468c57c7 Jason A. Donenfeld 2018-08-24  1520  	mul_eltfp25519_1w_adx(T[0], T[0], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1521  	copy_eltfp25519_1w(T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1522  	sqrn_eltfp25519_1w_adx(T[2], 5);
468c57c7 Jason A. Donenfeld 2018-08-24  1523  	mul_eltfp25519_1w_adx(T[0], T[0], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1524  	copy_eltfp25519_1w(T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1525  	sqrn_eltfp25519_1w_adx(T[2], 10);
468c57c7 Jason A. Donenfeld 2018-08-24  1526  	mul_eltfp25519_1w_adx(T[2], T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1527  	copy_eltfp25519_1w(T[3], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1528  	sqrn_eltfp25519_1w_adx(T[3], 20);
468c57c7 Jason A. Donenfeld 2018-08-24  1529  	mul_eltfp25519_1w_adx(T[3], T[3], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1530  	sqrn_eltfp25519_1w_adx(T[3], 10);
468c57c7 Jason A. Donenfeld 2018-08-24  1531  	mul_eltfp25519_1w_adx(T[3], T[3], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1532  	copy_eltfp25519_1w(T[0], T[3]);
468c57c7 Jason A. Donenfeld 2018-08-24  1533  	sqrn_eltfp25519_1w_adx(T[0], 50);
468c57c7 Jason A. Donenfeld 2018-08-24  1534  	mul_eltfp25519_1w_adx(T[0], T[0], T[3]);
468c57c7 Jason A. Donenfeld 2018-08-24  1535  	copy_eltfp25519_1w(T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1536  	sqrn_eltfp25519_1w_adx(T[2], 100);
468c57c7 Jason A. Donenfeld 2018-08-24  1537  	mul_eltfp25519_1w_adx(T[2], T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1538  	sqrn_eltfp25519_1w_adx(T[2], 50);
468c57c7 Jason A. Donenfeld 2018-08-24  1539  	mul_eltfp25519_1w_adx(T[2], T[2], T[3]);
468c57c7 Jason A. Donenfeld 2018-08-24  1540  	sqrn_eltfp25519_1w_adx(T[2], 5);
468c57c7 Jason A. Donenfeld 2018-08-24  1541  	mul_eltfp25519_1w_adx(T[1], T[1], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1542  
468c57c7 Jason A. Donenfeld 2018-08-24 @1543  	memzero_explicit(&m, sizeof(m));
468c57c7 Jason A. Donenfeld 2018-08-24  1544  }
468c57c7 Jason A. Donenfeld 2018-08-24  1545  
468c57c7 Jason A. Donenfeld 2018-08-24  1546  static void inv_eltfp25519_1w_bmi2(u64 *const c, const u64 *const a)
468c57c7 Jason A. Donenfeld 2018-08-24  1547  {
468c57c7 Jason A. Donenfeld 2018-08-24  1548  	struct {
468c57c7 Jason A. Donenfeld 2018-08-24  1549  		eltfp25519_1w_buffer buffer;
468c57c7 Jason A. Donenfeld 2018-08-24  1550  		eltfp25519_1w x0, x1, x2;
468c57c7 Jason A. Donenfeld 2018-08-24  1551  	} __aligned(32) m;
468c57c7 Jason A. Donenfeld 2018-08-24  1552  	u64 *T[5];
468c57c7 Jason A. Donenfeld 2018-08-24  1553  
468c57c7 Jason A. Donenfeld 2018-08-24  1554  	T[0] = m.x0;
468c57c7 Jason A. Donenfeld 2018-08-24  1555  	T[1] = c; /* x^(-1) */
468c57c7 Jason A. Donenfeld 2018-08-24  1556  	T[2] = m.x1;
468c57c7 Jason A. Donenfeld 2018-08-24  1557  	T[3] = m.x2;
468c57c7 Jason A. Donenfeld 2018-08-24  1558  
468c57c7 Jason A. Donenfeld 2018-08-24  1559  	copy_eltfp25519_1w(T[1], a);
468c57c7 Jason A. Donenfeld 2018-08-24  1560  	sqrn_eltfp25519_1w_bmi2(T[1], 1);
468c57c7 Jason A. Donenfeld 2018-08-24  1561  	copy_eltfp25519_1w(T[2], T[1]);
468c57c7 Jason A. Donenfeld 2018-08-24  1562  	sqrn_eltfp25519_1w_bmi2(T[2], 2);
468c57c7 Jason A. Donenfeld 2018-08-24  1563  	mul_eltfp25519_1w_bmi2(T[0], a, T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1564  	mul_eltfp25519_1w_bmi2(T[1], T[1], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1565  	copy_eltfp25519_1w(T[2], T[1]);
468c57c7 Jason A. Donenfeld 2018-08-24  1566  	sqrn_eltfp25519_1w_bmi2(T[2], 1);
468c57c7 Jason A. Donenfeld 2018-08-24  1567  	mul_eltfp25519_1w_bmi2(T[0], T[0], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1568  	copy_eltfp25519_1w(T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1569  	sqrn_eltfp25519_1w_bmi2(T[2], 5);
468c57c7 Jason A. Donenfeld 2018-08-24  1570  	mul_eltfp25519_1w_bmi2(T[0], T[0], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1571  	copy_eltfp25519_1w(T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1572  	sqrn_eltfp25519_1w_bmi2(T[2], 10);
468c57c7 Jason A. Donenfeld 2018-08-24  1573  	mul_eltfp25519_1w_bmi2(T[2], T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1574  	copy_eltfp25519_1w(T[3], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1575  	sqrn_eltfp25519_1w_bmi2(T[3], 20);
468c57c7 Jason A. Donenfeld 2018-08-24  1576  	mul_eltfp25519_1w_bmi2(T[3], T[3], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1577  	sqrn_eltfp25519_1w_bmi2(T[3], 10);
468c57c7 Jason A. Donenfeld 2018-08-24  1578  	mul_eltfp25519_1w_bmi2(T[3], T[3], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1579  	copy_eltfp25519_1w(T[0], T[3]);
468c57c7 Jason A. Donenfeld 2018-08-24  1580  	sqrn_eltfp25519_1w_bmi2(T[0], 50);
468c57c7 Jason A. Donenfeld 2018-08-24  1581  	mul_eltfp25519_1w_bmi2(T[0], T[0], T[3]);
468c57c7 Jason A. Donenfeld 2018-08-24  1582  	copy_eltfp25519_1w(T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1583  	sqrn_eltfp25519_1w_bmi2(T[2], 100);
468c57c7 Jason A. Donenfeld 2018-08-24  1584  	mul_eltfp25519_1w_bmi2(T[2], T[2], T[0]);
468c57c7 Jason A. Donenfeld 2018-08-24  1585  	sqrn_eltfp25519_1w_bmi2(T[2], 50);
468c57c7 Jason A. Donenfeld 2018-08-24  1586  	mul_eltfp25519_1w_bmi2(T[2], T[2], T[3]);
468c57c7 Jason A. Donenfeld 2018-08-24  1587  	sqrn_eltfp25519_1w_bmi2(T[2], 5);
468c57c7 Jason A. Donenfeld 2018-08-24  1588  	mul_eltfp25519_1w_bmi2(T[1], T[1], T[2]);
468c57c7 Jason A. Donenfeld 2018-08-24  1589  
468c57c7 Jason A. Donenfeld 2018-08-24  1590  	memzero_explicit(&m, sizeof(m));
468c57c7 Jason A. Donenfeld 2018-08-24  1591  }
468c57c7 Jason A. Donenfeld 2018-08-24  1592  
468c57c7 Jason A. Donenfeld 2018-08-24  1593  /* Given c, a 256-bit number, fred_eltfp25519_1w updates c
468c57c7 Jason A. Donenfeld 2018-08-24  1594   * with a number such that 0 <= C < 2**255-19.
468c57c7 Jason A. Donenfeld 2018-08-24  1595   */
468c57c7 Jason A. Donenfeld 2018-08-24  1596  static __always_inline void fred_eltfp25519_1w(u64 *const c)
468c57c7 Jason A. Donenfeld 2018-08-24  1597  {
468c57c7 Jason A. Donenfeld 2018-08-24  1598  	u64 tmp0 = 38, tmp1 = 19;
468c57c7 Jason A. Donenfeld 2018-08-24  1599  	asm volatile(
468c57c7 Jason A. Donenfeld 2018-08-24  1600  		"btrq   $63,    %3 ;" /* Put bit 255 in carry flag and clear */
468c57c7 Jason A. Donenfeld 2018-08-24  1601  		"cmovncl %k5,   %k4 ;" /* c[255] ? 38 : 19 */
468c57c7 Jason A. Donenfeld 2018-08-24  1602  
468c57c7 Jason A. Donenfeld 2018-08-24  1603  		/* Add either 19 or 38 to c */
468c57c7 Jason A. Donenfeld 2018-08-24  1604  		"addq    %4,   %0 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1605  		"adcq    $0,   %1 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1606  		"adcq    $0,   %2 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1607  		"adcq    $0,   %3 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1608  
468c57c7 Jason A. Donenfeld 2018-08-24  1609  		/* Test for bit 255 again; only triggered on overflow modulo 2^255-19 */
468c57c7 Jason A. Donenfeld 2018-08-24  1610  		"movl    $0,  %k4 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1611  		"cmovnsl %k5,  %k4 ;" /* c[255] ? 0 : 19 */
468c57c7 Jason A. Donenfeld 2018-08-24  1612  		"btrq   $63,   %3 ;" /* Clear bit 255 */
468c57c7 Jason A. Donenfeld 2018-08-24  1613  
468c57c7 Jason A. Donenfeld 2018-08-24  1614  		/* Subtract 19 if necessary */
468c57c7 Jason A. Donenfeld 2018-08-24  1615  		"subq    %4,   %0 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1616  		"sbbq    $0,   %1 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1617  		"sbbq    $0,   %2 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1618  		"sbbq    $0,   %3 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1619  
468c57c7 Jason A. Donenfeld 2018-08-24  1620  		: "+r"(c[0]), "+r"(c[1]), "+r"(c[2]), "+r"(c[3]), "+r"(tmp0), "+r"(tmp1)
468c57c7 Jason A. Donenfeld 2018-08-24  1621  		:
468c57c7 Jason A. Donenfeld 2018-08-24  1622  		: "memory", "cc");
468c57c7 Jason A. Donenfeld 2018-08-24  1623  }
468c57c7 Jason A. Donenfeld 2018-08-24  1624  
468c57c7 Jason A. Donenfeld 2018-08-24  1625  static __always_inline void cswap(u8 bit, u64 *const px, u64 *const py)
468c57c7 Jason A. Donenfeld 2018-08-24  1626  {
468c57c7 Jason A. Donenfeld 2018-08-24  1627  	u64 temp;
468c57c7 Jason A. Donenfeld 2018-08-24  1628  	asm volatile(
468c57c7 Jason A. Donenfeld 2018-08-24  1629  		"test %9, %9 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1630  		"movq %0, %8 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1631  		"cmovnzq %4, %0 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1632  		"cmovnzq %8, %4 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1633  		"movq %1, %8 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1634  		"cmovnzq %5, %1 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1635  		"cmovnzq %8, %5 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1636  		"movq %2, %8 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1637  		"cmovnzq %6, %2 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1638  		"cmovnzq %8, %6 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1639  		"movq %3, %8 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1640  		"cmovnzq %7, %3 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1641  		"cmovnzq %8, %7 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1642  		: "+r"(px[0]), "+r"(px[1]), "+r"(px[2]), "+r"(px[3]),
468c57c7 Jason A. Donenfeld 2018-08-24  1643  		  "+r"(py[0]), "+r"(py[1]), "+r"(py[2]), "+r"(py[3]),
468c57c7 Jason A. Donenfeld 2018-08-24  1644  		  "=r"(temp)
468c57c7 Jason A. Donenfeld 2018-08-24  1645  		: "r"(bit)
468c57c7 Jason A. Donenfeld 2018-08-24  1646  		: "cc"
468c57c7 Jason A. Donenfeld 2018-08-24  1647  	);
468c57c7 Jason A. Donenfeld 2018-08-24  1648  }
468c57c7 Jason A. Donenfeld 2018-08-24  1649  
468c57c7 Jason A. Donenfeld 2018-08-24  1650  static __always_inline void cselect(u8 bit, u64 *const px, const u64 *const py)
468c57c7 Jason A. Donenfeld 2018-08-24  1651  {
468c57c7 Jason A. Donenfeld 2018-08-24  1652  	asm volatile(
468c57c7 Jason A. Donenfeld 2018-08-24  1653  		"test %4, %4 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1654  		"cmovnzq %5, %0 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1655  		"cmovnzq %6, %1 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1656  		"cmovnzq %7, %2 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1657  		"cmovnzq %8, %3 ;"
468c57c7 Jason A. Donenfeld 2018-08-24  1658  		: "+r"(px[0]), "+r"(px[1]), "+r"(px[2]), "+r"(px[3])
468c57c7 Jason A. Donenfeld 2018-08-24  1659  		: "r"(bit), "rm"(py[0]), "rm"(py[1]), "rm"(py[2]), "rm"(py[3])
468c57c7 Jason A. Donenfeld 2018-08-24  1660  		: "cc"
468c57c7 Jason A. Donenfeld 2018-08-24  1661  	);
468c57c7 Jason A. Donenfeld 2018-08-24  1662  }
468c57c7 Jason A. Donenfeld 2018-08-24  1663  
468c57c7 Jason A. Donenfeld 2018-08-24  1664  static __always_inline void clamp_secret(u8 secret[CURVE25519_POINT_SIZE])
468c57c7 Jason A. Donenfeld 2018-08-24  1665  {
468c57c7 Jason A. Donenfeld 2018-08-24  1666  	secret[0] &= 248;
468c57c7 Jason A. Donenfeld 2018-08-24  1667  	secret[31] &= 127;
468c57c7 Jason A. Donenfeld 2018-08-24  1668  	secret[31] |= 64;
468c57c7 Jason A. Donenfeld 2018-08-24  1669  }
468c57c7 Jason A. Donenfeld 2018-08-24  1670  
468c57c7 Jason A. Donenfeld 2018-08-24  1671  static void curve25519_adx(u8 shared[CURVE25519_POINT_SIZE], const u8 private_key[CURVE25519_POINT_SIZE], const u8 session_key[CURVE25519_POINT_SIZE])
468c57c7 Jason A. Donenfeld 2018-08-24  1672  {
468c57c7 Jason A. Donenfeld 2018-08-24  1673  	struct {
468c57c7 Jason A. Donenfeld 2018-08-24  1674  		u64 buffer[4 * NUM_WORDS_ELTFP25519];
468c57c7 Jason A. Donenfeld 2018-08-24  1675  		u64 coordinates[4 * NUM_WORDS_ELTFP25519];
468c57c7 Jason A. Donenfeld 2018-08-24  1676  		u64 workspace[6 * NUM_WORDS_ELTFP25519];
468c57c7 Jason A. Donenfeld 2018-08-24  1677  		u8 session[CURVE25519_POINT_SIZE];
468c57c7 Jason A. Donenfeld 2018-08-24  1678  		u8 private[CURVE25519_POINT_SIZE];
468c57c7 Jason A. Donenfeld 2018-08-24  1679  	} __aligned(32) m;
468c57c7 Jason A. Donenfeld 2018-08-24  1680  
468c57c7 Jason A. Donenfeld 2018-08-24  1681  	int i = 0, j = 0;
468c57c7 Jason A. Donenfeld 2018-08-24  1682  	u64 prev = 0;
468c57c7 Jason A. Donenfeld 2018-08-24  1683  	u64 *const X1 = (u64 *)m.session;
468c57c7 Jason A. Donenfeld 2018-08-24  1684  	u64 *const key = (u64 *)m.private;
468c57c7 Jason A. Donenfeld 2018-08-24  1685  	u64 *const Px = m.coordinates + 0;
468c57c7 Jason A. Donenfeld 2018-08-24  1686  	u64 *const Pz = m.coordinates + 4;
468c57c7 Jason A. Donenfeld 2018-08-24  1687  	u64 *const Qx = m.coordinates + 8;
468c57c7 Jason A. Donenfeld 2018-08-24  1688  	u64 *const Qz = m.coordinates + 12;
468c57c7 Jason A. Donenfeld 2018-08-24  1689  	u64 *const X2 = Qx;
468c57c7 Jason A. Donenfeld 2018-08-24  1690  	u64 *const Z2 = Qz;
468c57c7 Jason A. Donenfeld 2018-08-24  1691  	u64 *const X3 = Px;
468c57c7 Jason A. Donenfeld 2018-08-24  1692  	u64 *const Z3 = Pz;
468c57c7 Jason A. Donenfeld 2018-08-24  1693  	u64 *const X2Z2 = Qx;
468c57c7 Jason A. Donenfeld 2018-08-24  1694  	u64 *const X3Z3 = Px;
468c57c7 Jason A. Donenfeld 2018-08-24  1695  
468c57c7 Jason A. Donenfeld 2018-08-24  1696  	u64 *const A = m.workspace + 0;
468c57c7 Jason A. Donenfeld 2018-08-24  1697  	u64 *const B = m.workspace + 4;
468c57c7 Jason A. Donenfeld 2018-08-24  1698  	u64 *const D = m.workspace + 8;
468c57c7 Jason A. Donenfeld 2018-08-24  1699  	u64 *const C = m.workspace + 12;
468c57c7 Jason A. Donenfeld 2018-08-24  1700  	u64 *const DA = m.workspace + 16;
468c57c7 Jason A. Donenfeld 2018-08-24  1701  	u64 *const CB = m.workspace + 20;
468c57c7 Jason A. Donenfeld 2018-08-24  1702  	u64 *const AB = A;
468c57c7 Jason A. Donenfeld 2018-08-24  1703  	u64 *const DC = D;
468c57c7 Jason A. Donenfeld 2018-08-24  1704  	u64 *const DACB = DA;
468c57c7 Jason A. Donenfeld 2018-08-24  1705  
468c57c7 Jason A. Donenfeld 2018-08-24 @1706  	memcpy(m.private, private_key, sizeof(m.private));
468c57c7 Jason A. Donenfeld 2018-08-24  1707  	memcpy(m.session, session_key, sizeof(m.session));
468c57c7 Jason A. Donenfeld 2018-08-24  1708  
468c57c7 Jason A. Donenfeld 2018-08-24  1709  	clamp_secret(m.private);
468c57c7 Jason A. Donenfeld 2018-08-24  1710  
468c57c7 Jason A. Donenfeld 2018-08-24  1711  	/* As in the draft:
468c57c7 Jason A. Donenfeld 2018-08-24  1712  	 * When receiving such an array, implementations of curve25519
468c57c7 Jason A. Donenfeld 2018-08-24  1713  	 * MUST mask the most-significant bit in the final byte. This
468c57c7 Jason A. Donenfeld 2018-08-24  1714  	 * is done to preserve compatibility with point formats which
468c57c7 Jason A. Donenfeld 2018-08-24  1715  	 * reserve the sign bit for use in other protocols and to
468c57c7 Jason A. Donenfeld 2018-08-24  1716  	 * increase resistance to implementation fingerprinting
468c57c7 Jason A. Donenfeld 2018-08-24  1717  	 */
468c57c7 Jason A. Donenfeld 2018-08-24  1718  	m.session[CURVE25519_POINT_SIZE - 1] &= (1 << (255 % 8)) - 1;
468c57c7 Jason A. Donenfeld 2018-08-24  1719  
468c57c7 Jason A. Donenfeld 2018-08-24  1720  	copy_eltfp25519_1w(Px, X1);
468c57c7 Jason A. Donenfeld 2018-08-24  1721  	setzero_eltfp25519_1w(Pz);
468c57c7 Jason A. Donenfeld 2018-08-24  1722  	setzero_eltfp25519_1w(Qx);
468c57c7 Jason A. Donenfeld 2018-08-24  1723  	setzero_eltfp25519_1w(Qz);
468c57c7 Jason A. Donenfeld 2018-08-24  1724  
468c57c7 Jason A. Donenfeld 2018-08-24  1725  	Pz[0] = 1;
468c57c7 Jason A. Donenfeld 2018-08-24  1726  	Qx[0] = 1;
468c57c7 Jason A. Donenfeld 2018-08-24  1727  
468c57c7 Jason A. Donenfeld 2018-08-24  1728  	/* main-loop */
468c57c7 Jason A. Donenfeld 2018-08-24  1729  	prev = 0;
468c57c7 Jason A. Donenfeld 2018-08-24  1730  	j = 62;
468c57c7 Jason A. Donenfeld 2018-08-24  1731  	for (i = 3; i >= 0; --i) {
468c57c7 Jason A. Donenfeld 2018-08-24  1732  		while (j >= 0) {
468c57c7 Jason A. Donenfeld 2018-08-24  1733  			u64 bit = (key[i] >> j) & 0x1;
468c57c7 Jason A. Donenfeld 2018-08-24  1734  			u64 swap = bit ^ prev;
468c57c7 Jason A. Donenfeld 2018-08-24  1735  			prev = bit;
468c57c7 Jason A. Donenfeld 2018-08-24  1736  
468c57c7 Jason A. Donenfeld 2018-08-24  1737  			add_eltfp25519_1w_adx(A, X2, Z2);	/* A = (X2+Z2) */
468c57c7 Jason A. Donenfeld 2018-08-24  1738  			sub_eltfp25519_1w(B, X2, Z2);		/* B = (X2-Z2) */
468c57c7 Jason A. Donenfeld 2018-08-24  1739  			add_eltfp25519_1w_adx(C, X3, Z3);	/* C = (X3+Z3) */
468c57c7 Jason A. Donenfeld 2018-08-24  1740  			sub_eltfp25519_1w(D, X3, Z3);		/* D = (X3-Z3) */
468c57c7 Jason A. Donenfeld 2018-08-24  1741  			mul_eltfp25519_2w_adx(DACB, AB, DC);	/* [DA|CB] = [A|B]*[D|C] */
468c57c7 Jason A. Donenfeld 2018-08-24  1742  
468c57c7 Jason A. Donenfeld 2018-08-24  1743  			cselect(swap, A, C);
468c57c7 Jason A. Donenfeld 2018-08-24  1744  			cselect(swap, B, D);
468c57c7 Jason A. Donenfeld 2018-08-24  1745  
468c57c7 Jason A. Donenfeld 2018-08-24  1746  			sqr_eltfp25519_2w_adx(AB);		/* [AA|BB] = [A^2|B^2] */
468c57c7 Jason A. Donenfeld 2018-08-24  1747  			add_eltfp25519_1w_adx(X3, DA, CB);	/* X3 = (DA+CB) */
468c57c7 Jason A. Donenfeld 2018-08-24  1748  			sub_eltfp25519_1w(Z3, DA, CB);		/* Z3 = (DA-CB) */
468c57c7 Jason A. Donenfeld 2018-08-24  1749  			sqr_eltfp25519_2w_adx(X3Z3);		/* [X3|Z3] = [(DA+CB)|(DA+CB)]^2 */
468c57c7 Jason A. Donenfeld 2018-08-24  1750  
468c57c7 Jason A. Donenfeld 2018-08-24  1751  			copy_eltfp25519_1w(X2, B);		/* X2 = B^2 */
468c57c7 Jason A. Donenfeld 2018-08-24  1752  			sub_eltfp25519_1w(Z2, A, B);		/* Z2 = E = AA-BB */
468c57c7 Jason A. Donenfeld 2018-08-24  1753  
468c57c7 Jason A. Donenfeld 2018-08-24  1754  			mul_a24_eltfp25519_1w(B, Z2);		/* B = a24*E */
468c57c7 Jason A. Donenfeld 2018-08-24  1755  			add_eltfp25519_1w_adx(B, B, X2);	/* B = a24*E+B */
468c57c7 Jason A. Donenfeld 2018-08-24  1756  			mul_eltfp25519_2w_adx(X2Z2, X2Z2, AB);	/* [X2|Z2] = [B|E]*[A|a24*E+B] */
468c57c7 Jason A. Donenfeld 2018-08-24  1757  			mul_eltfp25519_1w_adx(Z3, Z3, X1);	/* Z3 = Z3*X1 */
468c57c7 Jason A. Donenfeld 2018-08-24  1758  			--j;
468c57c7 Jason A. Donenfeld 2018-08-24  1759  		}
468c57c7 Jason A. Donenfeld 2018-08-24  1760  		j = 63;
468c57c7 Jason A. Donenfeld 2018-08-24  1761  	}
468c57c7 Jason A. Donenfeld 2018-08-24  1762  
468c57c7 Jason A. Donenfeld 2018-08-24  1763  	inv_eltfp25519_1w_adx(A, Qz);
468c57c7 Jason A. Donenfeld 2018-08-24  1764  	mul_eltfp25519_1w_adx((u64 *)shared, Qx, A);
468c57c7 Jason A. Donenfeld 2018-08-24  1765  	fred_eltfp25519_1w((u64 *)shared);
468c57c7 Jason A. Donenfeld 2018-08-24  1766  
468c57c7 Jason A. Donenfeld 2018-08-24  1767  	memzero_explicit(&m, sizeof(m));
468c57c7 Jason A. Donenfeld 2018-08-24  1768  }
468c57c7 Jason A. Donenfeld 2018-08-24  1769  

:::::: The code at line 1543 was first introduced by commit
:::::: 468c57c74ac7091c9c04ab2acccf68fe300cd9bc zinc: Curve25519 x86_64 implementation

:::::: TO: Jason A. Donenfeld <Jason@zx2c4.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
QPkfuS0jkMwwAQA=

--mP3DRpeJDSE+ciuQ--
