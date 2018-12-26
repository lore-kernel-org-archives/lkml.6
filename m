Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D59C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F5B2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aCINqcNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLZGY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:24:27 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:56358 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeLZGY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:24:26 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 5892C977
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 06:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xAad-qwzhOdq for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 00:24:25 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 2E534969
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 00:24:25 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id s3so12832266iob.15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ah9UrnxXN7i7/f+OebV6LtEy0PsZT62nZH6IXpAbhDw=;
        b=aCINqcNt0vEQV7BGGN2t8izgL47wCf9FcDM8NVQiyXXwbeXuEZWOufNRQQEPKrM/YM
         /LORVYsRzZvfqLWxscN8foCg8u2+NKfi9KkK7pDMfO6+R/P5FFW77gPpi/y7Lw2kPlCz
         zvNomM8D80iys3oD7hC/KaapU7ePBAul1+jbvEM+Eapax50fT2Hnk77R2Pl8DojbOjNm
         jWMEuc3DutnBk4hKkIvG8398c1bdrq+CBGomm48egXmENVsQ92zwBJEhAarNaAqvA/6H
         iqrmIN0CA5K0Gg6yGtPJ1QE5agLC0YHCu7ulRC6NhH8BTNeCM7gJYVbyH8TFgvX1i3AS
         6bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ah9UrnxXN7i7/f+OebV6LtEy0PsZT62nZH6IXpAbhDw=;
        b=ALQkTHb1eWImForhM+82wW0JBeD6+JJryybnEOgJzE3O0wul0eOSybZQLVICsyEqNF
         O4yu3LKOtX6GtVVzRIcR3HWJhHz78KChxZxtsY1VNpCFwmQf964pEZHZBLactWsCCcl5
         h8lgSpoyxS4Kp3XTaCNftB0JxbdGRRzGy1YH4MyH9UYF2W9f/GEmhDwIrrKLOWsZXwQO
         XVCVoK0yiKUFKEZs+91OXdk5GZWyIjlYbkoK/XXQZhQpnWSMy2NgITa7wmsgZUkwlqJv
         r0vsWQadFl6RE0PQgPKXevz0YGZt3kvEivkNJ7gtjevHH/2jViGTSPEa6s9xbhjXX+ay
         NdTQ==
X-Gm-Message-State: AA+aEWau4E6ehp1wk5QsU111gV9DkFIU43poIUHSizF40ee/p5ZBgy+a
        ZWKZWRySY/qcgiOgyDEZXErELzo021L39AC4gVn6jdvx64Am/oASl5Dy9SJhEaNeaCcPdw9yFa9
        0a4zICd0UJJBW0Ez2OmsJ0St61vVI
X-Received: by 2002:a02:818c:: with SMTP id n12mr11682531jag.108.1545805464709;
        Tue, 25 Dec 2018 22:24:24 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UspA6kb9HRVAHf+Kyd0c8B58Y+rDMk2n0vt6joRBT1j2uVDPM0WrV0BkjJviFL7IXtn6sAow==
X-Received: by 2002:a02:818c:: with SMTP id n12mr11682515jag.108.1545805464466;
        Tue, 25 Dec 2018 22:24:24 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 81sm15485012itz.15.2018.12.25.22.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 22:24:23 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        David Francis <David.Francis@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: drm: fix an improper check of amdgpu_bo_create_kernel
Date:   Wed, 26 Dec 2018 00:23:45 -0600
Message-Id: <20181226062348.75519-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adev->firmware.fw_buf being not NULL may not indicate kernel buffer is
created successful. A better way is to check the status (return value)
of it. The fix does so.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 7b33867036e7..ba3c1cfb2c35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -422,13 +422,19 @@ static int amdgpu_ucode_patch_jt(struct amdgpu_firmware_info *ucode,
 
 int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 {
+	int ret;
+
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
-		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
-			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
-			&adev->firmware.fw_buf,
-			&adev->firmware.fw_buf_mc,
-			&adev->firmware.fw_buf_ptr);
-		if (!adev->firmware.fw_buf) {
+		ret =
+			amdgpu_bo_create_kernel(adev,
+			  adev->firmware.fw_size,
+			  PAGE_SIZE,
+			  amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM :
+				AMDGPU_GEM_DOMAIN_GTT,
+			  &adev->firmware.fw_buf,
+			  &adev->firmware.fw_buf_mc,
+				&adev->firmware.fw_buf_ptr);
+		if (ret) {
 			dev_err(adev->dev, "failed to create kernel buffer for firmware.fw_buf\n");
 			return -ENOMEM;
 		} else if (amdgpu_sriov_vf(adev)) {
-- 
2.17.2 (Apple Git-113)

