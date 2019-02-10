Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597FBC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2140A20873
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruB6mj8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBJTAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 14:00:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51499 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfBJTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 14:00:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so13268758wmj.1;
        Sun, 10 Feb 2019 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+eMmTfwODzLvEzByWZTx/8AnGc8y+MNL0RRcXP1LEg8=;
        b=ruB6mj8opIwdf7cFefLjKj/IbICOZUBan906dBjoQNx7IJU+BhvIZnqNSUcNUmV+3V
         Lo8wkMQr3KOHmQtMQfH72Ws32Y/w0fZuzaIF+chIBTSZsWNABY1sWtOM8emDy3SsClyl
         TN4FadxzUZMTu6riTz9Rkh5dNGQH2VtknvUxH2TyjF2is3jnHJqMhH0ikRhjJsX3zjZA
         NNiWZENn3n5mWwDCs7e9NNTSrPeXnEfNpt84U4+OoNqD8aOPjLkPtI1ahcpT3hm4Y/ku
         CNbXz3ZI24TAjuhkXpWAtsJ2BQaOZTGOTJJX6ZCS/d2mJZeHIuaz4uz9u7jWiQsyaLPH
         WMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+eMmTfwODzLvEzByWZTx/8AnGc8y+MNL0RRcXP1LEg8=;
        b=irmzPymWa0NneeHgkzKSSK8m5fmr+Ktg9yCbtWKe1hse9Jtdq2b+1CFpAyOJd0mQGp
         FivwQ2XurW5EZ2crxjzh9k749ALaFKjoRpUYVfEV2+XpKfJYL8p9j/nlUgKj16dKuCZc
         /hWPEcpudLCYKgD79nEWP8LvuKY3vXOyVgJsV6Uotr2MBSwnR/y/uYCZtqjZ0sAV9ebg
         /Tqjw4Hfe7o8JmPavTbnkT3hcoDthYPVzSx+itqwPMNcOKBYF5e8cIV4uD5bzLouB7LD
         0JWk2xcNxL7BBitLeauP0GoKp8f3GGcH3NyuGOS2VCjqcSbstY5XFVL5j3zxb++DXGWf
         UlFw==
X-Gm-Message-State: AHQUAuZuxNDH7t+4AQvRnn+N6upEI+83vD+BObBNJsN7Pqdd74AkwwjO
        7VaHnLbwIPYIzMRq5m5A3dU=
X-Google-Smtp-Source: AHgI3Iboze4MAOT7M75jcLt/i5BOKZkIEqQNluKzPOhijI898ysF/3kpni+STmhmgYX1/FAzHnb+IA==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr6357904wmc.21.1549825223183;
        Sun, 10 Feb 2019 11:00:23 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dee:9f00:2436:5653:8de5:2886])
        by smtp.gmail.com with ESMTPSA id l20sm16001287wrb.93.2019.02.10.11.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 11:00:22 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     paulmck@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify two issues in KEYS-TRUSTED entry
Date:   Sun, 10 Feb 2019 20:00:09 +0100
Message-Id: <20190210190009.9995-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
further maintainer to the KEYS-TRUSTED section entry. Paul McKenney also
introduced a typo in Mimi Zohar's email address in the KEYS-TRUSTED section
entry.

The two issues were detected when writing a script that parses MAINTAINERS.

Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
Fixes: 1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mimi, please pick up this patch instead of
  "[PATCH] MAINTAINERS: use tab instead of spaces". Thanks.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf4965d6d5de..b4b62ea78eeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8405,8 +8405,8 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-M:	Mimi Zohar <zohar@linuxibm.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
-- 
2.17.1

