Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA50C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F5E20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vc/VKF/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F5E20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeJETsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:48:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35712 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbeJETsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:48:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id y19-v6so11559338edd.2;
        Fri, 05 Oct 2018 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKIor/sW87BP+V4JOfoeCe5+eQYewOaKx6KSwXqqmD0=;
        b=vc/VKF/tUAH9Z/FhaVqQhoGrBnIC05AJL+iTw2+LPT23+93GSki6X1XaHJgzZRqnBT
         jWy97OvgHal9XJP10cGD+shP3XP4omWxumIKgc9nNseNO5Omk7N8U1ZCrL7+GHi0xqIt
         mtQ6zrTX0A/kiWCDi+fR1xNqUIoNeArhwKM0jnZFtUvAQKkMkW3nDODabCfTFpmkoBjy
         Pq4lxHkiepCmyCr/tk7Eq3At7Y5v7lyDkE6A3EWUP7U/nVy6RDVFm69j+aUFtrkxXPN3
         ENjgTw52f5ui57UU6KeiMupcdXt+2Ryg8FNx0H3PQ+/B3uhMq9fr9Yha9kcdNN+EBm0C
         5Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKIor/sW87BP+V4JOfoeCe5+eQYewOaKx6KSwXqqmD0=;
        b=jlRaYm8fZizu/4YHBoIOblnKLq29bdYenLOM/GwFnRgTqZyr40tQIpXPyDGTl6V9Ip
         iS5HNo9EKr0um0xFZ/o159qz1/iroCke4TErF1tKa3ceFKvmvDdubXu8uCi8yTCU7HW4
         Ht7+lSHe8GEPWooHbn/X0WgBeft9BlgT1qEheucm3XD3jejZPRJDWF/QtvSlZpyREERU
         gymY5QGFD6CJAEkxB7ILchSZ8ijl2LG9SeimeyASKsvc2BILl3XxFflrbbIir4we9Rip
         tmDqmBgy1w8Dn5oUwX5JaSA0UvjibT5TvMIfa+xi61HFSVGcFmV63V8fhYzMEasFAhj+
         uaiw==
X-Gm-Message-State: ABuFfog5MNI86f5iwhqlz9m8ob3coXVURSvhX4XgFtQIEOeT6QqysOZw
        fjcKmWNVUd4NFwGrqfbNyJw=
X-Google-Smtp-Source: ACcGV63CzhivWWpI2CTZzhgqel0esQ1iZvfYsM1oNg2EaDNmY3bb9jS2xPfWSDCReh0JnJ+cmNJDbw==
X-Received: by 2002:a50:a186:: with SMTP id 6-v6mr14647112edk.12.1538743786333;
        Fri, 05 Oct 2018 05:49:46 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id b14-v6sm2360512edc.17.2018.10.05.05.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 05:49:45 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v8 3/3] [media] imx214: Fix range for V4L2_CID_EXPOSURE
Date:   Fri,  5 Oct 2018 14:49:39 +0200
Message-Id: <20181005124940.15539-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005124940.15539-1-ricardo.ribalda@gmail.com>
References: <20181005124940.15539-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going above 3184 changes the frame-rate of the sensor. Without this
patch there is no way to change the exposure without affecting the
frame-rate.

With the proper documentation we should be able the change the
frame-rate at wish, but until that happens we just cap what the sensor
can do.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/imx214.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 46a2fdfbd049..0b99123161b8 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -1027,7 +1027,7 @@ static int imx214_probe(struct i2c_client *client)
 	 */
 	imx214->exposure = v4l2_ctrl_new_std(&imx214->ctrls, &imx214_ctrl_ops,
 					     V4L2_CID_EXPOSURE,
-					     0, 0xffff, 1, 0x0c70);
+					     0, 3184, 1, 0x0c70);
 
 	ret = imx214->ctrls.error;
 	if (ret) {
-- 
2.19.0

