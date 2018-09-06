Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8689C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3090F20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QHWufvI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3090F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeIFSew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:34:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33097 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbeIFSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:34:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so11575863wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=r5jJc2S34MqKcDe2xIZm65osysYJmMlgiFVDcWOqGi4=;
        b=QHWufvI1U51SB2KMuCKO0DQsLsZ61cGd6hKwL2UUZzwKzoVRjcf5mX/Qntx4BtV1l2
         ZKma1IXyHBNff2zo/lkx10sLrkmIIkSbLp4K2T/tCdcB2Y4ZxxTmyY07ExJ0VGLwNzDH
         k55fd+4eP2l26kbC5SSzrwG2HW5rZfoQlTFhgG3hGpAwQ6912IAVlSkxDpi7IrKz6AWw
         zlIlYFmFSG7tiu8EfyTsmixhejYIA0bKoDZ3Q0iRSqLymejxSI5mxBKvsy38Necggfgs
         FMqpaEVjqVpPyVjjx+mwe+eklN1+BYzhNNO5OwDL3J9MJYYemJjVhyVdV3N8/YJ8/dEG
         NFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r5jJc2S34MqKcDe2xIZm65osysYJmMlgiFVDcWOqGi4=;
        b=YB0SmTEWnaXKVFmmT7xUxCIcQttL08Q0tMiSe1JOriusIzaB5eaAmw9JKMjL4yFiZG
         naqS3ei6nuH99ypqGB//0X7TGOJ5dAV72sqQf1FB9XJMwJs5lN5heM9LVCgcuYeS9XAM
         wJGphOdQSy2aJccWzbh7o4xXxokZhfMA3ayBkrWiaMIcwn9P0r+0WODgEgnahbaF41+0
         RBGUMrHah7x0HdXPEdfIi/Sca37Phl7GUoOjiHXIkY/0ph2Ur/dnrtUhFAeNXT9sudMK
         zqZ+6VOhd9kWx3ms6u7SDwfoyTM6NuzKDioCVsT3Y/FgfEdGbPPcVENi/4VCwVFJtznc
         KNUg==
X-Gm-Message-State: APzg51DF1AXK6uuoq54Po/f/Jib+b9nQ+L2iby3j9hE8mIQx9VsErlKo
        qss8L/TnrGKJ8UlLrSBFXmFPvg==
X-Google-Smtp-Source: ANB0VdY7fjU8Quy6bizcTtBDv/M24RtfDps9uvX4EXv52Jh93VpeKRlDU7FBC+VeVLrV7VVhxmdP5A==
X-Received: by 2002:adf:9187:: with SMTP id 7-v6mr2494408wri.215.1536242349279;
        Thu, 06 Sep 2018 06:59:09 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r66-v6sm8768660wmb.37.2018.09.06.06.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 06:59:08 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: pwm: silently error out on EPROBE_DEFER
Date:   Thu,  6 Sep 2018 15:59:04 +0200
Message-Id: <20180906135904.13803-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When probing, if we fail to get the pwm due to probe deferal, we shouldn't
print an error message. Just be silent in this case.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/leds/leds-pwm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index df80c89ebe7f..5d3faae51d59 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -100,8 +100,9 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		led_data->pwm = devm_pwm_get(dev, led->name);
 	if (IS_ERR(led_data->pwm)) {
 		ret = PTR_ERR(led_data->pwm);
-		dev_err(dev, "unable to request PWM for %s: %d\n",
-			led->name, ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "unable to request PWM for %s: %d\n",
+				led->name, ret);
 		return ret;
 	}
 
-- 
2.17.1

