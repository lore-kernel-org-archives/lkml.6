Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDFB20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+lyFQy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDFB20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeHaDOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:14:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46140 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaDOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:14:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so4543703pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LI6+qHPDRBvyXX9jBnTvMYKMO/1YjzPfSnNJukRSBEc=;
        b=g+lyFQy4q9GU+n1DOCqw3kv7QtxCneYzNVS7NiaKWXRWf7c69jaa+W/jpPfN3CTB4x
         pFgnxf4NlB/Yx8LwUvhXIPg/z3N+EFqVwpdQdKAWzdykOVNbDp8exmk66ny/6M3Q62Qo
         OxC+DXJ/IjnO5wHdK7Cb3EjX0JgbCRn2TDVOmAnSg460Efs7Vmn8SVCBrNOUnxefzzNA
         I4ZdBdzqCneayt3cnJHE9JNa1E40rVSr1P1EnoJuUuQz68l8dTzylArWN0ZT8xh/7ePZ
         KKOOTscVivNRwc/OMhfb2VwueuqInuYsZStWId9HTnm388W26FchTjMlTwO9h8Nz6hgQ
         g58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LI6+qHPDRBvyXX9jBnTvMYKMO/1YjzPfSnNJukRSBEc=;
        b=jkW7Kxbw98mdtbCMI01ShXt2g6rOndMWKv0fPiLQyi0KhXOyFEM+FsTu6PZaBG/jZl
         8Y1kk0LHtHKo7ZFNr/0I8X4nE80zzTjux0x7o02MM2eg/YWKBG9B4aFnB6AI2uIDzS5/
         Lu/IpJAVVRG2MDMrdmvEHBk35RrW7DOhA9xs65sqAgOImLP2x0x9XwDX8bJRitA29OPV
         Bp5hj5CNNGKizQs7miQBm8l/OuYDzXhVRj0InuP0eSWeMQ3ZglZdhHZU57ndxSBoINPC
         SRfgvyBCpbmiYmsGUkM+QMpesVfhtsn7m7jFCve1CHO1VRrKglvKMQUYCCxgyXGHQEiN
         6t6A==
X-Gm-Message-State: APzg51A9J/jWFWLpuisyissNQ3LkA2KsFwb2H0foJF/lviBYsHwtK8Kr
        voUIc6L5mqY2LX25GDzsDIVkw0N8aXg=
X-Google-Smtp-Source: ANB0VdYyovp8VvFAWITEDFD+JcnpSnSQVghwnuf2UghwiBKBqI7/5g3jiSEXyfZ1umcjXCoBZPjPXQ==
X-Received: by 2002:a62:c082:: with SMTP id g2-v6mr12725820pfk.72.1535670602158;
        Thu, 30 Aug 2018 16:10:02 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1612:726:adc3:41a6:c383])
        by smtp.gmail.com with ESMTPSA id j15-v6sm10348610pfn.52.2018.08.30.16.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 16:10:01 -0700 (PDT)
From:   Daniel Rosenberg <drosen@google.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH] staging: android: ion: check for kref overflow
Date:   Thu, 30 Aug 2018 16:09:46 -0700
Message-Id: <20180830230946.228701-1-drosen@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 4.9. It does not apply to master due to a large
rework of ion in 4.12 which removed the affected functions altogther.
4c23cbff073f3b9b ("staging: android: ion: Remove import interface")

Userspace can cause the kref to handles to increment
arbitrarily high. Ensure it does not overflow.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/android/ion/ion.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 6f9974cb0e152..48821948fa487 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -15,6 +15,7 @@
  *
  */
 
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/file.h>
@@ -305,6 +306,16 @@ static void ion_handle_get(struct ion_handle *handle)
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
 int ion_handle_put_nolock(struct ion_handle *handle)
 {
 	return kref_put(&handle->ref, ion_handle_destroy);
@@ -347,9 +358,9 @@ struct ion_handle *ion_handle_get_by_id_nolock(struct ion_client *client,
 
 	handle = idr_find(&client->idr, id);
 	if (handle)
-		ion_handle_get(handle);
+		return ion_handle_get_check_overflow(handle);
 
-	return handle ? handle : ERR_PTR(-EINVAL);
+	return ERR_PTR(-EINVAL);
 }
 
 struct ion_handle *ion_handle_get_by_id(struct ion_client *client,
@@ -1100,7 +1111,7 @@ struct ion_handle *ion_import_dma_buf(struct ion_client *client,
 	/* if a handle exists for this buffer just take a reference to it */
 	handle = ion_handle_lookup(client, buffer);
 	if (!IS_ERR(handle)) {
-		ion_handle_get(handle);
+		handle = ion_handle_get_check_overflow(handle);
 		mutex_unlock(&client->lock);
 		goto end;
 	}
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

