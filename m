Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBD5C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3862821019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeLaEPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 23:15:10 -0500
Received: from namei.org ([65.99.196.166]:53788 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeLaEPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 23:15:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBV4F84Y001668;
        Mon, 31 Dec 2018 04:15:08 GMT
Date:   Mon, 31 Dec 2018 15:15:08 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security: seccomp changes for v4.21
Message-ID: <alpine.LRH.2.21.1812311511360.1435@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Kees:

"- Add SECCOMP_RET_USER_NOTIF

- seccomp fixes for sparse warnings and s390 build (Tycho)"



The following changes since commit 1072bd678547f8663cfb81a22fdb50c589e4976e:

  security: fs: make inode explicitly non-modular (2018-12-12 14:58:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-seccomp

for you to fetch changes up to 55b8cbe470d103b44104c64dbf89e5cad525d4e0:

  Merge tag 'seccomp-next-part2' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-seccomp (2018-12-17 11:36:26 -0800)

----------------------------------------------------------------
James Morris (2):
      Merge tag 'seccomp-next' of https://git.kernel.org/.../kees/linux into next-seccomp
      Merge tag 'seccomp-next-part2' of https://git.kernel.org/.../kees/linux into next-seccomp

Tycho Andersen (6):
      seccomp: hoist struct seccomp_data recalculation higher
      seccomp: switch system call argument type to void *
      seccomp: add a return code to trap to userspace
      samples: add an example of seccomp user trap
      seccomp: fix poor type promotion
      seccomp, s390: fix build for syscall type change

 Documentation/ioctl/ioctl-number.txt           |   1 +
 Documentation/userspace-api/seccomp_filter.rst |  84 +++++
 arch/s390/kernel/compat_wrapper.c              |   2 +-
 include/linux/seccomp.h                        |   9 +-
 include/linux/syscalls.h                       |   2 +-
 include/uapi/linux/seccomp.h                   |  40 ++-
 kernel/seccomp.c                               | 467 ++++++++++++++++++++++++-
 samples/seccomp/.gitignore                     |   1 +
 samples/seccomp/Makefile                       |   7 +-
 samples/seccomp/user-trap.c                    | 375 ++++++++++++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c  | 447 ++++++++++++++++++++++-
 11 files changed, 1411 insertions(+), 24 deletions(-)
 create mode 100644 samples/seccomp/user-trap.c
