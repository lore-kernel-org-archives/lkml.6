Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5939FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4C206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfBVUyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:54:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35348 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfBVUyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:54:15 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gxHpm-0000MN-PH
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 20:54:14 +0000
Received: by mail-wr1-f72.google.com with SMTP id s5so1488086wrp.17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3RGIsjVJiV9/aYmypk7Tl84Nzy7qZUzmLjkFAcwVNY=;
        b=CL6TrAsrLZXmj/r0XAk8w8t0bA/wh4IOCdQuwsN6OviAYqUU7VYp8hKJUjYYwZcgIw
         ehgDxKoAR6tpbAurGcVy52gU3OrShz8Bd2S9jtHBU3LX2k9hI9gMr2EWMkUzkrYCegGp
         LfFOnkCVag22K8aZYdgqxJL7HoYssVPkRpS3GalJIG5rD75vHI4AStwGRykfYLg8izzH
         DrRak00MY6WyJC/TktFBuYcDbt3Q8u0GaM4iAYSHkfCxj89Eu5ibwUAepL5Z2t0D38Ut
         RIsKElQ+eZVe9HYOXvZHhrnHvAUbiqicd27DLSUem2f8mM75Di2URQvnBe9RnI0O8Skl
         iSSg==
X-Gm-Message-State: AHQUAuZfDqlcWNjOeGeo+e6n6qLaGKwLY1JCOxK2kfOkujMwTkTJZZQn
        PwN7BEDOh776mDavuThTB90zbh3/LVTFcVILSCSll6wWjSRIqqrRjrX4iZfq6Eij/BZDQ8VaUfx
        OTSHDjm81KbqN8Po3ZR3ySO9zCNLCwZ/t/xsZm14Fjg==
X-Received: by 2002:a7b:cc18:: with SMTP id f24mr3889578wmh.42.1550868854157;
        Fri, 22 Feb 2019 12:54:14 -0800 (PST)
X-Google-Smtp-Source: AHgI3Iaq9Ra3RsUt32F/YRL+99sKkbpXWyQZkGMAh2rYRuQPURXlOKRjW4W/CBv7vuJE9p+3WFqztQ==
X-Received: by 2002:a7b:cc18:: with SMTP id f24mr3889568wmh.42.1550868854010;
        Fri, 22 Feb 2019 12:54:14 -0800 (PST)
Received: from smeagol.c.hoisthospitality.com ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id r14sm1432990wrv.77.2019.02.22.12.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:54:13 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [RESEND PATCH v2 2/2] selftests/ftrace: Replace \e with \033
Date:   Fri, 22 Feb 2019 21:53:51 +0100
Message-Id: <20190222205351.743-3-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222205351.743-1-juergh@canonical.com>
References: <20190222091021.10178-1-juergh@canonical.com>
 <20190222205351.743-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The \e sequence character is not POSIX. Fix that by using \033 instead.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 tools/testing/selftests/ftrace/ftracetest | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 20c9c0ad8682..136387422b00 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -161,10 +161,10 @@ color_green=
 color_blue=
 # If stdout exists and number of colors is eight or more, use them
 if [ -t 1 -a "$ncolors" -ge 8 ]; then
-  color_reset="\e[0m"
-  color_red="\e[31m"
-  color_green="\e[32m"
-  color_blue="\e[34m"
+  color_reset="\033[0m"
+  color_red="\033[31m"
+  color_green="\033[32m"
+  color_blue="\033[34m"
 fi
 
 strip_esc() {
-- 
2.19.1

