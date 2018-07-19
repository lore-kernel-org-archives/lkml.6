Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE440ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618B9206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9BgoJde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618B9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeGSD0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:26:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43418 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGSD0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:26:14 -0400
Received: by mail-pl0-f68.google.com with SMTP id o7-v6so2904111plk.10;
        Wed, 18 Jul 2018 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wQ4FtTefVrsuGIMQ8qqQbYwUzmqzETl/q8Te7XEAutw=;
        b=I9BgoJdeROf8ITkpdC1tpDDvtpto9UALhukXsVa2mEedMsiO8L/FY/6nAglfVokfWv
         QwFY7O6rMvFmfodkiMvcmqtAAvn3a3NIiK7e28673J2D2CcclOcJQNeBhwgFJ3csSVL0
         LskSS/FUl8C+0YlDDC7RQ1pR75f98aMpeQiDWbi59OzfCLpD7VIq56/vZQv99BFv9cXG
         ax2J37jffFHbAPW2TLVS4ilpQqf8st5ukWCtAMfqZ2FBCn1pPUBgGkstHS3rDSv7US8h
         185lwDwEU4uCVpDnWNK3cAX1/YQ6wyngDQKfwTbgpZlAaa9J/UKKcsMCltWzdal/LP2e
         KKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wQ4FtTefVrsuGIMQ8qqQbYwUzmqzETl/q8Te7XEAutw=;
        b=GVed19MRvfZzQDgBNGTYpJQAFsWLqJ4KgCbuS4DvyXEVWwx35jUcGK5MTdnG4qUbUt
         6QqWuOH6b3SP2q4wNWQrUKwbBpkJbnW2QeN0Mr+TWJH/d8AUxWHpxMpk2DhWNZXJ3pvb
         yOVfYZNAWnD2+omOYq7PrY6b4K/glWaoMPjmTdX/lLZ5VeZ2NpkS6LoKy2vX23RwkTfj
         DnEJJUIMMs8SfNaxbMhVC7ml6Nrf+84sZU93aXMB+dfeoUARf+vUitY3kpqjOFE2llBx
         kFwWNUa0Jrl6Y2+qgwETe4bzKtkfEX275m3H0wdlCBdoRboOhTi5gctr9zAFHPUBEeiL
         /ALQ==
X-Gm-Message-State: AOUpUlHwn6hGvn8dHdrSXQjEDOt8dKrrx9v/jZ2fm6V4+92MEIHtkxWD
        UG74TU8YCRySqYQcCem4jRFKcQ==
X-Google-Smtp-Source: AAOMgpcCrXj4yInUTZilBvOxqusyN0UoaFmMpOn2l+d0r7plyHXbn1f0gyiENM8epGuwoORqm0ufRg==
X-Received: by 2002:a17:902:6e09:: with SMTP id u9-v6mr8113977plk.13.1531968325444;
        Wed, 18 Jul 2018 19:45:25 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id c1-v6sm6769900pfi.142.2018.07.18.19.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 19:45:24 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] tools/bpftool: ignore build products
Date:   Thu, 19 Jul 2018 11:45:14 +0900
Message-Id: <20180719024515.6659-1-treeze.taeung@gmail.com>
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

