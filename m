Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B369AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D3B20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlfkvqey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D3B20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeK1O3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:29:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41004 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1O3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:29:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so8821441pgh.8;
        Tue, 27 Nov 2018 19:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPaAWKHAJcb2Of8zDyRNv0aeors3VMWXMgg4oGsTdaY=;
        b=DlfkvqeyEE0wc7bAEhtlBA+aSfhTMCK3JGA1cUIQN8mWZIMHkyl4l4ZXgHBEkpaDi1
         6WbOfTCwjZDTd+KteRlNAmHwFkJk5qPt6klQoOo9ZK09wiCcNpGcxFyW3Jf9ShEz+m2q
         056C1frc8j8jvyCt9/xl/9L5EBbl4ocRsm+DDwSnFMeWJVXlLh6r1j5D+aqiz84Ivcrb
         sJHf72rB9zJoe+rl6xx7mxNycmrMUqgbZqwAv2Tozp8bZwS/cWSEvpkHeLnuuva5PrBx
         gRNhkZuiekHd/pkpXqR/Czx8KqR2B7vkaw2PXm0xVT2/4t6NQxDzG3hVqzBsViCwuZVK
         Vf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPaAWKHAJcb2Of8zDyRNv0aeors3VMWXMgg4oGsTdaY=;
        b=dpoKr1HS5Qa1xaH5fDY4XAbqbTj4gsvtfCNgVNEcLktCqpQtJ8XyHRX4pwaxxcbeTR
         CUCEMnbwNovk0Jqy8HKrJ+1/9Dk1cSxNKItELJ76RZ48DjGDyBoEBJ4tv/D/j20PpXdL
         anB3zutCKYZ9LRq8Vh5LdTMzRoSK0W9/tHuogMKAAeLSaYTThCZoZmDjF4nvc+ly2yXk
         OnkA6+6DRsR5JT882922pIfROaV7K6ckHcIrfONi7NFHXpufw3Uigbl1P3s8BUFfDJdx
         DWhYDJhnfIL+Ku3/5OPOMPC5n2qsVxdZadV1TYOYDWm0OH2BwsCGiehTOGJjGJaJhJw2
         KmCQ==
X-Gm-Message-State: AGRZ1gJD5KpzTpJilDuRsT1+qnsYIimQ59EXmiit1lfSP4bMIRY2rWT9
        2vvDxAfZ6GU68sQCv7SruSkmxeFumTE=
X-Google-Smtp-Source: AJdET5dWTbKB/vxMx/ycHUi9I12YmTCjv7GYIOWgPO6vPBdpH2A9+2meSRjGWLa1PZSBkfJGwEJhdA==
X-Received: by 2002:a62:8c11:: with SMTP id m17mr35838657pfd.224.1543375741001;
        Tue, 27 Nov 2018 19:29:01 -0800 (PST)
Received: from jupiter.localdomain ([2604:4080:1012:8070:9a48:b5d:be16:1cdc])
        by smtp.gmail.com with ESMTPSA id h19sm6624685pfn.114.2018.11.27.19.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 19:29:00 -0800 (PST)
From:   Cameron Gutman <aicommander@gmail.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com
Cc:     shelby@jueden.org
Subject: [PATCH] Input: xpad - add support for Hyperkin Duke Xbox One gamepad
Date:   Tue, 27 Nov 2018 19:28:57 -0800
Message-Id: <20181128032857.26167-1-aicommander@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally submitted by Shelby Jueden (GitHub: AkBKukU) to paroj/xpad:
https://github.com/paroj/xpad/pull/97

Minor change to the location of the new entries done by me.

Cc: Shelby Jueden <shelby@jueden.org>
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index cfc8b94527b9..8d6ea091a01a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -330,6 +330,7 @@ static const struct xpad_device {
 	{ 0x24c6, 0x5b03, "Thrustmaster Ferrari 458 Racing Wheel", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5d04, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0xfafe, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
+	{ 0x2e24, 0x0652, "Hyperkin Duke X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
@@ -440,6 +441,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
 	XPAD_XBOX360_VENDOR(0x24c6),		/* PowerA Controllers */
 	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA Controllers */
+	XPAD_XBOXONE_VENDOR(0x2e24),		/* Hyperkin Duke X-Box One pad */
 	{ }
 };
 
-- 
2.19.1

