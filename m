Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE1BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7E720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfAOPAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:00:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:55830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728494AbfAOPAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:00:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAB89AE46;
        Tue, 15 Jan 2019 15:00:18 +0000 (UTC)
Date:   Tue, 15 Jan 2019 15:57:47 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc:     lwn@lwn.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 JANUARY 2019
Message-ID: <20190115145747.GB7842@rei.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good news everyone,

the Linux Test Project test suite stable release for *January 2019* has been
released.

Since the last release 246 patches by 40 authors were merged.

NOTABLE CHANGES
===============

* New tests
  - fanotify11 - test for FAN_REPORT_TID
  - fanotify01, fanotify03, fanotify10
    - added coverage for FAN_MARK_FILESYSTEM
  - fanotify03
    - added coverage for mountpoint mark
  - getrlimit03 - test if getrlimit syscalls return consistent data
  - increased coverage for readahead and posix_fadvise on overlayfs
  - execveat01 - functional tests
  - execveat02 - invalid inputs tests
  - statx06 - checks for correct statx timestamps
  - lremovexattr01 - functional tests
  - fremovexattr01 - functional tests
  - fremovexattr02 - invalid inputs tests
  - pt_test - Intel PT full trace test
  - membarier01 - functional tests
  - preadv201 - functional tests
  - preadv202 - invalid inputs tests
  - new open posix conformance tests for strchr, strcpy, strncpy

* New regression tests
  - crypto_user01 aka CVE-2018-19854 (previously known as CVE-2013-2547)
  - fanout01 aka CVE-2017-15649
  - fanotify09
    - added coverage for merging events on child subdir
      fixed in b469e7e47c8a "fanotify: fix handling of events on child sub-directory"
  - fanotify10 - test for mount ignore mask
     fixed in 9bdda4e9cf2d fsnotify: fix ignore mask logic in fsnotify()
  - getxattr05
     fixed in 82c9a927bc5d ("getxattr: use correct xattr length")

* Additional 37 tests were converted to the new test library; with that about
  30% of the LTP syscall testcases have been converted so far

* The travis build-testing is now done using docker ensuring that latest LTP
  git HEAD builds smoothly on major distributions and architectures

* The fzsync library intended to trigger kernel races has been rewritten again,
  the code is simpler now and at the same time the probability to hit races
  has increased.

NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Peter Vorel

New features/tests:

 - tests for SIT tunnel
 - tests for MPLS labels
 - netstress: add support for SO_BINDTODEVICE
 - added tst_net_run() shell API function
 - nfs tests were rewritten to new API
 - various fixes in dhcp, ipsec, rpc and virt tests
 - removed ftp and ssh tests

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20190115

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

git shortlog -s -e -n 20180926..
    41  Petr Vorel <pvorel@suse.cz>
    28  Amir Goldstein <amir73il@gmail.com>
    25  Alexey Kodanev <alexey.kodanev@oracle.com>
    25  Xiao Yang <yangx.jy@cn.fujitsu.com>
    16  Jan Stancek <jstancek@redhat.com>
    13  Cyril Hrubis <chrubis@suse.cz>
     8  Enji Cooper <yaneurabeya@gmail.com>
     8  Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
     7  Clemens Famulla-Conrad <cfamullaconrad@suse.de>
     6  Cristian Marussi <cristian.marussi@arm.com>
     6  Greg Hackmann <ghackmann@google.com>
     6  Rafael David Tinoco <rafael.tinoco@linaro.org>
     6  Richard Palethorpe <rpalethorpe@suse.com>
     6  Steve Muckle <smuckle@google.com>
     4  Jinhui huang <huangjh.jy@cn.fujitsu.com>
     4  Mandri, Padmashree <padmashree.mandri@intel.com>
     4  Sandeep Patil <sspatil@google.com>
     3  Eric Biggers <ebiggers@google.com>
     3  Yixin Zhang <yixin.zhang@intel.com>
     2  Jason Xing <kerneljasonxing@linux.alibaba.com>
     2  Li Wang <liwang@redhat.com>
     2  Subash Ganesan <subash@zilogic.com>
     1  Allen, John <John.Allen@amd.com>
     1  Ammy Yi <ammy.yi@intel.com>
     1  Hongzhi.Song <hongzhi.song@windriver.com>
     1  Kai Kang <kai.kang@windriver.com>
     1  Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
     1  Kenneth Magic <kmagic@google.com>
     1  Khem Raj <raj.khem@gmail.com>
     1  Lei Yang <Lei.Yang@windriver.com>
     1  Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
     1  Michael Moese <mmoese@suse.de>
     1  Myungho Jung <mhjungk@gmail.com>
     1  Po-Hsu Lin <po-hsu.lin@canonical.com>
     1  Shaoting Lei <leist.fnst@cn.fujitsu.com>
     1  Sun Lianwen <sun_lianwen@163.com>
     1  Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
     1  Tommi Rantala <tommi.t.rantala@nokia.com>
     1  nixiaoming <nixiaoming@huawei.com>
     1  yangj <yangj.fnst@cn.fujitsu.com>

And also thanks to patch reviewers:

git log 20180926.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r
     86 Cyril Hrubis <chrubis@suse.cz>
     20 Petr Vorel <pvorel@suse.cz>
     13 Li Wang <liwang@redhat.com>
     10 Jan Stancek <jstancek@redhat.com>
      7 Alexey Kodanev <alexey.kodanev@oracle.com>
      4 Xiao Yang <yangx.jy@cn.fujitsu.com>
      3 Richard Palethorpe <rpalethorpe@suse.de>
      1 Steve Muckle <smuckle@google.com>
      1 Richard Palethorpe <rpalethorpe@suse.com>
      1 Jan Kara <jack@suse.cz>
      1 Amir Goldstein <amir73il@gmail.com>

-- 
Cyril Hrubis
chrubis@suse.cz
