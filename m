Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC4FC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639082098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgW5ZgdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639082098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJCWjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:39:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38524 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:39:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so6701623wrt.5;
        Wed, 03 Oct 2018 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H3W7VRgsY7hiwTl7kxop9hOadSIoFbnq6wSoA6c8KQk=;
        b=UgW5ZgdYfHEBzV6/+UQCoDrjFg88snaVzIfK30BXXf90FlqJCC/uIG7n5i6zhbeBGA
         lriHqk7xVz2qSaGyA7ijU0r+i5YNcUxXCWVeUUOyiuzlLNAEzI7W4BacjYt1ilTw7jLO
         iIAQWiXAGv1h/Pc1ypiGp6SI4+lBKYEN10a9mKkxMtzRRvTscJxsc1fkzW5LQ/H6qz4d
         0H/jQNa04PURdEKOap4upnnqAmitgdeHJXDBF0It2AHaKe6BMhH3181S06ta39gZ73iE
         G8jkXVZwaY9q4qgQ4OxbDWH2VX00sEDjyACsNaCHotD1y3Wjpz8/FyYYQ/Ih4uamlR0M
         KJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H3W7VRgsY7hiwTl7kxop9hOadSIoFbnq6wSoA6c8KQk=;
        b=Dw/uK/HMjmhVEDgjUJB2XnZlK8XmJj1XI1eosPCIT0X1/2vYQBQvUXiwDUL1JkqisS
         LRYkB+yp9kjIqr7/ePL6YPgzH+eZbUUs7NeSewMEG2b1UKg7z6UDrdkcrQvrb7a1kubC
         Ns6L/+1rlbLIFXqmwaEEc7p7lIXcoeyuYYw/OfQAYWJMfkQaoiPGkF3zgcuvGGMgJ9mx
         lfWjsOVhH26Errvg5r9KnMwjbE0DKBnEGFno+1Gistbzlhen3RlFB+/WE4oMaf67JbAR
         haQjFJJlXpZdoi2i7TNf8ifA1Iv+E0cIcAnX9E6CGes8hgkQ0LM+hdnJm1DzjX0rw4So
         zg/A==
X-Gm-Message-State: ABuFfoifOpLErMHY+G1hi/QBt4hBrrP6wGzQhVW9IsTgATxgfIYV0jXZ
        YoLO61FRGXlJo2i4j8dksOTQ7SLg
X-Google-Smtp-Source: ACcGV61Y7YqSLLUFHHT+aODcjR/ZrSNHRinX2LQTUQxnZaU6ZBnlCTI7Q9beraOeHAEo+j58VzXdFQ==
X-Received: by 2002:a5d:6883:: with SMTP id h3-v6mr1795454wru.108.1538581849220;
        Wed, 03 Oct 2018 08:50:49 -0700 (PDT)
Received: from pc-ceresoli.dev.aim (45.11.168.109.cust.ip.kpnqwest.it. [109.168.11.45])
        by smtp.gmail.com with ESMTPSA id h18-v6sm1707614wrb.82.2018.10.03.08.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:50:48 -0700 (PDT)
From:   Luca Ceresoli <lucaceresoli77@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Peter Rosin <peda@axentia.se>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v2 2/3] i2c: mux: ltc4306: simplify code to reach the adapter
Date:   Wed,  3 Oct 2018 17:50:23 +0200
Message-Id: <20181003155024.16024-2-lucaceresoli77@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003155024.16024-1-lucaceresoli77@gmail.com>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

struct i2c_client has a direct pointer to the adapter, no need to dig
it out of the struct device tree.

Suggested-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/i2c/muxes/i2c-mux-ltc4306.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
index a9af93259b19..83a714605cd6 100644
--- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
+++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
@@ -208,7 +208,7 @@ MODULE_DEVICE_TABLE(of, ltc4306_of_match);
 
 static int ltc4306_probe(struct i2c_client *client)
 {
-	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adap = client->adapter;
 	const struct chip_desc *chip;
 	struct i2c_mux_core *muxc;
 	struct ltc4306 *data;
-- 
2.17.1

