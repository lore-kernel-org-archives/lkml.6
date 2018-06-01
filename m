Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeFABKL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:10:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:62003 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbeFABKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:10:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="gz'50?scan'50,208,50";a="52501887"
Date: Fri, 1 Jun 2018 09:09:34 +0800
From: kbuild test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: include/linux/syscalls.h:211:18: error: 'sys_mmap2' alias between
 functions of incompatible types 'long int(long unsigned int,  long unsigned
 int,  long unsigned int,  long unsigned int,  long unsigned int,  long
 unsigned int)' and 'long int(long int,  long int,  long int,  long int,
  long int,  long int)'
Message-ID: <201806010928.vmOGnCsZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Al,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0512e0134582ef85dee77d51aae77dcd1edec495
commit: ee076e81fc14ca79334d02970cea66604f183a14 sparc: trivial conversions to {COMPAT_,}SYSCALL_DEFINE()
date:   2 months ago
config: sparc-defconfig (attached as .config)
compiler: sparc-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ee076e81fc14ca79334d02970cea66604f183a14
        # save the attached .config to linux build tree
        make.cross ARCH=sparc 

All errors (new ones prefixed by >>):

   In file included from arch/sparc/kernel/sys_sparc_32.c:21:
>> include/linux/syscalls.h:211:18: error: 'sys_mmap2' alias between functions of incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:101:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:101:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:211:18: error: 'sys_getdomainname' alias between functions of incompatible types 'long int(char *, int)' and 'long int(long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:197:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:205:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:197:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:205:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:211:18: error: 'sys_rt_sigaction' alias between functions of incompatible types 'long int(int,  const struct sigaction *, struct sigaction *, void *, size_t)' {aka 'long int(int,  const struct sigaction *, struct sigaction *, void *, unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:176:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(rt_sigaction, int, sig,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:176:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(rt_sigaction, int, sig,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:211:18: error: 'sys_sparc_sigaction' alias between functions of incompatible types 'long int(int,  struct old_sigaction *, struct old_sigaction *)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:198:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:168:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sparc_sigaction, int, sig,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:198:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:168:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sparc_sigaction, int, sig,
    ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:211:18: error: 'sys_mmap' alias between functions of incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:111:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc/kernel/sys_sparc_32.c:111:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/sparc//kernel/sys_sparc_32.c:21:
>> include/linux/syscalls.h:211:18: error: 'sys_mmap2' alias between functions of incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:101:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:101:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:211:18: error: 'sys_getdomainname' alias between functions of incompatible types 'long int(char *, int)' and 'long int(long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:197:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:205:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:197:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:205:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:211:18: error: 'sys_rt_sigaction' alias between functions of incompatible types 'long int(int,  const struct sigaction *, struct sigaction *, void *, size_t)' {aka 'long int(int,  const struct sigaction *, struct sigaction *, void *, unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:176:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(rt_sigaction, int, sig,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:176:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(rt_sigaction, int, sig,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:211:18: error: 'sys_sparc_sigaction' alias between functions of incompatible types 'long int(int,  struct old_sigaction *, struct old_sigaction *)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:198:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:168:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sparc_sigaction, int, sig,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:198:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:168:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    SYSCALL_DEFINE3(sparc_sigaction, int, sig,
    ^~~~~~~~~~~~~~~
>> include/linux/syscalls.h:211:18: error: 'sys_mmap' alias between functions of incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:111:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:18: note: aliased declaration here
     asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^~~
   include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   arch/sparc//kernel/sys_sparc_32.c:111:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
    ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +211 include/linux/syscalls.h

609320c8 Yonghong Song       2017-09-07  204  
bed1ffca Frederic Weisbecker 2009-03-13  205  #define SYSCALL_DEFINEx(x, sname, ...)				\
99e621f7 Al Viro             2013-03-05  206  	SYSCALL_METADATA(sname, x, __VA_ARGS__)			\
bed1ffca Frederic Weisbecker 2009-03-13 @207  	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
bed1ffca Frederic Weisbecker 2009-03-13  208  
2cf09666 Al Viro             2013-01-21  209  #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
bed1ffca Frederic Weisbecker 2009-03-13  210  #define __SYSCALL_DEFINEx(x, name, ...)					\
83460ec8 Andi Kleen          2013-11-12 @211  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
83460ec8 Andi Kleen          2013-11-12  212  		__attribute__((alias(__stringify(SyS##name))));		\
07fe6e00 Al Viro             2013-01-21  213  	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
f9597f24 Sergei Trofimovich  2013-09-11  214  	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
07fe6e00 Al Viro             2013-01-21  215  	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
1a94bc34 Heiko Carstens      2009-01-14  216  	{								\
2cf09666 Al Viro             2013-01-21  217  		long ret = SYSC##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
07fe6e00 Al Viro             2013-01-21  218  		__MAP(x,__SC_TEST,__VA_ARGS__);				\
2cf09666 Al Viro             2013-01-21  219  		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
2cf09666 Al Viro             2013-01-21  220  		return ret;						\
1a94bc34 Heiko Carstens      2009-01-14  221  	}								\
07fe6e00 Al Viro             2013-01-21  222  	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
1a94bc34 Heiko Carstens      2009-01-14  223  

:::::: The code at line 211 was first introduced by commit
:::::: 83460ec8dcac14142e7860a01fa59c267ac4657c syscalls.h: use gcc alias instead of assembler aliases for syscalls

:::::: TO: Andi Kleen <ak@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--J/dobhs11T7y2rNN--
