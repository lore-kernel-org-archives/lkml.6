Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9849C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED5220851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2SHGjAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeKTXxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:53:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34197 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeKTXxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:53:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so916392pgg.1;
        Tue, 20 Nov 2018 05:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aFxALuu/7D7no7EGEKAYaaNDS9V0B+ItYtApoEp/PZc=;
        b=s2SHGjAhp2gQbwiAC3ZRhWeyqFACDyZC1yks3gM/LH7y/cUzR7WBxYl/1VVLzPFWPw
         aRbksCBSqxwP2qHfsqCfb8JPrGn5hDyiRJVcXp6CI5w2i+F49GRaJOxeJ5MUmrZxGKLK
         rmZQp8ks0QAcoJTXCBQAXNIrrHVuWPiE1kmfT3uKnaTpTH4KiLFtAM55SCZyFOLYtBsF
         Vc0fTUv3wMIMFVWzHJG4pIr7Obr4+nxlpEIxb3849mOtyV3mdVKz42ZLlILmVjPvqvpY
         jStPF6IiLi3O6jPI1ZOC4cDnA/cwe+1zfWV4CNwmf4kfWLRWg1ZvI4kwctq+KCo4GAha
         HbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aFxALuu/7D7no7EGEKAYaaNDS9V0B+ItYtApoEp/PZc=;
        b=IiLRDQANOil2qlF3rSm5GYV+WuqMzUXbq0RKBnQHPvIIPUkFp/ZVf58rT0YNS4VGHV
         qRXkhXBPRUTLPxx+ohO05uzPEgk0kriQ/1+mp8yti/KYRTm2vbnaCQKV9184rtL4Twh2
         DwPeIDAXIDe8mgYcJ2ygLoRcPiGh/P+ZH7ssOgAw98ewIZ7juDMtRfDaoamNFVA01WWU
         GjdyJnGNT5bPGBPHY/rjrYIj7hCk+KJnDqAiuOqT10lctJB+CS0SLx/FbehJjD1TT+SD
         6DKv2ZAvjG4V/R1o42wJwVAnVDnak54n5K5vT8ehA1tK1FiQ2iqwvMygcFNn4/jTILei
         EQhQ==
X-Gm-Message-State: AA+aEWZ//h7wqIWJ2J8rnomsrvSkq1VmcENTHlu17Ygqnizu+rqFM+Xb
        CLDzro+W2XIqekJFeoxwezZ5EeKWK5U=
X-Google-Smtp-Source: AFSGD/X9WIEHzQI3PcPbKZ7vFCL9Qeo4duYafBE3wt+kPagm0YbNI62gidllQcqaURfEh5gcqDSjnQ==
X-Received: by 2002:a63:9809:: with SMTP id q9mr1874820pgd.109.1542720243216;
        Tue, 20 Nov 2018 05:24:03 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h10sm43934359pgn.11.2018.11.20.05.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:24:02 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] watchdog: cpwd: add of_node_put()
Date:   Tue, 20 Nov 2018 08:23:59 -0500
Message-Id: <20181120132359.19799-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/watchdog/cpwd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index aee0b25cf10d..d3a81642ada5 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -617,6 +617,7 @@ static int cpwd_probe(struct platform_device *op)
 
 	platform_set_drvdata(op, p);
 	cpwd_device = p;
+	of_node_put(options);
 	return 0;
 
 out_unregister:
-- 
2.17.0

