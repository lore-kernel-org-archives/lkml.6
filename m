Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA150C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6422147E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adLddh31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6422147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJQIBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:01:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38736 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:01:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so28024553qtf.5;
        Tue, 16 Oct 2018 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=VrnIrgBHqN7A7q86ytiSO2+obkna/A+3MKssGl3QH9Q=;
        b=adLddh31vQgKSwRE+gPgkd9igVDWf/2imqllqD8P0hJbajwWGbtEwFIOHVJkp0DYnG
         NHhsXmd8JT6yzvSug85vrOzPUV/ymHtrYZZGm/tbzsaOUEJEht6uENY4aQIkZot3h3C9
         RO1EXIYOJqARWYmcRYdlQOxPkkJJhdEDBLifjj108694dKR8RpiWzAmtPWVmQJBL7gEn
         p6CdzsG9eYOxCLbDk2ZUlFllchXVU7pg5Ii3EMGWLAQm2B3RPoaFC6WL56AKM1GiSGyi
         CpIrf0+ziy4guSWmcrmdCVSPPY9Qvyk3ITiHEbhYpOd0MJnC8qZcOgQbViykkLAyxW2N
         sh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=VrnIrgBHqN7A7q86ytiSO2+obkna/A+3MKssGl3QH9Q=;
        b=LV9MiakyyJFD7kJiePIQyd3+4mR6ff14o7oiZSWIgvq3fjGoD18wqC4uM8u6xmq0Yc
         BqEh2/h2AFjWhKmLWCK1tGAvDr0B+Gi09Y+Vvvv/vbOzcAVs30UqecbKcQOoVja69rOV
         GllSf+AqOZABkDOM64ky7jLJ4kHksMjqSEYhLZMaS+Lk+Wk/wDAH9lV6AfKHTfytcrzT
         /xAFkimVxxteB77k026tMQ5T6fbXlwhnm8WaA9o835/UI714T1enRwsLJ083wdr8g5Lk
         LTxodR5HOMv0axl2j26hZahnmd4oZBThO7Ml5q+8UHF1WPADanZb2L4Mu8f7QjLQlKgG
         5LYg==
X-Gm-Message-State: ABuFfohowRqeLHtstYMYQXCMCX5czy+jPLnqZtapbvW5RrBIHKU/QjnU
        OCpeoDkTMJP7QXcAYg4ejsA=
X-Google-Smtp-Source: ACcGV62s/i1JBDY5MaQxsQjbQ/Bo4tewL2r9YrCRDxVBFvf7p7wKBYbEv1jA148LUopQ7MaMr8L4Wg==
X-Received: by 2002:ac8:7482:: with SMTP id v2-v6mr23227319qtq.251.1539734895531;
        Tue, 16 Oct 2018 17:08:15 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id q84-v6sm692576qki.40.2018.10.16.17.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:08:14 -0700 (PDT)
Date:   Tue, 16 Oct 2018 21:08:09 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
Message-ID: <20181017000809.GA21292@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds -Wshadow=local on KBUILD_HOSTCFLAGS to show shadow warnings
on tools built for HOST.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e8b599b4dcde..fb0a9ac195e7 100644
--- a/Makefile
+++ b/Makefile
@@ -360,7 +360,7 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
+KBUILD_HOSTCFLAGS   := -Wall -Wshadow=local -Wmissing-prototypes -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
 		$(HOSTCFLAGS)
 KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
-- 
2.19.1

