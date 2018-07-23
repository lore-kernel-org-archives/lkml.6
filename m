Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB33ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE4820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS3f7a43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE4820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbeGWOV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34454 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388398AbeGWOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so9744211wme.1;
        Mon, 23 Jul 2018 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=irpdppR069ZKaBvVKjWmi1hRxV+li+fa3T9xts+4x88=;
        b=eS3f7a43/C+1hK+uiyMK3m7nXPOh0wuxMSwezwMgP8NI2hiHlvN4T0uOqlfg1nz+CY
         dnA1A6Med3YJL9LpYcsfkAh+2kOFq7pqtGoHd1Al7R6QVuyrUN9+qV9oZUPB7TF2dGTi
         iDrlmD3wDUNf2AuPaF66+VvgDxRTwcqCArwktHIzLFA43q2+vUN1/xrxpfgwjPDLwRQJ
         WfI5FdF/8ZkvyrwELAsjgjyxpqELRummVACVs7mubx+Vbju4lUKJIezOEYZqrUv8f2OP
         hFKqtz1rl+lPy6Sxwspjlkz6T/BuI0kiX1uHlITcoQpD0kV4pZVX9UK+Up8oNwxBMxAW
         NcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=irpdppR069ZKaBvVKjWmi1hRxV+li+fa3T9xts+4x88=;
        b=AqBjAxObiJI5RBTnaAskS7np4imTFw3Ta3wWz0v5xZj7qOPuYvewKgurTHHSwb0b+M
         ukBJ20oFXt1Rd57w2VAZ0r10mtW/oGwBtj2nZRDHyM1Khorcy8fKsSicZh3VNtpeWWnX
         8gGM2yGYGo1A8VDmQrZDBfXDVExjTLe6pG7JYXg7nk8uXfjDNMUc7LCwPqvV2CBcXTGT
         kThlqjzp4K6RUlssRjWaHw8h5DqK6Eyxbx9/GQzPSVccJ0+cKROffm9U+Xedc4+ZLFtK
         6KYnWduelfBUCXwYnbFM5DlYD7cRJ8e6T8kLbNuhwVvKtgg0AI6TencgRnpsMO2Uhmu+
         IoMg==
X-Gm-Message-State: AOUpUlHhWA52dokezzQHXEE8v+CYjz/irdiZ5/1J4GcN1pl1c8wCGfa2
        pKz+vlpRokclu3QDIr5h3MU=
X-Google-Smtp-Source: AAOMgpdu3fQfdjclTtmDxJeAHiNG4mNF7hUmpbm6Oz8V61Gy5uMN9DEGXwMtHrldUPOIkEe3QUxJ8Q==
X-Received: by 2002:a1c:ec86:: with SMTP id h6-v6mr7619940wmi.53.1532352043129;
        Mon, 23 Jul 2018 06:20:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:42 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Martin Kepplinger <martink@posteo.de>,
        Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] touchscreen: tsc200x: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:26 +0530
Message-Id: <20180723131954.30739-10-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(selftest, S_IRUGO, tsc200x_selftest_show, NULL);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/tsc200x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index e0fde590df8e..daefeca101ff 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -336,7 +336,7 @@ static ssize_t tsc200x_selftest_show(struct device *dev,
 	return sprintf(buf, "%d\n", success);
 }
 
-static DEVICE_ATTR(selftest, S_IRUGO, tsc200x_selftest_show, NULL);
+static DEVICE_ATTR(selftest, 0444, tsc200x_selftest_show, NULL);
 
 static struct attribute *tsc200x_attrs[] = {
 	&dev_attr_selftest.attr,
-- 
2.17.1

