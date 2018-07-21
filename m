Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1571BECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983CF20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSDIAgWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983CF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeGUNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:51:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45148 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeGUNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:31 -0400
Received: by mail-pl0-f66.google.com with SMTP id 94-v6so6330674ple.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fGowTXP61m7tCJr+aTp4LKW5gj00RXiaKOvOriy1mCA=;
        b=tSDIAgWOe85cH9et4cm7wRgC5DXij/UPPzMSz8XwTm5jmPapl2eUu+KLxGWTCsmJ5T
         YnmzQQt1tLUGQgNmHmQQh3fQRPfrTT26jR6EQWvQtMC5ld3grqFvMnKjTvVUIcEDifGt
         ejsb1pSX31KwvkxVolhv6qYpatsQ4fmGnJhubYb9wo/rZoyEfsQUlW4sT7FgVktHNP6M
         F/QidNHs0rfsg3jgNUbrOe2JZ+/ZIuTNnRvOv+9IR87aJtqXk6BAd+n6FHi/HEba4pyD
         jUn7PJoJkvMjkaNllGSAXod4WtF0l2MthOPB4molUB5pgGoj+d+s8H+7Gq7H9gEcH6BB
         l7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fGowTXP61m7tCJr+aTp4LKW5gj00RXiaKOvOriy1mCA=;
        b=Ap3AFPZZlOm4qYI8LlLU086GY1we3DHeeqXIDbsneQxyBrcIFhIrWoJh76+KXzFdJN
         K4nNnmo0K8bXa9YxSltEUAUr7Co5VFGkw8snGV90QCRIUwmOqURaBi2Jbv70ra3Kcx8u
         KBk/eXPWuiotvfc16xfqq7EXsA23DMtXkX2kW3/QO/u3o7u7MzopOvkix9xl21kSOrxh
         UKFPQNgF1KUFWmgm7ca5gqCafXk+YfJMmp/5HImcaJAlv0w7EIEwwR6u7ecVj12s9Kt2
         sM+brUsOCLwunB62UOvvoe/cPHDSUVSL4AFYR3/PKtYvJCq5KNURGk8fNnJNROs6vK0j
         WSzg==
X-Gm-Message-State: AOUpUlFpLbkXgIbNCDjWfPcIbfo7fxJPCS3KitaNRyCfRU+y29IHP2P5
        8mqftpMw+DIieCaf4nUE6+Y=
X-Google-Smtp-Source: AAOMgpeHbtWzOSxCgLz/MFvGuJ7qurlCsGkvA99tv9UZeEM1uC+4hDqCrniFe9F8zBvFGeKAd+AHGQ==
X-Received: by 2002:a17:902:b40c:: with SMTP id x12-v6mr5875197plr.163.1532177871609;
        Sat, 21 Jul 2018 05:57:51 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:50 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 10/20] staging: gasket: remove else clause after return in if clause
Date:   Sat, 21 Jul 2018 05:56:59 -0700
Message-Id: <20180721125713.88501-21-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Else after return is unnecessary and may cause static code checkers to
complain.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 2a27db658a4e4..617d602b8b447 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -598,9 +598,7 @@ bool gasket_page_table_is_dev_addr_bad(
 	if (gasket_addr_is_simple(pg_tbl, dev_addr))
 		return gasket_is_simple_dev_addr_bad(
 			pg_tbl, dev_addr, num_pages);
-	else
-		return gasket_is_extended_dev_addr_bad(
-			pg_tbl, dev_addr, num_pages);
+	return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages);
 }
 EXPORT_SYMBOL(gasket_page_table_is_dev_addr_bad);
 
-- 
2.18.0.233.g985f88cf7e-goog

