Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF264C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2C420661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTDyWxM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2C420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030218AbeFSQPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:15:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52672 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966800AbeFSQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:13:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so1338921wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WHl8y2e/CNxRLOFMGZ23TuP+wCFFLpgrtDsLMJiqlxg=;
        b=jTDyWxM67bZIvl1zbpKV9K/r0m1UzwrXuvlTj4lwzpgChSzcoO+KRl1P6I1dCAXngJ
         VoUXAwxliDPFZM6O8AVW56KBiejXwYXrtRWVhHCD/j/k6Wg0QIsqzmEEGNj3mVRCvY6W
         IgkWnsVbV4X6Z/RImmc7h5PiMTEVLz3lRGUe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WHl8y2e/CNxRLOFMGZ23TuP+wCFFLpgrtDsLMJiqlxg=;
        b=nfjZZ0QS6RJ7IJTzaeDXbLnfV/XgS7mYVqLU/Pr16dhO+PY+ftzkh/OQLPhFMwE/fZ
         caCMCkpYucW3pU6s3dYN5uqNHT5acY8I6Qx0YxHsl2xHSo4ikHZMbEXi58uA5STZqpcj
         7Sa9mA7v2HVBl6oK11+1/G07vxrSJcHPzXdCRWZeOnJwOHj2j1+cr7RSzZiPhLCn1hPH
         3IaMn56U42EangMjrZz5aXi8nfiYLtBGgndeVmbfdKcCCp3+wsvA26mKRI7EaJOmc5A2
         rAxLyGtMhd08QYDxThO0NtZHyDKqk60ju4SZOeRw5w18g1GoRHSVScHyFNq/HwGm5lL4
         35nw==
X-Gm-Message-State: APt69E023Z1mva0UIJpgY+/rqgOZawZO7iDile3TFFbNHQ8AwzTQEb8c
        gp/W31L1pAFdZGt0PrM8F20SWg==
X-Google-Smtp-Source: ADUXVKJhvOEHcZ/VP57h0cJXumvT7sT4BN3GfgDluWBKVzLMGDhRYGXJwhvWbmev5GxHGhZsICoZGw==
X-Received: by 2002:a1c:17d4:: with SMTP id 203-v6mr11849072wmx.75.1529424788535;
        Tue, 19 Jun 2018 09:13:08 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r5-v6sm47248wrp.59.2018.06.19.09.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 09:13:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, kramasub@codeaurora.org, sdharia@quicinc.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 2/5] slimbus: core: rearrange slim_eaddr structure
Date:   Tue, 19 Jun 2018 17:12:58 +0100
Message-Id: <20180619161301.4556-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
References: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange struct slim_eaddr so that the structure is packed correctly
to be able to send in SLIMBus messages.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/slimbus.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index efa36a852dc3..63801bcc5e60 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -14,16 +14,16 @@ extern struct bus_type slimbus_bus;
 
 /**
  * struct slim_eaddr - Enumeration address for a SLIMbus device
- * @manf_id: Manufacturer Id for the device
- * @prod_code: Product code
- * @dev_index: Device index
  * @instance: Instance value
+ * @dev_index: Device index
+ * @prod_code: Product code
+ * @manf_id: Manufacturer Id for the device
  */
 struct slim_eaddr {
-	u16 manf_id;
-	u16 prod_code;
-	u8 dev_index;
 	u8 instance;
+	u8 dev_index;
+	u16 prod_code;
+	u16 manf_id;
 } __packed;
 
 /**
-- 
2.16.2

