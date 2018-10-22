Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E1C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534AF2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="st5nzmzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534AF2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeJVU1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:27:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34443 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:27:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id f10-v6so1198347plr.1;
        Mon, 22 Oct 2018 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNPWzi16BaQIPNRhNlYjjFyzyS4QT2S9QCHuJW2z5/s=;
        b=st5nzmzvAfSCHRG7hJ8jc1EymC/nTBauIlsmhUzE1sDbW0V5D/rJ6Ne/lsYT/BBTQn
         BOQKdN+XkH/hxtJbH/14Zw+vhsCGHaIxdQkreB1SSFbWt4OCRSdecM94+iYDbk2ena93
         LBDLMske88TJ9QxO89R6uOxQN3Phk47L6pCUHHXux8j1uO5wiKtiidCWDGoeI+5br5ef
         Hpw9UfgLzcFyGgDydavM3yQHiS3EgF0azrqJCSueHwU/JA9e+b5Fe6KciELzABUnYsCu
         NExcwpUVSTtkRtYap+u0yfy2twHRbvJbeOJTAMXYtJjuIPJT9HGub6+eBiVNnBbullHf
         +2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNPWzi16BaQIPNRhNlYjjFyzyS4QT2S9QCHuJW2z5/s=;
        b=KZHRANxoEk2H8w8JaDamolJ59+1mGpwDFRdNrY+kc3rolB1DB3unaKoaNJ8ar6aeAD
         CD1zU1mHZ+6bss4MzW5rFfL+yLSFmqupz433gkJ3KI2wB+WjcpOpt7QCpsc81mgBbLBK
         hHyAIn0khnBfWClrKovOJAcAsVHFyfUtdxBmJjmk0vm7kb9mGz8hcdhrsReeRtS8YM1c
         J1chCUPyiRS684DNekoLbaXD83tUkaGjdZTdYqRhbhm7tjJMokyQgZbfE8gMlJQhCq9i
         VO314m2NAIIWj4vRQB7t6G4FwWFz90CV8CHI+xwBHK7i+he2GdliFHD3Ela7Tg7Y4Pcv
         PdzA==
X-Gm-Message-State: AGRZ1gLvpoH4hNojcGvld71X1ge4D0gSNmxaMb7iGmtsvRCQw1dPHrAy
        FOdFvUu/HOdB06WIMrvTiqGO8O7x
X-Google-Smtp-Source: AJdET5fkVOPdk+1afuX1HxhwZ7kJh18sNmBVzNV0G3CgNX4y035eFx796p+fgbHpPEHZzSNuip5h2Q==
X-Received: by 2002:a17:902:748a:: with SMTP id h10-v6mr6888565pll.187.1540210131114;
        Mon, 22 Oct 2018 05:08:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:1904:c698:f9ce:cdd:454c])
        by smtp.gmail.com with ESMTPSA id k70-v6sm39081926pfc.76.2018.10.22.05.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:08:50 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux@rasmusvillemoes.dk, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 1/6] gpio: 104-dio-48e: Mask read inputs for get_multiple
Date:   Mon, 22 Oct 2018 21:08:59 +0900
Message-Id: <e43738f7158a62d0000df6ecdd9442c59bbeb9c3.1540209293.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1540209293.git.vilhelm.gray@gmail.com>
References: <cover.1540209293.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch masks the read inputs with the word mask in order to ensure
only requested input states are returned in the bits array.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-dio-48e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 9c4e07fcb74b..92c8f944bf64 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -222,7 +222,7 @@ static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 		port_state = inb(dio48egpio->base + ports[i]);
 
 		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word_index] |= (port_state << word_offset) & word_mask;
 	}
 
 	return 0;
-- 
2.19.1

