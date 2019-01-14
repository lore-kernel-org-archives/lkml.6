Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DFFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120FC2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2KZFVSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfANLOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:14:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42884 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfANLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:14:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so18621444lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIHKUxbUMcsl1kh+bxxny68u7/r8UJ7G3RGM1yHCsVE=;
        b=Q2KZFVSjG5tgsGBaploWkLUUPIOpfHjyKlZxfoayiG0/BehQt/gpTKHx/OJazd4C6w
         ocPLgK/1fLJe7vYcFfzfPYWZ3DUqPK7vIWxDOIjrH9vk9OwiLUEmphuxybf2mcLwJ3az
         vcRFsureslCp55fQdamkhhuxCm3GsC2zy/oOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIHKUxbUMcsl1kh+bxxny68u7/r8UJ7G3RGM1yHCsVE=;
        b=BWaCrDnuH5qbgJt87xkqnAGU+VHysiLwcOgJeOd2HnaiWj+K2d6Nh0h0SgRKHDY/Rt
         LcF8RCG19o+kwOH/DRBrpxrs3He3RTAtric3y4Q4ahd9KR/+GerbldO/YQecJLr7N85x
         gFpWw7VOviI3JP2Erm7wN5PCn/70lj32ckZ1AAKEq1GTAB+dQbTGVRtNccctqgZFHMXh
         zeyc6I8M07Rq9SMl/bZuC27DW0YFt2t4m5eRLltI9j/dxU0+gLGpTZ1LjtoUWT4LNbjt
         favfZ80FRRXw0UUF3CVXf3GPClOvQOqNKasFuvkhU/otem7oFUmqhZPT3tFMIYblUUul
         vB6w==
X-Gm-Message-State: AJcUukeKeaK5N62eGJkGVF8wOORP2A6Mr1QrwXiz1mJvAz7Fn8uuE+M3
        V2+ljJpDj87nY4Ib2HuOJQ6xKA==
X-Google-Smtp-Source: ALg8bN4OEgRqSGpTSaGRspUyxmXZ3a2h+p2pH1ao9sa/3ZWJTBNIp1rrCP6j2cLhvpY1NJJAZzDL/g==
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr12081054lje.88.1547464478465;
        Mon, 14 Jan 2019 03:14:38 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id z15-v6sm35185ljb.9.2019.01.14.03.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 03:14:37 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] pwm: imx27: fix build issue
Date:   Mon, 14 Jan 2019 12:14:35 +0100
Message-Id: <20190114111435.27397-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PWM_IMX27 was configured as a module we got the following
build error:

In file included from ../drivers/pwm/pwm-imx27.c:15:
../drivers/pwm/pwm-imx27.c:292:25: error: ‘imx_pwm_dt_ids’
undeclared here (not in a function); did you mean ‘pwm_imx27_dt_ids’?
 MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
                         ^~~~~~~~~~~~~~
../include/linux/module.h:213:15: note: in definition of macro ‘MODULE_DEVICE_TABLE’
 extern typeof(name) __mod_##type##__##name##_device_table  \
               ^~~~
../include/linux/module.h:213:21: error: ‘__mod_of__imx_pwm_dt_ids_device_table’
aliased to undefined symbol ‘imx_pwm_dt_ids’
 extern typeof(name) __mod_##type##__##name##_device_table  \
                     ^~~~~~
../drivers/pwm/pwm-imx27.c:292:1: note: in expansion of macro ‘MODULE_DEVICE_TABLE’
 MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
 ^~~~~~~~~~~~~~~~~~~

Rework to use the new variable name pwm_imx27_dt_ids.

Fixes: 5a309d380019 ("pwm: imx: Split into two drivers")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pwm/pwm-imx27.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 8997c4c1bd03..55666cca4cee 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -289,7 +289,7 @@ static const struct of_device_id pwm_imx27_dt_ids[] = {
 	{ .compatible = "fsl,imx27-pwm", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
+MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
-- 
2.19.2

