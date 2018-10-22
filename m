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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA0C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2842064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCM74EZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2842064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeJVU1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:27:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46744 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVU1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:27:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id bb7-v6so1491477plb.13;
        Mon, 22 Oct 2018 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/BnlWHspQYteyA1pf5FqDoV4U0ZykYAxjKcocIiNSE=;
        b=FCM74EZpw+G+B+G/Fyy4jWp8fmUe/XvXnJVpJ3i+QDtZmf686caf0flQqCafVKWvlN
         xAj7H0GNYXwfGk07SHFbFsciHeeQsMAk+AnbTC5KExz6M82CKk3A8JNTBSgkHH+iq5lz
         IFZDdj9xnPzlbdTjny7sFpDd19Ph3O5GVEkZ/VkivF5Kf5mYB8WOVRogvBXp9rXImvqx
         DXW5sEuYqQ5J7n3XWabVz43rpxaG8AYm6TPVASrcKMn3O8Uu1gFmTxlu4ciCkbKlkUsw
         jADLyAO6lA0jsJj30E1qvjdFGm1NEojxIdIiGMRp91SJFjjstykKCdKdmspWF5gWmtSz
         DTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/BnlWHspQYteyA1pf5FqDoV4U0ZykYAxjKcocIiNSE=;
        b=udrFbwgCZ+ETdnC3IEJHckDjvzSrQw5pLyQP+hi7JZuRbWomtz8qslyUBzC9DiAYvU
         qZSvorIwZ7HvKIhSw5LS005YX7PJo9f9rBbykbiwCiI6g2SPK5ehGPv3uQpnW0WFbqSd
         QvcPPyzR0IwRbVs1s9pOqEpqIG6cIOZQ9GQpQfky8U7NrJtKyrRmLgcde7hUyd2H2VCD
         +eBIyp00g9pcVctGU5/vId21Zy1EbF/vHZQkzGFCRHJWU0lZFK5e0gjpQrwejs6/kYq0
         vJNDk6S3YQC6NBGNXTPWCMjWg/pZpLJd8hcg1a0CN17Dd8VZBQUR/2UBpG4pBaOKns2o
         Io4g==
X-Gm-Message-State: AGRZ1gJmCmHKb4jW3HbdMc8UeTdq1wcjPti1Us1++N0eiTIYVBNkb3yS
        8kGXTj/pcGEZMQOT2qbqeEg=
X-Google-Smtp-Source: AJdET5eWM0SvF5whqby7ZPZMlFpaX8pTYF+eGDRyfjhbjYH3TWq6KN0OQGAC0VS8HQuX5YSfuuwEwA==
X-Received: by 2002:a17:902:b283:: with SMTP id u3-v6mr652720plr.123.1540210161531;
        Mon, 22 Oct 2018 05:09:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:1904:c698:f9ce:cdd:454c])
        by smtp.gmail.com with ESMTPSA id v189-v6sm41584937pfb.54.2018.10.22.05.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:09:21 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux@rasmusvillemoes.dk, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 3/6] gpio: gpio-mm: Mask read inputs for get_multiple
Date:   Mon, 22 Oct 2018 21:09:31 +0900
Message-Id: <b4f8835ed44d25b8aca276d3ce6773143b53fe08.1540209293.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-gpio-mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index b56ff2efbf36..8c150fd68d9d 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -211,7 +211,7 @@ static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 		port_state = inb(gpiommgpio->base + ports[i]);
 
 		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word_index] |= (port_state << word_offset) & word_mask;
 	}
 
 	return 0;
-- 
2.19.1

