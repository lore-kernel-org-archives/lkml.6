Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2477C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8550A2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8550A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIADEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:04:32 -0400
Received: from foss.arm.com ([217.140.101.70]:36298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbeIADEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:04:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C28218A;
        Fri, 31 Aug 2018 15:54:54 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ABE93F5BD;
        Fri, 31 Aug 2018 15:54:53 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:54:53 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     <acme@kernel.org>, <jolsa@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Make perf script easier to use for itrace
Message-Id: <20180831175453.7378c5dd74d498b6d9002512@arm.com>
In-Reply-To: <20180831220206.28351-1-andi@firstfloor.org>
References: <20180831220206.28351-1-andi@firstfloor.org>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 15:01:56 -0700
Andi Kleen <andi@firstfloor.org> wrote:

> Also available in
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git pt/easy-script-2
> 
> v1: Initial post
> v2: Address review comments. Minor fixes to descriptions. Now builds everywhere.

OK, I grabbed the pt/easy-script-2 branch (commit 4c69fd388e17), and
see build failures for a 'make -C perf' build using gcc version 7.3.0
(Ubuntu 18.04):

builtin-script.c: In function ‘parse_output_fields’:
builtin-script.c:2571:22: error: array subscript is above array bounds [-Werror=array-bounds]
     output[j].fields &= ~all_output_options[i].field;
                      ^~
builtin-script.c:2571:22: error: array subscript is above array bounds [-Werror=array-bounds]
     output[j].fields &= ~all_output_options[i].field;
     ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
builtin-script.c:2574:10: error: array subscript is above array bounds [-Werror=array-bounds]
    output[j].user_set = true;
    ~~~~~~^~~
builtin-script.c:2575:10: error: array subscript is above array bounds [-Werror=array-bounds]
    output[j].wildcard_set = true;
    ~~~~~~^~~
...
util/cs-etm.c: In function ‘cs_etm__process_auxtrace_info’:
util/cs-etm.c:1436:14: error: ‘struct perf_session’ has no member named ‘itrace_synth’; did you mean ‘itrace_synth_opts’?
     session->itrace_synth.default_no_sample);
              ^~~~~~~~~~~~
              itrace_synth_opts

Thanks,

Kim

p.s. FWIW, my make VF=1 output:

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                      libslang: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                     backtrace: [ on  ]
...                fortify-source: [ on  ]
...         sync-compare-and-swap: [ on  ]
...                  gtk2-infobar: [ on  ]
...             libelf-getphdrnum: [ on  ]
...           libelf-gelf_getnote: [ on  ]
...          libelf-getshdrstrndx: [ on  ]
...                   libelf-mmap: [ on  ]
...             libpython-version: [ on  ]
...                 libunwind-x86: [ OFF ]
...              libunwind-x86_64: [ on  ]
...                 libunwind-arm: [ OFF ]
...             libunwind-aarch64: [ OFF ]
...   pthread-attr-setaffinity-np: [ on  ]
...               pthread-barrier: [ on  ]
...            stackprotector-all: [ on  ]
...                       timerfd: [ on  ]
...                  sched_getcpu: [ on  ]
...                           sdt: [ on  ]
...                         setns: [ on  ]
...                    libopencsd: [ on  ]

...                        bionic: [ OFF ]
...                    compile-32: [ OFF ]
...                   compile-x32: [ OFF ]
...                cplus-demangle: [ on  ]
...                         hello: [ OFF ]
...                 libbabeltrace: [ on  ]
...                       liberty: [ on  ]
...                     liberty-z: [ on  ]
...         libunwind-debug-frame: [ OFF ]
...     libunwind-debug-frame-arm: [ OFF ]
... libunwind-debug-frame-aarch64: [ OFF ]
...                           cxx: [ OFF ]
...                          llvm: [ OFF ]
...                  llvm-version: [ OFF ]
...                         clang: [ OFF ]
...                        prefix: /home/kim
...                        bindir: /home/kim/bin
...                        libdir: /home/kim/lib64
...                    sysconfdir: /home/kim/etc
...                 LIBUNWIND_DIR: 
...                     LIBDW_DIR: 
...                          JDIR: /usr/lib/jvm/java-1.8.0-openjdk-amd64
...     DWARF post unwind library: libunwind

