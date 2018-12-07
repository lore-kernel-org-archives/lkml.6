Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E33FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5523C208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPAiiZKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5523C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLGO1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:27:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35353 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:27:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so4718369wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nb/937q0HrPebKdO6en2QZ4aPcytPbz3X9jO/ZwmUq4=;
        b=ZPAiiZKWSdTkp0DdmMCBExPf8lfspMmI1ZsGKqxsMcdrK7qf/Sf7a7MfSiHdbkhQfw
         X6MLmNQw4yicelWzV+iiXIGL8daUpTAPyEu72KGnDsw70ReXrxot+aP1P1BWSvxvH9q4
         yY0+uct/RjeNAv44lWcxLPFiFoiYqcf2PJ8DKFK5+yIgHTdB29Hs5BPXP1ORVtikt0b6
         9EVk2WLyqPvFmLTzBqxoVTWnQZr0DuX21bxX7ARomdCaXNm9LNdQxYrRA2xxJVdt0HQT
         NBkQ7CrEeKh4cafjLKHThtUf+fQ9ls6wWZEVb5lNH8kHHBZhXqkh5I8h9XwEd8Fpkl1L
         NdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nb/937q0HrPebKdO6en2QZ4aPcytPbz3X9jO/ZwmUq4=;
        b=ROGpGAATVk06CsupAtNgpWdmDmJK4b57Ja+ENKaTPTsSe2dhR/QTVvkL/HECg+Tj4h
         PxslLYKXMQhVs4ALhkiQQCVGf0oufBJ3h7YaQ7YTAhSiwKoCIn8RPz3AfoEqCpW+hCN2
         fJEnpDj4jphHT6Uzv7bT3Q2/X5c9JuaJ9sB6qD8ukRFKpBQmKKBM8NTYCtOTCXw0dFEH
         ZEr5XwivCM+UCFZ3XwcdIGsp/ZtpFBjHvmLzEuV6ew5MaIREY2F3mwcLsffqAJ3kqIYS
         FCMov0kndOUBVi74V5Jb7iOru2zDScu8aMGgRoOR1bGZgLAaHriCYPSO1R2GYxy7PC8G
         T6jQ==
X-Gm-Message-State: AA+aEWb1NfwfqfWshiQwr6JQFRPNPzshOvqj56BYi9dXs+lRu2ldtV5U
        tZehZUPJvRRIFtZaa2r9O6Q=
X-Google-Smtp-Source: AFSGD/UCQsCdoeJX9lxXJ9W47mzssVafEM3NQbYaqS6ixB2CMI3HuEg/ttQlB3kcktIs3vIW++DmKw==
X-Received: by 2002:a1c:5dd1:: with SMTP id r200mr2551746wmb.93.1544192860069;
        Fri, 07 Dec 2018 06:27:40 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id 60sm7172523wrb.81.2018.12.07.06.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:27:39 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/5] char: lp: introduce list to save port number
Date:   Fri,  7 Dec 2018 14:27:30 +0000
Message-Id: <20181207142734.27370-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we are registering lp in LP_PARPORT_AUTO mode, we are not keeping
any record of the parallel port number to which lp is connecting.
Add an array to save the port number to it.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index e0a92d764eee..7e207ff0f2fe 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -141,6 +141,7 @@
 
 static DEFINE_MUTEX(lp_mutex);
 static struct lp_struct lp_table[LP_NO];
+static int port_num[LP_NO];
 
 static unsigned int lp_count = 0;
 static struct class *lp_class;
@@ -938,6 +939,7 @@ static int lp_register(int nr, struct parport *port)
 			       CONSOLE_LP, port->name);
 	}
 #endif
+	port_num[nr] = port->number;
 
 	return 0;
 }
@@ -1013,6 +1015,7 @@ static int __init lp_init(void)
 		init_waitqueue_head(&lp_table[i].dataq);
 		mutex_init(&lp_table[i].port_mutex);
 		lp_table[i].timeout = 10 * HZ;
+		port_num[i] = -1;
 	}
 
 	if (register_chrdev(LP_MAJOR, "lp", &lp_fops)) {
@@ -1091,6 +1094,7 @@ static void lp_cleanup_module(void)
 	for (offset = 0; offset < LP_NO; offset++) {
 		if (lp_table[offset].dev == NULL)
 			continue;
+		port_num[offset] = -1;
 		parport_unregister_device(lp_table[offset].dev);
 		device_destroy(lp_class, MKDEV(LP_MAJOR, offset));
 	}
-- 
2.11.0

