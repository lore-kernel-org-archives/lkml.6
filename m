Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A943C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 01:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB58E217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 01:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hMbAyp8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeLXBnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 20:43:07 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60154 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeLXBnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 20:43:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id A1F6ABC4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 01:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KlZmWITWbxIl for <linux-kernel@vger.kernel.org>;
        Sun, 23 Dec 2018 19:43:05 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 6E1F8BB6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 19:43:05 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id t4so182109iog.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 17:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GDY+yyiTc4iAkD2RK776jtb4Jp65q05AypXUayKQSdM=;
        b=hMbAyp8iMBgmuVV9aeDXgoeIKbm9I0bPxVeo62YjK4AAbxBgnBRjt7QMzgPpr69idL
         ukIatS/nOO5nisDVDzOdQOH1DuqmXQmYZ4RPtXimwWMYA2E3iJcbj5LG6OVzCzz7B3xM
         pxvggwS0A8+ULe3xyKn+Sqsafeqr9jyxiwDT3doq1QHDZP24CrepwAud/90j/0QD4iWZ
         85fMvzLRJVOTZDShNAiuom8d/f7Xtc6w6lCD6CUGZPcuWM6BLPqDVM9ZL86fR1n+qndA
         zydNt6CpW6bIOOVDbt4EQgYQrheuRFMPDqLI5RnSj6M5wo4sTtEIBAcHgYMe3PENkCsu
         3Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GDY+yyiTc4iAkD2RK776jtb4Jp65q05AypXUayKQSdM=;
        b=gDMc0Y1DwKpBrdXEAQHEcQJV8H0S76xRBpyTcgc2CXvt9dSHgk0M7weP3ntT2pdmxs
         tV4w2Q2tGA+lVhMFmraifOoSx50XMTuWh08UBvJDMF11Hao45daz7xWCrWhB9ghBDC57
         d3jDIURHvwM9k/doPWsiPRLc2eh7faU1la41vPEK2d3pEQdTofOaAmr0/5Q4ofOQWoGm
         Ji/QCgMcbnyqpHumOsx7doytG4N6LmYEpm6X1113s/2Mehvao8BYiiiUne9et+fe8LKF
         /z30fIRg5nH2WyPXrBfs0Ip/b1rUd2xCE3U8emBPMRq2RfOBlbBbpvBBEZThpw8xkd0D
         nuOQ==
X-Gm-Message-State: AJcUukfdEfLxq0QT1UlBsZ2tp7AExghEPD8baQloF1NvP5wFCJN3iZxk
        VnvHmNBqCSP0g9bm9/f9pzVQP/DVAFOMFl0XPqysIg+kNcEocdUeK2JLT0HNSZ4yFT2BW3E9KMt
        XIEZe9hYguO19ZjezE2rkgzp6P2aq
X-Received: by 2002:a6b:c402:: with SMTP id y2mr8352563ioa.77.1545615785028;
        Sun, 23 Dec 2018 17:43:05 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7qdfO+tsaCZqwQlNxOTQpaFg2kV+VZ/TKavtDGrEGmEubbr/Xpo79CCYyLClZ49aF5c9vtgg==
X-Received: by 2002:a6b:c402:: with SMTP id y2mr8352558ioa.77.1545615784756;
        Sun, 23 Dec 2018 17:43:04 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id m186sm9070345ita.2.2018.12.23.17.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 17:43:04 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/net_namespace: Check the return value of register_pernet_subsys()
Date:   Sun, 23 Dec 2018 19:42:38 -0600
Message-Id: <20181224014239.11601-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In net_ns_init(), register_pernet_subsys() could fail while registering
network namespace subsystems. The fix checks the return value and
sends a panic() on failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/core/net_namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index fefe72774aeb..af8849a7a9c3 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -917,7 +917,8 @@ static int __init net_ns_init(void)
 	init_net_initialized = true;
 	up_write(&pernet_ops_rwsem);
 
-	register_pernet_subsys(&net_ns_ops);
+	if (register_pernet_subsys(&net_ns_ops))
+		panic("Could not register network namespace subsystems");
 
 	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL,
 		      RTNL_FLAG_DOIT_UNLOCKED);
-- 
2.17.1

