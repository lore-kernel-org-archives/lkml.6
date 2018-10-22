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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E759C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267882064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNwQnGFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267882064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeJVU22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:28:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35409 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVU21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:28:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so7755496pgu.2;
        Mon, 22 Oct 2018 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eI7jyCscghMFVwi5rRdpET+OM09C3fZ24B1HB+ARyNE=;
        b=UNwQnGFsQEA6hnmfX2Z61OVHTk6czkWW3V3Mx4NoUJ0SgjgaKClFBn6sIjZG6+IA+b
         /M9vjeh/wxk8upLA7M9Vwnp2aMkpbhvI65LlK8/oTjAxsAswRO7JIadQZR296pNI03Zo
         FP6NSRDJs3U8y5NxQpgLzTJ1m74nAONmVzSayjvQD+Ea53gRBB6vzVOnxgcdQMtJBNO0
         8OXLiIbNnBK4AWf2XrDarthvX9Gh50+xfZP7m5PJ+w7j5dYfrpXr5r5j5iLTO4R/KlnQ
         C3nFYBmsg431DSH13RYJE4Aquf68ri3O3vGgWoYqyMkuXXJ6/60S0HUEsryJ+TtUmdho
         eiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eI7jyCscghMFVwi5rRdpET+OM09C3fZ24B1HB+ARyNE=;
        b=NfEbOtb21jilajOjrGeo+QDy4MiTkrGRerYdjiG6OOecedJErWjrbtQEeef9Gs9+KQ
         px4sXlNla8nC44zOe0tHa4l8FdvlGKKD8rj79rWQQIB5QH2YSO3BJMhyXF+ecc9s/akw
         DaWKbHRBesbklPtYG9/Vd3iPaESeAU09Fh/yw6xLY3bKZoiYXNXrmJHFYZW/4P5/c0z9
         84jLFjuLKOBMmoeQw0MVCPgPCmpsji6xhIEx4rVOC7zR/DjtotEp9Mh6yebf0r7zIVtI
         hilli3fYPZsiYtf/BmNX176MKrD9doAiaZAqtbVw2E2JdKcVige5/h0fpgq6wFjwbHVO
         llXA==
X-Gm-Message-State: ABuFfojhxNXy6xTa3eUpZAfvZk8e6+HIArTO1fNLhgmRYg6jAvJhD4Xc
        wgMR90BSLiTFwUGk+qctV9Q=
X-Google-Smtp-Source: ACcGV63TRS1JIAVRrF6VlOI3DlpNfBV2sJ5B5/+S7Uo0KZ6PXsM0Qj+B3ZjKYvt23QC0Zov81ZLQFA==
X-Received: by 2002:a63:4952:: with SMTP id y18-v6mr42594111pgk.32.1540210209171;
        Mon, 22 Oct 2018 05:10:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:1904:c698:f9ce:cdd:454c])
        by smtp.gmail.com with ESMTPSA id b14-v6sm38033147pgn.49.2018.10.22.05.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:10:08 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux@rasmusvillemoes.dk, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 6/6] gpio: pcie-idio-24: Mask read inputs for get_multiple
Date:   Mon, 22 Oct 2018 21:10:20 +0900
Message-Id: <820f8297d25932ba9dad2dfb50ceee3f803f83cc.1540209293.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pcie-idio-24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index f953541e7890..52f1647a46fd 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -243,7 +243,7 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
 
 		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word_index] |= (port_state << word_offset) & word_mask;
 	}
 
 	return 0;
-- 
2.19.1

