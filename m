Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF864C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A63922460
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9zPKCm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A63922460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933105AbeGGCls (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:41:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40318 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbeGGClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:41:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so3623258plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 19:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cXKns2az6hZq3c4DlOCxB0JgCT1DFMZOBXKk0lN76GE=;
        b=e9zPKCm7x5ybouBY4OcbRL8KDCXWsSL5KIl2ElV7Mrx345ciJ/aSVTIv4gy7+lThR4
         Is80Fo2juwnoyrIm/y1rJyJd6/5x49A0lllzjQj9pZWzMpKwSI0hef3uv0pdoF93X1/m
         a2yTHDPe8L06g5fbGelrka0FcmO6OHl6dT2VPZUmHj/66/gMKaoVFIb2VPa2QI29Lmxt
         aCCPVY8CYS3q+W4Roc52QoO3cA04udai72ug3cSQU8unrW6U2uraoW5Fqv3A5kX6rG/T
         dgOTk4L42+qghKaNCG1hwUnKnas7ynLjQv+31EBF+4AzMj2930qorx/RiP2QszSDU7cI
         Eq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cXKns2az6hZq3c4DlOCxB0JgCT1DFMZOBXKk0lN76GE=;
        b=GDWLm8jLVFxVpXnLGIauDKUU5KhagXGIrQsAKok2aldeAXHiqVgrPMv3+7IAQRbOGK
         bmjpQS+xXBwbsW6BGOaMZrSohbC/OYvZO9m4iTU5vN+a9MmJ1r+YKp6eLtyPHFCTq2RM
         3VCa4Tk29ySrIbtE+E1oOcCbXCT7z0kaNR4BYdlmKk5HvMBqar5HZCeohBdq8hhXG8Ib
         L4trYUzR1OYCMuUkqjzSt/wGewaG7h7GW3L2HTR3+hYN8u4NUzcgNLYpbooA/e9y7Qbo
         YYqXwQt6ZcXpJNS9K/iYoa5ZrDvDiahJM5yNT1uV96DYg/8+Ue/uYyiIsO7MQRKkIOU6
         An4A==
X-Gm-Message-State: APt69E2GHDZDyqeh90OxosxTmK+KebMlmSdca+zUBNOh2w3CFCab5IiN
        kNwx9LvRTRpr1sj0hyew+IE4wFvW
X-Google-Smtp-Source: AAOMgpfQ5IcoQj/BMqQJpnYbFjjH6zOdfbaFmG3wibymlVuDUvudd5vNuHl3DJOw57pqlBX4Ksuw2A==
X-Received: by 2002:a17:902:4101:: with SMTP id e1-v6mr12413154pld.205.1530931298768;
        Fri, 06 Jul 2018 19:41:38 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i17-v6sm18897276pfj.95.2018.07.06.19.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 19:41:37 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 4/6] mfd: rave-sp: Add legacy EEPROM access command translation
Date:   Fri,  6 Jul 2018 19:41:06 -0700
Message-Id: <20180707024108.32373-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707024108.32373-1-andrew.smirnov@gmail.com>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to make rave-sp-eeprom driver work on "legacy"
firmware.

Cc: linux-kernel@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mfd/rave-sp.c       | 2 ++
 include/linux/mfd/rave-sp.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index aa75d5841ca0..a999fa721b03 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -635,6 +635,8 @@ static int rave_sp_default_cmd_translate(enum rave_sp_command command)
 		return 0x1E;
 	case RAVE_SP_CMD_RESET_REASON:
 		return 0x1F;
+	case RAVE_SP_CMD_RMB_EEPROM:
+		return 0x20;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/mfd/rave-sp.h b/include/linux/mfd/rave-sp.h
index fe0ce7bc59cf..11eef77ef976 100644
--- a/include/linux/mfd/rave-sp.h
+++ b/include/linux/mfd/rave-sp.h
@@ -21,6 +21,7 @@ enum rave_sp_command {
 	RAVE_SP_CMD_STATUS			= 0xA0,
 	RAVE_SP_CMD_SW_WDT			= 0xA1,
 	RAVE_SP_CMD_PET_WDT			= 0xA2,
+	RAVE_SP_CMD_RMB_EEPROM			= 0xA4,
 	RAVE_SP_CMD_SET_BACKLIGHT		= 0xA6,
 	RAVE_SP_CMD_RESET			= 0xA7,
 	RAVE_SP_CMD_RESET_REASON		= 0xA8,
-- 
2.17.1

