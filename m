Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E8D6CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C981208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrzthGUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C981208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755350AbeFNNhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:37:25 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35447 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755214AbeFNNhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:37:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so3580152plt.2;
        Thu, 14 Jun 2018 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rkptTXaXwxNifXX6oxlPFocW17y+sm5YszZBhYdOqN4=;
        b=DrzthGUdP+4k2Oy0FA0BK3t4BfViwX+f1DBK1oMVfmmViPuEh7whRwxkLStnXWxZ2r
         iSDetForOrWeC18XTBO0AEk3OlKor7/HykcOLkRNxxu/Nx3vobTUKvoh5+MJnL7agfsr
         VGgoXerzwQVC8FHRxeNFfZr1+J0EB9JgcaKWoY6GTXqWkTmtAOIc2t+Lr1aot9HfWcCm
         0eA4FyORYJhHJ8p9bjPFtQW+P0SYQBRLKrB7KZ03BDfZ2zenywsZLEgzWPUQDcdaCqHv
         JCuRG2hULjbS/5JyOL539mP5hKrr1nsQp4vfIjXMVv/80dDF1Ofpei0fd0GKI3Ejl0on
         yUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rkptTXaXwxNifXX6oxlPFocW17y+sm5YszZBhYdOqN4=;
        b=rocJe5vy4gLaHp84kgRcxQOZNJG+Pcvpde20QyjLS9bD0EyFHVfcpJ8bEjHOomWQ1/
         Ccw7DvTl8RnKpm5lvGfb6dpnkWFAz8zeURAPxgLUr1xy+XhsRYncs0VaY+zto+llp9m2
         288djCWzrnuxlJ5QhZi69Fz8+zOrU2t4kJ13nohSIXhcsuOCneAYdbJ32QCa7fgpjW1Z
         h4e79IbJlzLNf4azuWgaGMhxnxeDQk6tPSsesVYX3D63spuU9tghXZciXxVQwda5qzoV
         rCH356BX3kKUNFB+YEZD/PNw8ynjAFRJvXfGRygL8loo6cQSxMVWFNKrV/BMy/LrZY8/
         EN7A==
X-Gm-Message-State: APt69E2NKuDLb4x3QZxTOSgmVNNy8BuweFtw9+B+a16ew/NHQxI2aBhi
        rrYSY+qCzoZ0DRBr2CufDMo=
X-Google-Smtp-Source: ADUXVKLQEcwEJpPIWw/W+DMlNlProqaIg82yt3VAhR6rge+LSUc+jGAJUQXrs3JqfM9H60iwkMhzJg==
X-Received: by 2002:a17:902:59ce:: with SMTP id d14-v6mr3104276plj.253.1528983442331;
        Thu, 14 Jun 2018 06:37:22 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id u14-v6sm9431859pfd.103.2018.06.14.06.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 06:37:21 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: hid-ntrig: add error handling for sysfs_create_group
Date:   Thu, 14 Jun 2018 21:37:17 +0800
Message-Id: <1528983437-52903-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528707296-35785-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528707296-35785-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sysfs_create_group fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling sysfs_create_group.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Remove goto statement.
---
 drivers/hid/hid-ntrig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 43b1c72..9bc6f48 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -955,6 +955,8 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = sysfs_create_group(&hdev->dev.kobj,
 			&ntrig_attribute_group);
+	if (ret)
+		hid_err(hdev, "cannot create sysfs group\n");
 
 	return 0;
 err_free:
-- 
2.7.4

