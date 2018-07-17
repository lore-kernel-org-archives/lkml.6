Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21085ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CB0208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5iakd5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CB0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeGQCkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:25 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34241 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbeGQCkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:24 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so2177838plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+QWRh4IdLQDSIbWqtQHS+2dhqjbFAEsShrwrvEWHtY=;
        b=r5iakd5dV5aTAyZGUxz3fFjnPDwmt7+hv/U2TtImQaXjI+XpGFJO5XLGASkvQSStjQ
         M1pH6YRdeEhUoaRT3iCL+vPJ1DaCZooIJEpdu2vjbOCLh6Jy4SlT2rfX4KicHci851w3
         3Gu6zDPEkGqU4xEucHqnLzurcEf4aMEQ6SVmmhcSwClZfJzeCBoMWyt7Ndp4cRq6oiD4
         KL+NPFILxxtS40sgVPVFj6+T7S9dw2iYDe+XFk7KFrL0s67Bm92L0a3cIMyD4DFMvYSZ
         TbJZ13Aq4TFBmWoIFn/Bd530jYyo/Jymf+AhBaIm2/56YJ02ol2GkuiPVLT54b5qQCXZ
         SFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4+QWRh4IdLQDSIbWqtQHS+2dhqjbFAEsShrwrvEWHtY=;
        b=ThA5ZHdnEDxVOEczhKVNYwpQ1IYn9Y45MxpAKcq/cIs9ehaSWM8JBoYJR0FauzcwqB
         zpgfs1fNckPBlQ3N9yNX+TvWznQTcDmyd8W/6vhUaj+f7tHNQUTzdelsaU9od1GcWTRE
         f2SQPozRKHxyOJJZI9tlLsNOs1ltwaEuqS1mObnQ16rIuQwTE5RnuwwF0nqbPgE7v5DB
         rSyAJjfA2mTPlNlpfsnyc4QfXSMR7KPQOT6RQiWXWXzEw5dY4OkZy3CXpY41KHSN9ee/
         YDLDkHLHSN86SHDhlvoYI4y2EWtDSYebRqkB/8dwD4nCQVzWCsRYyMM2I0cJRiP5n+WT
         EbKQ==
X-Gm-Message-State: AOUpUlEjYJDpQ5RwMp0msmoJD6YplPjQHII5f7xU/Oy2JVEZrz1lSsH4
        GSTbFdWrqo7DbIXOF956t0Y=
X-Google-Smtp-Source: AAOMgpeO9SPtP0uDxsZpXpMm3iSlfkR3Q/RXTOHDX5Uu5teHBSmXqGtXmi70VmN4rl8Da5YQUdGaHg==
X-Received: by 2002:a17:902:6845:: with SMTP id f5-v6mr18758761pln.173.1531793414234;
        Mon, 16 Jul 2018 19:10:14 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:13 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 20/32] staging: gasket: fix class create bug handling
Date:   Mon, 16 Jul 2018 19:09:14 -0700
Message-Id: <20180717020926.176408-21-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

class_create() never returns NULL, and this driver should never return
PTR_ERR(NULL) anyway.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 07c6fa3623f77..7ea6551626524 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -322,7 +322,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	internal->class =
 		class_create(driver_desc->module, driver_desc->name);
 
-	if (IS_ERR_OR_NULL(internal->class)) {
+	if (IS_ERR(internal->class)) {
 		gasket_nodev_error("Cannot register %s class [ret=%ld]",
 				   driver_desc->name, PTR_ERR(internal->class));
 		ret = PTR_ERR(internal->class);
-- 
2.18.0.203.gfac676dfb9-goog

