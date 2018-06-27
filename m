Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511D6C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE57924588
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFW6PBRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE57924588
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966465AbeF0Txq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:53:46 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35387 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966412AbeF0Txm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:53:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id c13-v6so3188759wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/o13KHR6wd0+0rl72f1gK/Qs+scE945pItDzEozSwuY=;
        b=YFW6PBRKbKv3wf87HnmgYfeg3v0CKaWn6WAKJdwqgTrTrn3nLhGoM2S5J+FT1IWTZv
         Zd78I9gqgKpoObAyTXChXot+ezG6E0aAhu9YtLBikgSDR9rOkLpOUoDdgFdf/W9RJFKL
         6W9RL3rkSQk2vmlE6jZFCGBE2DnxwTncMFXmTSQ+trR3JeKcwapBJi1YuZ/jBrCmmQbf
         ZeDnSCXs+7YXl08M3/t68Q1gd2vg8hGjOQX41hZxOkUSnQ7jFLwXlK87+vSg9MvUe4Mo
         GGDRCsoOrtSQkVH3lONKBT8RuYa1si8gLny2ZhVNvD5coLMv3stjRpaw3YIiX6MkAtSG
         AZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/o13KHR6wd0+0rl72f1gK/Qs+scE945pItDzEozSwuY=;
        b=oT6d2QemUHRniZnqECIfzxdkoNPdZCqrS7iDvG0lzv68h32CdFUw3An61BXdNDhh1H
         uiNEtVMTYP7g6AupIlj8+XkSIBv7VTWi1BZyw0l/wFM4lFz1jgfkR+WDzrfA9JNWtVk6
         VtE8F6KAy/eJ/3nRGOuSp2/aRJDmY7mjj7JjGXpPiCZ7BBHvNiqt+qmuyFtWxuli73vy
         PI5DAXwUjx4Xax2mZewPBTKqMjfSDxLnxU5FmhPZ5EApnNzTR4cFacTmD7OLFREl7VT7
         02ZF8TrZIg2Cy9N9lSk/z8hmZuZHsBv+cioeuh27n+sg+IpkSezTcMYMlpeF6i4REZWM
         67aQ==
X-Gm-Message-State: APt69E05PCfTRZGPgXcIGaRfibRyrGAhhIEZbxyMXWEnRVn7hi7Sgvg+
        YY5471s9PyWZKT2QwGO2Ug==
X-Google-Smtp-Source: AAOMgpetE1RlfTiFPmT52QqOCuNP5TaQoDdnqMXjqKC/LujNkYtdWEFWySGvOEnLtq5vQUXfILU3xw==
X-Received: by 2002:adf:f98a:: with SMTP id f10-v6mr6257279wrr.105.1530129221572;
        Wed, 27 Jun 2018 12:53:41 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id n18-v6sm11524098wrj.58.2018.06.27.12.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:53:40 -0700 (PDT)
Date:   Wed, 27 Jun 2018 22:53:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: smaller readlock section in readdir("/proc")
Message-ID: <20180627195339.GD18113@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Readdir context is thread local, so ->pos is thread local,
move it out of readlock.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -286,9 +286,9 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
+	i = ctx->pos - 2;
 	read_lock(&proc_subdir_lock);
 	de = pde_subdir_first(de);
-	i = ctx->pos - 2;
 	for (;;) {
 		if (!de) {
 			read_unlock(&proc_subdir_lock);
@@ -309,8 +309,8 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 			pde_put(de);
 			return 0;
 		}
-		read_lock(&proc_subdir_lock);
 		ctx->pos++;
+		read_lock(&proc_subdir_lock);
 		next = pde_subdir_next(de);
 		pde_put(de);
 		de = next;
