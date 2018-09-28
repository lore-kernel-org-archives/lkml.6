Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F82C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3522073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GooNWy5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3522073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeI2EPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:15:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36658 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeI2EPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:15:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so5163404pfo.3;
        Fri, 28 Sep 2018 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6n8Snxmx6UNLna4Rq9oHkp8SANzBfEF7kjJ2RrPGmo=;
        b=GooNWy5rcszGO0PadsSsWvH66eyIm79C/cITp5BAXVBJlzuVuGENx6iKrvIAQpmRU5
         7K873Sd03jVV7ZR6J2nacG/39ijfW51xRfVxJOMSKiGkv8ghd5LANDYrGaCFhsWWTxpN
         bx/MLK76GbHXuYOc6Yo8PVxF/MxUa2WFP3S8LLoeEhC5z2YmFx0MIGQCzcaCdftGvGQZ
         VPXUb0YOWb0m6zyLy9vQzbfPiw1D1jWke/to5mIrRoYzzyJpcSeDbspYR6acplxVbYDN
         /fkt6vWxnkafdtr+hb3xD1T/rHWrcAJCvdYoQiEK1hCBi8ztDRyFuPVX3oxSPgFewlEC
         OWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6n8Snxmx6UNLna4Rq9oHkp8SANzBfEF7kjJ2RrPGmo=;
        b=J5o7CGGUouDaOgAzarZ16JcKT4d8vTqqwEQDomoKHKs9vVNcYVVwmiOI+eUlYEz4uc
         mG8qpqbhpMbQecvzQDDqXKtyaWoPHhNCkpB9+TJosSF1CE4Edo8j4CsFj8uBavODAokO
         xi8XapZWyl/BuLF19tXG00a30H84QfG75QEHOFngkVAeyDQb5p0+Drirjdy12MdWUbof
         HvgKXQdhnw1fZZgJk06gR8XTPA/gzt3IOHdYvplrpIWHlQAJkkrkKWuTsQecA0bEfZLg
         VgwyE0kNsFxa8zRsA/Hd9dlYUsJwbdSup05iEnkll9druvU9a7Aq6hNnjPYNWyHodnUJ
         DDDA==
X-Gm-Message-State: ABuFfogWCXRrNqf5V2tzv99nE1zj9XjodTm5JCezz+XZcn2jChfD+kFG
        OoIqtU+Q5q5cz1Jy4RX0yO8=
X-Google-Smtp-Source: ACcGV63PenWzk3rZwV13X0p/AEbnny6UTHA9tMoPxLyFJtnro4LIIlPYB8ZtfbP+/+EBfvpeN/cXqg==
X-Received: by 2002:a63:9f0a:: with SMTP id g10-v6mr459650pge.232.1538171381248;
        Fri, 28 Sep 2018 14:49:41 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r1-v6sm136842pgo.81.2018.09.28.14.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:49:40 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: ina3221: Add INA3221_CONFIG to volatile_table
Date:   Fri, 28 Sep 2018 14:49:20 -0700
Message-Id: <20180928214921.11528-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928214921.11528-1-nicoleotsuka@gmail.com>
References: <20180928214921.11528-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSB (15th bit) of INA3221_CONFIG is a self-clear reset bit.
So this register should be added to the volatile_table of the
regmap_config. Otherwise, we will see this bit is sticky in the
regcache which might accidentally reset the chip when an actual
write happens to the register.

This might not be a severe bug for the current code line since
there's no second place touching the INA3221_CONFIG except the
reset routine in the probe().

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e6b49500c52a..cfe65ff01051 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -353,7 +353,7 @@ static struct attribute *ina3221_attrs[] = {
 ATTRIBUTE_GROUPS(ina3221);
 
 static const struct regmap_range ina3221_yes_ranges[] = {
-	regmap_reg_range(INA3221_SHUNT1, INA3221_BUS3),
+	regmap_reg_range(INA3221_CONFIG, INA3221_BUS3),
 	regmap_reg_range(INA3221_MASK_ENABLE, INA3221_MASK_ENABLE),
 };
 
-- 
2.17.1

