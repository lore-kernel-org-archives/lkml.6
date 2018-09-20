Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37579ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C7821531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE3bBROs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C7821531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbeITWDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:03:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39116 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeITWDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:03:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so8353487edi.6;
        Thu, 20 Sep 2018 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XR0yI+aW4ISKO6OurX+u0MtdwuSJkccbzRW5ErEx2Yg=;
        b=AE3bBROsPqHaTGBTbVFuLfw7/bd19gM2mpGyaLn+fwre7y7Jtn+cluX/0oepmG/Qia
         BeXJp+JuDXLAEmYf0OLE/oxFAXu4/l9NsJtyTfqStYYQu7MJroE0U/y0i36V3ENaT05C
         9h6pkHYEuKzBPuBLKn4Chd3Dd5yJaqugo2AmoHTW+YtPB86mKRjz4KgHaqwOR4CB2VnH
         nOC3RezkOCQdR0wurOPIpBTzaKqD8qycrOPK1fJ+QZva89ZQzbsnDQm5MGu4g8wI9RWv
         b5/nBMYwQ2s3aLpQF3GcIZVZ2ScrzG5T3RsO8BbL04NpiKJpdEPrZKzxHPMPMugz9avA
         s3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XR0yI+aW4ISKO6OurX+u0MtdwuSJkccbzRW5ErEx2Yg=;
        b=olD1BroVupvegdWJInNQIugaO6XAoGFy/V0PI7wCRJn+iIL58oyMIRC51x5RXIvg88
         HJCYMH7xWXZclXWW6V9dTEVdS7HFktv33RWd/Bw03DUEPnNjfM9Z4mXklFdltx0R3m0m
         Mr2Nkl0nypAW9bpJCqIEJR28mGKR4Klsv/rXEGg/ohDjlySQyYkJnxLcwQcpAcEZje4E
         RNpV6xlgs4j1o5SLhMoqNpuVCvW2Kf94Icp3+1z2Iz2L2WpjmoeCOsdzA+7pSg4QDj5F
         iy5tRLVfL3ql/aCFHfyIh4TTHPGggVYjdB+YdvmkNamU7aJ6tHCfDoG6poZQmJ2YSjEe
         aI7A==
X-Gm-Message-State: APzg51DKqQwkNk0BdpGH8Q4VzXwKOVTEz/54BMpbJQUar8bokeoAPERf
        N3/kXcvwbMVAuZ+5ss2D+9A=
X-Google-Smtp-Source: ANB0VdYNZx5EUa2YY5PNF3Viy40/EnCVOo6lWgL96g9nsW631z8KddbtCRfuIl72CjxgRkFV4saDrA==
X-Received: by 2002:a50:c40e:: with SMTP id v14-v6mr641350edf.232.1537460361732;
        Thu, 20 Sep 2018 09:19:21 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h40-v6sm958144edh.88.2018.09.20.09.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:19:20 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 4/4] [media] ad5820: Add support for of-autoload
Date:   Thu, 20 Sep 2018 18:19:12 +0200
Message-Id: <20180920161912.17063-4-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
References: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kernel 4.16, i2c devices with DT compatible tag are modprobed
using their DT modalias.
Without this patch, if this driver is build as module it would never
be autoprobed.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/ad5820.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 20931217e3b1..d352bc6b6adf 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -375,12 +375,19 @@ static const struct i2c_device_id ad5820_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 
+static const struct of_device_id ad5820_of_table[] = {
+	{ .compatible = "adi"AD5820_NAME },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5820_of_table);
+
 static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
 	.driver		= {
 		.name	= AD5820_NAME,
 		.pm	= &ad5820_pm,
+		.of_match_table = ad5820_of_table,
 	},
 	.probe		= ad5820_probe,
 	.remove		= ad5820_remove,
-- 
2.18.0

