Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC402083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC402083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeIANjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 09:39:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:11339 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeIANjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 09:39:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 02:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,315,1531810800"; 
   d="gz'50?scan'50,208,50";a="77219368"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Sep 2018 02:27:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fw2Ap-000CZs-T7; Sat, 01 Sep 2018 17:26:31 +0800
Date:   Sat, 1 Sep 2018 17:24:39 +0800
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
Message-ID: <201809011559.SDkYzWzc%fengguang.wu@intel.com>
References: <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Miguel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.19-rc1 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Miguel-Ojeda/Compiler-Attributes-remove-unused-attributes/20180901-125644
config: sh-titan_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sh 

All warnings (new ones prefixed by >>):

   In file included from include/linux/byteorder/little_endian.h:5:0,
                    from arch/sh/include/uapi/asm/byteorder.h:6,
                    from arch/sh/include/asm/bitops.h:12,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/uapi/linux/byteorder/little_endian.h:84:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
    static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
    ^~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: 'no_instrument_function' attribute applies only to functions
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/uapi/linux/byteorder/little_endian.h:84:8: note: in expansion of macro '__always_inline'
    static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/byteorder/little_endian.h:5:0,
                    from arch/sh/include/uapi/asm/byteorder.h:6,
                    from arch/sh/include/asm/bitops.h:12,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/uapi/linux/byteorder/little_endian.h:84:1: warning: 'always_inline' attribute ignored [-Wattributes]
    static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
    ^~~~~~
   include/uapi/linux/byteorder/little_endian.h:84:24: error: expected ',' or ';' before '__be16'
    static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
                           ^~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: type defaults to 'int' in declaration of '__always_inline' [-Werror=implicit-int]
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/uapi/linux/byteorder/little_endian.h:88:8: note: in expansion of macro '__always_inline'
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/byteorder/little_endian.h:5:0,
                    from arch/sh/include/uapi/asm/byteorder.h:6,
                    from arch/sh/include/asm/bitops.h:12,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/uapi/linux/byteorder/little_endian.h:88:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
    ^~~~~~
   In file included from <command-line>:0:0:
   include/linux/compiler_types.h:187:16: error: 'no_instrument_function' attribute applies only to functions
    #define inline __always_inline __gnu_inline __maybe_unused notrace
                   ^
   include/linux/compiler_attributes.h:48:33: note: in expansion of macro 'inline'
    #define __always_inline         inline __attribute__((always_inline))
                                    ^~~~~~
   include/uapi/linux/byteorder/little_endian.h:88:8: note: in expansion of macro '__always_inline'
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
           ^~~~~~~~~~~~~~~
   In file included from include/linux/byteorder/little_endian.h:5:0,
                    from arch/sh/include/uapi/asm/byteorder.h:6,
                    from arch/sh/include/asm/bitops.h:12,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/uapi/linux/byteorder/little_endian.h:88:1: warning: 'always_inline' attribute ignored [-Wattributes]
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
    ^~~~~~
   include/uapi/linux/byteorder/little_endian.h:88:24: error: expected ',' or ';' before '__u16'
    static __always_inline __u16 __be16_to_cpup(const __be16 *p)
                           ^~~~~
   In file included from include/asm-generic/bug.h:5:0,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/atomic.h: In function 'atomic_fetch_add_unless':
   include/linux/compiler.h:252:3: error: implicit declaration of function '__read_once_size' [-Werror=implicit-function-declaration]
      __read_once_size(&(x), __u.__c, sizeof(x));  \
      ^
   include/linux/compiler.h:258:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
>> arch/sh/include/asm/atomic.h:24:25: note: in expansion of macro 'READ_ONCE'
    #define atomic_read(v)  READ_ONCE((v)->counter)
                            ^~~~~~~~~
   include/linux/atomic.h:575:10: note: in expansion of macro 'atomic_read'
     int c = atomic_read(v);
             ^~~~~~~~~~~
   include/linux/compiler.h:254:3: error: implicit declaration of function '__read_once_size_nocheck' [-Werror=implicit-function-declaration]
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
      ^
   include/linux/compiler.h:258:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
>> arch/sh/include/asm/atomic.h:24:25: note: in expansion of macro 'READ_ONCE'
    #define atomic_read(v)  READ_ONCE((v)->counter)
                            ^~~~~~~~~
   include/linux/atomic.h:575:10: note: in expansion of macro 'atomic_read'
     int c = atomic_read(v);
             ^~~~~~~~~~~
   include/asm-generic/atomic-long.h: In function 'atomic_long_set':
   include/linux/compiler.h:277:2: error: implicit declaration of function '__write_once_size'; did you mean '__builtin_object_size'? [-Werror=implicit-function-declaration]
     __write_once_size(&(x), __u.__c, sizeof(x)); \
     ^
>> arch/sh/include/asm/atomic.h:25:26: note: in expansion of macro 'WRITE_ONCE'
    #define atomic_set(v,i)  WRITE_ONCE((v)->counter, (i))
                             ^~~~~~~~~~
   include/asm-generic/atomic-long.h:35:28: note: in expansion of macro 'atomic_set'
    #define ATOMIC_LONG_PFX(x) atomic ## x
                               ^~~~~~
   include/asm-generic/atomic-long.h:57:2: note: in expansion of macro 'ATOMIC_LONG_PFX'
     ATOMIC_LONG_PFX(_set##mo)(v, i);    \
     ^~~~~~~~~~~~~~~
   include/asm-generic/atomic-long.h:59:1: note: in expansion of macro 'ATOMIC_LONG_SET_OP'
    ATOMIC_LONG_SET_OP()
    ^~~~~~~~~~~~~~~~~~
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
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/sh/include/asm/bitops.h:25,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,
                    from arch/sh/include/asm/bug.h:112,
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
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/sh/include/asm/bitops.h:25,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,
                    from arch/sh/include/asm/bug.h:112,
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
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/sh/include/asm/bitops.h:25,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,
                    from arch/sh/include/asm/bug.h:112,
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
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/sh/include/asm/bitops.h:25,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,

vim +/READ_ONCE +24 arch/sh/include/asm/atomic.h

^1da177e include/asm-sh/atomic.h      Linus Torvalds 2005-04-16  23  
62e8a325 arch/sh/include/asm/atomic.h Peter Zijlstra 2015-09-18 @24  #define atomic_read(v)		READ_ONCE((v)->counter)
62e8a325 arch/sh/include/asm/atomic.h Peter Zijlstra 2015-09-18 @25  #define atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
^1da177e include/asm-sh/atomic.h      Linus Torvalds 2005-04-16  26  

:::::: The code at line 24 was first introduced by commit
:::::: 62e8a3258bda118f24ff462fe04cfbe75b8189b5 atomic, arch: Audit atomic_{read,set}()

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--zYM0uCDKw75PZbzx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
G4JWuoRhwS15EV4+TItC70VtyP8DJnODjWoKAQA=

--zYM0uCDKw75PZbzx--
