Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E9AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1381E2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgRLfT4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1381E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeGRONs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:13:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42199 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbeGRONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:13:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id l9-v6so2219915pff.9;
        Wed, 18 Jul 2018 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q/vKiI+Uaarkqq+CU6r4VtkCm6YsK5C5NdCa4R57fmg=;
        b=BgRLfT4V7bTMQm4XljYeJ8a0nl86whKQgVfNfcW2zofesP7ty7y8Cu/k4BS8+ElDjZ
         0ObeJ/sE6PVjbw/sfN/XK6tE2+PR7yNoZumpHLdOSQifFoVOmmTW9Mu2D6g3H9fyfinZ
         8KIzj09XOGJnXvTwpzhXNMdWteXnQXlwbn4baF4lpN2LecH1OpzSCIoNVK2qilQHLwGw
         mCvIAovQIYvKsUbNkz4WA1PbnckfPZIIhe5Xk4aZb3kC1l7AyMtXz3AsE6qxy1zKTEGY
         I8xVMFgWW/LX/lPOCmx/rvJe905kQOFKLoyIXnoelWD4Gqf1+U17SgL6vIKdrj+S9u+K
         WCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q/vKiI+Uaarkqq+CU6r4VtkCm6YsK5C5NdCa4R57fmg=;
        b=WaJlVM5i20GbQhJ+ubcWOqwn36GYJr9ADnuOgb0eQ1ldXfMrOqN1YyIhd5FBJTsHbY
         RKspAP/7kfUXfARgyKEdhLzY0t3CeRpzvIOTjx/ovpyxPyYka/Tk95d+x7gSDymFovwa
         hVRrQuT7at7vAdg84Ul04P4maTGJlOYH8GOqw5+R1KvvcTZYhLycCaG5m5YN6CmUV4SS
         YphTojoAtAjPd6eAm2xQ6WprIZKHvt6Lez5347Pe1Ad/sD3mT+ZAzRKSjtItYy+TwLW7
         6bJQspNKlYLPApt3F8grGc7eUvCCp0PpZmgTYZh+hLs/OGspVeB7/U2oWY5EMs6kLaF8
         RoCg==
X-Gm-Message-State: AOUpUlGAKfGQ1u/qU/aFqE8QMveuDwBAa2OwOqUlMLZrvDMa8PF4sgBM
        IhcfpzOamMy3+qqebegDhrE=
X-Google-Smtp-Source: AAOMgpenw5gMc3KxGLy3cii0Lm7TxTckuDtoWZqFT2X1Zb19alZnY+2kB6H9IYbbS2U4BoOGlQ5JAQ==
X-Received: by 2002:a63:a011:: with SMTP id r17-v6mr5623929pge.90.1531920949560;
        Wed, 18 Jul 2018 06:35:49 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id z11-v6sm9217203pff.162.2018.07.18.06.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 06:35:48 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 2/2] tools/bpftool: Fix segfault case regarding 'pin' arguments
Date:   Wed, 18 Jul 2018 22:35:26 +0900
Message-Id: <20180718133526.19669-2-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718133526.19669-1-treeze.taeung@gmail.com>
References: <20180718133526.19669-1-treeze.taeung@gmail.com>
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
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Reported-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/bpf/bpftool/common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 32f9e397a6c0..b1e1ba9e1c90 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -217,6 +217,14 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
 	int err;
 	int fd;
 
+	if (argc < 3) {
+		p_err("too few arguments, id PROG_ID and FILE path is required");
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

