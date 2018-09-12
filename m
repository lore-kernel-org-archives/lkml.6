Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA6BC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B6820882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP5tYl2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B6820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeILF2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:28:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52439 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeILF2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:28:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so437365wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l35jg51nqQT9C8cM5/wk+RzVdJVbP+i8XAe7iDMYtvQ=;
        b=PP5tYl2jDclIXAOkcFB5MdSS2rktgYSDw3pFKdAFXYyxwMJHo8veyJidfFZJebtI6M
         c5O+WU4o0L3+6YodJr0e+PlNOwz2EdcpVPAo4wH3GxCwR8oTd/V/26pvLFvQQ62GDA/p
         7xXWXlovlU7M90Kx19Hf7/ePd7GvABLw4zwXEqsQSGBBPPsecsaK9Tha8KLDypm++Vux
         DB9Vu7lxjVstnA1RJUHdJHcQgi28p0OeaZnu3rzPBo4waY4/OHJTW0nqvUL77dHlHJyN
         GD3htzck2oDpPRCComfEobPBqLUk6+Kz1q02xmq1guZJC7My+PZ7gJrRgcP5EfMSo83r
         WvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l35jg51nqQT9C8cM5/wk+RzVdJVbP+i8XAe7iDMYtvQ=;
        b=Sb1QzOxFoTbRHnX7JlZjwM54cuI9aEs7S57BLt6hwiuXy+0I4JN3LZuJ5y5e97U6Iw
         voZ6fBU9dIFoRVcJ5Nz3enLxwg3pjd9xEEC5o4Ui6C/vSV27k9DVJTKjFpqmmLRCLJrw
         bCUsfSxLALTx21YFVSmNhPEJGOP7OYwu3hDKIUBm0N4KG45Uoz/zWJ9ckrmEvMdGJqa8
         Y/J4uGq75wyxgHSuxXXIL5OBEPbbLJHZJK9RbtfB7hVDhCLDc2XU9opzcQgVgcZm5hgX
         YSGa9lLivlS0K6bHyKsYyHaqRIb2Es7lJfAGRU/H6YZekyWyDqsjqpGI/C9DbAYXA1AA
         pMAg==
X-Gm-Message-State: APzg51DZhS3JD3HyI9mXJge6LtAlw7xbw4hbTQpC/Tp9xhb81Wx/Hn42
        nY6QyR5t6E6UQgXamkP5AhmGTsSYvM3KSQ==
X-Google-Smtp-Source: ANB0VdbosIya515p0PsdUnCeKJmfkMHJ1bX4QKaWsg3DsGEnnp9S6ixGoofhQzDklEPgwlrfjVwAwQ==
X-Received: by 2002:a1c:6854:: with SMTP id d81-v6mr2649235wmc.160.1536711987603;
        Tue, 11 Sep 2018 17:26:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f132-v6sm1388680wme.24.2018.09.11.17.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 17:26:26 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Date:   Tue, 11 Sep 2018 17:25:59 -0700
Message-Id: <20180912002559.1853-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns if there are missing braces around a subobject
initializer.

drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
around initialization of subobject [-Wmissing-braces]
                struct amdgpu_task_info task_info = { 0 };
                                                      ^
                                                      {}
1 warning generated.

drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
around initialization of subobject [-Wmissing-braces]
                struct amdgpu_task_info task_info = { 0 };
                                                      ^
                                                      {}
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9333109b210d..968cc1b8cdff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info = { 0 };
+		struct amdgpu_task_info task_info = { { 0 } };
 
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 72f8018fa2a8..a781a5027212 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info = { 0 };
+		struct amdgpu_task_info task_info = { { 0 } };
 
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-- 
2.18.0

