Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A9EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3E3218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="G1BKxAbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbfAaOWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:22:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42070 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbfAaOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:22:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so2691402edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 06:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JIMo3w7sRDSl/keT71uYvTtuh4JE+UyImwPdfucCUkE=;
        b=G1BKxAbp2I4l6BcAvYlc3tr15PTmFxb6TK+igQETJs3Z974oXS6XYoIF7FDaeeETbo
         liUmbJQw5Z8JHHFEXjIM1recEd//z3F2feQ0kTxEnCAe9MhY+bLqnwdSjzfhTCmQvLZ7
         XAm84JWJtiz3frNJqQuzMFTyKC8FNJNrxkYuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JIMo3w7sRDSl/keT71uYvTtuh4JE+UyImwPdfucCUkE=;
        b=XkqKVWuNF2Ad3lHs/YCHNNHX3CxPqQa5LscpQHrb10Z7zmPcc1yXCveJHyIjBHuGkG
         NLRUHynnoVRLNBUs5WQbAGZpNMZvrBLztbhjdU9qnafit4dnE3FrtuJrNZgyjk3qCZH4
         0OBddDuzhWMD/HqZEJUjoaWNfZEhuKKfJFyltPYDb9monaBdgL9BqlwRSF/nXr4YMRBL
         eHJAWVXC1MBDgyN/uo2npMn1+9t9obsoVB6no4+nCUPauchAsFBUpAJlC6LiyYcezyiE
         wIOhWOclTM3lM74A2gre+nrGSvvKenwdilfWhmxGLi74jSy7XBkxLr5+9tQBUe4OHeqS
         azoQ==
X-Gm-Message-State: AJcUukeID2vgjiirFCQy5PZTICnAnZDH1197/zMb2VfgsJ79/IjHGG+h
        D7+u4TOM72kwbTcAvSBQ1jBzUg==
X-Google-Smtp-Source: ALg8bN7RpEeBt7uJblGVTs92zzlbD93ydoODqs91cPf+8uDdd4CuZZNQxbfZrENcSQLqlGtIl+l+Aw==
X-Received: by 2002:a50:91a8:: with SMTP id g37mr34123663eda.216.1548944556282;
        Thu, 31 Jan 2019 06:22:36 -0800 (PST)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id w24-v6sm793317eja.71.2019.01.31.06.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 06:22:35 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] MAINTAINERS: Update cgroup entry
Date:   Thu, 31 Jan 2019 15:22:19 +0100
Message-Id: <20190131142219.10175-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix wildcard patterns and add cgroup-v2 documentation.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f64f8d3740ed..a96054c1d870a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3906,9 +3906,10 @@ M:	Johannes Weiner <hannes@cmpxchg.org>
 L:	cgroups@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
 S:	Maintained
-F:	Documentation/cgroup*
+F:	Documentation/admin-guide/cgroup-v2.rst
+F:	Documentation/cgroup-v1/
 F:	include/linux/cgroup*
-F:	kernel/cgroup*
+F:	kernel/cgroup/
 
 CONTROL GROUP - CPUSET
 M:	Li Zefan <lizefan@huawei.com>
-- 
2.17.1

