Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B91CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9F020827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0mXDtkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9F020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeJ3UzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:55:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44793 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeJ3UzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:55:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so3797226plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/fZwBH2iVawH1pntIF6WCbMKPZ5JViHWRsqv2E4qUT8=;
        b=p0mXDtkA4SPwdPj+Oz41y47GdUj4XKHYufcQfmOyXtql1nSauDhak+HSXMbvSHlZD6
         vl/eKEy1/zAZeB/h1olmsfNoh/w48cYs+LElVIVQTLYWpQQdEYwUIz8hC5Dhd4jSwpea
         VebPz1NeUMXsB+pdM+oZUudwlrsl0zxFTeIUqwyZ6LaaCE8gTwvUuE20wgr6GCxpfqrg
         TACfI+x+eZobCczPsnidUGks2h4zDVESLaNlkWp/UF0uc5kiH/wYtNUMMKwO5gP6JNNV
         2l8JvRlIBbRG6aeSSP+3a8/YenCMWk1Bc0qwnCCWxD5Ps64I0nUhG5o1U56xux4Scqgh
         UeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/fZwBH2iVawH1pntIF6WCbMKPZ5JViHWRsqv2E4qUT8=;
        b=Wyxr6doBE2G67TD2hY0NUkY5QYczutlD1JBW5F4UommCLDZrKuExvqeM4TuzSd7lqu
         SJPsrTsvFA1O9GFHvvB3K4YFf1VkoJczCoqFQ2Xzvkqh1ogY/AO5KpxEZY3rqOwNe8+E
         3i6EDJI5g4VjDl+6XJWH/CGdjSxeGw29sbjV7mbDScczkXxvHAcZWaCiVXz0lPWAO7dn
         GeYxrRMRHdVlr5cP8oOiSyPUR1bmOExXKpZJrl324JbbNLmIeqZeXp0x0cf434QOr94/
         vY8pfQ9eiTiI3JclTshjK6cpbwoNsKzH0BNF4aUmRKPRo7SekrrZ1Cq2DxT2VSycQ6ma
         TErA==
X-Gm-Message-State: AGRZ1gJ+A1BfnVBfcteXYDcWpW9t2VDonNMR6opmRINBFG4rYG8Ls3tK
        9BqYNOl39JHQStryrijTbnI=
X-Google-Smtp-Source: AJdET5dEW7QMDhssalpw3d026WIfD8+MQTlfBv0T0fxxrUgM68+Sraa16idCG8CXL5kLKgc/q6PZSw==
X-Received: by 2002:a17:902:6b04:: with SMTP id o4-v6mr18726759plk.333.1540900921128;
        Tue, 30 Oct 2018 05:02:01 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id s80-v6sm27378369pfa.114.2018.10.30.05.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Oct 2018 05:02:00 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Bo YU <tsu.yubo@gmail.com>
Subject: [PATCH 2/3] kobject: Fix warnings in lib/kobject_uevent.c
Date:   Tue, 30 Oct 2018 08:01:15 -0400
Message-Id: <2783c5cb2226510ba8f7777aaefbd5df9c553bf3.1540886346.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1540886346.git.tsu.yubo@gmail.com>
References: <cover.1540886346.git.tsu.yubo@gmail.com>
In-Reply-To: <cover.1540886346.git.tsu.yubo@gmail.com>
References: <cover.1540886346.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blank after declaration.

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 lib/kobject_uevent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 402765c3a9cb..27c6118afd1c 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -240,6 +240,7 @@ static int kobj_usermode_filter(struct kobject *kobj)
 	ops = kobj_ns_ops(kobj);
 	if (ops) {
 		const void *init_ns, *ns;
+
 		ns = kobj->ktype->namespace(kobj);
 		init_ns = ops->initial_ns();
 		return ns != init_ns;
@@ -390,6 +391,7 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 	ops = kobj_ns_ops(kobj);
 	if (!ops && kobj->kset) {
 		struct kobject *ksobj = &kobj->kset->kobj;
+
 		if (ksobj->parent != NULL)
 			ops = kobj_ns_ops(ksobj->parent);
 	}
-- 
2.11.0

