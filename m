Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69BAC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967A621777
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwUI/AWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967A621777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeHDC3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:29:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34188 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbeHDC3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:29:14 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so3242343plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HT0qfXR1a7UHzfd+dXBGc+vhC9vE9qM53mDMm7UJpLs=;
        b=UwUI/AWvga74ih5dq+aqQurwV63MNQkm1B59NWnIfrartLmwju0Oq55jOyY+hKnjZF
         plg1+HW2vaASf3sLWKdC5zcPMktu+AuWz8yR5/nSZsfsIndpoMhFklGyKdtDQrtEqZIZ
         qKKEnjIk50+Twg4BluU2XikDdPv38eYJeWMKaKOJRWKUtWuyZaB8rzSEhrOpzBE5XP98
         7AVKOJqI/swDGR9x46cUE0qy5nWVeAR5P3zRD4sEe9O+t8fEY1Qyo5/UAXMCwH1ZEcvo
         tiWcwhyw3+VUwQhUFadWS2D3q+C2KEeB3loglCvMzlqCAncaJbK2T2TYBJzq9FE4rsjm
         6WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HT0qfXR1a7UHzfd+dXBGc+vhC9vE9qM53mDMm7UJpLs=;
        b=MW5WdIrGG5W2yTQBYJUV2TLIHpHuqdpZXwSn3MgopcizUW8pENEiFqoRW23YpqJnN4
         uI/DIfv54kUfAi9QuyqppHXyaYm5DVPIK7Lf4VETe1iLDc3h70g823HlRVcgv0TMxAxp
         rK95XdiD3o+g1bO04bhFdjs/cTelgBdHx37PUjMNmOunU9I0mZEJEx4L2FF0DGt93Gyv
         stU7isZYAb018VUeAk+U776HK4d0D7XLOXdHpdalOkdFzq/qQpguxLaDN8JRkxa7m5/2
         w3o0NObvkJO1NuHKCcVkuFjp42adoYLRxhmF/W7l2cj9iS6xp0bnMjfkvO8tDZ636oIw
         nXjg==
X-Gm-Message-State: AOUpUlHSwnQ0wrQko4qIWWJLhmJuPtpG1NKehCFD8f7Bap9lOAF16s7K
        ua6S3SIOhitNxNMBVMs67L4=
X-Google-Smtp-Source: AAOMgpfOihrFVrvRXD0SKStdWMHaLY5ybHiS8BG+RZlH9PN7t3NbNWy249Fm62CEZIK3kN6vT3v1vA==
X-Received: by 2002:a17:902:4201:: with SMTP id g1-v6mr5456228pld.203.1533342640064;
        Fri, 03 Aug 2018 17:30:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id 16-v6sm10067970pfo.164.2018.08.03.17.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:30:39 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: nouveau: nvkm: nv50: Replace mdelay() with msleep() in nv50_sensor_setup()
Date:   Sat,  4 Aug 2018 08:30:30 +0800
Message-Id: <20180804003030.18669-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nv50_sensor_setup() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
index 9b57b433d4cf..ce8f98f3ee48 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c
@@ -122,7 +122,7 @@ nv50_sensor_setup(struct nvkm_therm *therm)
 {
 	struct nvkm_device *device = therm->subdev.device;
 	nvkm_mask(device, 0x20010, 0x40000000, 0x0);
-	mdelay(20); /* wait for the temperature to stabilize */
+	msleep(20); /* wait for the temperature to stabilize */
 }
 
 static int
-- 
2.17.0

