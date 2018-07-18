Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC20ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66FE2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQHYMtri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66FE2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeGRONp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:13:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42606 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbeGRONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:13:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so2019039pgp.9;
        Wed, 18 Jul 2018 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wQ4FtTefVrsuGIMQ8qqQbYwUzmqzETl/q8Te7XEAutw=;
        b=hQHYMtrie/HQ7mC5puvy3uHvbVIrALX+qQPOyi6cOOV0etge5ewjt57CGIPpxBwpQH
         lL4KPqKi9lm6kRJ2Cb2OT0sgF8FjtcX4eeyjDaTdcLLyW3/ROfemWfbx7FguS5Bxuvpa
         8L5U2o0SruqdInWbAazgGH9yI7HnyMo7ckHacqcsCT2AeR+OlhHBxy8bOhStGeZV4Oo6
         lTuG9Dx4ykYqGNthuGUdkdQxNpSj1+YKSl/uz+8Ubnk25bQ2WWQ238+xFBuizlIrbcuY
         uLyOB7YIvE2xrzPaJ5D3DSCIhW9hNyfIUl2/df4zXEdVYYhdXoBVof+jhGbQ8o5hrJ5f
         uggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wQ4FtTefVrsuGIMQ8qqQbYwUzmqzETl/q8Te7XEAutw=;
        b=ljtExGoeiZ8LYA8EwsXm+P+fPdD0B/Cdss2FipA/SyHZPLtzP6w0u8mYInAUb2z9vp
         Ax7o9o19TntbmNY3yRmdnrCcQaiwNq0xAmcqZL0NXF6QDPMDPvr+NCAgJCBbJHl6b+ZM
         PWts2PvOqWc535vl4rnyHtkl1H4fDThHO782lxQBlGebcQ5Zp6E9i1B+pBTplAMfhVDi
         I+PxvdBsoiT9hCEbWnIXcsLPcIQ++opfmzqAe7Q/rdZYGbgARKkPadtDlSBd2v5b47Fo
         7AeKFcUmg4AR0Nl10ckShzE3J6RNUS1qN8WkCM58OXfvP2jKRFpJuXwRCJ0MnHbOX3Pc
         ppGQ==
X-Gm-Message-State: AOUpUlHsa4jQNiwuWzIH+boaOOsth8pMAcRIu2HmXU0b0TJQ779xgIPk
        YYaXOtUORsC/d/VFdQ61r6E8qQ==
X-Google-Smtp-Source: AAOMgpfJ0F8EYtsIBXtegD8DYxnlyFDj4uWuJKI+tUyFqASAVGUXN0ww+aQsR8PWhk8g37Hw2UPVag==
X-Received: by 2002:a62:9042:: with SMTP id a63-v6mr5291608pfe.52.1531920946734;
        Wed, 18 Jul 2018 06:35:46 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id z11-v6sm9217203pff.162.2018.07.18.06.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 06:35:45 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tools/bpftool: ignore build products
Date:   Wed, 18 Jul 2018 22:35:25 +0900
Message-Id: <20180718133526.19669-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For untracked things of tools/bpf, add this.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/bpf/.gitignore | 5 +++++
 1 file changed, 5 insertions(+)
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
-- 
2.17.1

