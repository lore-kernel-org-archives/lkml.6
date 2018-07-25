Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37479C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47FE20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgxEYkGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47FE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeGYHrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:47:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41441 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbeGYHrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:47:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so4595611pgu.8;
        Tue, 24 Jul 2018 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AOOv9K0ocbdGQgb1yuxUzPITfwkwtnPD9ssYJK7oDoY=;
        b=tgxEYkGnIU3A+txij1ieusSIPD0ft9YnrGIMXYu9iUhdf0NnRVEcgqqhAC35e1cR9+
         HR3cMhJVb5JhghKhm5PTe8dpcMewnas9YZCDvyGqLACaUqaPTc+XSdqPR4qziLMhpUa2
         gXI0y0oO1DuPchXYmRFph9w0bdwjnlttNZBgxF4BGN3wv1ioUmZCNA8Ric6gfeZ2nLCo
         0AfDgTHJOyNNp/2C9GK6HlPfntxFb1+mDae5D1i5kZbgnkpAW3FaFIf1Fnu5gUdO+fTr
         WRIOgQagw9pGjfHOLNo08orY/prtu90GQUlt0aLtHDaTrZCXMcFUj4MgHslP4wj6FAQ+
         KJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AOOv9K0ocbdGQgb1yuxUzPITfwkwtnPD9ssYJK7oDoY=;
        b=B8MI6nWCUqWWvwySJ71Q/YQ8pbGwHuUyD/RNSgMttnKSFNhXWQgMrLPFao4EzJ5t59
         1Qwdq6TeFHe7X4Nul5IRw8bqv9T5/47FltVCAXxMOERFeoCzJgy8ZdkCvM8e34O4VD7c
         5osIs2+SGHX0xtJkDicZcIDiKi0ggG6EXbqKX9tlIk1zuu4MU47i9MZEZwHcfZd8lElH
         SD6XZIhVQ3XRuMgHV7NIMP39jNtcsNAxPEvVbRzUyGGYimCoEZzeF60HixWq1pLpqU2k
         PK0NWtlDTQtFvPzbrMGxnik+AN++cx0SIlH0r8y5wZ+GIAcMfRLJCo7BvAuPTL9ltUEo
         0WLg==
X-Gm-Message-State: AOUpUlGXy2Wp91rDlEGPj9E2uYT5C5a1zvPHuLJeWe/HxbVn8BlaL1p9
        BmxCREz81q429EstfyC6RszGzMT1
X-Google-Smtp-Source: AAOMgpdyTljfx7x4OFB9ch+1i92+CQ2/zST9jtmnFW0iQCjrB61+cpJ9vU6DN3XyYQz7QOW7QWEOaw==
X-Received: by 2002:a63:b40e:: with SMTP id s14-v6mr19477442pgf.9.1532500619156;
        Tue, 24 Jul 2018 23:36:59 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id q28-v6sm24631594pfg.144.2018.07.24.23.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 23:36:58 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next] tools/bpftool: ignore build products
Date:   Wed, 25 Jul 2018 15:36:51 +0900
Message-Id: <20180725063651.19743-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For untracked things of tools/bpf, add this.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/bpf/.gitignore         | 5 +++++
 tools/bpf/bpftool/.gitignore | 2 ++
 2 files changed, 7 insertions(+)
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
index d7e678c2d396..67167e44b726 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -1,3 +1,5 @@
 *.d
 bpftool
+bpftool*.8
+bpf-helpers.*
 FEATURE-DUMP.bpftool
-- 
2.17.1

