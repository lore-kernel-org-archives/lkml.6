Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D5FC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254D4208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uShBzQj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254D4208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933523AbeGHVFv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:05:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45471 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933292AbeGHVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:46 -0400
Received: by mail-pf0-f194.google.com with SMTP id i26-v6so719223pfo.12;
        Sun, 08 Jul 2018 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8aM1k2j6Ljs8a7QqghmRuJpiCg7PJFBEcFzzSa0UZCI=;
        b=uShBzQj/LW44wtCFABhr9F/KPcDMNPU5VnuDHYdIpZocbFBYuwstdukhag/nOAwJBO
         jtgspGdaijlzeIGeS05UkZ10jPS9mc7eU85uoPAy9lRNpmMQeRSXbtSxekz7uLZtZSQM
         9ig4v48RntCcZFeBBMqABxurj956r4cyi1yUllKvg/FvcGHLj350mT51ceYND5dlr1Gy
         nDR3sxq3KVnOJHEqZIFEws42UitUkZL2zjbgIHYz/0SrsXGrJZUdpEdAiF3rqxdNPcQr
         vyyjb4JVKe0SrXGwNksmRpNkvvjPwkEPxn6KNQDKnqyAr7jyzlwLZkDXaRKhK7xTrBIw
         DyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8aM1k2j6Ljs8a7QqghmRuJpiCg7PJFBEcFzzSa0UZCI=;
        b=t74oqkmkN0zi+omSyRiFt59v2ubiaOCd7MMNKnH7SH3zV157vq+aPQRKfiaW9fCwaS
         IPiydJy561wQMm+iEYT0H66YUVA14RrfUFTeraWRTliqjv4Apw5R/OMWZxZ9MCA2njg8
         aLHkJuaLdTWVG1bgqLHh3pumvGBoMKg7CrU8rWWNnguGDjhtYRh2gFpSVWyrhNpe61M2
         yyrC3O5jvjmDIXs622C6khiJdoL5OqfZ9qZqBP5VsK9Fou4WUfOHTLbWv9Me94/IoSN6
         Lv1i+QvMMlNevpfRXlgndRaHCyJNZIK9RGL9m7xaY50HIAXYXNaywroV0WJBy6rL1eSU
         iHuQ==
X-Gm-Message-State: APt69E0/73IdiWGZ2isgOi6nsP8P2ATeDCu+eFdFpkjWCOs8IfCxL8rq
        t9/1Us0jFyNNP+JBirpO03c=
X-Google-Smtp-Source: AAOMgpdoVvq4yrplIdaZUenCMadR8lKnYOikPWF8R/5zRatE7kZ3t2IA2aZJs/8dEUNtfDCNjBYEWA==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr16720117pgd.372.1531083946119;
        Sun, 08 Jul 2018 14:05:46 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:45 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 16/18] fs_context: de-obfuscate control flow in fscontext_read()
Date:   Sun,  8 Jul 2018 14:01:52 -0700
Message-Id: <20180708210154.10423-17-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fsopen.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 1fbd8b0ca194b..dd38f6b65aace 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -161,20 +161,18 @@ static ssize_t fscontext_read(struct file *file,
 	if (ret < 0)
 		return ret;
 
-	ret = -ENODATA;
-	if (log->head != log->tail) {
-		index = log->tail & (logsize - 1);
-		p = log->buffer[index];
-		need_free = log->need_free & (1 << index);
-		log->buffer[index] = NULL;
-		log->need_free &= ~(1 << index);
-		log->tail++;
-		ret = 0;
+	if (log->head == log->tail) {
+		mutex_unlock(&fc->uapi_mutex);
+		return -ENODATA;
 	}
 
+	index = log->tail & (logsize - 1);
+	p = log->buffer[index];
+	need_free = log->need_free & (1 << index);
+	log->buffer[index] = NULL;
+	log->need_free &= ~(1 << index);
+	log->tail++;
 	mutex_unlock(&fc->uapi_mutex);
-	if (ret < 0)
-		return ret;
 
 	ret = -EMSGSIZE;
 	n = strlen(p);
-- 
2.18.0

