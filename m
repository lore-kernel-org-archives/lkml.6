Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809EEECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7382084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYggG6y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7382084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeGUMP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:15:58 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34765 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeGUMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:15:58 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so5611045ybq.1;
        Sat, 21 Jul 2018 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IISkwgtloMwre3PiNAm0Fpw8RGesT1eVn1treWoxBS4=;
        b=DYggG6y3GjScWPjhFTkzO6Zusy+AZnUzNuZhFovCU95PvUWE8wd/F2YsOTjqATSySR
         d0A+QR6dJ+LcvmoOPMTOt1eFXPgC60D5Umifu3bQ/pwJPMnNlZawz1uHaN9mvv72MuNE
         RgTN1zChsl8w6PHPMfPGpyTYwIcHTgo0PUmui+7Y26CBrMhoAipIm9xRuU6sDxo3aS3M
         hynVYUB2mgHUKw6PNCYIXGEmVCXOhsHwIJEmaeZqNHfc0CIgfB/eRploNZ2VuMVCAguI
         pLV1jUFMdaudmJDcviFF9VgZXsLSjmtIGOwr/73Gft1ncBuI19OG77CI0Mipzys45U85
         SFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IISkwgtloMwre3PiNAm0Fpw8RGesT1eVn1treWoxBS4=;
        b=L/p+ydKC9aHqFy5lWJjZOrTR2JYQzMshrz35VOn9j1+bNF74PCZnWAfXTZd5+WavVT
         0UVzg3cHxfklYAm6Umve0Cuphx+HkgA8aeimcpM8NLt8LyuIQNoYDhCu1B7MtyRbPMUM
         Gvz3QGAllvz9xDPz910lThNwsbK4acYYlaOotD6VF3uGrWLf0WMNLa6Gzq7fT43OwHq4
         A19ycn+Jg5w2jms+C7NKYAPUSql2d1N8ym7oPSXuhjboQZa0GD2n8zmL/4gyM9h8LhTv
         bk3wCiGsxEV8TSJTuwhvUvTnWb5pwpPon7FsPVKKRHAKq9VYiQlPtDC15EJsII9qVH9n
         wkxA==
X-Gm-Message-State: AOUpUlEQqS6JDXVXac9FvW1cTCF/BWwrCp/lPe7Xr7UPYgr0fZU6hR5h
        JwRQHTCZk6QvAulc2e03oMFu0ODVqUuR6w==
X-Google-Smtp-Source: AAOMgpdaQnbOIxOwCtN/d15h47IwnsoQHJJKLZnsyjJQ4ErWTyQZUt4TSA1TAcJ1Q1WfhiVc0UjELg==
X-Received: by 2002:a25:2102:: with SMTP id h2-v6mr2842983ybh.31.1532172213097;
        Sat, 21 Jul 2018 04:23:33 -0700 (PDT)
Received: from ?IPv6:2601:153:601:7d2a::100b? ([2601:153:601:7d2a::100b])
        by smtp.gmail.com with ESMTPSA id 64-v6sm2058121ywg.106.2018.07.21.04.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 04:23:32 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Message-ID: <17c10727-cab3-4736-281a-d4ace1cdbb82@gmail.com>
Date:   Sat, 21 Jul 2018 07:23:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-sending due to email address typo.

SW2 and SW4 use a shared table to provide voltage to the cpu core and
devices on Tegra hardware.
Added this table to the cpcap regulator driver as the first step to
supporting this device on Tegra.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
  drivers/regulator/cpcap-regulator.c | 23 +++++++++++++++++++++++
  1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/cpcap-regulator.c 
b/drivers/regulator/cpcap-regulator.c
index bd910fe123d9..c0b1e04bd90f 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -271,6 +271,29 @@ static struct regulator_ops cpcap_regulator_ops = {
  };

  static const unsigned int unknown_val_tbl[] = { 0, };
+static const unsigned int sw2_sw4_val_tbl[] = { 612500, 625000, 637500,
+                                               650000, 662500, 675000,
+                                               687500, 700000, 712500,
+                                               725000, 737500, 750000,
+                                               762500, 775000, 787500,
+                                               800000, 812500, 825000,
+                                               837500, 850000, 862500,
+                                               875000, 887500, 900000,
+                                               912500, 925000, 937500,
+                                               950000, 962500, 975000,
+                                               987500, 1000000, 1012500,
+                                               1025000, 1037500, 1050000,
+                                               1062500, 1075000, 1087500,
+                                               1100000, 1112500, 1125000,
+                                               1137500, 1150000, 1162500,
+                                               1175000, 1187500, 1200000,
+                                               1212500, 1225000, 1237500,
+                                               1250000, 1262500, 1275000,
+                                               1287500, 1300000, 1312500,
+                                               1325000, 1337500, 1350000,
+                                               1362500, 1375000, 1387500,
+                                               1400000, 1412500, 1425000,
+                                               1437500, 1450000, 
1462500, };
  static const unsigned int sw5_val_tbl[] = { 0, 5050000, };
  static const unsigned int vcam_val_tbl[] = { 2600000, 2700000, 2800000,
                                              2900000, };
-- 
2.17.1
