Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7EAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CFE218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joLnbLDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfAAOEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:04:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44304 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfAAOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:04:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so13570375pgr.11;
        Tue, 01 Jan 2019 06:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FVpq9NfH7pOa6Xw3+8DNcMQ4vCU7AxJNWMBivPbUUcY=;
        b=joLnbLDyRpNu9l2c4LS/NWcyYxk9rApbVvZst/3Vbjxl2IQeviJQW0Z0HIpI+niDyV
         Xx/t5xyzo2dg03dLwr7shQakc/FXbF+Xw0zNct4iOLvyGos9AP2HBBWrx7IVXX2xiz9S
         lUaz/EOy2JFWCr0iMFIHTBxVsgxB3etBn3Fn99mOFMsD7+9Cp3NQ+lyQyxDmCVNRgHNK
         L6OLVDHFseAAKlqeuyk3R1uUEp1xY50S85e9hyfIk4skl7ZbQZEZPFb7JbKQDtNlu8Gx
         wa2L8+uPGtZe+rlkwlok+kh82jCsdC8zdSnlEHxPLp/GNF2wojlZ1tSCazu3Nxkoth+s
         Ckxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FVpq9NfH7pOa6Xw3+8DNcMQ4vCU7AxJNWMBivPbUUcY=;
        b=fOD86VyK+5aF8OS11ggMsbwCYvZV68w16j6R3c+0sIN5FhaMo1PwZ9/SVcxMBfQ3cz
         muPeIhipr/4FF4RtpoLcoy4KkPuO/8s7c2p6/DtApkYsDy6wk89X4fr60p8n7SoIQeyL
         jUBhl8JXEuN/QqdtkAMhIbm8AdogN5N4tXeEpurdcm5tssIBiY/BnFORu4sU/m5qeQ/V
         IAJ3xn/AfhOyxo0sIowS/zQG6JICdwOzx+o1d6pH5ougF56uqwphNlFGqqszN2RlsT68
         LzJCMPnalZMtSQG9hlaPqZPCLjj0wjIx9TdmGnj22nQUPqYeS+kut3utKFS9O4s25/9B
         NX1Q==
X-Gm-Message-State: AJcUukepgsnM4aWdJLvR49XtXPW/8dsmxWuMbq2URAAp79pkAerFYP9U
        oYZoeuMxTAVJyXs8/vzfAA==
X-Google-Smtp-Source: ALg8bN6uCpj194teH+fx4QRkRzCQt0eNAMF74NKF2BPwia7Sehsp6+1GMnd8QUGI4EzHqjouyE4XEg==
X-Received: by 2002:a63:cd11:: with SMTP id i17mr10723232pgg.345.1546351482695;
        Tue, 01 Jan 2019 06:04:42 -0800 (PST)
Received: from localhost.localdomain (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id v14sm121117477pgf.3.2019.01.01.06.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Jan 2019 06:04:42 -0800 (PST)
From:   Junchang Wang <junchangwang@gmail.com>
To:     dave@stgolabs.net, paulmck@linux.ibm.com, josh@joshtriplett.org,
        corbet@lwn.net, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Junchang Wang <junchangwang@gmail.com>
Subject: [PATCH 1/2] whatisRCU.txt: fix outdated links
Date:   Tue,  1 Jan 2019 22:03:19 +0800
Message-Id: <1546351400-16389-2-git-send-email-junchangwang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546351400-16389-1-git-send-email-junchangwang@gmail.com>
References: <1546351400-16389-1-git-send-email-junchangwang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix outdated links in whatisRCU.txt.

Signed-off-by: Junchang Wang <junchangwang@gmail.com>
---
 Documentation/RCU/whatisRCU.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 4a68543..1ace208 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -302,7 +302,7 @@ rcu_dereference()
 	must prohibit.	The rcu_dereference_protected() variant takes
 	a lockdep expression to indicate which locks must be acquired
 	by the caller. If the indicated protection is not provided,
-	a lockdep splat is emitted.  See RCU/Design/Requirements.html
+	a lockdep splat is emitted.  See RCU/Design/Requirements/Requirements.html
 	and the API's code comments for more details and example usage.
 
 The following diagram shows how each API communicates among the
@@ -560,7 +560,7 @@ presents two such "toy" implementations of RCU, one that is implemented
 in terms of familiar locking primitives, and another that more closely
 resembles "classic" RCU.  Both are way too simple for real-world use,
 lacking both functionality and performance.  However, they are useful
-in getting a feel for how RCU works.  See kernel/rcupdate.c for a
+in getting a feel for how RCU works.  See kernel/rcu/update.c for a
 production-quality implementation, and see:
 
 	http://www.rdrop.com/users/paulmck/RCU
-- 
2.7.4

