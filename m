Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D90C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E95B208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsiDgW5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E95B208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755119AbeFRHcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:32:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43275 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754911AbeFRHb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:31:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so7716736pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+8y/bt7qtw8/FFLYxCkuKRPHRJPqbxidtmj+qQjKc2M=;
        b=CsiDgW5vFozI3Oi7UV5F9Oypp2NUAqF+ScWkQ/++9dpoltR76ijABONDRtzLSSCx3H
         eg8Upnd3L/fctzk9VIP6YvRU7T2rbEaY0+WLqUQodfXZbDjEF6RgJ6Yv38iXYFYwgj/j
         pWzI+hcYm4gb+AHlfKieY6nSAbpN0duu0vzYgdHuPqqUfBcgyBPHb3Xh6zq7DvYa8tAd
         oxOlzdYdjRbqALTH7WCCVZEeQ1eDE9ZKGHydHKMBulfW3t5BYJfXMqUTWFo4kb18WP3H
         7XEE/EHWu6iPkVyzacVzN0uv0+zqO3Nx/vP8CCo+Faquh040k3400QrUujG0l4zRsyIe
         QPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+8y/bt7qtw8/FFLYxCkuKRPHRJPqbxidtmj+qQjKc2M=;
        b=Prp5BwNF2JgRNlAT1FRX7jnp9s0if69dQWRgWN7z1BEvP1cqd7prRCnXcoPC7FQLsr
         DmyJVdWoa7Zu0y+OmLJ1lKgQ9Vr2S9G8QWNlwEB/y1ds6GoTFO1CCTyNLUdsXiil5fh0
         +Ce25z4HePwtnaJ1Nh5N8tMhV70Ad/MdXOha6bTDeIYEQ6VABHYcDqWHvHCaSP6gVI9H
         kMvOpI//m8lWnCSmoq/j0CY6TG1XyGtcRQcvZfJaZbS3coVaUQ59oG4BfPoiawjvg00K
         loFVeivtQ59HAhSfFRitDtmXHOTYAt9TqGVquB5zff3sWPhT5RM961Uw0MdOOdWfly8z
         Gmmw==
X-Gm-Message-State: APt69E3r1Rtd4nSaMJHSp7vcWfMZlU2aQdv7upX4TrR1Z3UBeXQzytBI
        BGkzDRmpiuGQn6SoLHTrOxI=
X-Google-Smtp-Source: ADUXVKIHQUF6TmG4/LapaAhEpjgQEYYxlpw25eBZCxdHOm2dQrESsm5ZBPEUp6snsPmba/CCrDfYSg==
X-Received: by 2002:aa7:810c:: with SMTP id b12-v6mr12147735pfi.79.1529307118266;
        Mon, 18 Jun 2018 00:31:58 -0700 (PDT)
Received: from rajan.sibshivalik.com ([219.65.63.222])
        by smtp.googlemail.com with ESMTPSA id a8-v6sm25694766pfe.72.2018.06.18.00.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 00:31:57 -0700 (PDT)
From:   rajan.vaja@gmail.com
X-Google-Original-From: rajan.vaja@softnautics.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, Rex.Zhu@amd.com, tom.stdenis@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@gmail.com>
Subject: [PATCH] drm/amd/pp: Fix uninitialized variable
Date:   Mon, 18 Jun 2018 13:01:02 +0530
Message-Id: <1529307062-21787-1-git-send-email-rajan.vaja@softnautics.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@gmail.com>

Initialize variable to 0 before performing logical OR operation.

Signed-off-by: Rajan Vaja <rajan.vaja@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
index a9efd855..bde01d4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
@@ -1090,7 +1090,7 @@ static int vega10_disable_se_edc_config(struct pp_hwmgr *hwmgr)
 static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	int result;
+	int result = 0;
 	uint32_t num_se = 0;
 	uint32_t count, data;
 
-- 
2.7.4

