Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FE220657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeA46feM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfAOOv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:51:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42294 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfAOOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:51:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so1330960pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 06:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FZJ/W6IU+NugTJlhoy6sFEcrGJ45mAFB8SnfVQu5JsA=;
        b=QeA46feMbsPssFCfDlMoK2l1aSTmugMu6TMFj7d2E/kcppFRMDLd5vRlu9qA9RU0JO
         kdv2dvlecJ3TSxIfq/6Hb6NMiIKDC3wGdg/Sx9NpRH/MYmn8yT6YzzWODcSOpL7BvBt+
         +r9BJaDFfYcA6N/ZkBKMYWvrtM7k4E799chy1zk742GvvShh3BR0fQGY97kMFUIom3UL
         MuirhE1bg7AL2YdoRQbnTy3A1Oo4+12LeCbWQZbLhmLOmAmGY5y7h4Z06h+Cv8ABlIeA
         KgcocCsLlW5lIikJ5Or/63sNdlMsPBicvVBRTIs3umgBDzvZ1qLXeXO3d2HHzLros47Z
         keZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FZJ/W6IU+NugTJlhoy6sFEcrGJ45mAFB8SnfVQu5JsA=;
        b=MjBC2Vb1wXPvyAnjjeJWlQ5k4P3ukV2DabQx2lDuLE78/suR4zesJnx3tMQOV5C4N6
         LguHrDYX6zFA8Ub0GsX2aGuAs+HB+Xvg0euTcpSFm3rX2sodEAicyexQJaReLZRGj6/Q
         e3wAHI45ypfkJkQOtnkur7h2lAP3Yw7dAjd+qNspBRrqiQqjpQ7qqUA5H/MGWs1b+L49
         KXkb5CqPiELUE8rXQjV3s1yawkxecKQTeNC6ggEJqQ0VS5tpFfvp5Pw0biFc1o8AGkjd
         qn9YerQEFFQnuBMG2RKfAnji58UAsJB5xgmfRlR759BBuZ9PKVw6iPSCh25LObS5PmHy
         B+Ig==
X-Gm-Message-State: AJcUukc+tfPqF/F713SDqRMidj5pmrjsjkXWu8FGulbFWnUPCmRv6mLH
        fnwFq/o3TCXy3IS8yLWN5as=
X-Google-Smtp-Source: ALg8bN7R/Pdkd1VhOsi0JqniZVzvr1mtc8+qozjVJ4rIOD48b8iYjHPjtwGHqftmShpvvtDGwIBzkA==
X-Received: by 2002:a62:5793:: with SMTP id i19mr4440505pfj.49.1547563888146;
        Tue, 15 Jan 2019 06:51:28 -0800 (PST)
Received: from localhost.localdomain.com ([203.109.101.34])
        by smtp.googlemail.com with ESMTPSA id h69sm3822157pge.4.2019.01.15.06.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:51:27 -0800 (PST)
From:   root <jkhasdev@gmail.com>
X-Google-Original-From: root <root@localhost.localdomain>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Jitendra Kumar Khasdev <jkhasdev@gmail.com>
Subject: [PATCH] staging: comedi: Removed not necessary braces for single block
Date:   Tue, 15 Jan 2019 20:21:08 +0530
Message-Id: <20190115145108.10249-1-root@localhost.localdomain>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to remove not necessary braces for single if block.

Signed-off-by: Jitendra Kumar Khasdev <jkhasdev@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 5d2fcbfe02af..0caae4a5c471 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1605,9 +1605,8 @@ static int do_insn_ioctl(struct comedi_device *dev,
 	unsigned int n_data = MIN_SAMPLES;
 	int ret = 0;

-	if (copy_from_user(&insn, arg, sizeof(insn))) {
+	if (copy_from_user(&insn, arg, sizeof(insn)))
 		return -EFAULT;
-	}

 	n_data = max(n_data, insn.n);

--
2.13.6

