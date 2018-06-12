Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0894DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58C520693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL4+v27h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58C520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeFLEWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:22:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32988 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeFLEWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:22:49 -0400
Received: by mail-pl0-f68.google.com with SMTP id n10-v6so13593055plp.0;
        Mon, 11 Jun 2018 21:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uHfPz/0FW3DSovSQYFdQIsmxMGKsKBoCByGmkyBWYKA=;
        b=VL4+v27h66QkObEfYs32z1TljQLoSd4MfG1ZFZ6DaYH7IqimT+ha0FgVkJPCFeZfkw
         XT2t9apL+bAoeP2x6ra2N7ra7MRB297I/61bWvFIwBFYfZHOoUUob/DHLuBD0mu1Pcnd
         gQBuuoRdH7ACzW9R9ke/zn0t6okMUKWphEQfHv2D1H++P3gsZbJG52J57D1DkOrnDnOP
         IVDXcPpMYIJ6eBDIf2fB7BxxZ1J2Ky161736Fbw0Zy7HGCFriQDR/wowyqz5uDwaLpQV
         iPzSX61r36LRGduqj0uPKnP3wDmBvcIrnvrpYpq1lmed7P3bhuN9ALtAnOAzaLbzRjEg
         UUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uHfPz/0FW3DSovSQYFdQIsmxMGKsKBoCByGmkyBWYKA=;
        b=Jd8Qs6WYFnQSGX37Z+tE/DDwvxJmChBvHTN6Yykwsbgu8pYf42jD3Q+XAsjpFMoO+a
         Vu/MPu6vKCxC4ihRkq+I9ovNou78gabkCgE+TY0CzTtMR14FataeUQiPahnRBoZS3/2B
         3MoHuJdD0FV4Mp5J35Y0nk0UXqHwDXd5Vj4XX9Wjey4NZiBdAyvZRWqprNMRpPUC5my0
         xFLTQElqNi3k+s8Wh+IWSylFub5nFqGVbv24spMH31wFJ81J+1S+xITgXv+tniE8gpie
         CTCQosIm0m7Csw2F2vtqaqfBDItImGTqmT5KYt60+3EN6LF0gu2xlNGlA2gJnEPQzjba
         EYjQ==
X-Gm-Message-State: APt69E1kz68oaguEAeP+ysnFYlUGC8bE4KfbcarpXHQKcr5YqD03+Nn0
        NVdg4SgU+MrO8rd84x0y1YeHmp8naR0=
X-Google-Smtp-Source: ADUXVKK1fR2W90PS2BDKZywbgVPSHdZNkRulIhmxOBqYKsBoHF4rTG8qMB1qLgbdm3RfpAOFOu6l3Q==
X-Received: by 2002:a17:902:206:: with SMTP id 6-v6mr2205808plc.294.1528777368784;
        Mon, 11 Jun 2018 21:22:48 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id u84-v6sm78869678pfg.156.2018.06.11.21.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:22:48 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] inotify: add error handling for kmem_cache_create
Date:   Tue, 12 Jun 2018 12:22:42 +0800
Message-Id: <1528777362-40212-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmem_cache_create fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kmem_cache_create.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index ef32f36..0704bab 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -805,6 +805,8 @@ static int __init inotify_user_setup(void)
 	BUG_ON(hweight32(ALL_INOTIFY_BITS) != 21);
 
 	inotify_inode_mark_cachep = KMEM_CACHE(inotify_inode_mark, SLAB_PANIC);
+	if (!inotify_inode_mark_cachep)
+		return -ENOMEM;
 
 	inotify_max_queued_events = 16384;
 	init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
-- 
2.7.4

