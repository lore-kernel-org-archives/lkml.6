Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935887AbeE3E43 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:56:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:57104 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935552AbeE3E41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:56:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,458,1520924400";
   d="scan'208";a="43845475"
From: "Li, Philip" <philip.li@intel.com>
To: lkp <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [kbuild-all] include/linux/syscalls.h:211:18: error:
 'sys_sparc_remap_file_pages' alias between functions of incompatible types
 'long int(long unsigned int, long unsigned int, long unsigned int, long
 unsigned int, long unsigned int)' and 'long int(lon
Thread-Topic: [kbuild-all] include/linux/syscalls.h:211:18: error:
 'sys_sparc_remap_file_pages' alias between functions of incompatible types
 'long int(long unsigned int, long unsigned int, long unsigned int, long
 unsigned int, long unsigned int)' and 'long int(lon
Thread-Index: AQHT99Gq/WO/y7y6C0+EGG9xq4brb6RHtTTg
Date: Wed, 30 May 2018 04:56:23 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662494CB9DAC1@shsmsx102.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmE5MTQ1OGYtODBhMi00ZmUyLWJlNGMtMjI2ZDExNDRhMjVmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOHVHc3ByTWsxSVZCdzRxVWsxeHNNalhQQWZiS0JpNFJabU5SbHFFXC9yZlZvazVob2ZkSk9WUzNrcGV0Y1hjYkEifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi Al,
> 
> FYI, the error/warning still remains.
hi AI, kindly ignore this, the warning below may be caused by gcc-8.1 upgrade.
we will double check to reduce noises.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0044cdeb731313f20b63cb5644de7588731de32b
> commit: a0d32ad366bb4235267380b341fcae8307f51044 switch
> sparc_remap_file_pages() to SYSCALL_DEFINE
> date:   2 months ago
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout a0d32ad366bb4235267380b341fcae8307f51044
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/sparc/kernel/sys_sparc_32.c:21:
>    include/linux/syscalls.h:211:18: error: 'sys_mmap2' alias between functions of
> incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned
> int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,
> long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:201:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:101:1: note: in expansion of macro
> 'SYSCALL_DEFINE6'
>     SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:201:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:101:1: note: in expansion of macro
> 'SYSCALL_DEFINE6'
>     SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:211:18: error: 'sys_getdomainname' alias between
> functions of incompatible types 'long int(char *, int)' and 'long int(long int,  long
> int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:197:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:205:1: note: in expansion of macro
> 'SYSCALL_DEFINE2'
>     SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:197:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:205:1: note: in expansion of macro
> 'SYSCALL_DEFINE2'
>     SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:211:18: error: 'sys_rt_sigaction' alias between functions
> of incompatible types 'long int(int,  const struct sigaction *, struct sigaction *, void
> *, size_t)' {aka 'long int(int,  const struct sigaction *, struct sigaction *, void *,
> unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int)' [-
> Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:200:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:176:1: note: in expansion of macro
> 'SYSCALL_DEFINE5'
>     SYSCALL_DEFINE5(rt_sigaction, int, sig,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:200:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:176:1: note: in expansion of macro
> 'SYSCALL_DEFINE5'
>     SYSCALL_DEFINE5(rt_sigaction, int, sig,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:211:18: error: 'sys_sparc_sigaction' alias between
> functions of incompatible types 'long int(int,  struct old_sigaction *, struct
> old_sigaction *)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:198:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:168:1: note: in expansion of macro
> 'SYSCALL_DEFINE3'
>     SYSCALL_DEFINE3(sparc_sigaction, int, sig,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:198:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:168:1: note: in expansion of macro
> 'SYSCALL_DEFINE3'
>     SYSCALL_DEFINE3(sparc_sigaction, int, sig,
>     ^~~~~~~~~~~~~~~
> >> include/linux/syscalls.h:211:18: error: 'sys_sparc_remap_file_pages' alias
> between functions of incompatible types 'long int(long unsigned int,  long unsigned
> int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,
> long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:200:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:119:1: note: in expansion of macro
> 'SYSCALL_DEFINE5'
>     SYSCALL_DEFINE5(sparc_remap_file_pages, unsigned long, start, unsigned
> long, size,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:200:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:119:1: note: in expansion of macro
> 'SYSCALL_DEFINE5'
>     SYSCALL_DEFINE5(sparc_remap_file_pages, unsigned long, start, unsigned
> long, size,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:211:18: error: 'sys_mmap' alias between functions of
> incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned
> int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,
> long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:201:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:111:1: note: in expansion of macro
> 'SYSCALL_DEFINE6'
>     SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:201:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc/kernel/sys_sparc_32.c:111:1: note: in expansion of macro
> 'SYSCALL_DEFINE6'
>     SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>     ^~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> --
>    In file included from arch/sparc//kernel/sys_sparc_32.c:21:
>    include/linux/syscalls.h:211:18: error: 'sys_mmap2' alias between functions of
> incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned
> int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,
> long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:201:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:101:1: note: in expansion of macro
> 'SYSCALL_DEFINE6'
>     SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:201:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:101:1: note: in expansion of macro
> 'SYSCALL_DEFINE6'
>     SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:211:18: error: 'sys_getdomainname' alias between
> functions of incompatible types 'long int(char *, int)' and 'long int(long int,  long
> int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:197:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:205:1: note: in expansion of macro
> 'SYSCALL_DEFINE2'
>     SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:197:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:205:1: note: in expansion of macro
> 'SYSCALL_DEFINE2'
>     SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:211:18: error: 'sys_rt_sigaction' alias between functions
> of incompatible types 'long int(int,  const struct sigaction *, struct sigaction *, void
> *, size_t)' {aka 'long int(int,  const struct sigaction *, struct sigaction *, void *,
> unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int)' [-
> Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:200:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:176:1: note: in expansion of macro
> 'SYSCALL_DEFINE5'
>     SYSCALL_DEFINE5(rt_sigaction, int, sig,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:200:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:176:1: note: in expansion of macro
> 'SYSCALL_DEFINE5'
>     SYSCALL_DEFINE5(rt_sigaction, int, sig,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:211:18: error: 'sys_sparc_sigaction' alias between
> functions of incompatible types 'long int(int,  struct old_sigaction *, struct
> old_sigaction *)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:198:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:168:1: note: in expansion of macro
> 'SYSCALL_DEFINE3'
>     SYSCALL_DEFINE3(sparc_sigaction, int, sig,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:198:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:168:1: note: in expansion of macro
> 'SYSCALL_DEFINE3'
>     SYSCALL_DEFINE3(sparc_sigaction, int, sig,
>     ^~~~~~~~~~~~~~~
> >> include/linux/syscalls.h:211:18: error: 'sys_sparc_remap_file_pages' alias
> between functions of incompatible types 'long int(long unsigned int,  long unsigned
> int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,
> long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:200:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:119:1: note: in expansion of macro
> 'SYSCALL_DEFINE5'
>     SYSCALL_DEFINE5(sparc_remap_file_pages, unsigned long, start, unsigned
> long, size,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:200:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:119:1: note: in expansion of macro
> 'SYSCALL_DEFINE5'
>     SYSCALL_DEFINE5(sparc_remap_file_pages, unsigned long, start, unsigned
> long, size,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:211:18: error: 'sys_mmap' alias between functions of
> incompatible types 'long int(long unsigned int,  long unsigned int,  long unsigned
> int,  long unsigned int,  long unsigned int,  long unsigned int)' and 'long int(long int,
> long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:201:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:111:1: note: in expansion of macro
> 'SYSCALL_DEFINE6'
>     SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>     ^~~~~~~~~~~~~~~
>    include/linux/syscalls.h:215:18: note: aliased declaration here
>      asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                      ^~~
>    include/linux/syscalls.h:207:2: note: in expansion of macro
> '__SYSCALL_DEFINEx'
>      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      ^~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:201:36: note: in expansion of macro
> 'SYSCALL_DEFINEx'
>     #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name,
> __VA_ARGS__)
>                                        ^~~~~~~~~~~~~~~
>    arch/sparc//kernel/sys_sparc_32.c:111:1: note: in expansion of macro
> 'SYSCALL_DEFINE6'
>     SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>     ^~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +211 include/linux/syscalls.h
> 
> 609320c8 Yonghong Song       2017-09-07  204
> bed1ffca Frederic Weisbecker 2009-03-13  205  #define SYSCALL_DEFINEx(x,
> sname, ...)				\
> 99e621f7 Al Viro             2013-03-05  206  	SYSCALL_METADATA(sname, x,
> __VA_ARGS__)			\
> bed1ffca Frederic Weisbecker 2009-03-13 @207  	__SYSCALL_DEFINEx(x,
> sname, __VA_ARGS__)
> bed1ffca Frederic Weisbecker 2009-03-13  208
> 2cf09666 Al Viro             2013-01-21  209  #define __PROTECT(...)
> asmlinkage_protect(__VA_ARGS__)
> bed1ffca Frederic Weisbecker 2009-03-13  210  #define __SYSCALL_DEFINEx(x,
> name, ...)					\
> 83460ec8 Andi Kleen          2013-11-12 @211  	asmlinkage long
> sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
> 83460ec8 Andi Kleen          2013-11-12  212
> 	__attribute__((alias(__stringify(SyS##name))));		\
> 07fe6e00 Al Viro             2013-01-21  213  	static inline long
> SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
> f9597f24 Sergei Trofimovich  2013-09-11  214  	asmlinkage long
> SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
> 07fe6e00 Al Viro             2013-01-21  215  	asmlinkage long
> SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
> 1a94bc34 Heiko Carstens      2009-01-14  216  	{
> 				\
> 2cf09666 Al Viro             2013-01-21  217  		long ret =
> SYSC##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
> 07fe6e00 Al Viro             2013-01-21  218
> 	__MAP(x,__SC_TEST,__VA_ARGS__);				\
> 2cf09666 Al Viro             2013-01-21  219  		__PROTECT(x,
> ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
> 2cf09666 Al Viro             2013-01-21  220  		return ret;
> 				\
> 1a94bc34 Heiko Carstens      2009-01-14  221  	}
> 				\
> 07fe6e00 Al Viro             2013-01-21  222  	static inline long
> SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
> 1a94bc34 Heiko Carstens      2009-01-14  223
> 
> :::::: The code at line 211 was first introduced by commit
> :::::: 83460ec8dcac14142e7860a01fa59c267ac4657c syscalls.h: use gcc alias
> instead of assembler aliases for syscalls
> 
> :::::: TO: Andi Kleen <ak@linux.intel.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
