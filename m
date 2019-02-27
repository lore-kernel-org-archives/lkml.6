Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDD2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF5A20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7+eMG8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfB0Dyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:54:55 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41026 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfB0Dyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 22:54:54 -0500
Received: by mail-pf1-f201.google.com with SMTP id z1so12228461pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 19:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=baxX1S5LtzfmqzAc72hpJ9BN2ZK/N6upcf+SaQYT9NE=;
        b=H7+eMG8ZA+v74XjzyzM6+KITVbJ6KK1i8VEz0BpZZaLGJgUdiPXnPd1EDEUuycCsJp
         EZjhK0tQFpeoWNcZ2Wq1CZFFJCW8T5uGW9Z89a2S63u7RvNqfmC3MwzNzVJFNTclY7gr
         2MfG5bgxZr9xLo9JMwZNIup9SWhiM48jLyyAgxjf0UmO5wcME2LCVDSr8k6AgOev9789
         A8THemqcpxx8ygWkV+8Md5gdP8XUkDfhv92yU3K2EKaW1ji77daw9JAExPlZak4rX8LE
         sMgLDc4QpcDuLmkD6awMTGqP+aKYbwAhwvyZuFlYUqKdycxWOz8BqfghYIUnjxQn33xE
         w1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=baxX1S5LtzfmqzAc72hpJ9BN2ZK/N6upcf+SaQYT9NE=;
        b=pB1SqkhQxZ3juZ0fcQvqiXU7qDALsXzm3s6Wuw/+hmlUKW8ZOJnJpCZ7JlhOcT2TOf
         HCRVvvxYOFBTEIUAWkN4NQFMZn3/p8M9L60OML3hZiCd8FOZWjA/Cdt06c5gEWGgL44i
         GZOjJLYj0bluvIAAGotZDVGeNITItl2m0TsVfvTMB7QmzL7+v5ywuaMFM3NyUiuAIebv
         Xth3T4er/ktxXKhDWzjgK/LSNx/XWQdw91xuUjU/Y0WV/q7FsqbkF7CLM+MdyiArrIxw
         sr1ajS8EhBZoFmARkzipaJMIYGHP0xYfZYrRsTdB5wOQJesItYdgKM5zip/6kyfU8LNW
         GqxA==
X-Gm-Message-State: AHQUAuYVfwEH1zQktjX5H29s46vn0+Wnqu6xGd5p9/oeB+hLMFoMsaWY
        42w8mHM/9vIKPe1iVzV8nzuB804nQegSyCY45tMjIOF4WyekjHnZtt6shZjJG7Vz0iSZpSyFoFX
        0BoBJgc1Q8jWkc1HU+hA3dBOVMKuonSxggDeASR9tFFv+0Tos6ucSQusBtzRPlIwNjlQ=
X-Google-Smtp-Source: AHgI3Ib/imDfoZJ4ItLCNcbF5XtYkjqiznblt6qKt1+LhMd5yLSVUg6ce1CYUmoalvSop74kbXFYdi7LJg==
X-Received: by 2002:aa7:8718:: with SMTP id b24mr9117456pfo.139.1551239693479;
 Tue, 26 Feb 2019 19:54:53 -0800 (PST)
Date:   Tue, 26 Feb 2019 19:54:45 -0800
Message-Id: <20190227035448.117169-1-fengc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [RFC dma-buf 0/3] Improve the dma-buf tracking
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, erickreyes@google.com,
        Chenbo Feng <fengc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all dma-bufs share the same anonymous inode. While we can count
how many dma-buf fds or mappings a process has, we can't get the size of
the backing buffers or tell if two entries point to the same dma-buf. And
in debugfs, we can get a per-buffer breakdown of size and reference count,
but can't tell which processes are actually holding the references to each
buffer.

To resolve the issue above and provide better method for userspace to track
the dma-buf usage across different processes, the following changes are
proposed in dma-buf kernel side. First of all, replace the singleton inode
inside the dma-buf subsystem with a mini-filesystem, and assign each
dma-buf a unique inode out of this filesystem.  With this change, calling
stat(2) on each entry gives the caller a unique ID (st_ino), the buffer's
size (st_size), and even the number of pages assigned to each dma-buffer.
Secoundly, add the inode information to /sys/kernel/debug/dma_buf/bufinfo
so in the case where a buffer is mmap()ed into a process=E2=80=99s address =
space
but all remaining fds have been closed, we can still get the dma-buf
information and try to accociate it with the process by searching the
proc/pid/maps and looking for the corresponding inode number exposed in
dma-buf debug fs. Thirdly, created an ioctl to assign names to dma-bufs
which lets userspace assign short names (e.g., "CAMERA") to buffers. This
information can be extremely helpful for tracking and accounting shared
buffers based on their usage and original purpose. Last but not least, add
dma-buf information to /proc/pid/fdinfo by adding a show_fdinfo() handler
to dma_buf_file_operations. The handler will print the file_count and name
of each buffer.

Greg Hackmann (3):
  dma-buf: give each buffer a full-fledged inode
  dma-buf: add DMA_BUF_{GET,SET}_NAME ioctls
  dma-buf: add show_fdinfo handler

 drivers/dma-buf/dma-buf.c    | 121 ++++++++++++++++++++++++++++++++---
 include/linux/dma-buf.h      |   5 +-
 include/uapi/linux/dma-buf.h |   4 ++
 include/uapi/linux/magic.h   |   1 +
 4 files changed, 122 insertions(+), 9 deletions(-)

--=20
2.21.0.rc2.261.ga7da99ff1b-goog

