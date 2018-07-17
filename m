Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B455FECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67144208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z202eMpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67144208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGQCkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42655 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbeGQCkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so8208745pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=inPp99IyCggJ5JzoBgEQkIf2dCom/uUiaC1+Y2uOfNo=;
        b=Z202eMpHdF16N866AcG25mMTmAZ4sFGTYjXml3VwkFslLj0N8F44E5x27lXbdL8wPw
         OAru82Uknf7J7QkMA0WAefjvI6mwFuz5EYuQhNmFbekMOCcA+qy71LWUn6FKRzb84Ss2
         xiaLrlt+5qHdXGNt4SOUIKEZcP6Kw4YYYJNSFiV93nZczIME3YXSqsfYjLoJb1svNZxe
         u7qtNyApD8swGtz8iZoQjQpIqPVblD2S9NM1cSr62A6tl6OPta00ZGYaIkiAJxG9lt0n
         98BetSXcFoDhgVf3KcrsNso9vGHx3ece+Hewoh0K2rnMdxXM5TS2894hNuPmDcA1xP/s
         Oa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=inPp99IyCggJ5JzoBgEQkIf2dCom/uUiaC1+Y2uOfNo=;
        b=TBlPB2ShFDs1JwOQxgSjaSUeX9a/nbKfQp6sDNp5ObRaGNY2LLavOkTD2Z21wlHpth
         lp6nu1R6Jelbn7Lmpj2IrIEoNAswWF1lXx1VtHJQd9wmnWnXQ8DcgpoKRUn63RvRs1Sx
         YU1LW9Z1TxYnMOpTy9eu+qvNuU3/scb6iQZrQqaY3WkV7SYyko6j3v+kIkGdGo/B1tiA
         pLfBXdIsQH0DMMUcn/D5vV0qtbDqOZSoEf9ASqJ+rRfLzo5MtzVPhSjE1hROXRwxR3K7
         1JM37h6DHs9XTx5UVZTgmOSV2VXObbpf2crkNG2cXCbgP/V+dLif0en0U3sEx69usNxt
         D7IA==
X-Gm-Message-State: AOUpUlEw2cqr/bujxQnUCCbEZC3GJZBqCucAkjDVWBOqZKexzKu5dOt5
        XFtmDorC7SRXnpbGKIiwYB4=
X-Google-Smtp-Source: AAOMgpcNU2UXM2j5LviCMByKqBSeSVt0cUzFEhMOdvgQIWKzpbjqmrYQj+PldhwsSTUo9NhBGYZSRQ==
X-Received: by 2002:a62:8b0f:: with SMTP id j15-v6mr20709478pfe.33.1531793390416;
        Mon, 16 Jul 2018 19:09:50 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:49 -0700 (PDT)
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
Subject: [PATCH 05/32] staging: gasket: remove driver registration on class creation failure
Date:   Mon, 16 Jul 2018 19:08:59 -0700
Message-Id: <20180717020926.176408-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

If class_create() fails, remove the gasket driver from the global
registration table.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index b69b630f1b79b..cbadab7544c81 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -335,7 +335,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	if (IS_ERR_OR_NULL(internal->class)) {
 		gasket_nodev_error("Cannot register %s class [ret=%ld]",
 				   driver_desc->name, PTR_ERR(internal->class));
-		return PTR_ERR(internal->class);
+		ret = PTR_ERR(internal->class);
+		goto unregister_gasket_driver;
 	}
 
 	/*
@@ -369,6 +370,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 fail1:
 	class_destroy(internal->class);
 
+unregister_gasket_driver:
 	g_descs[desc_idx].driver_desc = NULL;
 	return ret;
 }
-- 
2.18.0.203.gfac676dfb9-goog

