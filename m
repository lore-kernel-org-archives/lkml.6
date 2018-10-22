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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB62C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D972064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwG8sOGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D972064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeJVU1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:27:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35356 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:27:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so19815473pff.2;
        Mon, 22 Oct 2018 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7MusjG4H6b2xIMWg4wOmTmbsUrzk81LRSqovr0t9o4=;
        b=nwG8sOGRs95KXeDzgoBubkFS/kznqhQYkDgce0EdTSzzFh1jlUN/gaZIWMljC+WDSq
         dilvCcO3dPthcLY41ODGFrASqhALYLbddMVqm7tSMwPCv0ZFia6ujc8yZfpuwY4wqblI
         uzEd0bSuF4PNX2UYeH9nyD8ptwuX+9DCk60R2XZReeGa6eUMZaIfCuDg0wUq+p6qblSf
         k31+e0gnJbKHl4zCnzdDISHt1HWOK2Kme6ltHyLlWVLpIL0TIQA+3UCB+PhfaNM9uCuE
         OdP4mSQ2YVKYnDEu6ycDYb1XSo1q1F/nfkNjAHRkV13496qOOE1Z+aiqLdYyeD1bsZur
         T6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7MusjG4H6b2xIMWg4wOmTmbsUrzk81LRSqovr0t9o4=;
        b=saPGO9BXpi7jREXGvepfpvjy+v0DqJHCIfsGr04XdjNoJbiC95s+3JIgEPLIAQhF47
         vkbx9Hmj60WGbY9ysaGJhwiXAsiqnTlD5Y6kmRc3hkxKvrpUV1er/eWQpUfsR4b+18TC
         sokQMTqjxZVzi14LNSLRexrNYaMMO4HMHfL1cAroa/IC+jnZF2SB7MQPhviKvzDGqLTF
         iD7FeVneaae67l6afHtOgxqKPVX5/uBgasmuZKd9kE76ueIPoFWL9v2gbWEe10Q4B7ZE
         0KeqR+bI2QXLMs2fFBHqFjK+/P68Bs9BB8pt7ymBhrz69mAo6tLTsEHqJpoJDFfFl7Ev
         Y3qg==
X-Gm-Message-State: ABuFfojCOMxiKdRTDIp8gqA8FNiGlMaacV/XZvK6y3+cv3PIjyx6mu4N
        8X5FdQcmj6PuMV4oESGFfgw=
X-Google-Smtp-Source: ACcGV622Ml/v3cCxnxQiHRMQ7s/LgfTZ6VVnY2atBpIAEvf6/EwKttGzVFH7j9E1aElBSd8/9CkJMw==
X-Received: by 2002:a62:5a47:: with SMTP id o68-v6mr16308784pfb.31.1540210145814;
        Mon, 22 Oct 2018 05:09:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:1904:c698:f9ce:cdd:454c])
        by smtp.gmail.com with ESMTPSA id m74-v6sm64880572pfi.102.2018.10.22.05.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:09:05 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux@rasmusvillemoes.dk, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 2/6] gpio: 104-idi-48e: Mask the read inputs for get_multiple
Date:   Mon, 22 Oct 2018 21:09:16 +0900
Message-Id: <7f7c7bb8dc10bb315ca03860cc24230bfc5370d8.1540209293.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-idi-48.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 2c9738adb3a6..88dc6f2449f6 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -128,7 +128,7 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 		port_state = inb(idi48gpio->base + ports[i]);
 
 		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word_index] |= (port_state << word_offset) & word_mask;
 	}
 
 	return 0;
-- 
2.19.1

