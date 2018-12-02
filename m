Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904B4C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F05D2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhpFSbbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F05D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbeLBIHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:07:23 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:40509 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbeLBIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:07:23 -0500
Received: by mail-pl1-f171.google.com with SMTP id u18so4885413plq.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 00:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o2VuC/EXu1Op33/TJsNw+jgXAVTp5i10xfmjsWlEI6g=;
        b=VhpFSbbdYEDtuGFgJCD2fYNfSEI6N14IviP0a8zEQfG+Tadav3CV9AblJUexCLTVG/
         5M6lKKC7JzjQ+xNSsdDdrGYAOhPUsEFsboLmf6Uwyw/mSnIaLPpU+Jt5diwZcde3D2pI
         bpEbxwG/0MApI7wU6popvbeGbe81vzgp4THYxSnzPxeczUh24LZrAxRnINmPzPLhbcQE
         e2+qLGmxFkHoDF3vXLACI2fqCR7U1H7lvJD3jVitKQwiGvk3J9Fphflc5lhFDuW8fOx2
         17lwKENA8TQaJL2c1R/rnoXA8qNUywsNWbFHRhYu+FkfhGq/DUMOZswaWK3DaGqBE2Ez
         WS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o2VuC/EXu1Op33/TJsNw+jgXAVTp5i10xfmjsWlEI6g=;
        b=fmuhYDqbDPQD8oVMxUHrUowkxK9E52T+mZomTfZEFfamq4NTgOoSlptl1AWhQsK9Pk
         vW0h1FSO5zMvRagR71iKhpbAPLOMNuEmJXQYZ7kUlKVMkFFn7ux0KIC7Vu/9t1A3ImoU
         t9oOSqIvBacKhMxyBiKR0ENhIDffHucVh3tiGv0syehWOC8UkXufRY5M0Y5A1tlJ47ZB
         n5yxNFpIADrPAVCIqv5wjQMewHhmtrpXcHRHUgphO0tkpnIb+mTYYW+4nucR0jX3eJoQ
         TKxwGYkuFSwVRJ2gBDzShndqO1DX2lcLitZRXEhRD1/JrUF7MO11rHHHvL/8/ROruGO6
         LW3w==
X-Gm-Message-State: AA+aEWYohsPKXm8N8zt4Jo+ViWvxUKPzcvHObHmmwC0G6oBUhPmEzoV7
        O9QMxjc1hjCNxnRb1my0Rdk=
X-Google-Smtp-Source: AFSGD/UMrXjorwVJwQibrda/9e97nthRECb3lClLiH4ZqcqnKcrQTNI9WBtcrl1Y4DjVZpCQJ3FXsw==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr11521059plo.96.1543738034419;
        Sun, 02 Dec 2018 00:07:14 -0800 (PST)
Received: from localhost.localdomain ([115.143.98.81])
        by smtp.gmail.com with ESMTPSA id v191sm11862951pgb.77.2018.12.02.00.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 00:07:13 -0800 (PST)
From:   Sihyeon Jang <uneedsihyeon@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sihyeon Jang <uneedsihyeon@gmail.com>
Subject: [PATCH] perf beauty mmap_flags: Fixed syntax error Fixed missing ']' error Cc: Jiri Olsa <jolsa@kernel.org> Cc: Namhyung Kim <namhyung@kernel.org> Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Date:   Sun,  2 Dec 2018 17:06:51 +0900
Message-Id: <20181202080651.4685-1-uneedsihyeon@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index cd41023107d7..32bac9c0d694 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -20,12 +20,12 @@ egrep -q $regex ${arch_mman} && \
 (egrep $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} ] &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} ] &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-- 
2.17.1

