Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9207D214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9207D214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeIZSaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:30:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:38862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbeIZSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:30:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C03EAE61;
        Wed, 26 Sep 2018 12:17:18 +0000 (UTC)
Date:   Wed, 26 Sep 2018 14:16:44 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc:     lwn@lwn.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 SEPTEMBER 2018
Message-ID: <20180926121644.GA18865@rei.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good news everyone,

the Linux Test Project test suite stable release for *September 2018* has been
released.

Since the last release 275 patches by 39 authors were merged.

NOTABLE CHANGES
===============

* New tests
  - statx tests for:
    * basic tests
    * invalid inputs
    * AT_EMPTY_PATH, AT_SYMLINK_NOFOLLOW
    * FS_* flags
    * STATX_ATTR_ENCRYPTED (on ext4)
    + more is on the way
  - mlock2
    * basic tests
    * invalid inputs
  - memfd_create
    * MFD_HUGETLB, MFD_HUGE_2MB, MFD_HUGE_1GB
  - fgetxattr
  - fsetxattr
  - prctl
    * PR_{SET,GET}_CHILD_SUBREAPER
  - madvise
    * MADV_WIPEONFORK, MADV_KEEPONFORK

* New regression tests
  - mlock203
     b155b4fde5bd mm: mlock: avoid increase mm->locked_vm on mlock() when already mlock2(,MLOCK_ONFAULT)
  - execveat
     355139a8dba4 cap_inode_getsecurity: use d_find_any_alias() instead of d_find_alias()
  - pcrypt_aead01 aka CVE-2017-18075
     d76c68109f37 crypto: pcrypt - fix freeing pcrypt instances
  - shmctl05
     3f05317d9889 ipc/shm: fix use-after-free of shm file via remap_file_pages()
  - realpath01 aka cve-2018-1000001
     fixed by glibc commit 52a713fdd0a3
  - inotify07
     d90a10e2444b fsnotify: Fix fsnotify_mark_connector race
  - fanotify09
     54a307ba8d3c fanotify: fix logic of events on child
  - pty02
     966031f340185 n_tty: fix EXTPROC vs ICANON interaction with TIOCINQ (aka FIONREAD)
  - migrate_pages03
     4b0ece6fa016 mm: migrate: fix remove_migration_pte() for ksm pages

* msgctl IPC test were redesigned and rewritten

* ~50 tests were cleaned up and rewritten to the new library API

* Several network helper libraries and tests has been ported into new API
  (busy poll, DHCP, ipneigh, IPsec, iptables, SCTP, TCP fast open, virt, ...)

+ Many fixes all over the place

* Removed code
  - pounder21 - broken and wasn't compiled by default for years

* What didn't make it to this release
  - second rewrite and simplification of the fuzzy sync library
    and this time the user API is much easier to use
  - rewrite of the mempolicy NUMA tests that should finally solve
    all race conditions and random failures

TODO LIST AND ISSUE TRACKER
===========================

As noted in the previous release we started to maintain a LTP TODO list in the
form GitHub issues, as expected the list is growing:

https://github.com/linux-test-project/ltp/labels/missing%20coverage

But more importantly we are starting to implement testcases based on that list,
recently we added the fsetxattr, fgetxattr, mlock2, prctl, and statx tests and
more is about to come in the near future.

We do have also list of reproducers to be turned into testcases:

https://github.com/linux-test-project/ltp/labels/reproducer

Lastly but not least I would like to ask everyone to contribute to these lists.
If you have a reproducer or notice missing coverage do not hesitate to open an
issue.

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20180926

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

git shortlog -s -e -n 20180515..

    61  Petr Vorel <pvorel@suse.cz>
    31  Xiao Yang <yangx.jy@cn.fujitsu.com>
    28  Cyril Hrubis <chrubis@suse.cz>
    25  Alexey Kodanev <alexey.kodanev@oracle.com>
    18  Jan Stancek <jstancek@redhat.com>
    13  Li Wang <liwang@redhat.com>
     9  Alistair Strachan <astrachan@google.com>
     9  Jinhui huang <huangjh.jy@cn.fujitsu.com>
     9  Mylene Josserand <mylene.josserand@bootlin.com>
     8  Yixin Zhang <yixin.zhang@intel.com>
     7  Punit Agrawal <punit.agrawal@arm.com>
     7  Rafael David Tinoco <rafael.tinoco@linaro.org>
     7  Richard Palethorpe <rpalethorpe@suse.com>
     5  Jinhui Huang <huangjh.jy@cn.fujitsu.com>
     4  Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
     4  vaishnavid <vaishnavi.d@zilogic.com>
     3  Michael Moese <mmoese@suse.de>
     3  Sandeep Patil <sspatil@google.com>
     2  Amir Goldstein <amir73il@gmail.com>
     2  Eric Biggers <ebiggers@google.com>
     2  Junchi Chen <junchi.chen@intel.com>
     2  Kewal Ukunde <kewal@zilogic.com>
     2  Wang Long <w@laoqinren.net>
     1  Anton Smorodskyi <asmorodskyi@suse.com>
     1  Chen Rong <chenr.fnst@cn.fujitsu.com>
     1  Christian Lanig <clanig@suse.com>
     1  Eddie.Horng <eddie.horng@mediatek.com>
     1  Fang Guan <fguan322@gmail.com>
     1  Fathi Boudra <fathi.boudra@linaro.org>
     1  Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
     1  He Zhe <zhe.he@windriver.com>
     1  Kenneth Magic <kmagic@google.com>
     1  Po-Hsu Lin <po-hsu.lin@canonical.com>
     1  Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
     1  Vishnu K <vishnu@zilogic.com>
     1  Yang Shi <yang.shi@linux.alibaba.com>
     1  xiao yang <yangx.jy@cn.fujitsu.com>

And also thanks to patch reviewers:

git log 20180515.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

     64 Cyril Hrubis <chrubis@suse.cz>
     36 Jan Stancek <jstancek@redhat.com>
     33 Petr Vorel <pvorel@suse.cz>
     18 Alexey Kodanev <alexey.kodanev@oracle.com>
     17 Li Wang <liwang@redhat.com>
      2 Richard Palethorpe <rpalethorpe@suse.de>
      2 Petr Vorel <petr.vorel@gmail.com>
      1 Xiao Yang <yangx.jy@cn.fujitsu.com>
      1 Naresh Kamboju <naresh.kamboju@linaro.org>
      1 Mimi Zohar <zohar@linux.vnet.ibm.com>
      1 Jan Kara <jack@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
