Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C61C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA6C21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="v2O+6uWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA6C21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeI0VaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:30:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37079 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeI0VaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:30:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so2193239pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Wr7KqnM3yUXoEWd/oMwrL5jRQqwTL//qNH8I4yPylHM=;
        b=v2O+6uWCOEor1InB0/BazSECB/1dpQRrnCvGGAFN2B3PwcloxZ8+WDHli6Jw5Eoj2v
         6NDY4lNygGMM52iWp2LvbYVm3vb03q6UnN1sHHRa95fE//tWQoCIUzz/kxeDCom0TT37
         2g49ploiag3k6N0Fp51Coq4UQt6WYxhpwKs4a9vefYzZQgKIX4R2Ii14qiv9WZ8dPJwK
         fzt1pDX+9iI3IF1lMLY7E+5r/USdjQEXmAfXT2VpRcr+T91Hi9puBAGmonQfb7E3qcqU
         A2kiZwxZ9kNNoUeVZS8Yd2zHnOdrwgNlIV+Tabev38sH8OKlBAGTQVU4bJWqWdu5VKUi
         QyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wr7KqnM3yUXoEWd/oMwrL5jRQqwTL//qNH8I4yPylHM=;
        b=IsRwqm/rR17ohAalb/Ti9cwTIFVw8/PkP3YpZo4JPOKzsPAepvu4bqfJ9qNbpuvg8Z
         Bjkqha94kC8Utkb4s4q7WU0r7cy0NZnWXucFy4lleNBdlfcz8u7bdlyaCFsjFZzfr7QA
         F2uKA+QdedZK8ZpCJ2kwdGB/z1UJ2p1yUJD5g4oRzT0syXMaaRzEKeaQY95aRs1PNWj/
         JUC9gU/kn42gG5QGnbhBcxb19AUBJYq1kdLtdufb73wJJ2ogHRodlMRuk0QXOPdpgXNW
         XhnGTe9kWsDyEHE+ZvI1Pz+TVvr5HSz5hbZicpyvnLQpU+nO8L/M1py2sjG17/3mfrlj
         WzsA==
X-Gm-Message-State: ABuFfogyfLAOdSE7PluFGm6sDlgl6cTzaEaeeMOBA2PrOpaCYg5/p3Hy
        SX50Ck0xn0lntatQl45tLI87rg==
X-Google-Smtp-Source: ACcGV60rOvYF2YajtuxIAcllWXmrpRRPJeb1G1I9h+IJ/b+pwEtbdyVxcHYFq02LwvUnjpDT4DtKCA==
X-Received: by 2002:a63:9c01:: with SMTP id f1-v6mr10049333pge.156.1538061095315;
        Thu, 27 Sep 2018 08:11:35 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.178])
        by smtp.gmail.com with ESMTPSA id y19-v6sm5429610pff.14.2018.09.27.08.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:11:33 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v7 0/6] seccomp trap to userspace
Date:   Thu, 27 Sep 2018 09:11:13 -0600
Message-Id: <20180927151119.9989-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's v7 of the seccomp trap to userspace set. There are various minor
changes and bug fixes, but two major changes:

* We now pass fds to the tracee via an ioctl, and do it immediately when
  the ioctl is called. For this we needed some help from the vfs, so
  I've put the one patch in this series and cc'd fsdevel. This does have
  the advantage that the feature is now totally decoupled from the rest
  of the set, which is itself useful (thanks Andy!)

* Instead of putting all of the notification related stuff into the
  struct seccomp_filter, it now lives in its own struct notification,
  which is pointed to by struct seccomp_filter. This will save a lot of
  memory (thanks Tyler!)

v6 discussion: https://lkml.org/lkml/2018/9/6/769

Thoughts welcome,

Tycho

Tycho Andersen (6):
  seccomp: add a return code to trap to userspace
  seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
  seccomp: add a way to get a listener fd from ptrace
  files: add a replace_fd_files() function
  seccomp: add a way to pass FDs via a notification fd
  samples: add an example of seccomp user trap

 Documentation/ioctl/ioctl-number.txt          |   1 +
 .../userspace-api/seccomp_filter.rst          |  89 +++
 fs/file.c                                     |  22 +-
 include/linux/file.h                          |   8 +
 include/linux/seccomp.h                       |  14 +-
 include/uapi/linux/ptrace.h                   |   2 +
 include/uapi/linux/seccomp.h                  |  42 +-
 kernel/ptrace.c                               |   4 +
 kernel/seccomp.c                              | 527 ++++++++++++++-
 samples/seccomp/.gitignore                    |   1 +
 samples/seccomp/Makefile                      |   7 +-
 samples/seccomp/user-trap.c                   | 312 +++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 607 +++++++++++++++++-
 13 files changed, 1617 insertions(+), 19 deletions(-)
 create mode 100644 samples/seccomp/user-trap.c

-- 
2.17.1

