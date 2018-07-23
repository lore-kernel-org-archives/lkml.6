Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718F3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA8620854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZqtpQyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA8620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbeGWOV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35009 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388053AbeGWOV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so702653wrt.2;
        Mon, 23 Jul 2018 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PXXkeOHx2j7gEKcIiCiqq0iwGaZjTCw597NbTI8OYKw=;
        b=KZqtpQyFmtxoZog5Q9r4DNY1x36ls5djqoV4Rt2GWTkT3ssG0D5LGIczwkbh+Gk/l9
         Z+G9loS3xl79w783tBJ2AjN94MbEjodrk+8pRgXGpeLsk/Sl155vfxb5feALWFzZUEen
         4mhoRLlHMly95RCliPCuvKhlMIfhqXUrZsYw/6Oax9OOb2r8+UL1yvbnRnViin2psksN
         pNg/k5hpn6WsHcsHGgqFF6svM4z7bY9k7DuA7AQl5cHPcwZNkp6hZL2m3k4Z18a8Zpoi
         aflzkiJetGwCML0bF/WaICZ6bY3U3kA5Lhaf1PEaRilIqPTyOZBAch8Oo3OPkW/SCP9I
         fsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PXXkeOHx2j7gEKcIiCiqq0iwGaZjTCw597NbTI8OYKw=;
        b=Rmn7IuqNb7nRKGl7Q/wGUyHK2Bb3BtjwtVIHNiBvDj7yoFyrm1V2s35h21QeWxN1lQ
         ULD76Y4jh7TVbhs7qbYLa2xZfs9gGp6uUTrO8f42YpRq4T3QemuqRMzQVrrqWUEq2Jn4
         Sh+l8SoXdNlmMgR3lqrYdGLdL5I+f4BH2KiXT8ONUZzeJCMbazJmqo0LS4MBc5+YcC2r
         D2YAjSeMPBLixTjp2TYZlxPa1CS8srzhMB0xPxT/VcdAH5NxAbaI+vQXl2ubKJpVzCXL
         2ElEbPYcPH45UWkYZfT9DFdgDtrh56FZ3ASwZihIe579b7FfsEKBpW6y6tpuYxczTvdl
         TIwA==
X-Gm-Message-State: AOUpUlF8GYbHYLh30Z9n01UA5Ifo+mjT319LpxpbCmIMLHA8XiYkF2zr
        6a0oEP9iUFlrH6qEoR+J9fA=
X-Google-Smtp-Source: AAOMgpewtDFAQyXGAbnusgP2c86ijuWilYprggzGFaH4yZr5wcsrBztnf0bhJreH1HWGQfyBRAcpjw==
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr8523872wrh.148.1532352011804;
        Mon, 23 Jul 2018 06:20:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:11 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] touchscreen: elants: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:20 +0530
Message-Id: <20180723131954.30739-4-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+		.dattr = __ATTR(_field, S_IRUGO,			\

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/elants_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index d21ca39b0fdb..9717b7c3bb6f 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1000,8 +1000,8 @@ static ssize_t show_iap_mode(struct device *dev,
 }
 
 static DEVICE_ATTR_WO(calibrate);
-static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
-static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw);
+static DEVICE_ATTR(iap_mode, 0444, show_iap_mode, NULL);
+static DEVICE_ATTR(update_fw, 0200, NULL, write_update_fw);
 
 struct elants_version_attribute {
 	struct device_attribute dattr;
@@ -1016,7 +1016,7 @@ struct elants_version_attribute {
 	 __ELANTS_FIELD_SIZE(_field))
 #define ELANTS_VERSION_ATTR(_field)					\
 	struct elants_version_attribute elants_ver_attr_##_field = {	\
-		.dattr = __ATTR(_field, S_IRUGO,			\
+		.dattr = __ATTR(_field, 0444,			\
 				elants_version_attribute_show, NULL),	\
 		.field_offset = offsetof(struct elants_data, _field),	\
 		.field_size = __ELANTS_VERIFY_SIZE(_field),		\
-- 
2.17.1

