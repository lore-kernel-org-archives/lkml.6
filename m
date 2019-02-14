Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8431C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991EE222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550158224;
	bh=nMU56f5nmsGH8TH3vIr7+n2drjq6KVNbfpVh/fM9bng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ns03HiNRMKoMjQH2bdbv+l26TDX6Grib6hmf1bpduIIhn66FiAeTkerKqNnoz1I4K
	 8Z3OpanrVXUcWNTtR8v9IZUbFTsTYkdjs5TnX2OwLllH9NUozijWCiYikV0M4q8zIK
	 RPROIsN+W6TrNfvzv8Z9/1YeymqDcPvb/9kTswyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502128AbfBNPaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbfBNPaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:30:22 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05FD62229F;
        Thu, 14 Feb 2019 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550158221;
        bh=nMU56f5nmsGH8TH3vIr7+n2drjq6KVNbfpVh/fM9bng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Far3E7kDlJniK8id4ZjabNOLmqSn8A7HraSvv6+nCkrVRmdeYY+ox6n82P+tvFVDG
         lFpAxFO94U9rt+pvaD5F9edrCd6A7b+c5l3gRFkX+oKMaWy9AvDECf2RyCJkKU9pMc
         gapi7V+yCx4hS7I2ryEH/K0aGLLj+PEoLngL/mnY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42877410D5; Thu, 14 Feb 2019 12:30:18 -0300 (-03)
Date:   Thu, 14 Feb 2019 12:30:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools build: Add test-reallocarray.c to test-all.c to fix
 the build Was: Re: reallocarray failure on centos:7 superseded by raw data
 API
Message-ID: <20190214153018.GA23266@kernel.org>
References: <20190212205557.GM3269@kernel.org>
 <20190212205750.GN3269@kernel.org>
 <D9304DB8-0E43-49D0-9F61-871CB14473F8@fb.com>
 <CAEf4BzaCMq5C94bp31Ew=PqcasfuUm-dEvSi6p9ErduRHRgGTA@mail.gmail.com>
 <CA+JHD93gPW4oPkumPK36UkQv_2AOxywAzTjDXz1VgJ7YHa5qBg@mail.gmail.com>
 <CAEf4BzYGzgoZ2c_zuvyjM1d734dMKLm_9Ki8XfFvUGMCMxU=Lw@mail.gmail.com>
 <20190213133855.GB1904@kernel.org>
 <20190213142136.GC1904@kernel.org>
 <CAEf4BzaNBSxZCVC2myZRkn4N8WLJ6cCtV1M6Qy-3e7ZHJHZp6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaNBSxZCVC2myZRkn4N8WLJ6cCtV1M6Qy-3e7ZHJHZp6A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 13, 2019 at 09:30:11PM -0800, Andrii Nakryiko escreveu:
> On Wed, Feb 13, 2019 at 6:21 AM Arnaldo Carvalho de Melo
> > Em Wed, Feb 13, 2019 at 10:38:55AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > >> >     > make[2]: *** [/tmp/build/perf/libbpf.a] Error 2
> > > > >> >     > make[2]: *** Waiting for unfinished jobs....
> > > > >> >     >   CC       /tmp/build/perf/debug.o

> > > > >> >     > I thought you had mentioned something about this?

> > > > >> Yeah, libbpf has feature detection for reallocarray, because it's not
> > > > >> available everywhere yet. This is done by libbpf's Makefile, but for
> > > > >> cmake I added this (similar to what bcc does):

So, I have the fix below in my tree, no need for that __weak function
after all :-)

Jin, your bisect to something seeming unrelated:

c30fb4c perf build: Add missing FEATURE_CHECK_LDFLAGS-libcrypto

Was another cset that introduced a check with problems and when fixed
made test-all.c build successfully on modern systems but not on your
system, ubuntu 16.04, so it assumed that reallocarray() was present and
didn't trigger the libc_compat.h fallback which ended up breaking your
build.

Thanks,

- Arnaldo

commit e2d2f7369b4b968bab4fdd2830a9a1a39b6b7443
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Feb 14 12:01:04 2019 -0300

    tools build: Add test-reallocarray.c to test-all.c to fix the build
    
    When a test is in the FEATURE_TESTS_BASIC list in tools/build/Makefile.feature
    must be added to tools/build/feature/test-all.c, because the successfull
    compilation and linking of that test-all.bin file means that all the
    features listed in FEATURE_TESTS_BASIC are present in the system, so we
    don't have to go on feature by feature test building them.
    
    Since reallocarray() is expected to be present in modern systems, it has
    a place in FEATURE_TESTS_BASIC, so that we speed up the build process
    building just that file.
    
    For older systems, such as ubuntu:16.04 (build failure reported by Jin
    Yao) debian:8, and for the current flagship RHEL distro, RHEL7, the
    build will fail as test-all.bin (without test-reallocarray.c included)
    passes but reallocarray() isn't present, making the build fail with:
    
        CC       /tmp/build/perf/libbpf.o
        MKDIR    /tmp/build/perf/fs/
        CC       /tmp/build/perf/fs/tracing_path.o
        LD       /tmp/build/perf/fd/libapi-in.o
        CC       /tmp/build/perf/bpf.o
      libbpf.c: In function 'bpf_object__add_program':
      libbpf.c:367:10: error: implicit declaration of function 'reallocarray' [-Werror=implicit-function-declaration]
        progs = reallocarray(progs, nr_progs + 1, sizeof(progs[0]));
                ^
      libbpf.c:367:2: error: nested extern declaration of 'reallocarray' [-Werror=nested-externs]
        progs = reallocarray(progs, nr_progs + 1, sizeof(progs[0]));
        ^
      libbpf.c:367:8: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
        progs = reallocarray(progs, nr_progs + 1, sizeof(progs[0]));
              ^
      libbpf.c: In function 'bpf_object__elf_collect':
      libbpf.c:887:10: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
          reloc = reallocarray(reloc, nr_reloc,
                ^
      libbpf.c: In function 'bpf_program__reloc_text':
      libbpf.c:1394:12: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
         new_insn = reallocarray(prog->insns, new_cnt, sizeof(*insn));
                  ^
        CC       /tmp/build/perf/nlattr.o
    
    Even with:
    
      $ grep reallocarray /tmp/build/perf/FEATURE-DUMP
      feature-reallocarray=1
      $
    
    Which ubuntu:16.04.5 LTS doesn't have:
    
      perfbuilder@38a153a1bba8:/$ head -2 /etc/os-release
      NAME="Ubuntu"
      VERSION="16.04.5 LTS (Xenial Xerus)"
      perfbuilder@38a153a1bba8:/$ find /usr/include/ -name "*.h" | xargs grep -w reallocarray
      perfbuilder@38a153a1bba8:/$
    
    Fix it by including it to test-all.c, which ends up forcing the
    individual tests to be triggered and for the build process to notice
    that indeed reallocarray() is not there:
    
      perfbuilder@38a153a1bba8:/$ cat /tmp/build/perf/feature/test-all.make.output
      In file included from test-all.c:178:0:
      test-reallocarray.c: In function 'main_test_reallocarray':
      test-reallocarray.c:7:11: error: implicit declaration of function 'reallocarray' [-Werror=implicit-function-declaration]
        return !!reallocarray(NULL, 1, 1);
                 ^
      cc1: all warnings being treated as errors
      perfbuilder@38a153a1bba8:/$
    
    That is the only test that is failing on Ubuntu 16.03.5 LTS, so all
    tests are forced:
    
      perfbuilder@38a153a1bba8:/tmp/build/perf/feature$ ls -lSr *.make.output
      <SNIP successful tests>
      -rw-r--r--. 1 perfbuilder perfbuilder   0 Feb 14 15:00 test-dwarf.make.output
      -rw-r--r--. 1 perfbuilder perfbuilder   0 Feb 14 14:16 test-cplus-demangle.make.output
      -rw-r--r--. 1 perfbuilder perfbuilder   0 Feb 14 15:00 test-bpf.make.output
      -rw-r--r--. 1 perfbuilder perfbuilder   0 Feb 14 15:00 test-backtrace.make.output
      -rw-r--r--. 1 perfbuilder perfbuilder 104 Feb 14 15:00 test-bionic.make.output
      -rw-r--r--. 1 perfbuilder perfbuilder 107 Feb 14 15:00 test-libunwind-x86.make.output
      -rw-r--r--. 1 perfbuilder perfbuilder 115 Feb 14 15:00 test-libunwind-aarch64.make.output
      -rw-r--r--. 1 perfbuilder perfbuilder 122 Feb 14 15:00 test-libbabeltrace.make.output
      -rw-r--r--. 1 perfbuilder perfbuilder 254 Feb 14 15:00 test-reallocarray.make.output
      -rw-r--r--. 1 perfbuilder perfbuilder 312 Feb 14 15:00 test-all.make.output
      perfbuilder@38a153a1bba8:/tmp/build/perf/feature$
    
    And that reallocarray() one shows:
    
      perfbuilder@38a153a1bba8:/tmp/build/perf/feature$ cat test-reallocarray.make.output
      test-reallocarray.c: In function 'main':
      test-reallocarray.c:7:11: error: implicit declaration of function 'reallocarray' [-Werror=implicit-function-declaration]
        return !!reallocarray(NULL, 1, 1);
                 ^
      cc1: all warnings being treated as errors
      perfbuilder@38a153a1bba8:/tmp/build/perf/feature$
    
    Which now generates the expected result:
    
      perfbuilder@38a153a1bba8:~$ grep reallocarray /tmp/build/perf/FEATURE-DUMP
      feature-reallocarray=0
      perfbuilder@38a153a1bba8:~$
    
    The fallback mechanism kicks in and libbpf and perf are again buildable
    in systems without reallocarray():
    
      $ cat tools/include/tools/libc_compat.h
      // SPDX-License-Identifier: (LGPL-2.0+ OR BSD-2-Clause)
      /* Copyright (C) 2018 Netronome Systems, Inc. */
    
      #ifndef __TOOLS_LIBC_COMPAT_H
      #define __TOOLS_LIBC_COMPAT_H
    
      #include <stdlib.h>
      #include <linux/overflow.h>
    
      #ifdef COMPAT_NEED_REALLOCARRAY
      static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
      {
              size_t bytes;
    
              if (unlikely(check_mul_overflow(nmemb, size, &bytes)))
                      return NULL;
              return realloc(ptr, bytes);
      }
      #endif
      #endif
      $
    
    Reported-by: Jin Yao <yao.jin@linux.intel.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexei Starovoitov <ast@fb.com>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Song Liu <songliubraving@fb.com>
    Cc: Yonghong Song <yhs@fb.com>
    Fixes: 531b014e7a2f ("tools: bpf: make use of reallocarray")
    Link: https://lkml.kernel.org/n/tip-aonqku8axii8rxki5g11w40b@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 74329957553a..e903b86b742f 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -174,6 +174,10 @@
 # include "test-libaio.c"
 #undef main
 
+#define main main_test_reallocarray
+# include "test-reallocarray.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -214,6 +218,7 @@ int main(int argc, char *argv[])
 	main_test_sdt();
 	main_test_setns();
 	main_test_libaio();
+	main_test_reallocarray();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-reallocarray.c b/tools/build/feature/test-reallocarray.c
index 8170de35150d..8f6743e31da7 100644
--- a/tools/build/feature/test-reallocarray.c
+++ b/tools/build/feature/test-reallocarray.c
@@ -6,3 +6,5 @@ int main(void)
 {
 	return !!reallocarray(NULL, 1, 1);
 }
+
+#undef _GNU_SOURCE
