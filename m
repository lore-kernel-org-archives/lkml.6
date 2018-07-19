Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B7C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7BA2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRJSkPtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7BA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbeGSMxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:53:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38482 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeGSMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:53:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so3574158pgq.5;
        Thu, 19 Jul 2018 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=21pKPZhtnO957syxU7OiO14AZTXWGdj1VCApUX7g3w8=;
        b=BRJSkPtvzBOI2k4v+mu5mxbMUjm6lFT696gcWNvHC9sSx79Q0zmtV5t+KXyXLMR4UZ
         Zl3oef3FiW4hAxQJ7TXAhgJ7QieO3u88vaAq2GKuuqTmfh19bLZs98gQJPq8ZguHHjWn
         rNqgCSKKdhauMmSpIXjLugfs/UTrDoYGIFOK4Pg3IZoy/Ex6dIFyBAe06KeZ2AFbpgMF
         00OOHQ+2C4zpZ6RMaTK90Q8lpjCHXzViS0ClMSHB+6kCUCQp6kHiIHXz4xhz3Q+bQyNx
         S4AlvuzqDQm06iylNPgzGV9DQM3YCtDyRPzusq9DSQaxBLMcjmG2oJ9zCaMNfwWe2QqD
         wu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=21pKPZhtnO957syxU7OiO14AZTXWGdj1VCApUX7g3w8=;
        b=fL7zfJiQqXafjXDqBvv0Tdl02WcRXqGEdWm9/eUubHvsuspDrA4UDPhRtrFAg1rbme
         WHNZFbPPpkiw+OhIvTAyVs8iTl6RL/pZLofSgfLOTfytnrjmMGT81T+XBncqkiqTVDad
         M0rIE4d1BEKhlg+lJhTpvqhmAs4o9Y7/TqqbMICMwGd7I2fxv7yCDZ71W/+v556OWYsC
         DLGjbeQA5T+wOYmiycOCUw07zV3RZ4TXx82bsYOkQtqkHwcDqcAFGFbIK44gfCsB3EPH
         CuMrk/xjn19F8OUXTfPUvO8wyJgBhHXrIvrQoIJ5c6ImZAp0zuJmiLOUNu+RvlogxKde
         j7hw==
X-Gm-Message-State: AOUpUlFUKbzEcpxBtY7LQUQp7sx/YjMxot/tJG4X6FY/VjQvmgZHGbhY
        1XKRiviFtQ791Yds619PaU0=
X-Google-Smtp-Source: AAOMgpeTuvbG+bwK+L4fbPaem/S+9afo85FM9A0IoXTwAx3mimTQqOvcKfC+xRXmretAoSZHI+mNug==
X-Received: by 2002:a62:4808:: with SMTP id v8-v6mr9309310pfa.89.1532002214027;
        Thu, 19 Jul 2018 05:10:14 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id z123-v6sm8726490pfz.16.2018.07.19.05.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 05:10:13 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] tools/bpftool: ignore build products
Date:   Thu, 19 Jul 2018 21:10:04 +0900
Message-Id: <20180719121005.12018-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For untracked things of tools/bpf, add this.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/bpf/.gitignore         | 5 +++++
 tools/bpf/bpftool/.gitignore | 1 +
 2 files changed, 6 insertions(+)
 create mode 100644 tools/bpf/.gitignore

diff --git a/tools/bpf/.gitignore b/tools/bpf/.gitignore
new file mode 100644
index 000000000000..dfe2bd5a4b95
--- /dev/null
+++ b/tools/bpf/.gitignore
@@ -0,0 +1,5 @@
+FEATURE-DUMP.bpf
+bpf_asm
+bpf_dbg
+bpf_exp.yacc.*
+bpf_jit_disasm
diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
index d7e678c2d396..103cc5b5b446 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -1,3 +1,4 @@
 *.d
 bpftool
+bpftool*.8
 FEATURE-DUMP.bpftool
-- 
2.17.1

