Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88341C64E93
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C05F20880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbgpg07C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C05F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeI3EOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:14:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39192 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeI3EOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:14:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so6595046pff.6;
        Sat, 29 Sep 2018 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6n8Snxmx6UNLna4Rq9oHkp8SANzBfEF7kjJ2RrPGmo=;
        b=Nbgpg07C/T4QCCuI1uJThvV1xtbd6m2jEDxSFyugAmDTw+LH1cKH1WZmoZOJIsgQ0C
         6KcKvpiOgIxsDv5ZzfeJjI9XuZ3LarubFNYjCWBI6yE/a/sbyxz6QZsNgWMWVh3mtVqM
         Sz3sb5o3PYwqBiZBa9c9aLMzyx4ZHOk41EwL8IJLxivdqHwdkkUOR1gdeuldgW2d97nd
         TRuBU/Sm0XWvLCek/yS+9kR3xY6rOYFTOLnhXyt0QzoPe6Des/ijFC8d8TweDk8PqdjX
         Yj3sotg4rmoAEx1OOL79Uxjj/25J+yocre6HlT6fku2TD9v5tmZdca3cS+o2GUgSVd+j
         nlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6n8Snxmx6UNLna4Rq9oHkp8SANzBfEF7kjJ2RrPGmo=;
        b=t/yt9rlqZI/tWjXQarmc/I0svjCzuVp7xQ3GHLyAAOId/vgxOcpAQirWzdKu5QXo9O
         lUk9+yzf1CwfcXQQQSAVYIiGHAzgpHNwEJ+UYkpig1rhyQFH6w0BWhYHoiqolrYZyX8t
         6KLZHyAQNZartx43fkWlUPbquoar28/7MRJSZ94JN11SkCdarczUn6UtjJP76Bcda3e1
         vwkykGjWlBcm74xKukYVwcH7GN6nQbUvwu79jflu9AnDw2+KJJk+mlVyntMvTu3ePc9v
         f6LeaG16+BD74O/wSlu58+fB6J7RgInpU6cFa2ZWGIG1e7vEWRdj9rPCpfUV3f8rESma
         mfPQ==
X-Gm-Message-State: ABuFfohtZ1fkdRLCgK3svpNur8MeCK34ofIjtMT6tK9LzxBIRSMJC1gL
        0sONqYViqJi13cZ1qVtENl0=
X-Google-Smtp-Source: ACcGV63da/uK2Ar8DJS/LTA1oAJsQjjJ9dBOiz9Z5GYDOFiJiZglmZO4f3/4xG99zuMkvG0XWeM0SA==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1-v6mr4794429plb.129.1538257455178;
        Sat, 29 Sep 2018 14:44:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id o20-v6sm17780313pfj.35.2018.09.29.14.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 14:44:14 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] hwmon: ina3221: Add INA3221_CONFIG to volatile_table
Date:   Sat, 29 Sep 2018 14:44:05 -0700
Message-Id: <20180929214407.27208-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929214407.27208-1-nicoleotsuka@gmail.com>
References: <20180929214407.27208-1-nicoleotsuka@gmail.com>
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

