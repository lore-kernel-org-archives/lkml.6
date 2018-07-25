Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DEC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE6E20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTDhv9m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE6E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeGYHoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:44:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39613 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeGYHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:44:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so4597351pgs.6;
        Tue, 24 Jul 2018 23:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=onrM45gAEBswBPVegWxUltCZUToDTygbCP1SLn/7j0w=;
        b=ZTDhv9m+nrIlbbaQLuDTxDHJFODEeukq5lVQZO7EWg/uQResKk29yqPBzbgFRY0cPf
         JrIM508Gt6p5CWo2QDgmlhPf+lb5QxGOn18fAB2bpD77YLfKI+FeGcJYrIGiJx0zBMxZ
         WmX9hnSm8FdPNc5ym9oy6lt9YbDE9Qs9PqTd8H4ncn2z/oPsxVzIp2R7BCcBpGslBOdm
         eM1LnoNnOFGOxDfpyPGsQ1iCuwczTZm7b6aNTOETivViMaEA1j8TMFYoAxfV9C0Vc8Y6
         w7aKMIMlfgzhHMBVDnNCg44QQDj30fhjeluGCmA6kzELlzORV+mTmfrtw8F3SImwXJnQ
         geuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=onrM45gAEBswBPVegWxUltCZUToDTygbCP1SLn/7j0w=;
        b=UmwXILwzl2T8DlVNCZzmNNWUIuZElATl4ZOvK0qYvkC7R6cc6a/IFO7xEKOBk7p12h
         fU+V+5ufFWW5j24EeNT1qaUFxjkVEBqzGfq5MW4r11PItYFe3RNrmOrPyu9g6uV54x25
         ranpXTwZQVIo1v8XJQ8fnwF694dlgG41NZw5lROlQsFlQfUyIGGGUqMKKoGB703mMCGx
         yL5c56hZns43OCS7rzYP4uevKyr8rzZyLiUVTptaVx8dLaC345cNqPzaUonudbvLvK/b
         6F5MHP8xZRHcAQbCuegIiTH+moSYbLO5ua9f1MPFaD3Av9SyKyxXc7ZmgPZ1LWf7ZO7N
         aHag==
X-Gm-Message-State: AOUpUlF9kkQBUFGg9TfSdaMFf88x9Tq2Zdfj08i+0vifP/ebaSNOA83h
        GdVBYUVNJUp7ippYamBxbLo=
X-Google-Smtp-Source: AAOMgpdGvXzffrfJ+LTjqccwBmt5yLg2RLEOxttZDZi7vbElUpYDtakwTDfMVFTXJ70p8HEMH1GuiA==
X-Received: by 2002:a63:7d7:: with SMTP id 206-v6mr19207558pgh.137.1532500452971;
        Tue, 24 Jul 2018 23:34:12 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id x184-v6sm19436151pfx.188.2018.07.24.23.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 23:34:11 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] tools/bpftool: ignore build products
Date:   Wed, 25 Jul 2018 15:34:03 +0900
Message-Id: <20180725063403.19522-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For untracked things of tools/bpf, add this.

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
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

