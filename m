Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68698ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 02:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40E320645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 02:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40E320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJVLOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 07:14:24 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:25663 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726851AbeJVLOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 07:14:24 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9M2xItG029569;
        Mon, 22 Oct 2018 10:59:18 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 22 Oct 2018
 10:57:42 +0800
Date:   Mon, 22 Oct 2018 10:57:43 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= 
        <greentime@andestech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>
Subject: Re: [PATCH 1/1] Perf: Compile failed when compile with libelf.
Message-ID: <20181022025742.GA23616@andestech.com>
References: <cover.1539654517.git.nickhu@andestech.com>
 <36763ffb49ecc0342669ca4029a4592670f6249a.1539654517.git.nickhu@andestech.com>
 <20181018145610.GH3849@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181018145610.GH3849@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9M2xItG029569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Oct 18, 2018 at 10:56:10PM +0800, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 18, 2018 at 04:36:46PM +0800, Nickhu escreveu:
> > The error message:
> > =====================================================================
> > util/symbol-elf.c:46:12: error: static declaration of 'elf_getphdrnum'
> > follows non-static declaration
> > static int elf_getphdrnum(Elf *elf, size_t *dst)
> >             ^~~~~~~~~~~~~~
> > In file included from util/symbol.h:20,
> >                  from util/symbol-elf.c:9:
> > /local/nickhu/build-system-3/toolchain/nds32le-linux-glibc-v3-upstream/
> > nds32le-linux/sysroot/usr/include/libelf.h:266:12: note: previous declaration
> > of 'elf_getphdrnum' was here
> > extern int elf_getphdrnum (Elf *__elf, size_t *__dst);
> >             ^~~~~~~~~~~~~~
> > util/symbol-elf.c:62:12: error: static declaration of 'elf_getshdrstrndx'
> > follows non-static declaration
> > static int elf_getshdrstrndx(Elf *elf __maybe_unused, size_t *dst __maybe
> > _unused)
> >             ^~~~~~~~~~~~~~~~~
> > In file included from util/symbol.h:20,
> >                  from util/symbol-elf.c:9:
> > /local/nickhu/build-system-3/toolchain/nds32le-linux-glibc-v3-upstream/
> > nds32le-linux/sysroot/usr/include/libelf.h:316:12: note: previous declaration
> > of 'elf_getshdrstrndx' was here
> > extern int elf_getshdrstrndx (Elf *__elf, size_t *__dst);
> > =====================================================================
> > 
> > Fix it.
> 
> Humm, I think the fix lies elsewhere.
> 
> If you find that function in a header, then its probably because you
> _have_ it in your system, right? In that case
> HAVE_ELF_GETPHDRNUM_SUPPORT should be defined and that elf_getphdrnum()
> fallback implementation should not be compiled.
> 
> So looking at where HAVE_ELF_GETPHDRNUM_SUPPORT is defined, in
> tools/build/feature, more specifically here:
> 
> [acme@jouet perf]$ cat tools/build/feature/test-libelf-getphdrnum.c 
> // SPDX-License-Identifier: GPL-2.0
> #include <libelf.h>
> 
> int main(void)
> {
> 	size_t dst;
> 
> 	return elf_getphdrnum(0, &dst);
> }
> [acme@jouet perf]$ 
> 
> [acme@jouet perf]$ find tools/ -type f | xargs grep HAVE_ELF_GETPHDRNUM_SUPPORT
> tools/perf/Makefile.config:    CFLAGS += -DHAVE_ELF_GETPHDRNUM_SUPPORT
> tools/perf/util/symbol-elf.c:#ifndef HAVE_ELF_GETPHDRNUM_SUPPORT
> [acme@jouet perf]$ 
> 
> Can you take a look at:
> 
> [acme@jouet perf]$ ls -la /tmp/build/perf/feature/test-libelf-getphdrnum.*
> -rwxrwxr-x. 1 acme acme 8240 Oct 17 09:20 /tmp/build/perf/feature/test-libelf-getphdrnum.bin
> -rw-rw-r--. 1 acme acme 1373 Oct 17 09:20 /tmp/build/perf/feature/test-libelf-getphdrnum.d
> -rw-rw-r--. 1 acme acme    0 Oct 17 09:20 /tmp/build/perf/feature/test-libelf-getphdrnum.make.output
> [acme@jouet perf]$ 
> 
> So in my case, using this libelf:
> 
> [acme@jouet perf]$ rpm -qf /usr/include/libelf.h 
> elfutils-libelf-devel-0.173-1.fc28.x86_64
> [acme@jouet perf]$
> 
> the .make.output file is empty, the build was successful, without
> warnings, that binary was generated:
> 
> [acme@jouet perf]$ ls -la /tmp/build/perf/feature/test-libelf-getphdrnum.bin
> -rwxrwxr-x. 1 acme acme 8240 Oct 17 09:20 /tmp/build/perf/feature/test-libelf-getphdrnum.bin
> [acme@jouet perf]$ ldd /tmp/build/perf/feature/test-libelf-getphdrnum.bin
> 	linux-vdso.so.1 (0x00007ffdf93ea000)
> 	libelf.so.1 => /lib64/libelf.so.1 (0x00007efc3f2d7000)
> 	libc.so.6 => /lib64/libc.so.6 (0x00007efc3ef21000)
> 	libz.so.1 => /lib64/libz.so.1 (0x00007efc3ed0a000)
> 	/lib64/ld-linux-x86-64.so.2 (0x00007efc3f4ef000)
> [acme@jouet perf]$ nm /tmp/build/perf/feature/test-libelf-getphdrnum.bin | grep getphdrnum
>                  U elf_getphdrnum@@ELFUTILS_1.6
> [acme@jouet perf]$
> 
> And here are the headers used:
> 
> [acme@jouet perf]$ cat /tmp/build/perf/feature/test-libelf-getphdrnum.d 
> /tmp/build/perf/feature/test-libelf-getphdrnum.bin: \
>  test-libelf-getphdrnum.c /usr/include/stdc-predef.h \
>  /usr/include/libelf.h \
>  /usr/lib/gcc/x86_64-redhat-linux/7/include/stdint.h \
>  /usr/include/stdint.h /usr/include/bits/libc-header-start.h \
>  /usr/include/features.h /usr/include/sys/cdefs.h \
>  /usr/include/bits/wordsize.h /usr/include/bits/long-double.h \
>  /usr/include/gnu/stubs.h /usr/include/gnu/stubs-64.h \
>  /usr/include/bits/types.h /usr/include/bits/typesizes.h \
>  /usr/include/bits/wchar.h /usr/include/bits/stdint-intn.h \
>  /usr/include/bits/stdint-uintn.h /usr/include/sys/types.h \
>  /usr/include/bits/types/clock_t.h /usr/include/bits/types/clockid_t.h \
>  /usr/include/bits/types/time_t.h /usr/include/bits/types/timer_t.h \
>  /usr/lib/gcc/x86_64-redhat-linux/7/include/stddef.h \
>  /usr/include/endian.h /usr/include/bits/endian.h \
>  /usr/include/bits/byteswap.h /usr/include/bits/byteswap-16.h \
>  /usr/include/bits/uintn-identity.h /usr/include/sys/select.h \
>  /usr/include/bits/select.h /usr/include/bits/types/sigset_t.h \
>  /usr/include/bits/types/__sigset_t.h \
>  /usr/include/bits/types/struct_timeval.h \
>  /usr/include/bits/types/struct_timespec.h /usr/include/sys/sysmacros.h \
>  /usr/include/bits/sysmacros.h /usr/include/bits/pthreadtypes.h \
>  /usr/include/bits/thread-shared-types.h \
>  /usr/include/bits/pthreadtypes-arch.h /usr/include/elf.h
> [acme@jouet perf]$
> 
> So, taking this into account, I think the feature test is using a
> different include path than the tool, which may be a real bug in the
> feature detection, how is the command line that led to this?
> 
> One other way to see that the feature test is not detecting that
> library, use VF=1 after a clean and check if this line is present:
> 
> ...             libelf-getphdrnum: [ OFF ]
> 
> [acme@jouet perf]$ rm -rf /tmp/build/perf/ ; mkdir -p /tmp/build/perf 
> [acme@jouet perf]$ time make VF=1 -C tools/perf O=/tmp/build/perf
> make: Entering directory '/home/acme/git/perf/tools/perf'
>   BUILD:   Doing 'make -j4' parallel build
>   HOSTCC   /tmp/build/perf/fixdep.o
>   HOSTLD   /tmp/build/perf/fixdep-in.o
>   LINK     /tmp/build/perf/fixdep
> Warning: Kernel ABI header at 'tools/include/uapi/linux/mman.h' differs from latest version at 'include/uapi/linux/mman.h'
> diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h
> 
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ on  ]
> ...                      libaudit: [ on  ]
> ...                        libbfd: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ on  ]
> ...        numa_num_possible_cpus: [ on  ]
> ...                       libperl: [ on  ]
> ...                     libpython: [ on  ]
> ...                      libslang: [ on  ]
> ...                     libcrypto: [ on  ]
> ...                     libunwind: [ on  ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ on  ]
> ...                     get_cpuid: [ on  ]
> ...                           bpf: [ on  ]
> ...                     backtrace: [ on  ]
> ...                fortify-source: [ on  ]
> ...         sync-compare-and-swap: [ on  ]
> ...                  gtk2-infobar: [ on  ]
> ...             libelf-getphdrnum: [ on  ]
> ...           libelf-gelf_getnote: [ on  ]
> ...          libelf-getshdrstrndx: [ on  ]
> ...                   libelf-mmap: [ on  ]
> ...             libpython-version: [ on  ]
> ...                 libunwind-x86: [ OFF ]
> ...              libunwind-x86_64: [ on  ]
> ...                 libunwind-arm: [ OFF ]
> ...             libunwind-aarch64: [ OFF ]
> ...   pthread-attr-setaffinity-np: [ on  ]
> ...               pthread-barrier: [ on  ]
> ...                  reallocarray: [ on  ]
> ...            stackprotector-all: [ on  ]
> ...                       timerfd: [ on  ]
> ...                  sched_getcpu: [ on  ]
> ...                           sdt: [ on  ]
> ...                         setns: [ on  ]
> ...                    libopencsd: [ OFF ]

Thank your for the quick reply. Your advices are very helpful to me.
Unfortunately, I can't reproduce the problem now. When I try to
reproduce the problem, it just compiled success. I guess maybe I have
something not clean cause the problem then.

I will drop my patch, thanks! 
