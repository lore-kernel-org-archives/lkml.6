Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeBDKuX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 05:50:23 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33154 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeBDKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 05:50:14 -0500
X-Google-Smtp-Source: AH8x226KR/bdobjyDlN8GNdUreKUl1Y+TC6GYfxSEtdQxo3qOYNZNaPeNtRYmNCvk1Ffcb78G96GZQ==
From: Tycho Andersen <tycho@tycho.ws>
To: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [RFC 0/3] seccomp trap to userspace
Date: Sun,  4 Feb 2018 11:49:43 +0100
Message-Id: <20180204104946.25559-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several months ago at Linux Plumber's, we had a discussion about adding a
feature to seccomp which would allow seccomp to trigger a notification for some
other process. Here's a draft of that feature.

Patch 1 contains the bulk of it, patches 2 & 3 offer an alternative way to
acquire the fd that receives notifications via ptrace (the method in patch 1
poses some problems). Other suggestions for how to acquire one of these fds
would be welcome.

Take a close look at the synchronization. I think I've got it right, but I
probably don't :)

Thanks!

Tycho Andersen (3):
  seccomp: add a return code to trap to userspace
  seccomp: hoist out filter resolving logic
  seccomp: add a way to get a listener fd from ptrace

 arch/Kconfig                                  |   7 +
 include/linux/seccomp.h                       |  14 +-
 include/uapi/linux/ptrace.h                   |   1 +
 include/uapi/linux/seccomp.h                  |  18 +-
 kernel/ptrace.c                               |   4 +
 kernel/seccomp.c                              | 467 ++++++++++++++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 180 +++++++++-
 7 files changed, 653 insertions(+), 38 deletions(-)

-- 
2.14.1
