Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF1AC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833072087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMR+QCn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833072087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeI3EOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:14:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35304 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeI3EOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:14:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so6603055pfh.2;
        Sat, 29 Sep 2018 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lKWbMkp368XzmVlJVun9ac08PeLhKi9JwX0MssQOjqQ=;
        b=MMR+QCn/veKndWWeKP3/d0ixGMu/V4Fo0B8/4FVRiVvgqpuID/hSO8QvlbZv0WlSGI
         MyA1RQ8iaP13R3B9AgaGCku8+Se8FXZK4pzijHMFB/GSJJCZ0LQkH7vSLd5+PwCRnEkJ
         HY0zXx0WlGqdk8KDbZM59RS2ppV9qFsclZve1UBwCgjGR4+vANdW0S4rx6IunJjsvbvf
         yocR1dviJq4ACJ2GpAUMO0AnMbhoT/b39PiLeYjBms+/6JMZDW1K9PlKkManVt+25nIK
         bYgzD9CIVnBTqAfDs5sqmNDjDcnzaIAGuyy0p3vHvVAjRfSHrR9QCHlqigZ7fpWQ2Twa
         3Nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lKWbMkp368XzmVlJVun9ac08PeLhKi9JwX0MssQOjqQ=;
        b=OdkKGlM/jX1zmjQYesWdjyiCZjBVlxo1cOffXuZMSJ4Rpmyw7qhJVP4Bag+7rvUvCF
         2XnF809Gq8Rasq59jMmzcZBpcdvsM7FFoyZKFOcOyJrpJMGfvwj+5wHCEAU+4DBD0kqE
         h2Bd6MsC5OngRSJWwki8jYd5KGf8wGVxONkQa9tkKhxvQLvRT1HJjJqPQTvgMz9Bj5O1
         EQdzVFY75fwX4bnWIbAKEsLO0BbDU2epvJX7ilfQselAbx3zVdEADzVQiAJdCmXVsyVN
         Uvv9lglIJMNytLaAcOOFkdw32QeChtNZyigL/+oWY/8h6gBn6wakNbXNr6p1UVbKgrtF
         0nRA==
X-Gm-Message-State: ABuFfogZA3OlRJQgdlpBF3fZlMREuvMQkhg4I2Fix8TscYcSfofoveT8
        3qBctB+G1BMeMW1VAk9TJ9U=
X-Google-Smtp-Source: ACcGV61K/npanOLBDxq+t/7801acDzwXlsxjdKjV2Gcv1pe+advO6dNmLhuiShZAd+cqTbaPa5GrgQ==
X-Received: by 2002:a63:8343:: with SMTP id h64-v6mr3105113pge.368.1538257456062;
        Sat, 29 Sep 2018 14:44:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id o20-v6sm17780313pfj.35.2018.09.29.14.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 14:44:15 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] hwmon: ina3221: Fix INA3221_CONFIG_MODE macros
Date:   Sat, 29 Sep 2018 14:44:06 -0700
Message-Id: <20180929214407.27208-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929214407.27208-1-nicoleotsuka@gmail.com>
References: <20180929214407.27208-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The three INA3221_CONFIG_MODE macros are not correctly defined here.
The MODE3-1 filed is loacted at BIT 2-0 according to the datasheet.

So this patch just fixes them by shifting all of them with a correct
offset. However, this isn't a crital bug fix as the driver does not
use any of them at this point.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index cfe65ff01051..e0c4f4d83f4e 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -38,9 +38,9 @@
 #define INA3221_WARN3			0x0c
 #define INA3221_MASK_ENABLE		0x0f
 
-#define INA3221_CONFIG_MODE_SHUNT	BIT(1)
-#define INA3221_CONFIG_MODE_BUS		BIT(2)
-#define INA3221_CONFIG_MODE_CONTINUOUS	BIT(3)
+#define INA3221_CONFIG_MODE_SHUNT	BIT(0)
+#define INA3221_CONFIG_MODE_BUS		BIT(1)
+#define INA3221_CONFIG_MODE_CONTINUOUS	BIT(2)
 
 #define INA3221_RSHUNT_DEFAULT		10000
 
-- 
2.17.1

