Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeEOOWV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:22:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:53288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753467AbeEOOWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:22:15 -0400
Date: Tue, 15 May 2018 16:12:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc: lwn@lwn.net, akpm@linux-foundation.org, torvalds@linux-foundation.org
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for MAY
 2018
Message-ID: <20180515141217.GA23351@rei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good news everyone,

the Linux Test Project test suite stable release for *May 2018* has been
released.

Since the last release 297 patches by 38 authors were merged.

NOTABLE CHANGES
===============

 * New testcases:

   - two inotify regression tests for:
     764baba80168 ("ovl: hash non-dir by lower inode for fsnotify")
     31747eda41ef ("ovl: hash directory inodes for fsnotify")

   - sysclt01 a regression test for:
     5ccba44ba118 ("sched/sysctl: Check user input value of sysctl_sched_time_avg")

   - CVE regression tests for:
     * CVE-2017-17053 - ccd5b3235180 ("x86/mm: Fix use-after-free of ldt_struct")
     * CVE-2017-16939 - 1137b5e2529a ("ipsec: Fix aborted xfrm policy dump crash")
     * CVE-2015-3290  - 9b6e6a8334d5 ("x86/nmi/64: Switch stacks on userspace NMI entry")
     * CVE-2017-17052 - 2b7e8665b4ff ("fork: fix incorrect fput of ->exe_file causing use-after-free")
     * CVE-2017-17807 - 4dca6ea1d943 ("KEYS: add missing permission check for request_key() destination")

   - read_all

     Test that aims to stress test /proc, /sys, and safe subset of /dev
     filesystems by reading by reading each readable file using several
     threads.

   - The pwritev03 and preadv03 tests with O_DIRECT executed on all supported filesystems.
     (https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2214-testing-with-a-block-device)

   - Pids controller tests fixed a race that made them fail sporadically and
     the the coverage was increased.

   - pwrite03, write02

     Write syscall tests for special case with NULL buffer and len 0
     where the call is expected to return 0 i.e. success.

 * Removed outdated and broken tests
   - sssd daemon test
   - mail command test
   - ht_interrupt -- hyperthreading interrupt balancing test

 * 54 testcases were cleaned up and converted to the new test library

 * The syscalls testrun has been speeded up by about a minute which is 5% of the runtime.

 * Several Android fixes have been applied.

 * New macro for automatic retry with exponential backoff has been added to the
   test library, which should replace all the ad-hoc retry loops we do have all
   around the codebase.

 * IMA (Integrity Measurement Architecture) tests
   - Were rewritten to use new API, updated, and various bugs has been fixed.
   - The most important changes:
     * Avoid running on tmpfs ima_measurements.sh and ima_violations.sh
     * ima_measurements.sh: support new IMA measurement templates, support testing
       most of IMA supported hash algorithms, fix & update iversion check
     * tpm.sh: replace ima_measure with evmctl (external)
     * ima_policy.sh: improve check of policy writability
     * ima_boot_aggregate: fixing event size for modern BIOS

     Many thanks to Mimi Zohar for her review and testing of IMA test cases.

  + The usual number of fixes and cleanups all over the place

NETWORK TESTS
=============

 Changelog for network tests brought to you by Peter Vorel.

 * New testcases:
   - for IP_BIND_ADDRESS_NO_PORT, DCCP and UDP ipsec and for UDPLITE protocol
   - regression test sctp_big_chunk aka CVE-2018-5803
   - netstress gained support for IP_BIND_ADDRESS_NO_PORT, SO_ZEROCOPY flags
     and UDPLITE protocol
   - Use libtirpc for all RPC tests

  * Test cases rewritten into new shell API:
    - interface and multicast tests cases
    - in6_02

  * Removed tests cases
    - route{4,6}-ifdown

  + Various fixes and doc cleanups


TODO LIST AND ISSUE TRACKER
===========================

Just recently we started to maintain a LTP TODO list in the form GitHub issues,
so far there is very coarse list of missing, mostly syscall, coverage:

https://github.com/linux-test-project/ltp/labels/missing%20coverage

Which I suppose will expand quite a bit soon.

And also nearly empty list of reproducers:

https://github.com/linux-test-project/ltp/labels/reproducer

Which I'm about to feed with a list of CVE reproducers I have, that
can be converted into regression testcases.

Lastly but not least I would like to ask everyone to contribute to that list.

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20180515

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.

CREDITS
=======

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20180118..
    76  Petr Vorel <pvorel@suse.cz>
    38  Cyril Hrubis <chrubis@suse.cz>
    37  Michael Moese <mmoese@suse.de>
    30  Alexey Kodanev <alexey.kodanev@oracle.com>
    21  Xiao Yang <yangx.jy@cn.fujitsu.com>
    12  yang xu <xuyang.jy@cn.fujitsu.com>
     9  Yixin Zhang <yixin.zhang@intel.com>
     7  Jinhui Huang <huangjh.jy@cn.fujitsu.com>
     7  Richard Palethorpe <rpalethorpe@suse.com>
     6  Jan Stancek <jstancek@redhat.com>
     6  Li Wang <liwang@redhat.com>
     5  Amir Goldstein <amir73il@gmail.com>
     4  Carlo Marcelo Arenas Belon <carenas@gmail.com>
     4  Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
     3  Petr Vorel <petr.vorel@gmail.com>
     3  Steve Muckle <smuckle.linux@gmail.com>
     2  Anders Roxell <anders.roxell@linaro.org>
     2  Eric Biggers <ebiggers@google.com>
     2  Khem Raj <raj.khem@gmail.com>
     2  Sandeep Patil <sspatil@google.com>
     2  Sebastian Chlad <schlad@suse.de>
     2  xiao yang <yangx.jy@cn.fujitsu.com>
     1  Christian Lanig <clanig@suse.com>
     1  Dmitry Safonov <dima@arista.com>
     1  Erick Reyes <erickreyes@google.com>
     1  Greg Hackmann <ghackmann@google.com>
     1  Harish <harish@linux.vnet.ibm.com>
     1  Hoang Van Tuyen <tuyen.hoangvan@toshiba-tsdv.com>
     1  Hridya Valsaraju <hridya@google.com>
     1  Joe Konno <joe.konno@intel.com>
     1  Lars Persson <larper@axis.com>
     1  Lianwen Sun <sunlw.fnst@cn.fujitsu.com>
     1  Pavel Boldin <pboldin@cloudlinux.com>
     1  Qiao Zhao <qiaozqjhsy@gmail.com>
     1  Xiong Zhou <xzhou@redhat.com>
     1  Yang Pengfei <yangpengfei4@huawei.com>
     1  akodanev <akodanev@gmail.com>
     1  xie hui <xieh.jy@cn.fujitsu.com>
     1  yosun <yosun@suse.com>

And also thanks to patch reviewers:

git log 20180118.. | grep -Ei '(reviewed|acked)-by:' | \
    sed 's/.*by: //' | sort | uniq -c | sort -n -r
     34 Cyril Hrubis <chrubis@suse.cz>
     15 Petr Vorel <pvorel@suse.cz>
     15 Alexey Kodanev <alexey.kodanev@oracle.com>
     11 Jan Stancek <jstancek@redhat.com>
      7 Richard Palethorpe <rpalethorpe@suse.de>
      4 Li Wang <liwang@redhat.com>
      3 Mimi Zohar <zohar@linux.vnet.ibm.com>
      2 Petr Vorel <petr.vorel@gmail.com>
      2 James Morris <james.l.morris@oracle.com>
      1 yang xu <xuyang.jy@cn.fujitsu.com>
      1 Xiao Yang <yangx.jy@cn.fujitsu.com>

-- 
Cyril Hrubis
chrubis@suse.cz
