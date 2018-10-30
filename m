Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB18C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3289920827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcHZZV4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3289920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJ3UzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:55:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44652 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeJ3UzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:55:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id j13-v6so2216493pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gXt7PGWaFqlgXfIGV1PiMV5WnWSWVWJiLoNBWO0xwus=;
        b=pcHZZV4l9FeBHuGFNY/M/mcrJpICttLHWL/8BqYywLcasTZdAxAJ6WDSc6x91CGeJu
         gn6Q6FATR4enUyyJ76CSPXKjXZX/3CxEb6WvFgBLw64eak3pU9nnVUHBWJroe8VR2pvz
         BYR9H0FOVn1Gc+kE4J4KEwaShkHf3bPf2WpAeWpNAuDyvvHCF5uMkJJml+MIgPs4acVS
         Aoj5eQ7BpyjVmpm1smCw3qLFSiKRR01mr8yOZ0RMexQADbGZyJIhjFdw6Ty41GIMV5hT
         2mU7Jy46txQ07C8MnGPiwzx/A9aQy2vfH1uT61rTbL3WXTHxP+kfzNZupNPexeNO0hYt
         EjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gXt7PGWaFqlgXfIGV1PiMV5WnWSWVWJiLoNBWO0xwus=;
        b=mvq4diN8eFYLXgngZzIo8di88CcWSBWwPa6iiS5+MxyLV1X/kEdcEou8nM+JJDQs69
         Z39O3HdhsWX0af91c7urUbm11tCDFATQEa+q1UYCAwSvgY8310xpUVOLm2gwqpdCOciB
         82KSFEIkfE4/9p4VTB/1UVZLj+3Ptn2JWQPPkH5diiYdnLBSrK9/ZWpCgip/BW8MhGXq
         BVx4VuhthEQoxdbgWsALFm90L4Ddz/2/1O2r8Xosrs+S3Cq3snySPBtFahMrQvV6qrl/
         gsDlQi6td1R+h+t2OuZVEQtiOniqfWSCGA6Dd28m6nHq8GoGl1M09iiRaSkdc2lzY+X+
         L84Q==
X-Gm-Message-State: AGRZ1gKBFi57jbJBeSrIRQ2HFlYKPZUw4HPJ7tHDP0745+2UYMAhZafL
        LBFH/o3RpezXZCrpvsfN/1o=
X-Google-Smtp-Source: AJdET5d0WwgRC5Wl7nkRftiPHMKabtmjXliYVhto9XC9++CZJGHt7RzP17XFvgEWlxv11aqsmrDLdQ==
X-Received: by 2002:a65:5c81:: with SMTP id a1-v6mr17611080pgt.390.1540900915800;
        Tue, 30 Oct 2018 05:01:55 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id s80-v6sm27378369pfa.114.2018.10.30.05.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Oct 2018 05:01:55 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Bo YU <tsu.yubo@gmail.com>
Subject: [PATCH 1/3] kobject: drop unnecessary cast "%llu" for u64
Date:   Tue, 30 Oct 2018 08:01:14 -0400
Message-Id: <35468e5db6df40544967256e3fe276e9f3bc36a8.1540886346.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1540886346.git.tsu.yubo@gmail.com>
References: <cover.1540886346.git.tsu.yubo@gmail.com>
In-Reply-To: <cover.1540886346.git.tsu.yubo@gmail.com>
References: <cover.1540886346.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no searon for u64 var cast to unsigned long long type.

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 63d0816ab23b..402765c3a9cb 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -579,7 +579,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,

 	mutex_lock(&uevent_sock_mutex);
 	/* we will send an event, so request a new sequence number */
-	retval = add_uevent_var(env, "SEQNUM=%llu", (unsigned long long)++uevent_seqnum);
+	retval = add_uevent_var(env, "SEQNUM=%llu", ++uevent_seqnum);
 	if (retval) {
 		mutex_unlock(&uevent_sock_mutex);
 		goto exit;
--
2.11.0

