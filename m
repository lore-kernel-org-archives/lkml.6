Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8A8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0A2208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVSywI+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0A2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbeGQCkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33014 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731605AbeGQCkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so27215873pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8LZFgAyB0TxYIUuUNQmSGVZw4nA0hoI/VyMkKVZ6Ks=;
        b=tVSywI+xC27PDAmhYSCLE1R3JMdMhcuxxn92d66howq+7+bGItrYA9Gt7D4cAydmnf
         +3aINTQfVgM7KxYOib8oFMgoUkFCVVV3t3SSUCJHq7rkpp9yd/+8UbuwKw7WU9EGbZzX
         NJ3hlby8uhc6KtE7sL7fdZBBXDLNStmQ21uqjP7Z5Ai0CS0FjHZnnMhPytkpD858tl+c
         jtS5rOSaxAkh5yWa2DfU/qhyogTGwMSUdCQ3PI47cKb1ZYyt2KPK0iuSC7TqthlbgIcj
         5oJAp50ahw+/QoAMsmO32MKq5zjD90ZMD2EGt58i09CYzw85JY+6Efi/qR+uEBxecGTr
         dtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8LZFgAyB0TxYIUuUNQmSGVZw4nA0hoI/VyMkKVZ6Ks=;
        b=mFRGAYnt3rujYcFqTnOd/oTKLyQpc52VipBx6/hLPg158LBeH3kWUbvZRzJVQBjIec
         xPBdg+ZfhTjSsgYAwaFzfe5iDmsVgMxCJqTSkubNI6lLnxXdazs9pUhEBdudj3zuJ7cl
         7jmSL7nb9Z94qF+K1f5SWQ5TRUOt0A4/1+ftnBZx7fImlv1zJ3XarMJXqWWm37sJVjgp
         RzoupjVaynHBDnD62pIX49WSgCVvh/zropqHdng9GrKnfLNV/7RbBy42y09PTydiK3no
         0AfXON5Tc47x/+Vh/ATbmJHV2nUJlD510afgLVzHxTjjPyDSbVFKM33oXiMQ4xMqr+ge
         8Iiw==
X-Gm-Message-State: AOUpUlGGMha2yzM04NokDlWNgj5sopFLOlyGWdr/cmDr7y/AQaOkkm9W
        0Am3Vwg5ix3eeRldmqrPfqc=
X-Google-Smtp-Source: AAOMgpfVuAVgbyLMBQsbhMJVKLX/Sgoew2VpBFJhrIsLaRK41cgXGlYlxRdgSXgC0muNlYiP/2Mgaw==
X-Received: by 2002:a63:7a0a:: with SMTP id v10-v6mr17415132pgc.444.1531793403032;
        Mon, 16 Jul 2018 19:10:03 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:02 -0700 (PDT)
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
Subject: [PATCH 13/32] staging: gasket: gasket_wait_with_reschedule use 32 bits of retry count
Date:   Mon, 16 Jul 2018 19:09:07 -0700
Message-Id: <20180717020926.176408-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Don't need a 64-bit retry counter.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ++--
 drivers/staging/gasket/gasket_core.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 85116cc46f311..a7f696d8e1026 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -2089,9 +2089,9 @@ struct device *gasket_get_device(struct gasket_dev *dev)
  **/
 int gasket_wait_with_reschedule(
 	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	u64 max_retries, u64 delay_ms)
+	uint max_retries, u64 delay_ms)
 {
-	u64 retries = 0;
+	uint retries = 0;
 	u64 tmp;
 
 	while (retries < max_retries) {
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 94a5537bff2c2..50ad0c8853183 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -702,6 +702,6 @@ struct device *gasket_get_device(struct gasket_dev *dev);
 /* Helper function, Asynchronous waits on a given set of bits. */
 int gasket_wait_with_reschedule(
 	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	u64 max_retries, u64 delay_ms);
+	uint max_retries, u64 delay_ms);
 
 #endif /* __GASKET_CORE_H__ */
-- 
2.18.0.203.gfac676dfb9-goog

