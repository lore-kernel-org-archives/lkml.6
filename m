Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DC6C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F24214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBeyA5h1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F24214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeHUXyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:54:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39328 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeHUXyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:54:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id a11-v6so8980651pgw.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9cjkjlrdY+HGBYI9OzUREJRROMf3EB5erbhTOL6QPK4=;
        b=eBeyA5h1aTUgiScY8bPSLBOswB0d+JclWGGvCnBWSvTNtpx9ZCy4iQfF0QRs3hh0Ct
         2TMDM0evFyUXr7SxRyHKm1JC+G/O5rQmZoG7LctvQf6eqwz/1nwYH3X7J4d31JtfKleE
         yJ9XAJlcOjo7qP5hIWuAzV0B3M8qq7+FqRJkkPFaA7ZDU370boVuumrJd+7jfbnhKZBg
         9nU5NRZdkmnAl25QgNU5vYzFZtMwn4/0A2eOsfodS2cctLG3FbIRGMwMB1vRpnrAMdV1
         bj4NnkX8MQ2+V27BqboX8ar9LRL0u77p6P5opadNPHO9MfSvVA7/Op2JbTYUx/ZH43oE
         dQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9cjkjlrdY+HGBYI9OzUREJRROMf3EB5erbhTOL6QPK4=;
        b=D4yalam3EpiiTlSgk2yYESv9hCv6RUmJvGHnuvYXO0raHmqKyJ0WIgzraBS/PuH8Ry
         Ru1WzEodMZeT/uwDWmzYieXUsDAg5AVzEFwmJ1Q9V8KMbny1rJjodZCkzfVDO7HB4a1e
         b3qOtOOaGptYtyktNkRmI0FUi9hVR7xXzyGjhe6LppCAj3jU/Zr4PlyAZ6W8AlnweSQT
         Glk5QkeMS9LscjHnOLN1QUiAasClP0+vXMI+ngSn2M3f9/7KrxTkAeqkTjKcgiBIGmjP
         YzHf1okzQqemXLNAhUnmt1u5kErUyneiUauxQwg8H+D2leLWcYafKmuxquh9qYeooNI5
         lH7Q==
X-Gm-Message-State: AOUpUlFpofHm+Z3fxeXdCSSjbU63yAdso+IrksJLsT3er/YUFy8B1vvf
        V6EBJ0Svz9bDabeskk+G0gy+dQ==
X-Google-Smtp-Source: AA+uWPwSrKpowlBLdMwgwuFIiyYgH7Oik0oibF58l3d15zmt7m0UdZY6l1YUt7Qe5v2N4erFlpRwag==
X-Received: by 2002:a63:1e63:: with SMTP id p35-v6mr10088845pgm.376.1534883558432;
        Tue, 21 Aug 2018 13:32:38 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1612:726:adc3:41a6:c383])
        by smtp.gmail.com with ESMTPSA id v82-v6sm22350495pfd.64.2018.08.21.13.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 13:32:37 -0700 (PDT)
From:   Daniel Rosenberg <drosen@google.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH v2] staging: android: ion: check for kref overflow
Date:   Tue, 21 Aug 2018 13:31:50 -0700
Message-Id: <20180821203150.231997-1-drosen@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can cause the kref to handles to increment
arbitrarily high. Ensure it does not overflow.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
v2: Fixed patch corruption :(

This patch is against 4.4. It does not apply to master due to a large
rework of ion in 4.12 which removed the affected functions altogther.
4c23cbff073f3b9b ("staging: android: ion: Remove import interface")

It applies from 3.18 to 4.11, although with a trivial conflict resolution
for the later branches.
 drivers/staging/android/ion/ion.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 374f840f31a48..47cb163da9a07 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -15,6 +15,7 @@
  *
  */
 
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/file.h>
@@ -387,6 +388,16 @@ static void ion_handle_get(struct ion_handle *handle)
 	kref_get(&handle->ref);
 }
 
+/* Must hold the client lock */
+static struct ion_handle *ion_handle_get_check_overflow(
+					struct ion_handle *handle)
+{
+	if (atomic_read(&handle->ref.refcount) + 1 == 0)
+		return ERR_PTR(-EOVERFLOW);
+	ion_handle_get(handle);
+	return handle;
+}
+
 static int ion_handle_put_nolock(struct ion_handle *handle)
 {
 	int ret;
@@ -433,9 +444,9 @@ static struct ion_handle *ion_handle_get_by_id_nolock(struct ion_client *client,
 
 	handle = idr_find(&client->idr, id);
 	if (handle)
-		ion_handle_get(handle);
+		return ion_handle_get_check_overflow(handle);
 
-	return handle ? handle : ERR_PTR(-EINVAL);
+	return ERR_PTR(-EINVAL);
 }
 
 struct ion_handle *ion_handle_get_by_id(struct ion_client *client,
@@ -1202,7 +1213,7 @@ struct ion_handle *ion_import_dma_buf(struct ion_client *client, int fd)
 	/* if a handle exists for this buffer just take a reference to it */
 	handle = ion_handle_lookup(client, buffer);
 	if (!IS_ERR(handle)) {
-		ion_handle_get(handle);
+		handle = ion_handle_get_check_overflow(handle);
 		mutex_unlock(&client->lock);
 		goto end;
 	}
-- 
2.18.0.865.gffc8e1a3cd6-goog

