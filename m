Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B38C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F54E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="F0neg97F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F54E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeKSU4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:56:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34013 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeKSU4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:56:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so14409486plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 02:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i48REQ5xKcodhlmnW4XayGlQL3igcgkvyoSrOEc6atA=;
        b=F0neg97FwpmlJyDksyvozPh12H5rx3FrpdGz/ml4bg3rCrowQcKuS86kO0ctRgre1J
         xGIyy2FBfUtyVISppzCv5ZjgJOSHJ6e0M7Bvj5+8p0Kqc6M9aQR/BV630gDv0dcHsXYW
         DBu6PtPPb30HHLzwFwAHF3peu4ejVtRFEdmorK+5E+L1sBkX4Vf9N7yOrkeK9sWHRTOk
         miHpFk8qNTHRXX2sA5ePLBA1jAYCcVDin5aMmviW9zTb0/pMBCJx5+fj27bd92VYLo7s
         /+T0EfmCJHbqHuqQKEoU1FlSPfyefVsPfXR/CZRCIfwrOpMs4v82ZF1eeIUVZNsjZl23
         c8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i48REQ5xKcodhlmnW4XayGlQL3igcgkvyoSrOEc6atA=;
        b=t6ljBCYY7qYx7vAeC7+mrNHEItabCl53rXaTFom3JdsRM4jjmpKo6TtuaG5dBxoKqk
         nMDjZpW0v9uP1Ph0Krz9Utx3OTN2AEThM2dTcM9dAs5BdM8+2RxUYov6Zac3Oqkor/NC
         6K5806kzLQolKliEavvhehBwihfUu7sg3QBkKDUdWVaM7HJ8CQbgmVKsvMCe65mCSlaX
         bYJDz0fWEKdkUL2URGFMdgNefN/kgBUSO1YnQYjpJjddlI05q0UErOQwUtuJ5DA2s66u
         Kg9zEbOfEFERmw9YYq/qs4Xk07D41eDKpNYl5aSRVybv/wXc5pPrd3h50A73Ot2zYeUW
         j0zQ==
X-Gm-Message-State: AGRZ1gJrrdzpWqzDqLUlsPD1yEOIpfjrLSlX41eylm6Vn2gV/7qtHuEF
        d5KxhcPIo0eAMEsD06j4EPTN6g==
X-Google-Smtp-Source: AJdET5fJUD6EctUfqJWSOnu2p41a76gRzrarfP1vZMM0Ijc8P8ezaV1EIFH00Xc7XkoAwpg6R+Cx0Q==
X-Received: by 2002:a17:902:d03:: with SMTP id 3-v6mr19784571plu.66.1542623613071;
        Mon, 19 Nov 2018 02:33:33 -0800 (PST)
Received: from localhost.localdomain ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id d21sm32958139pgv.37.2018.11.19.02.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:33:32 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 0/2] proc: allow signaling processes via file descriptors
Date:   Mon, 19 Nov 2018 11:32:37 +0100
Message-Id: <20181119103241.5229-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This little series introduces the ability to signal processes via file
descriptors to eliminate race-conditions caused by pid recycling.
With this patch an open() call on /proc/<pid> will give userspace a
handle to struct pid of the process associated with /proc/<pid>. This
allows to maintain a stable handle on a process.
Discussion has shown that a dedicated syscall is prefered over an ioctl().
Thus, the  new syscall procfd_signal() is introduced to solve this
problem. It operates on a process file descriptor. More details are
found in the individual commit messages.

With this series a process can be killed via:

 #define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <unistd.h>

 int main(int argc, char *argv[])
 {
         int ret;
         char buf[1000];

         if (argc < 2)
                 exit(EXIT_FAILURE);

         ret = snprintf(buf, sizeof(buf), "/proc/%s", argv[1]);
         if (ret < 0)
                 exit(EXIT_FAILURE);

         int fd = open(buf, O_DIRECTORY | O_CLOEXEC);
         if (fd < 0) {
                 printf("%s - Failed to open \"%s\"\n", strerror(errno), buf);
                 exit(EXIT_FAILURE);
         }

         ret = syscall(__NR_procfd_signal, fd, SIGKILL, NULL, 0);
         if (ret < 0) {
                 printf("Failed to send SIGKILL \"%s\"\n", strerror(errno));
                 close(fd);
                 exit(EXIT_FAILURE);
         }

         close(fd);

         exit(EXIT_SUCCESS);
 }

Thanks!
Christian

Christian Brauner (2):
  proc: get process file descriptor from /proc/<pid>
  signal: add procfd_signal() syscall
  procfd_signal.2: document procfd_signal syscall

 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/proc/base.c                         | 23 ++++++++
 include/linux/proc_fs.h                |  1 +
 include/linux/syscalls.h               |  2 +
 kernel/signal.c                        | 76 ++++++++++++++++++++++++--
 6 files changed, 98 insertions(+), 6 deletions(-)

-- 
2.19.1

