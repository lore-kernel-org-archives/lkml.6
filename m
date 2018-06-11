Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tVIYB604HltENgAAmS7hNA
	; Mon, 11 Jun 2018 08:55:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C28466074D; Mon, 11 Jun 2018 08:55:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp/vK3cz"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5821860385;
	Mon, 11 Jun 2018 08:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5821860385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeFKIzF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:55:05 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36788 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932272AbeFKIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:55:04 -0400
Received: by mail-pg0-f65.google.com with SMTP id m5-v6so9425484pgd.3;
        Mon, 11 Jun 2018 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yi43wpY12A4cZ2jAu5/IWBRVrT/E1PUWJ027uoVi3Ds=;
        b=Bp/vK3czP/0M6biK0Hdi7oKlpG9aInQEq5eFa9HHb/rdqex0htCSTuhSsCL3CG+Bja
         lc2zbv8OvZzk6bK7KMnYPw/FkWXYMlEY8YnIxUYqT4E/l8LhV48FtCE8xregHq7mNOJs
         zZjRZGmEibGJ/lecYd1oryyECBuX5Cu7nv0LpxrBV1npS1okFvWUN+5RKhERZP2KCnN2
         zq/SVDtxWWpdt9hAhmVu7JK1FwrGSUIDldRt44ifWx8qZKORINrePPyYG9ukPThFcjAt
         kkcvpPFYBH77ltluHSitJ21NYUfUDE3bnO3fdpaHRUF+p6LMj9c1SQZxgEUoMtWjBZoO
         9Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yi43wpY12A4cZ2jAu5/IWBRVrT/E1PUWJ027uoVi3Ds=;
        b=cL+hl3ZWQZSPtyZcSEo68n0qSDYt/Qafm8pSNwX7hxE+QVBTReYX3KYUrAPONGMcRP
         YDZ4BoFKz8brYMOCUxKHmKoo5XYHpvE/FT+/igSMbZdzdXKszr41UdLX/+dvkXkfPWUl
         cnF7/BpoWIHPbKH4UBT/eX0B3+DAt7E/zVvfH+/GLAFoL52D47+K3YGWV75TP0kb/I2S
         c9ENUrWTEFTW2jNXl5zrj9nQCJjWCQEpecrmQtGo3NmlaNn11sD4B/cIpvAyTgZtRr+S
         rO4++HijiXyrVofgZERdT/GFcYIyQZkj+IbDOesv/pzJ8CX3jZhzVYZbKUsGLgz4MAq5
         Uiaw==
X-Gm-Message-State: APt69E1V4ALyux/OhCYjRFzv/NhWlqxcnfOC9p2kk7qKz5KnyFSMrspK
        LupY/9pXy5+3RV6huqEn+3E=
X-Google-Smtp-Source: ADUXVKJUYExWWreovMojMFwBMXap2ujjs4JJNQvPa/kE9fhq7lw9Hg4POwuXvKzu76SFrfZrQWWMCw==
X-Received: by 2002:a63:8b44:: with SMTP id j65-v6mr14401533pge.203.1528707303616;
        Mon, 11 Jun 2018 01:55:03 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id w18-v6sm14570044pgq.1.2018.06.11.01.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:55:03 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-ntrig: add error handling for sysfs_create_group
Date: Mon, 11 Jun 2018 16:54:56 +0800
Message-Id: <1528707296-35785-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sysfs_create_group fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling sysfs_create_group.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/hid/hid-ntrig.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 43b1c72..1e70dae 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -955,6 +955,10 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = sysfs_create_group(&hdev->dev.kobj,
 			&ntrig_attribute_group);
+	if (ret) {
+		hid_err(hdev, "cannot create sysfs group\n");
+		goto err_free;
+	}
 
 	return 0;
 err_free:
-- 
2.7.4
