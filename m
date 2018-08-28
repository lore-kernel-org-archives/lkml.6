Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8407EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3582F2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/EKZYwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3582F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeH1XzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:55:16 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38113 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH1XzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:55:15 -0400
Received: by mail-qt0-f195.google.com with SMTP id x7-v6so3210260qtk.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O0I2gMIoVUpUJueoRJlcfYT++s16FkZQJMGWrqcKD2E=;
        b=t/EKZYwQHdAfiVC422DD1M5QZE3/SSW/Afde3CbcJBwtIw9TlM1JIU/1emXR/d9P+V
         9jovKr4abvGJcmki2h4i1fRLfK1boD9/MrJ1pF7RjeS9xSZcdyY3ShkQ0v5zykOUi7/v
         AYVv7TzxxKn0hTQ8nSAlL+1U/kn2grJmqINaVYOzZzEQT3zlpbAB/S9eeLlmy2xlB4S8
         bMLhaagWRFJgfLVrwX+t1AAvhWVbqBSJYuVT8ddjOoSgWV3GWNwWOhPFK1ccGhb2XQdf
         7KqwxxV3NX9d4eBkmK6FVwdHRLJxVO6LCRSYUEYWdlYmQIDW9Zs9YhLNPYjlTHCdQKID
         NrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O0I2gMIoVUpUJueoRJlcfYT++s16FkZQJMGWrqcKD2E=;
        b=sYNOTNkZZTKCLFX3ITx8id24RDS67mdmHN3162hAvxrJ/brvmqmw4qPdl/s+HlJL+m
         BeNHOm9KD142Z0JjeUOn+9Iw3S7l6j1qHgFzUmx2GvukZb2Do8NVE9uXPD8TgT2YcBYH
         Ja8ZVbSch8xB2iYEnk8NQqeIIC5LyI//8fKGIAZUHpJkBlF/fLjF1QXjW2LvX5tCPdRB
         C1LbOB3qTpP1a1f6wxlfuHJepRI1rbiuFhzffAxTq9AGvQzRzDn04veT1qINjLHy5r4M
         bXcd5h20J94/icwSqpHrDT4ReHWgIFysALGmq8TqvaAFpnix8qyMd/AeT8IZxUJ1D9FP
         W//w==
X-Gm-Message-State: APzg51Aom7ktM3QXSZ7ex3wn6tWMw7Ux4WeZR2sBsZUwwikPdlbjILRb
        2Q2BlwFJBXJgzJfG8QjfDTA=
X-Google-Smtp-Source: ANB0VdZjW5lUb/RzIXXjjuO5p7A5s67Aek1RMu4q4YhHvNimSNtnqO1hh6hWS84QwHa8gV0/X11RJA==
X-Received: by 2002:ac8:3f0a:: with SMTP id c10-v6mr3568198qtk.280.1535486523068;
        Tue, 28 Aug 2018 13:02:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:3bb:156d:eeea:1f91:1405])
        by smtp.gmail.com with ESMTPSA id b16-v6sm1221158qkj.76.2018.08.28.13.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 13:02:02 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        andrey.gusakov@cogentembedded.com, cphealy@gmail.com,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] mfd: mc13xxx-core: Fix PMIC shutdown when reading ADC values
Date:   Tue, 28 Aug 2018 17:02:40 -0300
Message-Id: <1535486560-16267-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

When trying to read any MC13892 ADC channel on a imx51-babbage board:

# cat /sys/class/hwmon/hwmon0/device/in7_input

The MC13892 PMIC shutdowns completely.

After debugging this issue and comparing the MC13892 and MC13783
initializations done in the vendor kernel, it was noticed that the
CHRGRAWDIV bit of the ADC0 register was not being set.

This bit is set by default after power on, but the driver was
clearing it.

After setting this bit it is possible to read the ADC values correctly.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/mfd/mc13xxx-core.c  | 3 ++-
 include/linux/mfd/mc13xxx.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index c63e331..f475e84 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -276,7 +276,8 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
 
-	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
+	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2 |
+	       MC13XXX_ADC0_CHRGRAWDIV;
 	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
 
 	/*
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 54a3cd8..2ad9bdc 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -249,6 +249,7 @@ struct mc13xxx_platform_data {
 #define MC13XXX_ADC0_TSMOD0		(1 << 12)
 #define MC13XXX_ADC0_TSMOD1		(1 << 13)
 #define MC13XXX_ADC0_TSMOD2		(1 << 14)
+#define MC13XXX_ADC0_CHRGRAWDIV		(1 << 15)
 #define MC13XXX_ADC0_ADINC1		(1 << 16)
 #define MC13XXX_ADC0_ADINC2		(1 << 17)
 
-- 
2.7.4

