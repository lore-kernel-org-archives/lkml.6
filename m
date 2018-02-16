Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161442AbeBPQwv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161415AbeBPQwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:52:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4962F217C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 16 Feb 2018 13:52:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 1/3] tools include powerpc: Grab a copy of
 arch/powerpc/include/uapi/asm/unistd.h
Message-ID: <20180216165245.GD24436@kernel.org>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 29, 2018 at 02:04:15PM +0530, Ravi Bangoria escreveu:
> Will be used for generating the syscall id/string translation table.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  tools/arch/powerpc/include/uapi/asm/unistd.h | 399 +++++++++++++++++++++++++++
>  tools/perf/check-headers.sh                  |   1 +
>  2 files changed, 400 insertions(+)
>  create mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h

Not building on a cross-compiling environment (ubuntu 16.04), I'm checking...

  CC       /tmp/build/perf/util/syscalltbl.o
util/syscalltbl.c: In function 'syscalltbl__init_native':
util/syscalltbl.c:64:19: error: 'syscalltbl_native_max_id' undeclared (first use in this function)
  for (i = 0; i <= syscalltbl_native_max_id; ++i)
                   ^
util/syscalltbl.c:64:19: note: each undeclared identifier is reported only once for each function it appears in
util/syscalltbl.c:65:7: error: 'syscalltbl_native' undeclared (first use in this function)
   if (syscalltbl_native[i])
       ^
util/syscalltbl.c: In function 'syscalltbl__name':
util/syscalltbl.c:105:15: error: 'syscalltbl_native_max_id' undeclared (first use in this function)
  return id <= syscalltbl_native_max_id ? syscalltbl_native[id]: NULL;
               ^
util/syscalltbl.c:105:42: error: 'syscalltbl_native' undeclared (first use in this function)
  return id <= syscalltbl_native_max_id ? syscalltbl_native[id]: NULL;
                                          ^
util/syscalltbl.c:106:1: error: control reaches end of non-void function [-Werror=return-type]
 }
 ^
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.syscalltbl.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/syscalltbl.o' failed
make[4]: *** [/tmp/build/perf/util/syscalltbl.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/tests/sample-parsing.o
  CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
  CC       /tmp/build/perf/tests/kmod-path.o
  CC       /tmp/build/perf/tests/thread-map.o
  CC       /tmp/build/perf/tests/llvm.o
  CC       /tmp/build/perf/tests/bpf.o
  CC       /tmp/build/perf/tests/topology.o
  CC       /tmp/build/perf/tests/mem.o
  CC       /tmp/build/perf/tests/cpumap.o
  CC       /tmp/build/perf/tests/stat.o
/git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
make[3]: *** [util] Error 2
Makefile.perf:629: recipe for target '/tmp/build/perf/libperf-in.o' failed
make[2]: *** [/tmp/build/perf/libperf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/tests/event_update.o
