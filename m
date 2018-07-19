Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE71ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28877206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeqAlM0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28877206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbeGSD0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:26:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35982 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGSD0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:26:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id d14-v6so3127704pfo.3;
        Wed, 18 Jul 2018 19:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7yHEkI2qyi3/Vjo55C5HCqG2svJZrXiyo43jXf/t2c=;
        b=LeqAlM0LI+V+0GSzoBUnDGGMPIqZEWYcf/G+3i0pFcOliYaMKL4P5CtV7jhKvZ4V/h
         rf3jRdslEPCVb4oEcI+hrPTc6sVK+PQLErlcRjHKjbe3qiVZ7Zf+190KcdG60j1m21gb
         dlBUkSglY18yjup10mzmPfLuTXkOlpbLjrSJnDGSh5hpCktND9fFOO1g28OBsbMjQve0
         N0Cx6K2v9PVMQxqUZW6XyEzJcqynV+a2mHDpA2ThCdT1rgahJ33MoTfprdWcZ9dUL5vl
         CWjjJeYpQEs7t5YzsbKKPYcunKtgTDKMIG3rhzVgwXF6YU9bY5oBNKj/VTUL9TMCUNaD
         ou6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7yHEkI2qyi3/Vjo55C5HCqG2svJZrXiyo43jXf/t2c=;
        b=TnJABXoYdH4+M5twnZ5mU7V5KkbWwhK1banOyC9EjPzztDhR20uGrAUUDUBvdObbdK
         KyAvLDyffVGGV5gQxn9bT54hZEwPwVRsI/ehihhQGpqZRiUuoFEiiuuFrfpX33/6ERJK
         4dXg2k69gwLrEEbM1TfAuv5Y8CUD58rE17oT3QTK+Dwh5t2cdj5885lBzabOU5Za9Xhx
         4PYhkYRnu5tKqF3rjButIYoyCSUQMbFz50ecz1lchMLIy8Vf7DeOzbmTAaQZgmJPA5jE
         hi291mWQJBliENU5luU5v+cbY8uhIECcfnfb07j7kFu/RVG3ZH902E1qEtK0AbYYuqXs
         5mVQ==
X-Gm-Message-State: AOUpUlGU4ZnnXc+Zk060b6h9sf+u3NayZHHQdM2mTD9p3dR6NXVFdgQL
        qGrpIq9bJa5i8H6z6fTy2Vg2ow==
X-Google-Smtp-Source: AAOMgpcFxDmsIyARarKJ/d5/iVfVq2qqzDm+YA0la++Oi+iaSEX7cF+G4dQL3aFJAiFVkq4YwvFSWA==
X-Received: by 2002:a62:f50b:: with SMTP id n11-v6mr7662470pfh.120.1531968328113;
        Wed, 18 Jul 2018 19:45:28 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id c1-v6sm6769900pfi.142.2018.07.18.19.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 19:45:27 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] tools/bpftool: Fix segfault case regarding 'pin' arguments
Date:   Thu, 19 Jul 2018 11:45:15 +0900
Message-Id: <20180719024515.6659-2-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719024515.6659-1-treeze.taeung@gmail.com>
References: <20180719024515.6659-1-treeze.taeung@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments of 'pin' subcommand should be checked
at the very beginning of do_pin_any().
Otherwise segfault errors can occur when using
'map pin' or 'prog pin' commands, so fix it.

  # bpftool prog pin id
  Segmentation fault

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reported-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/bpf/bpftool/common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 32f9e397a6c0..3f140eff039f 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -217,6 +217,14 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
 	int err;
 	int fd;
 
+	if (argc < 3) {
+		p_err("too few arguments, id ID and FILE path is required");
+		return -1;
+	} else if (argc > 3) {
+		p_err("too many arguments");
+		return -1;
+	}
+
 	if (!is_prefix(*argv, "id")) {
 		p_err("expected 'id' got %s", *argv);
 		return -1;
@@ -230,9 +238,6 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
 	}
 	NEXT_ARG();
 
-	if (argc != 1)
-		usage();
-
 	fd = get_fd_by_id(id);
 	if (fd < 0) {
 		p_err("can't get prog by id (%u): %s", id, strerror(errno));
-- 
2.17.1

