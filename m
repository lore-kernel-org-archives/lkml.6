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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F352BC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C9A2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpnqgo/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C9A2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeJVU2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:28:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44622 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVU2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:28:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so19807587pff.11;
        Mon, 22 Oct 2018 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNkLkzZthpVuejMWcaYNvPopA/s2Vk8gtDQxxhr97GI=;
        b=Cpnqgo/NCz2VZb9uaocLkw3+yQAOgRLKaaUnVWLle5K4pRQqqaPDJUaN4ZBc8I4QCJ
         TiFwe1vmbvLpTDDMowxY+koZa7xc891V2rY/pCXzAdEmVINPUUxp0mq1uAFHd3ySyOCC
         9bOer/7RmAOGE63/UG71XGoM4jzeVz8aR07zhky2D2gzJYWfLIX3lN0MmJpCrmuCYPQN
         IymbNnUj6Sz7c3zXxpX4WHn/f7ericl1T834ntCaf+NgCIopQewnfBtGuAatoc1SLGaW
         Zc+br9dqsm/ZyNaf+zei1DmAzRfqjnfj9PBJswEZiBCZBlchqzl0shiGwhYhwQ3CdaGB
         Ebxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNkLkzZthpVuejMWcaYNvPopA/s2Vk8gtDQxxhr97GI=;
        b=WiBL4H2TvUjQDqqGNjAE60nKnwtOERmDaVzKNmGMz/yXHpNWLSReXWpnq5JRLJ/EtL
         Tm6bDFHaoRjcmJ2pEY2IQ08hS5WZ6OoAjg/rz0fFASZEWoh4vrmsaQl7F2OzPNyftN18
         OEtlfGDa+ycl45U7kgcHWmKNIT34AmCAw5RLz2A3GyKgPUOrKb5eDEDDNjxujU4FTza1
         Pga+SnHAkC1yZa8yzDTHSHsEodk1B9z++hucOGz595DMEVH8EEl0USeCp2QcWilDjb9A
         pStPNGBg+Dj3yin0duMDZ9pNk3OJowiXjkQuWsT8JCCbJJNmHzLgDdQP0rJiZIL2USbm
         zszg==
X-Gm-Message-State: ABuFfogY9snsR/y5YGc7yMjVXzPOpOIjvct+CsFyhySI3Qputpj7OzhB
        M1dCh0ghKG7buXAIBHg+JwM=
X-Google-Smtp-Source: ACcGV62byiUcK7b5zbgivGfgvZFjKltWkt667AG9xQ6xqJqUx3PXqHV7Lp6VvVkpikSu2LvgI22sRQ==
X-Received: by 2002:a65:6249:: with SMTP id q9-v6mr42437631pgv.392.1540210195530;
        Mon, 22 Oct 2018 05:09:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:1904:c698:f9ce:cdd:454c])
        by smtp.gmail.com with ESMTPSA id w33-v6sm11572326pgl.29.2018.10.22.05.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:09:55 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux@rasmusvillemoes.dk, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 5/6] gpio: pci-idio-16: Mask read inputs for get_multiple
Date:   Mon, 22 Oct 2018 21:10:06 +0900
Message-Id: <4e02f26b801f271e80b7738a851b52ab7ffde649.1540209293.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pci-idio-16.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 25d16b2af1c3..6b7349783223 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -146,7 +146,7 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 		port_state = ioread8(ports[i]);
 
 		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word_index] |= (port_state << word_offset) & word_mask;
 	}
 
 	return 0;
-- 
2.19.1

