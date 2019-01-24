Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E2C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0272184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sePglr2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfAXU2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:28:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54563 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbfAXU2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:28:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so4585598wmh.4;
        Thu, 24 Jan 2019 12:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6IfJiCGXlpW+dv24DGIPbhLiY/a5Z0pefOdxLNkgPs=;
        b=sePglr2n5+N+RPa28bDMFT82KfHBuei3V4a878wR5TOYpuiUowEvgw56bX4z2HmCFC
         2GCose1fGUuw/V+/FMTgmdXebl0740MFL5AdZkbrR+uOw27TQXk7XjFPB82suVp3ydwx
         ig3/F1i9Ayf9c3jd8/M46Ojv2AxLos/lJNigSq+MquOgsuzf/Ysg/5zUwBv5LuTpNEHf
         2q+vnbf1OxUbL0i/+JATZM0CpO2STUQfrnDlPr0yHYOh/i0TTp4rqVIUBRl9F7Ibrzy8
         2q5RGugAfCtyIMG24TYWYO3YLxOiJYbpbYZy5K9SE8X8Ip1PJzkR/QBJiiIG2Emp1fvg
         FUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6IfJiCGXlpW+dv24DGIPbhLiY/a5Z0pefOdxLNkgPs=;
        b=LovjbO8UtRmMByeh+sU0LWDPP1yLHMbF/ntiwTNhjiSME8p4E72H4IXgw2cXcyxcPw
         ltgTfmwC7GhUKdhmVq5cY2D3VaZdFhKueza5PeP8MghQ37dNqonknu5L03Hg/EQTCQpI
         MEouEQp+AdQutza/nIsSxtZNrJxiMCS6svfFOyaYjfDjT+M8qdHTUzmo4/meJBoSXTKd
         NYA12DCKRIMGbQDwTeB9NF0/D+4a4Uk9gaqH9yx7hsPK1+wA5dsZl+S8+NMWW6RzBxSA
         Fkv5nc8/WGJrBTxFbwcJgjlR5ZCSVKgYZzaBfLGYTO9v9lTFq36l6KbLxgu3ZRVutkUx
         MGXg==
X-Gm-Message-State: AJcUukfr7k8SmYFk7cMCXG67zzgolLPvDqxrpujjfNqASBF3FNCoBt0i
        tVWbb+HXT6OXjlmV4G0ycF8+P8Y2yOc=
X-Google-Smtp-Source: ALg8bN7772rhYUqdCQQQ+0xH6mYJHPLxLdHLm3PyD7m8TqeQYB0q1Y4bW6PHt21ydQ2cKQXcLAg6ww==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr4266950wmh.92.1548361678614;
        Thu, 24 Jan 2019 12:27:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:9dbf:5832:1d37:55b2])
        by smtp.googlemail.com with ESMTPSA id g67sm128617960wmd.38.2019.01.24.12.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:27:57 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 2/2] input: misc: pwm-vibra: Stop regulator after disabling pwm, not before
Date:   Thu, 24 Jan 2019 21:27:32 +0100
Message-Id: <20190124202732.14723-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124202732.14723-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190124202732.14723-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes order of disable calls in pwm_vibrator_stop.
Currently when starting device, we first enable vcc regulator and then
setup and enable pwm. When stopping, we should do this in oposite order,
so first disable pwm and then disable regulator.
Previously order was the same as in start.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/pwm-vibra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 9df87431d7d4..dbb6d9e1b947 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -80,14 +80,14 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 
 static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
 {
+	if (vibrator->pwm_dir)
+		pwm_disable(vibrator->pwm_dir);
+	pwm_disable(vibrator->pwm);
+
 	if (vibrator->vcc_on) {
 		regulator_disable(vibrator->vcc);
 		vibrator->vcc_on = false;
 	}
-
-	if (vibrator->pwm_dir)
-		pwm_disable(vibrator->pwm_dir);
-	pwm_disable(vibrator->pwm);
 }
 
 static void pwm_vibrator_play_work(struct work_struct *work)
-- 
2.17.1

