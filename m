Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1235C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84926206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAw8bBuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfAHTwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:52:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52543 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbfAHTbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so5276781wml.2;
        Tue, 08 Jan 2019 11:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5sFOPt4aq19rpBhUsbZpWrQgS4A7ZzjtPjtU08pKzcs=;
        b=JAw8bBuCMF3bZAc4dQ1CfPWk8hesh/W5PqLm3LwpinI+KgUajK/F9cEGmZ6m3b6WQ0
         aBXBMfunZyy4w4L0ZHu4b2W26OUg4OQvIkHcfM9hvIy3QfW9E+dJfpnKG+ItfGjFS9JE
         4mN1IUWR0sYjx/+Cm0msU/uNOAITWHD11oNv4dbDd5wBdp6glhVahRUXvciQn7g7tp4F
         qAxWvT8FXfXMgH740pKikBO3kuOsVqPuUz5E3KnUCit/KZDFlCUJv97qvMKRoXaH5FnX
         vScQ41Z63qSbbfrY5Q3pCy+4SgMXWBg1KgAFhNGQWspl2k1ChWAgbKpOkKDuM+KXEkyk
         mZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5sFOPt4aq19rpBhUsbZpWrQgS4A7ZzjtPjtU08pKzcs=;
        b=GUoNV4VBIUWoF/m7SXmLtNUg6nSfmOZtraUA9l4qF8+4K8Ncp7nF+nyExxkv95M8hq
         cmrb4bgHriQ1vAEj1z3g+GswFKoKp8d1sCsBhIbHnIAG1dTxvaEYj84fPTeEfckNlQTb
         iomdRpqFNBL+mcazZR5WQzExtIYKVNU0ev8zpgJNhelMlYevakKzbN8BB/q9lOd4jMPR
         PCg/n+7oW59KV5456RETQbHxgALLZxlFGgUXexLrYFw84e/fKVLLZW7Rb7hBbA3kFP7h
         z3gWYlKGioQ5ycgH/hUKnip86qtxwS7vbFaS4TCutu0z0D/APHoJgcJOR0rRImQxTgsx
         fKNw==
X-Gm-Message-State: AJcUukcUdUDNbuoMkds9eIs6yDkKMkA/XedT32NJ0vBIR60XrkHLZfnZ
        hjLk212cTwnRIRCesz4fOqytAzc=
X-Google-Smtp-Source: ALg8bN46R0ml13cK4fQo6XQ58TDql2yCccAJbY8dfp1s/cq8EfbQz8OOEeFQQ5znjX3+jkURoMcNIA==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr2821687wmh.124.1546975871477;
        Tue, 08 Jan 2019 11:31:11 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id 10sm12926161wmy.40.2019.01.08.11.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:31:10 -0800 (PST)
Date:   Tue, 8 Jan 2019 22:31:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: return exit code 4 for skipped tests
Message-ID: <20190108193108.GA12259@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test harness uses 4 for SKIP, not 2.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-loadavg-001.c        |    2 +-
 tools/testing/selftests/proc/proc-self-map-files-002.c |    2 +-
 tools/testing/selftests/proc/proc-self-syscall.c       |    2 +-
 tools/testing/selftests/proc/proc-self-wchan.c         |    2 +-
 tools/testing/selftests/proc/read.c                    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/proc/proc-loadavg-001.c
+++ b/tools/testing/selftests/proc/proc-loadavg-001.c
@@ -30,7 +30,7 @@ int main(void)
 
 	if (unshare(CLONE_NEWPID) == -1) {
 		if (errno == ENOSYS || errno == EPERM)
-			return 2;
+			return 4;
 		return 1;
 	}
 
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -63,7 +63,7 @@ int main(void)
 	p = mmap((void *)va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
 	if (p == MAP_FAILED) {
 		if (errno == EPERM)
-			return 2;
+			return 4;
 		return 1;
 	}
 
--- a/tools/testing/selftests/proc/proc-self-syscall.c
+++ b/tools/testing/selftests/proc/proc-self-syscall.c
@@ -39,7 +39,7 @@ int main(void)
 	fd = open("/proc/self/syscall", O_RDONLY);
 	if (fd == -1) {
 		if (errno == ENOENT)
-			return 2;
+			return 4;
 		return 1;
 	}
 
--- a/tools/testing/selftests/proc/proc-self-wchan.c
+++ b/tools/testing/selftests/proc/proc-self-wchan.c
@@ -27,7 +27,7 @@ int main(void)
 	fd = open("/proc/self/wchan", O_RDONLY);
 	if (fd == -1) {
 		if (errno == ENOENT)
-			return 2;
+			return 4;
 		return 1;
 	}
 
--- a/tools/testing/selftests/proc/read.c
+++ b/tools/testing/selftests/proc/read.c
@@ -126,7 +126,7 @@ int main(void)
 
 	d = opendir("/proc");
 	if (!d)
-		return 2;
+		return 4;
 	f(d, 0);
 	return 0;
 }
