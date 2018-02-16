Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x22539iEkzJv1GqO0CPvi5v5Qomu0IBGrlgiRjA690RydQYR36zsNJVjj807xrKB0Ug9pNxus
ARC-Seal: i=1; a=rsa-sha256; t=1518744296; cv=none;
        d=google.com; s=arc-20160816;
        b=bSX1DBLenWs3m3TBBsP4O/MCpKnsxII38QU9RmynI80ag90mCCsc0DY5bjCSW9g5Dh
         SEkUIOpnHNrBIjibTn9GTFPuTZkUbO6ZjS7Y91IyrMq/tyCGKAztWuGbxLQqgYkXWBuA
         rTI/LYVDnZpQSbP7HAta+YvnPXYf0RSLPhdsHJwhPvhRppalbHW7lqQaD45UxGcGFBaA
         VcDBD5pI9RxJ8/CYuD9/mBVWL7EsOwDjUtJfLyQjA1eZw69qwg2X7+L5LeGQ7wECLDab
         61WOnYhoZs4Edf2djLS7xYGToNtQgcFvRS0vsIEuvogHdH0dfDmEeTA1LGanYLmxEBW+
         PAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=NlbK7Gw8ap1T1etK3aN47C4Ub47XG0c1EkdugCUTsxg=;
        b=h9Bv7+y9jwrWQ9b4b2/ck1PNmHWs1/RxGds3H5/das2UuoAcVceSA1OTA85cUL6wCp
         FJDdrge94H8ubKuUH6k0RaDNrg0pzTZZ0FW5n5+qdQVDkTWxb9HI+cyWXcFlO457Rgj8
         bY1Q6Ep82TQ+Be9FXJhLs8jEGO8W94LgHVUAveVFCtM9gUptij9rjlIiEWKSHjQGpso5
         g3xFN3xgxnOKw55F37K42/2iuDXgQ+tU8NZLZp1yNHEbdt9LWQXyA+jadjgRg12cozo9
         RxkWqS7qr1RlsjtrxA3c7vUS/F3cQafU9gvizJVQOgEcnD41GEMtRQdULX5Wk8ETjLUM
         gPBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757073AbeBPBYz (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 15 Feb 2018 20:24:55 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41903 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757069AbeBPBYz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Feb 2018 20:24:55 -0500
From: Laura Abbott <labbott@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Laura Abbott <labbott@redhat.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@android.com>,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Liam Mark <lmark@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/2] Ion unit test with VGEM
Date: Thu, 15 Feb 2018 17:24:43 -0800
Message-Id: <20180216012445.17264-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592518819320805350?=
X-GMAIL-MSGID: =?utf-8?q?1592518819320805350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Ion hasn't had much in the way of unit tests and fixing that is
something that needs to happen before it can move out of staging. The
difficult part of testing parts of Ion is that it relies on having a
kernel driver to actually make some of the dma_buf calls. The vgem
DRM driver exists mostly for testing and works great for this case. I
went back and forth about trying to put this in the existing graphics
test suite but I think having something in the self-tests directory is
easier.

I'm mostly interested in feedback about the use of the DRM APIs but I
appreciate any and all comments.

Thanks,
Laura

Laura Abbott (2):
  selftests: ion: Remove some prints
  selftests: ion: Add simple test with the vgem driver

 tools/testing/selftests/android/ion/Makefile      |   3 +-
 tools/testing/selftests/android/ion/config        |   1 +
 tools/testing/selftests/android/ion/ionmap_test.c | 136 ++++++++++++++++++++++
 tools/testing/selftests/android/ion/ionutils.c    |   6 -
 4 files changed, 139 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/android/ion/ionmap_test.c

-- 
2.14.3

