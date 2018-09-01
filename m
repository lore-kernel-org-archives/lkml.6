Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374B8C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74CA2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74CA2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeIAOFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 10:05:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:28808 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeIAOFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 10:05:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 02:54:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,315,1531810800"; 
   d="gz'50?scan'50,208,50";a="80088968"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2018 02:54:10 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fw2aY-000BI3-OE; Sat, 01 Sep 2018 17:53:06 +0800
Date:   Sat, 1 Sep 2018 17:51:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     kbuild-all@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
Message-ID: <201809011505.Z78SglIa%fengguang.wu@intel.com>
References: <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Miguel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.19-rc1 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Miguel-Ojeda/Compiler-Attributes-remove-unused-attributes/20180901-125644
config: parisc-default_defconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=parisc 

All warnings (new ones prefixed by >>):

                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/uapi/linux/byteorder/big_endian.h:84:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
    static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
    ^~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: 'no_instrument_function' attribute applies only to functions
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/uapi/linux/byteorder/big_endian.h:84:8: note: in expansion of macro '__always_inline'
    static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/byteorder/big_endian.h:5:0,
                    from arch/parisc/include/uapi/asm/byteorder.h:5,
                    from arch/parisc/include/asm/bitops.h:11,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/uapi/linux/byteorder/big_endian.h:84:1: warning: 'always_inline' attribute ignored [-Wattributes]
    static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
    ^~~~~~
   include/uapi/linux/byteorder/big_endian.h:84:24: error: expected ',' or ';' before '__be16'
    static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
                           ^~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: type defaults to 'int' in declaration of '__always_inline' [-Werror=implicit-int]
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/uapi/linux/byteorder/big_endian.h:88:8: note: in expansion of macro '__always_inline'
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/byteorder/big_endian.h:5:0,
                    from arch/parisc/include/uapi/asm/byteorder.h:5,
                    from arch/parisc/include/asm/bitops.h:11,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/uapi/linux/byteorder/big_endian.h:88:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
    ^~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: 'no_instrument_function' attribute applies only to functions
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/uapi/linux/byteorder/big_endian.h:88:8: note: in expansion of macro '__always_inline'
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/byteorder/big_endian.h:5:0,
                    from arch/parisc/include/uapi/asm/byteorder.h:5,
                    from arch/parisc/include/asm/bitops.h:11,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/uapi/linux/byteorder/big_endian.h:88:1: warning: 'always_inline' attribute ignored [-Wattributes]
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
    ^~~~~~
   include/uapi/linux/byteorder/big_endian.h:88:24: error: expected ',' or ';' before '__u16'
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
                           ^~~~~
   include/linux/byteorder/generic.h: In function 'le32_to_cpu_array':
   include/uapi/linux/byteorder/big_endian.h:95:27: error: implicit declaration of function '__swab32s'; did you mean '__swahb32s'? [-Werror=implicit-function-declaration]
    #define __le32_to_cpus(x) __swab32s((x))
                              ^
   include/linux/byteorder/generic.h:163:3: note: in expansion of macro '__le32_to_cpus'
      __le32_to_cpus(buf);
      ^~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:10:0,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/parisc/include/asm/atomic.h: In function 'atomic_read':
   include/linux/compiler.h:252:3: error: implicit declaration of function '__read_once_size' [-Werror=implicit-function-declaration]
      __read_once_size(&(x), __u.__c, sizeof(x));  \
      ^
   include/linux/compiler.h:258:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
>> arch/parisc/include/asm/atomic.h:73:9: note: in expansion of macro 'READ_ONCE'
     return READ_ONCE((v)->counter);
            ^~~~~~~~~
   include/linux/compiler.h:254:3: error: implicit declaration of function '__read_once_size_nocheck' [-Werror=implicit-function-declaration]
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
      ^
   include/linux/compiler.h:258:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
>> arch/parisc/include/asm/atomic.h:73:9: note: in expansion of macro 'READ_ONCE'
     return READ_ONCE((v)->counter);
            ^~~~~~~~~
   In file included from <command-line>:0:0:
   include/asm-generic/atomic-long.h: At top level:
   include/linux/compiler_types.h:187:16: error: type defaults to 'int' in declaration of '__always_inline' [-Werror=implicit-int]
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/asm-generic/atomic-long.h:119:8: note: in expansion of macro '__always_inline'
    static __always_inline void atomic_long_inc(atomic_long_t *l)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/atomic.h:1315:0,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/asm-generic/atomic-long.h:119:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
    static __always_inline void atomic_long_inc(atomic_long_t *l)
    ^~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: 'no_instrument_function' attribute applies only to functions
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/asm-generic/atomic-long.h:119:8: note: in expansion of macro '__always_inline'
    static __always_inline void atomic_long_inc(atomic_long_t *l)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/atomic.h:1315:0,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/asm-generic/atomic-long.h:119:1: warning: 'always_inline' attribute ignored [-Wattributes]
    static __always_inline void atomic_long_inc(atomic_long_t *l)
    ^~~~~~
   include/asm-generic/atomic-long.h:119:24: error: expected ',' or ';' before 'void'
    static __always_inline void atomic_long_inc(atomic_long_t *l)
                           ^~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: type defaults to 'int' in declaration of '__always_inline' [-Werror=implicit-int]
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/asm-generic/atomic-long.h:126:8: note: in expansion of macro '__always_inline'
    static __always_inline void atomic_long_dec(atomic_long_t *l)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/atomic.h:1315:0,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/asm-generic/atomic-long.h:126:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
    static __always_inline void atomic_long_dec(atomic_long_t *l)
    ^~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: 'no_instrument_function' attribute applies only to functions
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/asm-generic/atomic-long.h:126:8: note: in expansion of macro '__always_inline'
    static __always_inline void atomic_long_dec(atomic_long_t *l)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/atomic.h:1315:0,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/asm-generic/atomic-long.h:126:1: warning: 'always_inline' attribute ignored [-Wattributes]
    static __always_inline void atomic_long_dec(atomic_long_t *l)
    ^~~~~~
   include/asm-generic/atomic-long.h:126:24: error: expected ',' or ';' before 'void'
    static __always_inline void atomic_long_dec(atomic_long_t *l)
                           ^~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: type defaults to 'int' in declaration of '__always_inline' [-Werror=implicit-int]
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~

vim +/READ_ONCE +73 arch/parisc/include/asm/atomic.h

9d664c0ae arch/parisc/include/asm/atomic.h Peter Zijlstra 2017-06-09  70  
^1da177e4 include/asm-parisc/atomic.h      Linus Torvalds 2005-04-16  71  static __inline__ int atomic_read(const atomic_t *v)
^1da177e4 include/asm-parisc/atomic.h      Linus Torvalds 2005-04-16  72  {
62e8a3258 arch/parisc/include/asm/atomic.h Peter Zijlstra 2015-09-18 @73  	return READ_ONCE((v)->counter);
^1da177e4 include/asm-parisc/atomic.h      Linus Torvalds 2005-04-16  74  }
^1da177e4 include/asm-parisc/atomic.h      Linus Torvalds 2005-04-16  75  

:::::: The code at line 73 was first introduced by commit
:::::: 62e8a3258bda118f24ff462fe04cfbe75b8189b5 atomic, arch: Audit atomic_{read,set}()

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tThc/1wpZn/ma/RB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tThc/1wpZn/ma/RB--
