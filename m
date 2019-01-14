Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEA4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2D820873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="TaN/Tsg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfANVFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:05:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35678 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfANVE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:04:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so1088850wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szdIF+Suhz10zCtWWxkhWdxc8OuoBctk1LJGyiLTiG8=;
        b=TaN/Tsg7Dn5637ORt0+damjozyB6kxjJBBcFpr7MxNsm03Sci4EfPgbJCnHYh97z7I
         uv1dajT1Y3yLUxPIOEzU6Ivo6XYk8V3XmABWTkmSe8NODX4FKSln0CBgVkT0nUnZhEpY
         bAkMI1tpOkZ9nd6lyAdHh9be+UvO2EMtfNd04QGWSG/bfho4N80ZcP1gFkDzg0Ev5zey
         HKoS7ZJ0F8h4WDDD3A2VHJ1agqbqf5o8V+cx5qHSram705NGf9pF5Cn+qlVMsAtTylkS
         BB1UPA0luSJV3hzRcYMj22IToIqc+8qtCaVw0q05lB+txWD7BkpkIjS00x2f9nn8C5Z7
         0/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szdIF+Suhz10zCtWWxkhWdxc8OuoBctk1LJGyiLTiG8=;
        b=pRvxXvmhvrOR+r2lZ7js975mqtWjwXCRGZvo4y9fuvDyahF8ewgW+pBhlZdryUFaZ1
         TW+LmoiEjbOaBawvHpF5YqwkrXQkmbeyTYYCTh8xbpTBLEtUOMW6mMVHPWGxY+0PQjAC
         N1CAXis8Vtw5FfHxr8/I8tVTXjw3E/OHHf+LiAanGSbUmEoFmZdwPnANw/BlitnJMlD+
         FVnOyLNrun8ER8GJjG7d3b0d+wiHECFcCRKUxhvoUpkkvlCztV1GWWYM51qK4WWcZhTg
         Vjnpxlq/eX50HkdgzGxJzb1uLAey7Ofu+f3J+XnfvTf9mggOvdx6AOooMEITJpJ1TgsK
         cpyw==
X-Gm-Message-State: AJcUuke1wlS++N47W6f8fYZ/erR90NbqGuCqwJULNB6LOuORtGY7UV9h
        PWuIgQxgGoyhv+HeLCvHmWvu1Q==
X-Google-Smtp-Source: ALg8bN7bD2SVLyj/PwXxjjj02Ssal9FS4zY/Q0FFmaQzVj2VCzInxbBDj5/IixT5Oc+SSx1ujT2BjA==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr689771wmf.17.1547499896379;
        Mon, 14 Jan 2019 13:04:56 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id s1sm106981548wro.9.2019.01.14.13.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 13:04:55 -0800 (PST)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH 0/4] gcov: add Clang support
Date:   Mon, 14 Jan 2019 13:04:22 -0800
Message-Id: <20190114210426.177543-1-trong@android.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 kernel/gcov/Kconfig    |   9 +
 kernel/gcov/Makefile   |   5 +-
 kernel/gcov/base.c     |  78 +-----
 kernel/gcov/clang.c    | 554 +++++++++++++++++++++++++++++++++++++++++
 kernel/gcov/gcc_base.c |  79 ++++++
 kernel/gcov/gcov.h     |   3 +
 6 files changed, 650 insertions(+), 78 deletions(-)
 create mode 100644 kernel/gcov/clang.c
 create mode 100644 kernel/gcov/gcc_base.c

--
2.20.1.97.g81188d93c3-goog

