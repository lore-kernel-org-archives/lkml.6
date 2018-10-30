Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E651FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB63320823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLS5aEgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB63320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJ3SyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:54:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52104 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJ3SyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:54:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id w7-v6so44513wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NuxinlPFkTFdjaEbQkXHMBa3Mw58yZFqIfMCUEnEDSY=;
        b=rLS5aEgWL6fDLTgU58G5ZB9HwHHBeowRFymG8eSvRJY2YwW6XNTNxvxs5AFDa0WCOR
         N/n0rcFSbIi6+5sq4HauX8VPp2pKXMiw0a7EwJzQDLIfvEqeu/uOBGRUUL6ch4SPLjlY
         D2RrZFxq7WUBe0bNEAbkHELw/4oJ2WX9f/zZptfFHiHN7i8V/JqqfKm1sXa+d1ULgi2r
         FLvPLcW1ZT/BO9spbf1H5ip0oFx16zug2gajmwx6nbx4atKDZo+msiEypwH9npzD9Cj1
         6+cjm4j5BDxLB6KvnSSS6O9qhy8RrYp2t6DBu4ZjCHXw0f239udR7uSj1AxIbuqBCVjH
         ibCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NuxinlPFkTFdjaEbQkXHMBa3Mw58yZFqIfMCUEnEDSY=;
        b=F8yOkOicIMfNQgD2KMPvlPMhjicUPmW60yhnF/n/N7v8wdtK1DzmeUCCUP4+ylkpCh
         rMrbtXhpYiIvn0BszOSgtFcfp7Ufi7IokHZD5IoI6xdL95PsPEKZTDnnZmVx6iA+95r0
         kw8yTOAoluwauNDME9HW/3rG9kdVhUsR29AwCQKKmjX/hNWSttBq4zCnGJOUHrL9Gozx
         ET1Wa1X1qTuB/QV9lO5XqValm/yBZ2WS+tOm3aFIT0b0C2MAunfntviA4Fo63pZMYlmk
         xWLyPxGOhcbmrnMHW1BmuGP3R+ybmVoqdWEuqkJKvRjMxX1+eHd6X+ooF4b+qYJA9VwE
         jutg==
X-Gm-Message-State: AGRZ1gIFKDe8mbZitNqlhJOeY4Q+VWxm6acb6WDGcQX62L3NecOsaiD3
        PmzycMNC5xw8UxgaM1Qyosc=
X-Google-Smtp-Source: AJdET5ch03jlyaZ8QsjzPLguPHICXfvserlErz048N4EwfQi8L+ZjEqnN0qYfgCiyNDePha1y/3uWQ==
X-Received: by 2002:a1c:f60f:: with SMTP id w15-v6mr1228836wmc.101.1540893681699;
        Tue, 30 Oct 2018 03:01:21 -0700 (PDT)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id f1-v6sm18420825wme.23.2018.10.30.03.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:01:21 -0700 (PDT)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu, green.hu@gmail.com,
        deanbo422@gmail.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 2/2] doc: re-run features-refresh.sh
Date:   Tue, 30 Oct 2018 11:01:07 +0100
Message-Id: <20181030100107.4590-3-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181030100107.4590-1-david.abdurachmanov@gmail.com>
References: <20181030100107.4590-1-david.abdurachmanov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some arch-support.txt are out-of-date.
This also incl. riscv in sg-chain and pte_special tables.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 Documentation/features/io/sg-chain/arch-support.txt           | 4 ++--
 .../features/locking/queued-spinlocks/arch-support.txt        | 2 +-
 Documentation/features/perf/kprobes-event/arch-support.txt    | 2 +-
 Documentation/features/vm/pte_special/arch-support.txt        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index 6554f0372c3f..41ea6f738b38 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -22,12 +22,12 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 478e9101322c..beb013a72a90 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 7331402d1887..bfe41d68b7af 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -20,7 +20,7 @@
     |       nds32: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: |  ok  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index a8378424bc98..5bca00664a4f 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -22,7 +22,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-- 
2.17.2

