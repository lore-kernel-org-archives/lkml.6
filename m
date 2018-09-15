Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1C2ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D5C2083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U54MXtva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D5C2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeIOK1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 06:27:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41884 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeIOK1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 06:27:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so5292320pgv.8;
        Fri, 14 Sep 2018 22:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cajKTwSrMQhKjLfAgR+no/JZ9XepjehaTNg6E79EXhQ=;
        b=U54MXtvamLDOxLnixoSaGuc9fSjeUi8uew/iJHZVBycLeV3sYHCizChdZko/MdfEkb
         sj0jqxbp3uk8WB6ATeM6nJFlSsJvG7C7381FxnyMKLKT8aFlshMjwyrLXZpIxKmx8KDR
         l+w+vKOJf5o2+2TNfHZ9384ybfPsnokFFeMwEsznXirUJV1LnwMHh85lQ3jIa315sRgy
         qsFiAMmpVov1Y8xBG2dffSho5N/Mm4f7j41AD2bzoPDkSfWjaPS+hDYjBvzmOW4+qS88
         WNLE8eGRWbYPzbPrnWlv5lk618+LLdTd/Fb/zYN3mK819LDBsSbqhMUJElDxUVZgduk9
         8dkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cajKTwSrMQhKjLfAgR+no/JZ9XepjehaTNg6E79EXhQ=;
        b=R3PbF7pEBsx58gQPASzscKacAB3jhrHFD2GAwxHCdi3zcD+xW7DBGvW9Nofi6jMbk/
         HN2GeG8V2Wq+yxYNVUZdVMIIokRNeH7OMUIN7Daa6tsoSzovBcNtjoGaLFWLOSJvsgSF
         zLIXakZX2RSjvttixbV0tjIWhrQAtO3rDcWAUCVC/AdF1Lgy9hW86yM58FR+9vPmezia
         B8oESkEtqB6XRkqviamqEw7TCvlnK7x/xJ6s/63J/D8d8TO3SSRseTYUgvnBmKpLL3TL
         Fm3FHV4OeV+U0tX29hXmEVznQfWUJ1wrrN+8J2KdmCoRuXjm8up4xGd6LsHBbCUPTyqp
         jGWA==
X-Gm-Message-State: APzg51A53vFzYnUnDDrOJp/iHTN+8My3x7szvCjXU+HWJFge2rSz2YRb
        Q4xUeOMcUYnxtt6xoxVHVmE=
X-Google-Smtp-Source: ANB0VdbVU5BiWYhvyyMTBIFoK9yrX8PJ3t+ucq2HRI04pxl3ZVvoRTOrj+GhMNTBir7B9E+kHDbnDw==
X-Received: by 2002:a63:ef10:: with SMTP id u16-v6mr14450079pgh.269.1536988161527;
        Fri, 14 Sep 2018 22:09:21 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id g6-v6sm14195676pfb.11.2018.09.14.22.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 22:09:20 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH v2 0/5] y2038: Make ppoll, io_pgetevents and pselect y2038 safe
Date:   Fri, 14 Sep 2018 22:08:38 -0700
Message-Id: <20180915050843.19183-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series transitions the ppoll, io_getevents, and pselect syscalls
to be y2038 safe.

This is part of the work proceeding for syscalls for y2038.
It is based on the series [1] from Arnd Bergmann.

The overview of the series is as below:
1. Refactor sigmask handling logic for the above syscalls.
2. Provide y2038 safe versions of syscalls for all ABIs.

[1] https://lkml.org/lkml/2018/8/27/651

Changes since v1:
* fixed bug pointed out by arnd

Deepa Dinamani (5):
  signal: Add set_user_sigmask()
  signal: Add restore_user_sigmask()
  ppoll: use __kernel_timespec
  pselect6: use __kernel_timespec
  io_pgetevents: use __kernel_timespec

 fs/aio.c                 | 138 ++++++++++-----
 fs/eventpoll.c           |  52 +-----
 fs/select.c              | 367 +++++++++++++++++++++++----------------
 include/linux/compat.h   |  20 +++
 include/linux/signal.h   |   4 +
 include/linux/syscalls.h |  20 ++-
 kernel/signal.c          |  78 +++++++++
 7 files changed, 437 insertions(+), 242 deletions(-)

-- 
2.17.1

