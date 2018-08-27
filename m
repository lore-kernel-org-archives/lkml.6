Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CCDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18FC208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWEmy9a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18FC208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeH1DE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44905 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeH1DE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10-v6so427876edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OrMGb4FasZK/tsEjWe7wC72rwi4YHy+ybAa+ZBp/Xl4=;
        b=fWEmy9a4Yqxwrzl7s0theaP8+HHHMQhejjgM5z2mqmehR7qab5kr0T2p/qDM8fTdLp
         NxW3kpgjRi9hmAieAy6tEMDF29/i5cidDiSNsex33DsWnvPSRSmuuJAhD6CafrdrXzgS
         qXrfEf0PeXY4T0zrKm/nN6PPiFkWIrO0FD8wbtnj4kINSFK5z4JQBJy+Wg1qfDQaRzln
         sbkGmHoTSE5hP1d5AkJ9d0f7EOTZZitWRAZ9xoEAUoamtsYFm4ekkMWUATRwwqyjygjO
         UulO40tWPUq+KP1ZalP58jIWvyN1X2KCYMFimnxjjFOpgY3DLIq/uCnQ51OgqZDDGy+8
         BDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OrMGb4FasZK/tsEjWe7wC72rwi4YHy+ybAa+ZBp/Xl4=;
        b=qQC6ZdxawRn9wOeL3d4nEt2Or0OcEZ5YCHChPhchr8eSgrPaI8hDVWQFfmZXfocwVC
         x1o+6czLCECThws6KGn1r3lEWOs+GZd6YuMTVdvuz9WSR3v9Vwb9UvQpDiyhbxcGCVko
         /pgh7Qn9SfTuHCawDCJT4qSp4SEjDTi3QSawTj6AG0c+tN1FLpGtkx78GMRQWTLEmjlv
         5AbDZ3YRf8Eq/zVWqPrsz6hsO+Jwe3c/hBdNBrCLL39vlM3OEvtq0PNJD/LG/i+wmdwq
         inDYeKkns4F5k/7q/IWVccWi15W51oeG1Josb5MUVFGDmtT2mOwmaEFJfYGnB8VPcBqj
         HpSg==
X-Gm-Message-State: APzg51DvovIgk2yJnE4kRp5TN2HQG9diWi4Yw6sFh9zlsos3U8xVsBBp
        Hm2UZ6QWlu+y3XvmHNl13c7jhhA=
X-Google-Smtp-Source: ANB0VdbBmh2xeLiR+9BgBShtKQFV6iFH2FLE58oklyT+hQ22e9bUtXea0T4TbQFzwuK7u0Fr3WH28A==
X-Received: by 2002:a50:9297:: with SMTP id k23-v6mr18829121eda.180.1535411739176;
        Mon, 27 Aug 2018 16:15:39 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:38 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 08/13] proc: convert /proc/*/fd to _print_integer()
Date:   Tue, 28 Aug 2018 02:14:58 +0300
Message-Id: <20180827231503.26899-8-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benchmark opendir+readdir("/proc/self/fd")+closedir 2^21 times
with 4 descriptors (0, 1, 2, 3 from opendir):

	11.802099126 seconds time elapsed ( +-  0.23% )
	10.950810068 seconds time elapsed ( +-  0.23% )

	-7.2%

Benchmark the same thing with 1000 descriptors:

	362.1250 us per iteration
	288.4375 us

	-20%

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/fd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index e098302b5101..60ad1935eefc 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -247,8 +247,7 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 	     fd++, ctx->pos++) {
 		struct file *f;
 		struct fd_data data;
-		char name[10 + 1];
-		unsigned int len;
+		char name[10], *p = name + sizeof(name);
 
 		f = fcheck_files(files, fd);
 		if (!f)
@@ -257,9 +256,10 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 		rcu_read_unlock();
 		data.fd = fd;
 
-		len = snprintf(name, sizeof(name), "%u", fd);
+		p = _print_integer_u32(p, fd);
 		if (!proc_fill_cache(file, ctx,
-				     name, len, instantiate, tsk,
+				     p, name + sizeof(name) - p,
+				     instantiate, tsk,
 				     &data))
 			goto out_fd_loop;
 		cond_resched();
-- 
2.16.4

