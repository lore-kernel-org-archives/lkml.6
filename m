Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192CDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA05E21537
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3JQs8iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA05E21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeHWO0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:26:25 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44074 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHWO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:26:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so2236818plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XlJEj42KrUyGPchHDOTMg7xyST9hcpr7Ghv2shVlbl0=;
        b=U3JQs8izoFjujv63SO69C1Xuh/D8S0qnM0mLcl+w5CgQH9rn8Sq27C8g2vyyCEj8IH
         iSU+Ho3uvuNKsfusGx1EOYWw7ndez5o3SkH+3wpXaRdWbSr3aG21WR/JfOycer3l87iY
         qsTHG+l8tOeYC+Gc5ST/ajcAf+ZGkt6iijZQDobUBVQ+aFWFwLwd0GhlIIzmT79WI9lo
         A74byKr7x2PPmW/PHVYR6TbDHqfzFR3axjksPbiV/OwbbuMgF87XxI60y3kMvPwSW/Iv
         YhZqh+xTOCin+JbudQ+ptaraeXSJBwCOpXH8rnbSn905zgk7/iTYoL2I6Ne0k8tWS2ax
         KUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XlJEj42KrUyGPchHDOTMg7xyST9hcpr7Ghv2shVlbl0=;
        b=djuT7FLwstLnSl7OdHdf8IRmPCI8hp4gqYlbbKmbsUB9AFbB/KkkDC5LF7jqKNzWHo
         d/6dZWLR/NuOfnM0fQxhjci2Of3xNZ6wiQSix4WZitw03Vfa3kX9nTJOU/x7WB6iwkV1
         ltJI3BQOvXo23AnOmO7XR1SmMimHz19krxXcFY5Od5QgOnxntT59L9hj/d3zkqRQODRm
         8uttaFfKBpD8gBv3KUDeouRI/hmrzgb/TkRwmvC3DQ1GnXJgChNeb0KvLXqPonF7KQa/
         BZfWoUCZ7IYZTbX1t2WC9zc8LSixaEHGd3lUk5MBr3ex8I9/juEcdGZctvr+1NYCVr0w
         kdPw==
X-Gm-Message-State: AOUpUlEBc7tTcr+P0N3FV+9g5uylMTdlXSPhEzNUflVUaBP+bKq8S+OI
        Q5d0cEkGL/EA9CkcQOknwoU=
X-Google-Smtp-Source: AA+uWPwVs5Cvjsyyor7xVtw2cCtAgjyWyEjHwYTaS5GsYCmljW6/YnPhbKEYLIRGCCSGKGvVc5Janw==
X-Received: by 2002:a17:902:261:: with SMTP id 88-v6mr58132302plc.331.1535021835959;
        Thu, 23 Aug 2018 03:57:15 -0700 (PDT)
Received: from localhost.localdomain ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id f13-v6sm4384048pgs.92.2018.08.23.03.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Aug 2018 03:57:15 -0700 (PDT)
From:   Weikang Shi <swkhack@gmail.com>
To:     dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        swkhack@qq.com, Weikang Shi <swkhack@gmail.com>
Subject: [PATCH] fs: Eliminate redundant assignments
Date:   Thu, 23 Aug 2018 03:57:08 -0700
Message-Id: <1535021828-130439-1-git-send-email-swkhack@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after the assignments statement ,all return statement do not use ret variable,so delete the assignments.

Signed-off-by: Weikang Shi <swkhack@gmail.com>
---
 fs/afs/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 855bf2b..5a3770a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -541,7 +541,6 @@ static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
 		return ret;
 	}
 
-	ret = -ENOENT;
 	if (!cookie.found) {
 		_leave(" = -ENOENT [not found]");
 		return -ENOENT;
-- 
2.7.4

