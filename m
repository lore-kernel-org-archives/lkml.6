Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042DEECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2462084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYDcAlk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2462084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeGSMxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:53:08 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36467 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeGSMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:53:08 -0400
Received: by mail-pl0-f67.google.com with SMTP id e11-v6so3569051plb.3;
        Thu, 19 Jul 2018 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7yHEkI2qyi3/Vjo55C5HCqG2svJZrXiyo43jXf/t2c=;
        b=UYDcAlk9lRuQdda/hKwR2cv2pcpjq6a3lWhFi5h04Gx1pBQdQ5aVX2BcRcHpU9lY7J
         ARvM7miRiB1GkCZWEj4AR02MmGO6L3A1BTg5K4Nbe9XmAvfrpBVKTJuC/GM7iNgUEdyi
         jXjPh4HgWTmS2p7bjuwyxgwaTcfVMeF7dYw8UnoPcOcvx1XlAJGkqvQ1k8nF0Z6nGjlp
         g2h94dofvLkkTJTu5dpo2piX6UHKCxiLd8d2cHYlqK1tbxxQDNLqF29jqR+57WBRHnf8
         K26wIKOuux5YKAkts1skIFy/MRQpZiY30wutAaiKW/DYOqoJV4SteDlWKJKKyEz9xYZV
         BGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7yHEkI2qyi3/Vjo55C5HCqG2svJZrXiyo43jXf/t2c=;
        b=rfHUdfabztORZ9z7yttCtwXBsQjRiaUSXWK5UbUz7eirAr+wgcvGhQPyv+svr01G/j
         Yh8ekKuluiMOiVpMv8JW+9v69kk0066EZfqTFaLU1o9XDhNUNVGwob49Eok1Fn5qMWfr
         rdsjh+etAEjiAJyghH+NV1W/4KJvc3ZDb6KsHqlC5+2nNu8GPfNpKiobTZgY+jcbI/LA
         Daepf8nCrW/ddiDP7B++U99RDBNK1WR2OLKY38syGxWv5KtvXmnjRXMMg5sxn6J9pW9+
         g3i/BEdWDkANI9MJjxsLO9Q43y8KZFnVk+Mxk5wj6UbzdNvpMIP+f1KLCK/YBccWfDKR
         2LOg==
X-Gm-Message-State: AOUpUlG/YHuGncy4MatfhgRXiFJGOH9d89cNishoqrBjrjE5OqcJJxN8
        xRARSeodtQZPkOfFuXoHSY0mTbmp
X-Google-Smtp-Source: AAOMgpcQ2gceppRSo8CL4mSUpnbblVaZAECBa5M5pR4eI+YoxKWIDuUTJCo3qx+B1okOSDYxM4xUdA==
X-Received: by 2002:a17:902:b693:: with SMTP id c19-v6mr9935418pls.114.1532002216784;
        Thu, 19 Jul 2018 05:10:16 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id z123-v6sm8726490pfz.16.2018.07.19.05.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 05:10:15 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] tools/bpftool: Fix segfault case regarding 'pin' arguments
Date:   Thu, 19 Jul 2018 21:10:05 +0900
Message-Id: <20180719121005.12018-2-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719121005.12018-1-treeze.taeung@gmail.com>
References: <20180719121005.12018-1-treeze.taeung@gmail.com>
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

