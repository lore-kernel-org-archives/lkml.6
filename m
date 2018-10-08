Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8055DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DB52089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYzDTZkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DB52089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJIDTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:19:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40181 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIDTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:19:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so8302273pgm.7;
        Mon, 08 Oct 2018 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NETaRhhqThBx8sJ4jYSJZpsYlid5vjM+cDKbA/NtqBs=;
        b=AYzDTZkJphxZWE/3MrHZKk/0sedhI1+egfw4EJAuaWqkyMG4Mozm20Fb4XpcyOV9Do
         E7Vw954VOJWgH6qms9+TkkvyOqMNsqHUEykjbxKPjC8brZDYc/yATeYoUECGjm/e8JSU
         zN8I9fZ57H4T7KRVTCE0krrlMEnDz46045O6dwb0ee3fq+qnYDAdCjSVetd0u/mmyA3K
         C9X30ZR32FmOVKo1IjWYVPRAr5UXIqchF5E++wUxF1b0jcdONamCRzI0ooMb3YDJirLi
         DVczn1h94zm2DTKf9qPtGbEhLjPiMf3skFQeNVHUMA0TyfZhqGK9bFNr9lE7HGjapDXo
         lRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NETaRhhqThBx8sJ4jYSJZpsYlid5vjM+cDKbA/NtqBs=;
        b=QRpVUnLFp8NGzAQrDiB4Qgkz4EBsOlL/d5IfY5x2ng4HJ+0h/2/l8i1zwfXEIzZbjR
         IIsJjli7chtuxwOAZ+7eTLIAiX0xqjE6QDHbDHBgjGJrhOdpXwOPnH4JiTBFYtvzA3+L
         tyDsVhO9w8EN9UZMOMCxksRk3cfnLa+KV+dqPRJycbtfuKa6puKvwNqdPIRz4oRB5HMo
         BNcT6zMI/Yz2sTWGAgqf+4xi7LLzdkDXSHxf1He8GWjapZ4drLfWRLcS6r8sQueBtmIv
         6EYppDTsjfUcSfA0FHLlRiZR1udqEprm6Ook4fLCsbjxVkNVyjdg1Lc/3luZIQlkId5s
         5V0w==
X-Gm-Message-State: ABuFfogcbYlKmyvzYASqRI4zOiZrlhZOYq28ohXCIZrTGt9mslACXO2I
        I7eqjuYF0oMpdS28OncyZYU=
X-Google-Smtp-Source: ACcGV61CsXnjV3pRTzEL6iAvZZP/GsTWZ34nxajd1OXUWwEJERQAfuDXWwg2XB1EdxeDvH49fpTSKQ==
X-Received: by 2002:a62:5982:: with SMTP id k2-v6mr16236060pfj.180.1539029147508;
        Mon, 08 Oct 2018 13:05:47 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e19-v6sm36576193pfb.153.2018.10.08.13.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 13:05:46 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (ina3221) Clamp shunt resistor value from DT
Date:   Mon,  8 Oct 2018 13:05:37 -0700
Message-Id: <20181008200537.22062-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input->shunt_resistor is int type while the value from DT is
unsigned int. Meanwhile, a divide-by-zero error would happen if
the value is 0. So this patch just simply clamps the value.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index c3a497aed345..ce8f0a8c4982 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -536,8 +536,10 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 	of_property_read_string(child, "label", &input->label);
 
 	/* Overwrite default shunt resistor value optionally */
-	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val))
+	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val)) {
+		val = clamp_val(val, 1, INT_MAX);
 		input->shunt_resistor = val;
+	}
 
 	return 0;
 }
-- 
2.17.1

