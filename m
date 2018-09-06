Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2022AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78A620857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce67cDzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78A620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeIFGoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:44:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39229 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeIFGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:44:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so4189570plp.6;
        Wed, 05 Sep 2018 19:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJpsI/WMMOpOfHY1MYHmD8ru/tq1kO6UyZ/ygQ5r3Lo=;
        b=Ce67cDzpT5KR9S1AwYnEItA8oI1fm+vyh9cV0hpO/BWBMihZCJ0IynO5gmoBci5CkE
         4Bb7Rl5jtieKTP6On2l6dOPaLUixNYCeVGdEvsuNMxWomSZdELNKtYzruHf7iVnNsFZj
         kaH+A7KoSvVVCR1v/oATl98TWD3V//prwwXewHw9sIBqpaCT+DmvsRoAM9oZrraZc4VK
         xyoFDOYSmRKbo+rDL0c1ydULY/y6is1FsYV2We4Yt111At5TsGoWNOH4S/gOm9WwHjgM
         hC5HECFC/WtGmyRn7NnZd13kRWkI8rTyLHu8Z9LysDl7RS1fTM880MMzA2IxTf2eiD2p
         xGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJpsI/WMMOpOfHY1MYHmD8ru/tq1kO6UyZ/ygQ5r3Lo=;
        b=He8mjD6E6N90Y6tU1pwC6nN7cz7iwGvILkTG/gYd1AfXSQALgBUemhOIKBHWeQ5T8T
         /GURVIInzSM09rIr5d3IMWICqGKq388AJ4mW13BQAZU2H6JSmoslnVPrQef3XfE03t0d
         VI/zgULwUsrPWV+iDN8HZDiIN136R+kaeuCjrDqwK9UBT8J43L22ApNujq2cyPODpklX
         c33BirzOBulAG3zIhuZvqokbUPYYO7LfWPRJrrfhsRrdPnyHFn5QBhgxh1gG6DAl0tWs
         K/AcxQuMAT0DEa2AfjyAtDSJ2XkBEMB+6Yl7vURR6usTGJ22UyZFL/i9cufOc2Igqgjy
         V8tw==
X-Gm-Message-State: APzg51Bwk4sWO0MHlWA814fZS02lvha7T+JFi3b0TBKm0NZ24x/w6e6Q
        80whQ3W7/SftiYE/YOEx812x3NGht6g=
X-Google-Smtp-Source: ANB0VdaTTFhz5QgXiGA/RLhbQsVvornbHVVMtwytwQKtBNoS9Qtb8Y5nXjT1alHbPFV07KPSHOTpNg==
X-Received: by 2002:a17:902:d213:: with SMTP id t19-v6mr539404ply.63.1536199863459;
        Wed, 05 Sep 2018 19:11:03 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id z17-v6sm5072151pfl.146.2018.09.05.19.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 19:11:02 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id D95A4200700; Thu,  6 Sep 2018 11:11:00 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        airlied@linux.ie, andrey.grodzovsky@amd.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix wornings while make xmldocs
Date:   Thu,  6 Sep 2018 11:10:57 +0900
Message-Id: <20180906021057.22756-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes following wornings.

./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3011:
warning: Excess function parameter 'dev' description
in 'amdgpu_vm_get_task_info'

./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3012:
warning: Function parameter or member 'adev' not
described in 'amdgpu_vm_get_task_info'

./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3012:
warning: Excess function parameter 'dev' description
in 'amdgpu_vm_get_task_info'

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b17771dd5ce7..861718e2be7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3002,7 +3002,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 /**
  * amdgpu_vm_get_task_info - Extracts task info for a PASID.
  *
- * @dev: drm device pointer
+ * @adev: drm device pointer
  * @pasid: PASID identifier for VM
  * @task_info: task_info to fill.
  */
-- 
2.19.0.rc2

