Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2783121535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oE1IosRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783121535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbeIUCbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:31:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34549 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:31:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id c29-v6so9602599lfj.1;
        Thu, 20 Sep 2018 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N/Wj/Ce31UHtgG56wu9+wBfD+B1MQY3nPhNgA+c5JMY=;
        b=oE1IosRz2+s9KG92zWkQA2apmFjzwcGSCogp7kTh/ZP1sYI0Dk1zPiFumrLy4xC/pX
         q38NYGJcxdQOyRk7J4QlgtA3qo3fbukf2TcQbZOZLpP17lf7LhvjUFDpI1mFwCylHIso
         onh3nHknK3Ef8jqpLPeKm+u26/9CFjkvEj197BzFFNZyfO5JJ1hgtnMjM/yDUCvGzsS+
         FvBvnBpHgHGH/PECBULyxT3+lurWRMghMJyPTMgBKVyNC1Ifx0TRs6scgNc9KbSnsq8D
         e1CmQzsomQ3/xYfVRgimLCRc/ZxFy5pbSK/WLFXjuezHHZ3Of5mqTLmTXUdXhi8MBI+d
         qDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N/Wj/Ce31UHtgG56wu9+wBfD+B1MQY3nPhNgA+c5JMY=;
        b=atebnXJRT044GtfnmZY5hIaNmoxbhX48wQ6c6hFcshROUoOHIsMIP8lipc4+Jz748R
         1EOuXfWNjrVLrJSzEkuYtJ6yimpFsuAWUraecv31F4Lji0Dr6yF4c5xiubiGv++OGnbv
         6VNC6D4+nzGFUiFf7n8XHhY4crHfaIRJLzFYDtHz40fKGcjZsgGTVHns7SCimS/uK/zc
         mpUvaf/PxHw40oxC1UIiU4qPKIApEZPNVxnMOjHAKfkc1O+bz5kFdLS0co7XFGqi2WLb
         xTXOJ01m1xpjMNKmlSgPWzKy+R8KXVN66Fql1VZCrULvpVUAfzaybVOfuX0lQYxul3/b
         zRdg==
X-Gm-Message-State: APzg51DX4kXufwHVRnKg7rwVl/uLF81DgDjHbMr3Ux9l7p8M2lk/7iSU
        6p/eE5A/p+sPzk4tq9qYsnA=
X-Google-Smtp-Source: ANB0VdYRIbGvvdEnK8Xg6kNjGhavel0EJsNDwDkbePt7DaolHqvz7JXEnpLTrrbTFl+bqk8+oOPF/Q==
X-Received: by 2002:a19:7709:: with SMTP id s9-v6mr6418489lfc.84.1537476355412;
        Thu, 20 Sep 2018 13:45:55 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r23-v6sm4470355ljc.15.2018.09.20.13.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:45:54 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [[PATCH v3] 3/6] [media] ad5820: Add support for of-autoload
Date:   Thu, 20 Sep 2018 22:45:37 +0200
Message-Id: <20180920204540.28832-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920204540.28832-1-ricardo.ribalda@gmail.com>
References: <20180920204540.28832-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kernel 4.16, i2c devices with DT compatible tag are modprobed
using their DT modalias.
Without this patch, if this driver is build as module it would never
be autoprobed.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/ad5820.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 625867472929..e461d36201a4 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -372,12 +372,21 @@ static const struct i2c_device_id ad5820_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ad5820_of_table[] = {
+	{ .compatible = "adi,ad5820" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5820_of_table);
+#endif
+
 static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
 	.driver		= {
 		.name	= AD5820_NAME,
 		.pm	= &ad5820_pm,
+		.of_match_table = of_match_ptr(ad5820_of_table),
 	},
 	.probe		= ad5820_probe,
 	.remove		= ad5820_remove,
-- 
2.18.0

