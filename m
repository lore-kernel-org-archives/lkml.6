Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98913C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C4520843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C4520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIAOKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 10:10:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:55309 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeIAOKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 10:10:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 02:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,315,1531810800"; 
   d="gz'50?scan'50,208,50";a="86320855"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2018 02:58:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fw2eq-000CZE-Fc; Sat, 01 Sep 2018 17:57:32 +0800
Date:   Sat, 1 Sep 2018 17:56:10 +0800
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
Subject: Re: [PATCH 3/7] Compiler Attributes: remove unneeded tests
Message-ID: <201809011629.NtCalUc2%fengguang.wu@intel.com>
References: <20180831170514.24665-3-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20180831170514.24665-3-miguel.ojeda.sandonis@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Miguel,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc1 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Miguel-Ojeda/Compiler-Attributes-remove-unused-attributes/20180901-125644
config: sparc64-allnoconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

Note: the linux-review/Miguel-Ojeda/Compiler-Attributes-remove-unused-attributes/20180901-125644 HEAD 4327b9ceea1b6be41cbce2c51370a365fc6a52cc builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   WARNING: unmet direct dependencies detected for COMPAT_BINFMT_ELF
   Depends on COMPAT && BINFMT_ELF
   Selected by
   - COMPAT && SPARC64
   In file included from include/linux/swab.h:5:0,
   from include/uapi/linux/byteorder/big_endian.h:13,
   from include/linux/byteorder/big_endian.h:5,
   from arch/sparc/include/uapi/asm/byteorder.h:5,
   from arch/sparc/include/asm/bitops_64.h:16,
   from arch/sparc/include/asm/bitops.h:5,
   from include/linux/bitops.h:19,
   from include/linux/kernel.h:11,
   from include/asm-generic/bug.h:18,
   from arch/sparc/include/asm/bug.h:25,
   from include/linux/bug.h:5,
   from include/linux/page-flags.h:10,
   from kernel/bounds.c:10:
   include/uapi/linux/swab.h:47:15: error: unknown type name '__attribute_const__'
   static inline __attribute_const__ __u16 __fswab16(__u16 val)
   ^~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:47:41: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__fswab16'
   static inline __attribute_const__ __u16 __fswab16(__u16 val)
   ^~~~~~~~~
   include/uapi/linux/swab.h:56:15: error: unknown type name '__attribute_const__'
   static inline __attribute_const__ __u32 __fswab32(__u32 val)
   ^~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:56:41: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__fswab32'
   static inline __attribute_const__ __u32 __fswab32(__u32 val)
   ^~~~~~~~~
   include/uapi/linux/swab.h:65:15: error: unknown type name '__attribute_const__'
   static inline __attribute_const__ __u64 __fswab64(__u64 val)
   ^~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:65:41: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__fswab64'
   static inline __attribute_const__ __u64 __fswab64(__u64 val)
   ^~~~~~~~~
   include/uapi/linux/swab.h:78:15: error: unknown type name '__attribute_const__'
   static inline __attribute_const__ __u32 __fswahw32(__u32 val)
   ^~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:78:41: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__fswahw32'
   static inline __attribute_const__ __u32 __fswahw32(__u32 val)
   ^~~~~~~~~~
   include/uapi/linux/swab.h:87:15: error: unknown type name '__attribute_const__'
   static inline __attribute_const__ __u32 __fswahb32(__u32 val)
   ^~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:87:41: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__fswahb32'
   static inline __attribute_const__ __u32 __fswahb32(__u32 val)
   ^~~~~~~~~~
   include/uapi/linux/swab.h: In function '__swahw32p':
>> include/uapi/linux/swab.h:144:2: error: implicit declaration of function '__fswahw32'; did you mean
   __fswahw32(x))
   ^
   include/uapi/linux/swab.h:207:9: note: in expansion of macro '__swahw32'
   return
   ^~~~~~~~~
   include/uapi/linux/swab.h: In function '__swahb32p':
>> include/uapi/linux/swab.h:155:2: error: implicit declaration of function '__fswahb32'; did you mean
   __fswahb32(x))
   ^
   include/uapi/linux/swab.h:222:9: note: in expansion of macro '__swahb32'
   return
   ^~~~~~~~~
   include/linux/byteorder/generic.h: In function 'le16_add_cpu':
>> include/uapi/linux/swab.h:106:2: error: implicit declaration of function '__fswab16'; did you mean
   __fswab16(x))
   ^
   include/uapi/linux/swab.h:104:32: note: in definition of macro '__swab16'
   (__builtin_constant_p((__u16)(x)) ^
   include/linux/byteorder/generic.h:90:21: note: in expansion of macro '__cpu_to_le16'
   #define cpu_to_le16 __cpu_to_le16
   ^~~~~~~~~~~~~
   include/uapi/linux/byteorder/big_endian.h:36:26: note: in expansion of macro '__swab16'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
   ^~~~~~~~
   include/linux/byteorder/generic.h:91:21: note: in expansion of macro '__le16_to_cpu'
   #define le16_to_cpu __le16_to_cpu
   ^~~~~~~~~~~~~
>> include/linux/byteorder/generic.h:146:21: note: in expansion of macro 'le16_to_cpu'
   = + val);
   ^~~~~~~~~~~
   include/linux/byteorder/generic.h: In function 'le32_add_cpu':
>> include/uapi/linux/swab.h:119:2: error: implicit declaration of function '__fswab32'; did you mean
   __fswab32(x))
   ^
   include/uapi/linux/swab.h:117:32: note: in definition of macro '__swab32'
   (__builtin_constant_p((__u32)(x)) ^
   include/linux/byteorder/generic.h:88:21: note: in expansion of macro '__cpu_to_le32'
   #define cpu_to_le32 __cpu_to_le32
   ^~~~~~~~~~~~~
   include/uapi/linux/byteorder/big_endian.h:34:26: note: in expansion of macro '__swab32'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
   ^~~~~~~~
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
   #define le32_to_cpu __le32_to_cpu
   ^~~~~~~~~~~~~
>> include/linux/byteorder/generic.h:151:21: note: in expansion of macro 'le32_to_cpu'
   = + val);
   ^~~~~~~~~~~
   include/linux/byteorder/generic.h: In function 'le64_add_cpu':
>> include/uapi/linux/swab.h:132:2: error: implicit declaration of function '__fswab64'; did you mean
   __fswab64(x))
   ^
   include/uapi/linux/swab.h:130:32: note: in definition of macro '__swab64'
   (__builtin_constant_p((__u64)(x)) ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__cpu_to_le64'
   #define cpu_to_le64 __cpu_to_le64
   ^~~~~~~~~~~~~
   include/uapi/linux/byteorder/big_endian.h:32:26: note: in expansion of macro '__swab64'
   #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
   ^~~~~~~~
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__le64_to_cpu'
   #define le64_to_cpu __le64_to_cpu
   ^~~~~~~~~~~~~
>> include/linux/byteorder/generic.h:156:21: note: in expansion of macro 'le64_to_cpu'
   = + val);
   ^~~~~~~~~~~
   In file included from include/linux/kernel.h:12:0,
   from include/asm-generic/bug.h:18,
   from arch/sparc/include/asm/bug.h:25,
   from include/linux/bug.h:5,
   from include/linux/page-flags.h:10,
   from kernel/bounds.c:10:
   include/linux/log2.h: At top level:
   include/linux/log2.h:202:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'int'
   int __order_base_2(unsigned long n)
   ^~~
   cc1: some warnings being treated as errors
   Makefile Module.symvers System.map arch block built-in.a certs crypto drivers firmware fs include init ipc kernel lib mm modules.order net scripts security sound source usr virt vmlinux vmlinux.o Error 1
   Target '__build' not remade because of errors.
   Makefile Module.symvers System.map arch block built-in.a certs crypto drivers firmware fs include init ipc kernel lib mm modules.order net scripts security sound source usr virt vmlinux vmlinux.o Error 2
   Target 'prepare' not remade because of errors.
   make: Makefile Module.symvers System.map arch block built-in.a certs crypto drivers firmware fs include init ipc kernel lib mm modules.order net scripts security sound source usr virt vmlinux vmlinux.o Error 2

vim +/__fswahw32 +144 include/uapi/linux/swab.h

607ca46e David Howells 2012-10-13   86  
607ca46e David Howells 2012-10-13  @87  static inline __attribute_const__ __u32 __fswahb32(__u32 val)
607ca46e David Howells 2012-10-13   88  {
607ca46e David Howells 2012-10-13   89  #ifdef __arch_swahb32
607ca46e David Howells 2012-10-13   90  	return __arch_swahb32(val);
607ca46e David Howells 2012-10-13   91  #else
607ca46e David Howells 2012-10-13   92  	return ___constant_swahb32(val);
607ca46e David Howells 2012-10-13   93  #endif
607ca46e David Howells 2012-10-13   94  }
607ca46e David Howells 2012-10-13   95  
607ca46e David Howells 2012-10-13   96  /**
607ca46e David Howells 2012-10-13   97   * __swab16 - return a byteswapped 16-bit value
607ca46e David Howells 2012-10-13   98   * @x: value to byteswap
607ca46e David Howells 2012-10-13   99   */
7322dd75 Arnd Bergmann 2016-05-05  100  #ifdef __HAVE_BUILTIN_BSWAP16__
7322dd75 Arnd Bergmann 2016-05-05  101  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
7322dd75 Arnd Bergmann 2016-05-05  102  #else
607ca46e David Howells 2012-10-13  103  #define __swab16(x)				\
607ca46e David Howells 2012-10-13  104  	(__builtin_constant_p((__u16)(x)) ?	\
607ca46e David Howells 2012-10-13  105  	___constant_swab16(x) :			\
607ca46e David Howells 2012-10-13 @106  	__fswab16(x))
7322dd75 Arnd Bergmann 2016-05-05  107  #endif
607ca46e David Howells 2012-10-13  108  
607ca46e David Howells 2012-10-13  109  /**
607ca46e David Howells 2012-10-13  110   * __swab32 - return a byteswapped 32-bit value
607ca46e David Howells 2012-10-13  111   * @x: value to byteswap
607ca46e David Howells 2012-10-13  112   */
7322dd75 Arnd Bergmann 2016-05-05  113  #ifdef __HAVE_BUILTIN_BSWAP32__
7322dd75 Arnd Bergmann 2016-05-05  114  #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
7322dd75 Arnd Bergmann 2016-05-05  115  #else
607ca46e David Howells 2012-10-13  116  #define __swab32(x)				\
607ca46e David Howells 2012-10-13  117  	(__builtin_constant_p((__u32)(x)) ?	\
607ca46e David Howells 2012-10-13  118  	___constant_swab32(x) :			\
607ca46e David Howells 2012-10-13 @119  	__fswab32(x))
7322dd75 Arnd Bergmann 2016-05-05  120  #endif
607ca46e David Howells 2012-10-13  121  
607ca46e David Howells 2012-10-13  122  /**
607ca46e David Howells 2012-10-13  123   * __swab64 - return a byteswapped 64-bit value
607ca46e David Howells 2012-10-13  124   * @x: value to byteswap
607ca46e David Howells 2012-10-13  125   */
7322dd75 Arnd Bergmann 2016-05-05  126  #ifdef __HAVE_BUILTIN_BSWAP64__
7322dd75 Arnd Bergmann 2016-05-05  127  #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
7322dd75 Arnd Bergmann 2016-05-05  128  #else
607ca46e David Howells 2012-10-13  129  #define __swab64(x)				\
607ca46e David Howells 2012-10-13  130  	(__builtin_constant_p((__u64)(x)) ?	\
607ca46e David Howells 2012-10-13  131  	___constant_swab64(x) :			\
607ca46e David Howells 2012-10-13 @132  	__fswab64(x))
7322dd75 Arnd Bergmann 2016-05-05  133  #endif
607ca46e David Howells 2012-10-13  134  
607ca46e David Howells 2012-10-13  135  /**
607ca46e David Howells 2012-10-13  136   * __swahw32 - return a word-swapped 32-bit value
607ca46e David Howells 2012-10-13  137   * @x: value to wordswap
607ca46e David Howells 2012-10-13  138   *
607ca46e David Howells 2012-10-13  139   * __swahw32(0x12340000) is 0x00001234
607ca46e David Howells 2012-10-13  140   */
607ca46e David Howells 2012-10-13  141  #define __swahw32(x)				\
607ca46e David Howells 2012-10-13  142  	(__builtin_constant_p((__u32)(x)) ?	\
607ca46e David Howells 2012-10-13  143  	___constant_swahw32(x) :		\
607ca46e David Howells 2012-10-13 @144  	__fswahw32(x))
607ca46e David Howells 2012-10-13  145  
607ca46e David Howells 2012-10-13  146  /**
607ca46e David Howells 2012-10-13  147   * __swahb32 - return a high and low byte-swapped 32-bit value
607ca46e David Howells 2012-10-13  148   * @x: value to byteswap
607ca46e David Howells 2012-10-13  149   *
607ca46e David Howells 2012-10-13  150   * __swahb32(0x12345678) is 0x34127856
607ca46e David Howells 2012-10-13  151   */
607ca46e David Howells 2012-10-13  152  #define __swahb32(x)				\
607ca46e David Howells 2012-10-13  153  	(__builtin_constant_p((__u32)(x)) ?	\
607ca46e David Howells 2012-10-13  154  	___constant_swahb32(x) :		\
607ca46e David Howells 2012-10-13 @155  	__fswahb32(x))
607ca46e David Howells 2012-10-13  156  

:::::: The code at line 144 was first introduced by commit
:::::: 607ca46e97a1b6594b29647d98a32d545c24bdff UAPI: (Scripted) Disintegrate include/linux

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Qxx1br4bt0+wmkIi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICFAuilsAAy5jb25maWcAjTvbctu4ku/zFaxM1VZStcn4FiezW36AQFDEiCBoAJTkvLAU
iXZUsSUfXc6Z/P12g5R4AzxbNRnb6EYDaPQdzd9/+z0gx8P2ZXFYLxfPz7+Cp3JT7haHchU8
rp/L/w1CGaTSBCzk5hMgJ+vN8e8/9q+L3fL2Jrj5dPnnp4uPu+VlMCl3m/I5oNvN4/rpCBTW
281vv/8G//0Ogy+vQGz3P0E98eMzkvn4tDl+fFoug/dh+X292ARfPl0BtcvLD9VvMJfKNOLj
gtKC62JM6d2v0xD8UUyZ0lymd18uri4uzrgJScdn0EW1g7E91XOwLw/H14buSMkJSwuZFlpk
DW2eclOwdFoQNS4SLri5u77Cc9QrSJHxhBWGaROs98Fme0DCp9mJpCQ5rf/uXTOvDShIbqRj
8ijnSVhokhicWg+GLCJ5YopYapMSwe7evd9sN+WHFm39oKc8o22KzX6V1LoQTEj1UBBjCI2d
eLlmCR85NhWTKQNe0Bh2DXIAa8FBEuCX5S1X98H++H3/a38oXxrejlnKFIeLU/eFjuWsxV4Y
yRSLEjkrIqINk7wB6owozRCnGbNLU2DfRMtcUVaExJCWKNQrGS5YMW121wNbAmzKUqNPWzfr
l3K3d+0+/lZkMEuGHGXuzKJUIoSHCXNy0IKdkJiP40IxbTeptIPJwBEmMgM0UtZe8jQ+lUme
GqIenPRrrDasUr0s/8Ms9j+DAxw1WGxWwf6wOOyDxXK5PW4O681Tc2bD6aSACQWhVMJaPB23
NzLlyvTAyNvBkormgR5yFPAfCoC1ScKfBZsDo43zUHxS/eKW6rGSeabdsJjRSSZ5apDnRir3
dWnAC60mWlpOHMUS4mb5KJmAZk6ttVCh40bBQskM7pt/Y0UkFQoU/BAkpZ0L7qNp+MWnhDkP
L29bygKybhJgIWVAAayKUcQSr+EVb9uLCbAjHBRduRkyZkYQPSlqJXIjPehIv4kRxST1qUgm
NZ87tKAlyXBtEzfHc7cojAhYjCj37SY3bO6EsEz6zsjHKUmi0Am0m/fArH3xwHQMNtgJIVy6
x8Mph6PVvHbzC2iOiFLcc6UTnPgg3HNHWfTmRaKgWNcTueQbFmZhyMJG3qyMopgXZzt7ulUc
BHLFVMBismNUM3p5cTMwI3VAkZW7x+3uZbFZlgH7d7kB20XAilG0XmC7KyPXWqNa2Hmaqaig
hTVfPvlD704MhAZuGdQJcblIneSj9pl0Ikfe+XBnasxObt2PFoFRT7gGIwb6JN2i00WMiQrB
3bnlL1My4gmYbcf+b29G3HS9MO39eXvT88iw/+rPu3cQ1f2oosI/ljYC3J9ixGJVPlZD7zqT
YTO0APuuMI6at5ZGDzNC6UpDTtLeksTkrV1BJDOxFq/QeZZJ1aKCvj5k2RBgycR8xFRKrMkE
g6T5KGlZTRvkWMSeZGtm8gzFrHKDirWCkJSBKzmBrGYUEVdwJTTO04kHLyMgBk40IfLenuuT
aGA72EE79aRJp/sdGwIHKRKQ8kTf3bin58D5ETuHQNluuyz3++0uOPx6rSKEx3JxOO7Kjm5B
fOyOa74VlxcXLnf1rbj6fNFWCRi57qL2qLjJ3AGZ019qppko5jQekxAcdzKWiptYDGO9eMYg
4DKOIJBAiKuIQe0Dx97jsSAPtQ2jRRR2jBQjKnmIRgMzBdcYRLvyX8dys/wV7CGJqmKqxp7A
PYN+3nsM7HUhqOPc1Z2xhFFzityFhC33hcJGy4AA6kK6QtwF17amgUOkAXojyLz4BgGnBLOh
7i6vW8bCbW6oCMGCsGIkZTLgxei4D7avmPntg/cZ5UF5WH760ISAepS3XAL+RcFgdcxmnhYJ
mDpPaAAk+2viGNusXrfrzaHjDChHE2KDQA8xSpTHUcMuZMZS0BQRuWL1ykecVEis98s6MbaG
Mljt1v/u+aY2SY+zl6OsiBKi3cmZIXAWTDr15cVVkVOj3C5bgj1MMEOaD1h1SoLRWK8P5RKV
/OOqfC03K/Crp5tr5UCoCbLyGp2I9a9cZAX4HZa4NBZnWXcCCgphFEbYlDKte8Z0crZDnVHF
jBOQCt4bsRJuzX8s5WSo6mCybKZWmBgsdT9KUWysC3CrlRept1iQrL8KrFvMiKFxKMeuDTS8
6PuY02xNIgZ6k6HZ6uHMCEQjkLYXVdJ7Kho4kOqo5P+FK5Owhd/yrGAXia4ODDw2YFsg3ajz
zfbB4Hf0yZa5kyoLbIM9iaDnelLUCYy64nzM0Gu1nJwM8wRyYowLWRLZXKtHhc1BjvoXKMH4
wxYgSCfUdJiAR4dhnWvQtdaMmh01uD+rhl5fodBidN+NRiCrZ1HEKcdTRJHuZLAYA+U43ks/
Ko2jcvrx+2JfroKfVTj7uts+rp87aXeW5GOe2uIOpa2qj81qNIbLd5etcL/imScjhajHoZI8
tTZbZ7BMniJSt75Sw5HJNfwtmHPuDBwx801uAx2VnXNoQgwYR1ooMethoIDc5ywHW4KHsJUg
P4qanRDsJbC/y+XxsPj+XNqSZmDTiUPHOo94GgmDMug19i2c9v3Xo5oqnrn9TI0huPZU5yAE
DvNueFW5lfJlu/sViMVm8VS+OC30mwFC4/wFSXPigvSUraaTKaZB1F2UwCoo1taPBjSF/wmS
NYFI4/v6OD6vgalsV4A6w6CIIYYsrUotqCZEIqZzFJ0loMaZsVNAfzES7mZ3Vv1dJbj4AYQw
DFVhzglRk0hr4ZhyKs3aowvQL5x+d3Px523LdTuMoINUJzOYiE6JKGEkpYTG7poKFcQ5/i3r
RWkNZJS7Q59vusrP3SETU7g3cCCeDHsM6dGIpTQWRLkMUe0YNdwOmiNGuRXLpn7KXAX1yhFg
reIvfg66wvLf62UZhOdQqwlx1st6OJBnhWki7qoEELMk81RMQjY1IovcJ4SzpyFJwGf6yrCW
POR0YgY3XtXzB6odrXcv/1nsyuB5u1iVu/b+ohnkriT07A3vZmarji6z0ToCpoih4lPvGS0C
myqPK6kQ8IWjJgMeQMgpGxwFY/6VvYsOm8ep9pSrjKuUJKOWD4+wOCDA0HSsCAzD+spXjQX9
Qicy2F8KNifQx9fX7e5wkhIbsDs2DfwUD+ig3KW9lCZS5wrrAGrKqYdzWhFP6nTl3CBjeNpg
f95is6CFFH9e0/ntYJop/17sA77ZH3bHF1sW2/8AiVoFh91is0dSAYQZZbCCs65f8dfT6cnz
AdKAIMrGBBxiLYir7X82KIzBy3Z1BCf5HlPa9a6EJa7oh9NUvjlADAM+OvivYFc+22fCfZe3
DQpKRqWHJ5imPHIMT2XmGG0Ixdv9wQuki93KtYwXf/t6rnjoA5yg7WDfU6nFh75Rwf2dyTW3
Q2PXA541VjxkJzulqea1rLVYdZIVAKLbPj+lbV6PhyF28yCSZvlQgmJggb1E/ocMcEo388Rn
LJ8tFlglOZc8LGpb58ZEMKfQUpC1xRLkyKVGxrhVFMyNrwAOoIkPhrsiiTV6o9ytczyDPKt6
dHDbu3j2Vg3VUPjnKXjMeZI8+NYl4bAgAfrivLort0+FeNYzLtyAWLvHs+5bWFUcMVmwfN4u
f/a1lG1sPAwBD774YtEPXO9MqgnGQDYFAkcnMqwVH7ZArwwOP8pgsVqt0aEuniuq+0+digtP
vVWJccZl7235DJtdeh6KZuB1yNRTCrJQDFQ91R0Lx8wicQtjPBPdGLCRhpgpCILce60rAa4X
AD1q15Kbi9Su94IRxGxO9FEvmKsc1vH5sH48bpbI/ZN9cFSZRBRCEiVYUkQJm1OPuDdYcUJD
t1gijsAwxB1ZIjjmtzdXl0WGVtXJYYO1Cs3ptZfEhIkscQeidgPm9vrPL16wFp8v3LJDRvPP
Fxc2RvLPftDUIwEINrwg4vr687wwmhIPlxQb5wlkrW6jI1jIySm7HdYGdovXH+vl3mUsQuUx
k0oUYVZQRgfkCM2C9+S4Wm/BxZ2L+h/cDTlEhEGy/r5bQH652x4PEB2cvV20W7yUwffj4yNY
93Bo3SO3Fo8InSTWm4BMuQ7dKITMU1cMmIMCyZjyAtI3k7DBAxDCB885OHjOKmIatlUp18Ny
PY7Z4GjV9fE4nv34tccuqCBZ/ELPNtSvVGZ2xTllfOop6I/Aa4Zjj1kyDxlzixJOzJOMe31c
PnMzXgiPBjOhsaPDCUwZpBks9Hg1WwvlIw4X8eC4KAWKDca8uQQcEPTy5vbr5dchhCZEd2tm
MBhTI0EDPdQBYkAUunTqQQwEIPi+e7c7LC/edanarMWtqQBN++FH1a5igH/4lvy46Ek6zuGp
iXBFL9FQTQeNYOc4AGn3BA39vWcY3bBnVgaxNtaterDePqiQA0bjeKgvr77evnkEQPl86Tam
bZTPblveQrn9+rmIiOAet9vC/HJz9Q8oVzfdvoABijaTyy+GfH0TSdx8Nf9wekS5/uwRxhPC
5z9dvBVa3F51T9LDGN3ffL24cs1V2Wfq8WAnlOn1xZX7zfSE8e0hvXdUD7ebj/g0+aa86Dy9
mXaVrOIqURFXzLXlyMBvF5dvb0mnnqjtfPAv191zV3kMDwNdbjAz62678X8YkgxS76oeJMgo
j1ol0sbfPKS0wCcst7HL5yHXma+skHse6+wbSFUZ8TSbAAKXYIXTfBjOrZe77X77eAjiX6/l
7uM0eDqWkOM6IgG4i3GvY6MVwp6K4cP8zAb9envceQJFwpORdHdFcSlE7g1bVPmyPZSYQ7vo
YpHIYNliGKCo15f9k3NOJvSJX/6AYcbVsPikYZ332jYaBnIDWen69UOwfy2X68dzEfBsQ8nL
8/YJhvV2YF5Hu+1itdy+uGDpPPsj2pUlPu2Xwf12x+9daOtPYu4avz8unoFyn3TrcNi4OjjZ
HB+J/vZNmmMbz7yY0tzJsAzf+6fepgM2N97I174AuMXCczvZbOhTsYS2hMsYVjwIRLBjTm3j
QaraD1s8w3dYX/RjMz37MKlk4svyIzEUO8hnO92oTUpaPxMjgjOgpaKYyJRgZHblxcJ0OZuT
4uprKjA19xTO21hIz4slSJbFMmWFCMXtraddxia3lLhrv4K640RFhkaTbFa77XrVZgtJQyW5
OyfrNRU00aQzsIpnWItcrjdPbsPmTnEg4ILE1LibIGzN0gnwFEU09xg5nXDRk7W6Mg9KXglL
R+PYHK1hpKs31kJ6Go/RzdjeM5/NBgospeoh6z9BNUxOpeGRRwcrWOFt4I3IG7Pvc2nc7MMW
6EjfFJ5Hjwrsg0b49OqB1RX7Hrhi7GL5o5dZ6sETV6XC+/K42trHW8fN2EZCz/IWRmOehIq5
uW2bmd3eNYckLhl5oNUPP1PwuddKA2YtzNPPlCZDtuhyedytD79ckcyEPXjeHBjNFSRrECAx
bY2lAdPmSb9rXGdjk60En5pIrZhRmT3YZyeKdY5OP18fzb2cIZCFWhx8nx6+u53Evn5IbY5C
WvlfH9r5rsaqkxxw0lHg6Jl+4FJK4XgRPrPgDh1NRICSsNQDxSYzCJfsi3RrOyBzlBs3+wF6
6U5GcJ65vAh55AVzkxdestdur0Kxc9cH8QLcVTfI7e1Cvu+MqCcTs6X36yvsV4j6yXIT1HyD
a3b1QmJpB7jcbVfAITTJ3X4AHIdMoNduq23mUMA9jk3cgyEA3+5RTvvtkwjrtQN0YuRKmDt3
L1XoiQGAjtum49dQve8Q2puwLVv4SQvhaaeuDCqejp0s/a3VP/9jsfxZtRvZ0dfdenP4aUsN
q5cSAvJBTwn80NJ6sbFtJD63jn7xYtznnJmm3xhskMbG5gGFm87ngB/tJ0ngBJY/93ZDy/oz
QZfpq96jeRq5g9Cq6aQQue2kZs4uqEgRwYoZUend1cXN1y4ns4JoUXg/lMD2J7sC0e6wJU/B
QmBRWYyk50MN2+wtZ+mbT/Juq8ywEq+rk7VloJoDRtF2soPPEfg+4TP7HSTLiEKmnjpNvRvb
JDxjZHJqTHE7O4IhPXi67st5h9SEqZSdvxmse5vC8vvx6anXMG35BDkKS7U3Ruq2wPvZnUmu
ZeoLxioycvQX8MbrDevtg/lJgA9D7p8gb6xQtZjmutf308Oa+p5GEVi3ZuG3Zo6Nnjo7SUrl
tOqJLTLqkJS419xQt9LALQTJdvnz+FppYrzYPPWy1Mj2U+UZUKoaRz2bRSDETil2LGs3U2b3
zne01s2lIE4gq7IXZrvgxZQkObu76ALxBVPmBoabI9iP/aqrYGk4NBM9XiGJCWNZT3iq0AKr
K2fhDd7vX9cb+yD638HL8VD+XcIv2Pv+qd39bhMHS3tsDff5KaMdrk7fTh8sDXRVb0mboyjU
lyb8JO7Nzp/ZrELCD5lmGfHkYxWu3ZRfESukurdTJ8DSf6CF3CEZP7s29z7tqiCHJlfDT7Eb
WTuf463Qo/mSyE0ETSUcEKy8hpgBW0z9zQS1VaisyttGBf5BfjSSmg1VFT/nesv28X/C0G/Z
PJslcl/tssKhCo6aGk4cWQp+4+s03vhFr/0Oz8trxPjHa7NI3vuwnw3f6zeee2ohvq89mPL7
rhMnCqaUVGBg/2KD9tBWeo1JiBOnfbtRntLmc1x198sNHSuSxW6c8CElqC5R74PeikBl4EXV
eK4YBp39L9Wqjzor4vYbmP73FLSeWFFpgDjDY54i/43YSBlk8o0HOPxQQFRXjvT7hfF2CdIr
FtZdp/bzfwy1Ve4vo2gisl6ffPv4NrSejMPOR5v4tzu6G4FrdZCqLgJ8apSQsXbxrG60pFGS
dz/s+T/upgHkekMAAA==

--Qxx1br4bt0+wmkIi--
