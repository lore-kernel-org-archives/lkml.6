Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964CFC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC720672
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhqVLYmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAC720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeKUAHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:07:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44444 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKUAHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:07:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so910841pgr.11;
        Tue, 20 Nov 2018 05:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8HBrm1zH1BkMFcxEhbIsl978ZBsel0NyChgBIFAkMsk=;
        b=bhqVLYmdEiCaUcKIi+fpgo26vf9fI132kBz8d9OvJ/QTmwJ9JtE/FMVwt3F9dewCas
         GFevLmA4DL0pzbWdq21X9AASPL4Fn87bQfUxWeuJZ3JENWj0vE9n1KFIHD/f01y63cDB
         OOCJhaoMKW4Ao/lzy7WUnRb5khYqTiX05KwL+6ZZ9gp2xNoB46khPzQZUIcBHKUVznA+
         +yE2RhHDQZo2UizMA7jlo9/RIKSM6WNwZZ2OYdB3f0XGRcXE/4u/gsICHvpuKcm/Use5
         IC1n2PM1afX/9J7Pc0DBxR1/zVcwgUfBPbbMrNO/BuGWTi9Ccp+Wy2/3rhw+Vao5w0aw
         QZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8HBrm1zH1BkMFcxEhbIsl978ZBsel0NyChgBIFAkMsk=;
        b=pvVUPY+4/W07R/ZC0duNBbB4J+D4McJvD2U7kfY0kpFWcTrLEcuD6+nph8yIss10VN
         y1FOVcRqyemets3IrR/UVw/wrIbPHlTKCL7lW5ArLZLpAryO+QVt25kIh2Z3Z73ufH5b
         v1CsXCe8Dn/O5GYelfJEUcc7o15N0naGY6IqqX9z3yaMxFvWq4KoeSFZfmTQy0SRfioS
         i5873f/D5YFvtCHX6cB4qbF3Utff3DLxQa3lCLfJZOQcgTgvEWF1d3vx9WBJfrJCwCgo
         znrX0I86ArovU5AFTXUtM7eM3p/519Fm2SYfhbsxrwUp/9gnI4yB+ou9tSEgp6+rriIX
         UwOA==
X-Gm-Message-State: AGRZ1gJBij5C6TaOU3Er1aP89X9qLYncTFeo1Aui9/ptn1qzms6sma1g
        xmn/qmhZrKSJj1z9PsACmzg=
X-Google-Smtp-Source: AJdET5ewx1ZgN/2QPp/Oha4ryp7xTxUPwDY7feFzk2nFaZqIXTS90Fw9KQnHo8byYV7oT4r+GoxfJA==
X-Received: by 2002:a62:9111:: with SMTP id l17mr2056430pfe.200.1542721110122;
        Tue, 20 Nov 2018 05:38:30 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id i72sm28285865pfe.181.2018.11.20.05.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:38:29 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] drivers/sbus/char: add of_node_put()
Date:   Tue, 20 Nov 2018 08:38:26 -0500
Message-Id: <20181120133826.20019-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/sbus/char/envctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 56e962a01493..b8481927bfe4 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -910,8 +910,10 @@ static void envctrl_init_i2c_child(struct device_node *dp,
 			for (len = 0; len < PCF8584_MAX_CHANNELS; ++len) {
 				pchild->mon_type[len] = ENVCTRL_NOMON;
 			}
+			of_node_put(root_node);
 			return;
 		}
+		of_node_put(root_node);
 	}
 
 	/* Get the monitor channels. */
-- 
2.17.0

