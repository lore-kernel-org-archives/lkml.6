Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88471C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4817020657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="GJGlEpOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbfAOShI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:37:08 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:45486 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfAOShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:37:08 -0500
Received: by mail-pl1-f180.google.com with SMTP id a14so1665107plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYcv8ablxl0ZbOIh3xmsnvFxJ8XJ9dtBdwlkRCdLqts=;
        b=GJGlEpOFY4VXTRpmaHEbLT5uqHbpztD6c2VCIHx6PmWDzuWBaBAr0GXTRxqX8Drrhi
         itJYuQ4XkUy0bnBpIk5LX5vGASv/nOE0kTxVK/xrpet/S9iKTBAJ0W3Z5e2diicXqjpR
         SQX5joNeYV7ULb34LCURQifkfzteLarMQSXIdhHClqhbrINGys+qbmRJ3kefhwo5Ry25
         bMHD06zvDQ3+ON3fYwr+5anmgL6gCaOmyanBOf6xfF9hLXw9EqjPrSCugsqF5iZJTsvc
         RbaOBfUk8PxMkT/ghyEtiP7vuAHFIR2QqyBK1gRg/QUEo0j3zTMQESU7mFnSkElb79Be
         toLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYcv8ablxl0ZbOIh3xmsnvFxJ8XJ9dtBdwlkRCdLqts=;
        b=E0I2FcHqgXvQb6KbH2xzw9kB8LbZfvEnXFVXkgJh0rVMeJw2c//OyFPtNWJ+m5w9bw
         qGNyxCQ0mRtt73fZ7/olxsOuI3DQH41y+YaVtTtG7w+5Z3PPK0BmWOP5x6VcJoillnaP
         oMcI70GG2kJW+oyNgTiTPvKVNBR7QlFhX87IBx2sGktkSaKgJa9PLcBrSIBGeRvjbcy7
         4sGHpx3YvG/bvZMUfRNvTVxjtQGTZoSiL3Rw6lL5DPzGzSwBHFqbHmhsLjZvnN1EuD6B
         pY15eCowoG91Ds24SYmX9y5nnw9ojCl3XLBLnB4Q3WFAH/FZz9Y7YH5hejyv28TPupih
         TpKw==
X-Gm-Message-State: AJcUukeAn62DDf/n0InpHKjrfIvdkw0kupEVe1yhvrrZgBcDLHaIt/+7
        NGMqjnHvDsfsmJ0AryKKudu9ag==
X-Google-Smtp-Source: ALg8bN4WpQc7oBF4PcyXGEb+GNrW6qtpE4MOlpJ60w276ecem1KfMFn0b8BG5SVVylTMY8c0vbvNvA==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr4251720plk.206.1547577426807;
        Tue, 15 Jan 2019 10:37:06 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id i193sm10156113pgc.22.2019.01.15.10.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 10:37:06 -0800 (PST)
From:   Tri Vo <trong@android.com>
X-Google-Original-From: Tri Vo <trong@google.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v2 0/4] gcov: add Clang support
Date:   Tue, 15 Jan 2019 10:36:39 -0800
Message-Id: <20190115183643.120619-1-trong@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tri Vo <trong@android.com>

This patch series adds Clang supoprt for gcov.

Patch 1 refactors existing code in preparation for Clang support. Patches
2-3 implement necessary LLVM runtime hooks and gcov kernel interfaces.
Patch 4 simplifies config selection.

Greg Hackmann (2):
  gcov: clang: move common gcc code into gcc_base.c
  gcov: clang support

Nick Desaulniers (1):
  gcov: clang: link/unlink profiling data set.

Tri Vo (1):
  gcov: clang: pick GCC vs Clang format depending on compiler

 kernel/gcov/Kconfig    |   3 +-
 kernel/gcov/Makefile   |   5 +-
 kernel/gcov/base.c     |  78 +-----
 kernel/gcov/clang.c    | 554 +++++++++++++++++++++++++++++++++++++++++
 kernel/gcov/gcc_base.c |  79 ++++++
 kernel/gcov/gcov.h     |   3 +
 6 files changed, 643 insertions(+), 79 deletions(-)
 create mode 100644 kernel/gcov/clang.c
 create mode 100644 kernel/gcov/gcc_base.c

v2:
- Reorganized config dependencies, as per Masahiro.

--
2.20.1.97.g81188d93c3-goog

