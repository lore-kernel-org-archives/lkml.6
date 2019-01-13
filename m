Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FECC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F1A20836
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hbTkhyIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfAMAPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 19:15:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40684 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfAMAO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 19:14:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so8684800qki.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 16:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OixqdVEoBSDrkAHasDpQua+Q1wKGVCQ1PcDyZD5bqY4=;
        b=hbTkhyIl9mxXWsJKnfmpKmBukMyy1OtAJFhGQ7e0T/HrUS8ojkqzwvz89EbTDY4WJK
         zlEg3dJdZNIBRT7AiAPWz/3ipLir0cbC9kXUIUy+K4bhvAQgF4UVnM+1dzePMa3ph92y
         YE6uWxOQsN6qNHylFZzb60sbQQDyBuY11NiJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OixqdVEoBSDrkAHasDpQua+Q1wKGVCQ1PcDyZD5bqY4=;
        b=jnm0zaxzqQsRDoaNpDn6sGil3LnjF5nTY7Vftlh5EU2BZ35S4kKQaZxCtooC8/gSOV
         00u7RcWuzQR05+1uGfEiBwfGYjRbVrLqXNTbcyOPd2W2EUHLuCGu/eAqtR1Q71pbljR0
         Rj6dS//BfrjGPQPGJtjQGt8WhA4QF25ScoHw2Fq4k68tjvXaMFDNrMLBldbzL8Rtk5m3
         xC+DF8pXYjKABYDSQ0+PAxqIku4tCkwRXFUHJsl4NxDeTQTo2rViADCeR4Cznru/UHFZ
         3rAwH/mPSzcwTIsXTy+InyGdGh6PDoU8Gh70ZkCaLXPIAmZbkMXLhkvEWQkDLn8a2DnL
         nCkA==
X-Gm-Message-State: AJcUukdEZpl3HFT2aBLMOJ6lFMqvV3i2HT3PptWFR1PhUzQx4KNqCX+p
        XMNBbpWo+d05zhv62+qisxmHhUEHoMY=
X-Google-Smtp-Source: ALg8bN6i2Kb2QgUrD78QgT6UkYpMtASdWu0lYC1jWiGvfNkm9qvDZt5Xx76aZzrZNXTCkV0YxRvzEw==
X-Received: by 2002:a37:ab03:: with SMTP id u3mr17667678qke.24.1547338495684;
        Sat, 12 Jan 2019 16:14:55 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cfd0:d2ee:d54d:ab6d])
        by smtp.gmail.com with ESMTPSA id p48sm50525149qtp.62.2019.01.12.16.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 16:14:54 -0800 (PST)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, mtk.manpages@gmail.com
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, marcandre.lureau@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -manpage 2/2] memfd_create.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
Date:   Sat, 12 Jan 2019 19:14:46 -0500
Message-Id: <20190113001446.158789-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190113001446.158789-1-joel@joelfernandes.org>
References: <20190113001446.158789-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

More details of the seal can be found in the LKML patch:
https://lore.kernel.org/lkml/20181120052137.74317-1-joel@joelfernandes.org/T/#t

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 man2/memfd_create.2 | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/man2/memfd_create.2 b/man2/memfd_create.2
index 3cd392d1b..fce2bf8d0 100644
--- a/man2/memfd_create.2
+++ b/man2/memfd_create.2
@@ -280,7 +280,15 @@ in order to restrict further modifications on the file.
 (If placing the seal
 .BR F_SEAL_WRITE ,
 then it will be necessary to first unmap the shared writable mapping
-created in the previous step.)
+created in the previous step. Otherwise, behavior similar to
+.BR F_SEAL_WRITE
+can be achieved, by using
+.BR F_SEAL_FUTURE_WRITE
+which will prevent future writes via
+.BR mmap (2)
+and
+.BR write (2)
+from succeeding, while keeping existing shared writable mappings).
 .IP 4.
 A second process obtains a file descriptor for the
 .BR tmpfs (5)
@@ -425,6 +433,7 @@ main(int argc, char *argv[])
         fprintf(stderr, "\\t\\tg \- F_SEAL_GROW\\n");
         fprintf(stderr, "\\t\\ts \- F_SEAL_SHRINK\\n");
         fprintf(stderr, "\\t\\tw \- F_SEAL_WRITE\\n");
+        fprintf(stderr, "\\t\\tW \- F_SEAL_FUTURE_WRITE\\n");
         fprintf(stderr, "\\t\\tS \- F_SEAL_SEAL\\n");
         exit(EXIT_FAILURE);
     }
@@ -463,6 +472,8 @@ main(int argc, char *argv[])
             seals |= F_SEAL_SHRINK;
         if (strchr(seals_arg, \(aqw\(aq) != NULL)
             seals |= F_SEAL_WRITE;
+        if (strchr(seals_arg, \(aqW\(aq) != NULL)
+            seals |= F_SEAL_FUTURE_WRITE;
         if (strchr(seals_arg, \(aqS\(aq) != NULL)
             seals |= F_SEAL_SEAL;
 
@@ -518,6 +529,8 @@ main(int argc, char *argv[])
         printf(" GROW");
     if (seals & F_SEAL_WRITE)
         printf(" WRITE");
+    if (seals & F_SEAL_FUTURE_WRITE)
+        printf(" FUTURE_WRITE");
     if (seals & F_SEAL_SHRINK)
         printf(" SHRINK");
     printf("\\n");
-- 
2.20.1.97.g81188d93c3-goog

